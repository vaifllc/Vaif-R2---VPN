//
//  R1SignupViewController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/18/22.
//

import Foundation
import UIKit
import PromiseKit
import CocoaLumberjackSwift
import FirebaseAuth
import FirebaseFirestore

protocol R1SignupStepsDelegate: AnyObject {
    func twoFactorCodeNeeded()
    func mailboxPasswordNeeded()
    func createAddressNeeded(data: CreateAddressData)
    func userAccountSetupNeeded()
    func firstPasswordChangeNeeded()
    
}

protocol R1SignupViewControllerDelegate: R1SignupStepsDelegate {
    func userDidDismissLoginViewController()
    func userDidRequestSignup()
    func userDidRequestHelp()
    func loginViewControllerDidFinish(endLoading: @escaping () -> Void, data: LoginData)
    func validatedName(name: String, signupAccountType: SignupAccountType)
    func validatedEmail(email: String, signupAccountType: SignupAccountType)
    func signupCloseButtonPressed()
    func signinButtonPressed()
    func hvEmailAlreadyExists(email: String)
}

final class R1SignupViewController: UIViewController, AccessibleView, Focusable {

    // MARK: - Outlets

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var loginTextField: PMTextField!
    @IBOutlet private weak var passwordTextField: PMTextField!
    @IBOutlet private weak var signInButton: ProtonButton!
    @IBOutlet private weak var signUpButton: ProtonButton!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var brandImage: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet private weak var helpButton: ProtonButton!

    // MARK: - Properties

    weak var delegate: R1SignupViewControllerDelegate?
    var initialError: LoginError?
    var showCloseButton = true
    var isSignupAvailable = true
    lazy var db = Firestore.firestore()
    var viewModel: LoginViewModel!
    var customErrorPresenter: LoginErrorPresenter?
    var initialUsername: String?

    var focusNoMore: Bool = false
    private let navigationBarAdjuster = NavigationBarAdjustingScrollViewDelegate()
    
    static let accountStateDidChange = Notification.Name("AccountUIAccountStateDidChangeNotification")
    private var isBannerShown = false { didSet { updateButtonStatus() } }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { darkModeAwarePreferredStatusBarStyle() }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        setupDelegates()
        setupNotifications()
        setupGestures()
        requestDomain()
        if let error = initialError {
            if self.customErrorPresenter?.willPresentError(error: error, from: self) == true { } else { showError(error: error) }
        }

        focusOnce(view: loginTextField, delay: .milliseconds(750))

        setUpCloseButton(showCloseButton: showCloseButton, action: #selector(R1SignupViewController.closePressed(_:)))

        generateAccessibilityIdentifiers()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBarAdjuster.setUp(for: scrollView, shouldAdjustNavigationBar: showCloseButton, parent: parent)
        scrollView.adjust(forKeyboardVisibilityNotification: nil)
    }

    // MARK: - Setup

    private func setupUI() {
        
        if let image = LoginUIImages.brandLogo {
            brandImage.image = image
            brandImage.isHidden = false
        }
        
        titleLabel.text = CoreString._ls_screen_title
        titleLabel.textColor = ColorProvider.TextNorm
        subtitleLabel.text = CoreString._ls_screen_subtitle
        subtitleLabel.textColor = ColorProvider.TextWeak
        signUpButton.isHidden = !isSignupAvailable
        signUpButton.setTitle(CoreString._ls_sign_in_button, for: .normal)
        helpButton.setTitle(CoreString._ls_help_button, for: .normal)
        signInButton.setTitle(CoreString._ls_create_account_button, for: .normal)
        loginTextField.title = CoreString._ls_username_title
        passwordTextField.title = CoreString._ls_password_title

        view.backgroundColor = ColorProvider.BackgroundNorm
        separatorView.backgroundColor = ColorProvider.InteractionWeak
        signUpButton.setMode(mode: .text)
        helpButton.setMode(mode: .text)

        loginTextField.autocorrectionType = .no
        loginTextField.autocapitalizationType = .none
        loginTextField.textContentType = .emailAddress
        loginTextField.keyboardType = .emailAddress
        loginTextField.returnKeyType = .next

        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.textContentType = .password

        loginTextField.value = initialUsername ?? ""
    }

    private func requestDomain() {
        viewModel.updateAvailableDomain()
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }

    private func setupDelegates() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func setupBinding() {
        viewModel.error.bind { [weak self] error in
            guard let self = self else {
                return
            }

            switch error {
            case .invalidCredentials:
                self.setError(textField: self.passwordTextField, error: nil)
                self.setError(textField: self.loginTextField, error: nil)
                if self.customErrorPresenter?.willPresentError(error: error, from: self) == true { } else { self.showError(error: error) }
            default:
                if self.customErrorPresenter?.willPresentError(error: error, from: self) == true { } else { self.showError(error: error) }
            }
        }
        viewModel.finished.bind { [weak self] result in
            switch result {
            case let .done(data):
                self?.delegate?.loginViewControllerDidFinish(endLoading: { [weak self] in self?.viewModel.isLoading.value = false }, data: data)
            case .twoFactorCodeNeeded:
                self?.delegate?.twoFactorCodeNeeded()
            case .mailboxPasswordNeeded:
                self?.delegate?.mailboxPasswordNeeded()
            case let .createAddressNeeded(data):
                self?.delegate?.createAddressNeeded(data: data)
            }
        }
        viewModel.isLoading.bind { [weak self] isLoading in
            self?.view.isUserInteractionEnabled = !isLoading
            self?.signInButton.isSelected = isLoading
        }
        //try? self.loginTextField.setUpChallenge(viewModel.challenge, type: .username)
    }

    // MARK: - Actions

    @IBAction private func signInPressed(_ sender: Any) {
        cancelFocus()
        dismissKeyboard()


        let passwordValid = validatePassword()

        guard passwordValid else {
            return
        }

        clearErrors()
        
        viewModel.isLoading.value = true
        
        R2Signup()

    }
    
    private func updateButtonStatus() {
        if validateEmailAddress != nil, !isBannerShown {
            signUpButton.isEnabled = true
        } else {
            signUpButton.isEnabled = false
        }
    }
    
    private var validateEmailAddress: String? {
        let emailaddress = loginTextField.value
        guard viewModel.isValidEmail(email: emailaddress) else { return nil }
        return emailaddress
    }
    
    private func R2Signup(){
        let r1email = loginTextField.value
        let r2password = passwordTextField.value
        
        viewModel.isLoading.value = true
        
    }
    

    @IBAction func signUpPressed(_ sender: ProtonButton) {
        cancelFocus()
        PMBanner.dismissAll(on: self)
        delegate?.signinButtonPressed()
    }


    @objc private func closePressed(_ sender: Any) {
        cancelFocus()
        delegate?.userDidDismissLoginViewController()
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }

    private func dismissKeyboard() {
        if loginTextField.isFirstResponder {
            _ = loginTextField.resignFirstResponder()
        }

        if passwordTextField.isFirstResponder {
            _ = passwordTextField.resignFirstResponder()
        }
    }

    // MARK: - Keyboard

    private func setupNotifications() {
        NotificationCenter.default
            .setupKeyboardNotifications(target: self, show: #selector(keyboardWillShow), hide: #selector(keyboardWillHide))
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        adjust(scrollView, notification: notification,
               topView: topView(of: loginTextField, passwordTextField),
               bottomView: signUpButton)
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        adjust(scrollView, notification: notification, topView: titleLabel, bottomView: signUpButton)
    }

    // MARK: - Validation

    @discardableResult
    func isValidEmail(email: String) -> Bool {
        guard !email.isEmpty else { return false }
        return email.isValidEmail()
    }
    private func validateUsername() -> Bool {
        let usernameValid = viewModel.validate(username: loginTextField.value)
        switch usernameValid {
        case let .failure(error):
            setError(textField: loginTextField, error: error)
            return false
        case .success:
            clearError(textField: loginTextField)
            return true
        }
    }

    @discardableResult
    private func validatePassword() -> Bool {
        let passwordValid = viewModel.validate(password: passwordTextField.value)
        switch passwordValid {
        case let .failure(error):
            setError(textField: passwordTextField, error: error)
            return false
        case .success:
            clearError(textField: passwordTextField)
            return true
        }
    }

    // MARK: - Errors

    private func clearErrors() {
        PMBanner.dismissAll(on: self)
        clearError(textField: loginTextField)
        clearError(textField: passwordTextField)
    }
}

// MARK: - Text field delegate

extension R1SignupViewController: PMTextFieldDelegate {

    func didChangeValue(_ textField: PMTextField, value: String) {}

    func textFieldShouldReturn(_ textField: PMTextField) -> Bool {
        if textField == loginTextField {
            _ = passwordTextField.becomeFirstResponder()
        } else {
            _ = textField.resignFirstResponder()
        }
        return true
    }

    func didBeginEditing(textField: PMTextField) {}

    func didEndEditing(textField: PMTextField) {
        switch textField {
        case loginTextField:
            validateUsername()
        case passwordTextField:
            validatePassword()
        default:
            break
        }
    }
}

// MARK: - Additional errors handling

extension R1SignupViewController: LoginErrorCapable {
    func onUserAccountSetupNeeded() {
        delegate?.userAccountSetupNeeded()
    }

    func onFirstPasswordChangeNeeded() {
        delegate?.firstPasswordChangeNeeded()
    }

    var bannerPosition: PMBannerPosition { .top }
}
