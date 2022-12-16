//
//  SignupViewController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit


protocol SignupViewControllerDelegate: AnyObject {
    func validatedName(name: String, signupAccountType: SignupAccountType)
    func validatedEmail(email: String, signupAccountType: SignupAccountType)
    func signupCloseButtonPressed()
    func signinButtonPressed()
    func hvEmailAlreadyExists(email: String)
}

enum SignupAccountType {
    case `internal`
    case external
}

class SignupViewController: UIViewController, AccessibleView, Focusable {

    weak var delegate: SignupViewControllerDelegate?
    var viewModel: SignupViewModel!
    var customErrorPresenter: LoginErrorPresenter?
    var signupAccountType: SignupAccountType!
    var showOtherAccountButton = true
    var showCloseButton = true
    var showSeparateDomainsButton = true
    var minimumAccountType: AccountType?
    var tapGesture: UITapGestureRecognizer?

    // MARK: Outlets

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var createAccountTitleLabel: UILabel! {
        didSet {
            createAccountTitleLabel.text = CoreString._su_main_view_title
            createAccountTitleLabel.textColor = ColorProvider.TextNorm
        }
    }
    @IBOutlet weak var createAccountDescriptionLabel: UILabel! {
        didSet {
            createAccountDescriptionLabel.text = CoreString._su_main_view_desc
            createAccountDescriptionLabel.textColor = ColorProvider.TextWeak
        }
    }
    @IBOutlet weak var internalNameTextField: PMTextField! {
        didSet {
            internalNameTextField.title = CoreString._su_username_field_title
            internalNameTextField.keyboardType = .default
            internalNameTextField.textContentType = .username
            internalNameTextField.isPassword = false
            internalNameTextField.delegate = self
            internalNameTextField.autocorrectionType = .no
            internalNameTextField.autocapitalizationType = .none
            internalNameTextField.spellCheckingType = .no
        }
    }
    @IBOutlet weak var domainsView: UIView!
    @IBOutlet weak var domainsLabel: UILabel!
    @IBOutlet weak var domainsButton: ProtonButton!
    @IBOutlet weak var usernameAndDomainsView: UIView!
    @IBOutlet weak var domainsBottomSeparatorView: UIView!
    @IBOutlet weak var externalEmailTextField: PMTextField! {
        didSet {
            externalEmailTextField.title = CoreString._su_email_field_title
            externalEmailTextField.autocorrectionType = .no
            externalEmailTextField.keyboardType = .emailAddress
            externalEmailTextField.textContentType = .emailAddress
            externalEmailTextField.isPassword = false
            externalEmailTextField.delegate = self
            externalEmailTextField.autocapitalizationType = .none
            externalEmailTextField.spellCheckingType = .no
        }
    }
    var currentlyUsedTextField: PMTextField {
        switch signupAccountType {
        case .external:
            return externalEmailTextField
        case .internal:
            return internalNameTextField
        case .none:
            assertionFailure("signupAccountType should be configured during the segue")
            return internalNameTextField
        }
    }
    var currentlyNotUsedTextField: PMTextField {
        switch signupAccountType {
        case .external:
            return internalNameTextField
        case .internal:
            return externalEmailTextField
        case .none:
            assertionFailure("signupAccountType should be configured during the segue")
            return externalEmailTextField
        }
    }

    @IBOutlet weak var otherAccountButton: ProtonButton! {
        didSet {
            otherAccountButton.setMode(mode: .text)
        }
    }
    @IBOutlet weak var nextButton: ProtonButton! {
        didSet {
            nextButton.setTitle(CoreString._su_next_button, for: .normal)
            nextButton.isEnabled = false
        }
    }
    @IBOutlet weak var signinButton: ProtonButton! {
        didSet {
            signinButton.setMode(mode: .text)
            signinButton.setTitle(CoreString._su_signin_button, for: .normal)
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var brandLogo: UIImageView!

    var focusNoMore: Bool = false
    private let navigationBarAdjuster = NavigationBarAdjustingScrollViewDelegate()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { darkModeAwarePreferredStatusBarStyle() }

    // MARK: View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorProvider.BackgroundNorm
        
        if let image = LoginUIImages.brandLogo {
            brandLogo.image = image
            brandLogo.isHidden = false
        }
        
        setupGestures()
        setupNotifications()
        

        focusOnce(view: currentlyUsedTextField, delay: .milliseconds(750))

        setUpCloseButton(showCloseButton: showCloseButton, action: #selector(SignupViewController.onCloseButtonTap(_:)))
        //configureAccountType()
        generateAccessibilityIdentifiers()
        
        //try? internalNameTextField.setUpChallenge(viewModel.challenge, type: .username)
        //try? externalEmailTextField.setUpChallenge(viewModel.challenge, type: .username_email)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBarAdjuster.setUp(for: scrollView, shouldAdjustNavigationBar: showCloseButton, parent: parent)
        scrollView.adjust(forKeyboardVisibilityNotification: nil)
    }

    // MARK: Actions


    @IBAction func onNextButtonTap(_ sender: ProtonButton) {
        cancelFocus()
        PMBanner.dismissAll(on: self)
        nextButton.isSelected = true
        currentlyUsedTextField.isError = false
        if signupAccountType == .internal {
            switch minimumAccountType {
            case .username:
                checkUsernameWithoutSpecifyingDomain(userName: currentlyUsedTextField.value)
            case .internal, .external:
                checkUsernameWithinDomain(userName: currentlyUsedTextField.value)
            case .none:
                assertionFailure("signupAccountType should be configured during the segue")
            }
            //        } else {
            //            if viewModel.humanVerificationVersion == .v3 {
            //                checkEmail(email: currentlyUsedTextField.value)
            //            } else {
            //                requestValidationToken(email: currentlyUsedTextField.value)
            //            }
            //        }
        }
    }

    @IBAction func onSignInButtonTap(_ sender: ProtonButton) {
        cancelFocus()
        PMBanner.dismissAll(on: self)
        delegate?.signinButtonPressed()
    }
    

    @objc func onCloseButtonTap(_ sender: UIButton) {
        cancelFocus()
        delegate?.signupCloseButtonPressed()
    }

    // MARK: Private methods

//    private func configureAccountType() {
//        internalNameTextField.value = ""
//        externalEmailTextField.value = ""
//        switch signupAccountType {
//        case .external:
//            externalEmailTextField.isHidden = false
//            usernameAndDomainsView.isHidden = true
//            domainsView.isHidden = true
//            domainsBottomSeparatorView.isHidden = true
//            internalNameTextField.isHidden = true
//        case .internal:
//            externalEmailTextField.isHidden = true
//            usernameAndDomainsView.isHidden = false
//            domainsView.isHidden = false
//            domainsBottomSeparatorView.isHidden = showOtherAccountButton
//            internalNameTextField.isHidden = false
//        case .none: break
//        }
//        let title = signupAccountType == .internal ? CoreString._su_email_address_button
//                                                   : CoreString._su_proton_address_button
//        otherAccountButton.setTitle(title, for: .normal)
//    }


    

    
    private func setupGestures() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        tapGesture?.delaysTouchesBegan = false
        tapGesture?.delaysTouchesEnded = false
        guard let tapGesture = tapGesture else { return }
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }

    private func dismissKeyboard() {
        if currentlyUsedTextField.isFirstResponder {
            _ = currentlyUsedTextField.resignFirstResponder()
        }
    }

    private func validateNextButton() {
        if signupAccountType == .internal {
            nextButton.isEnabled = viewModel.isUserNameValid(name: currentlyUsedTextField.value)
        } else {
            nextButton.isEnabled = viewModel.isEmailValid(email: currentlyUsedTextField.value)
        }
    }

    private func checkUsernameWithoutSpecifyingDomain(userName: String) {
        lockUI()
        viewModel.checkUsernameAccount(username: userName) { result in
            self.unlockUI()
            self.nextButton.isSelected = false
            switch result {
            case .success:
                self.delegate?.validatedName(name: userName, signupAccountType: self.signupAccountType)
            case .failure(let error):
                switch error {
                case .generic(let message, _, _):
                    if self.customErrorPresenter?.willPresentError(error: error, from: self) == true { } else {
                        self.showError(message: message)
                    }
                case .notAvailable(let message):
                    self.currentlyUsedTextField.isError = true
                    if self.customErrorPresenter?.willPresentError(error: error, from: self) == true { } else {
                        self.showError(message: message)
                    }
                }
            }
        }
    }
    
    private func checkUsernameWithinDomain(userName: String) {
        lockUI()
//        viewModel.checkInternalAccount(username: userName) { result in
//            self.unlockUI()
//            self.nextButton.isSelected = false
//            switch result {
//            case .success:
//                self.delegate?.validatedName(name: userName, signupAccountType: self.signupAccountType)
//            case .failure(let error):
//                switch error {
//                case .generic(let message, _, _):
//                    if self.customErrorPresenter?.willPresentError(error: error, from: self) == true { } else {
//                        self.showError(message: message)
//                    }
//                case .notAvailable(let message):
//                    self.currentlyUsedTextField.isError = true
//                    if self.customErrorPresenter?.willPresentError(error: error, from: self) == true { } else {
//                        self.showError(message: message)
//                    }
//                }
//            }
//        }
    }
    
//    private func checkEmail(email: String) {
//        lockUI()
//        viewModel.checkExternalEmailAccount(email: email) { result in
//            self.unlockUI()
//            self.nextButton.isSelected = false
//            switch result {
//            case .success:
//                self.delegate?.validatedEmail(email: email, signupAccountType: self.signupAccountType)
//            case .failure(let error):
//                switch error {
//                case .generic(let message, let code, _):
//                    if code == APIErrorCode.humanVerificationAddressAlreadyTaken {
//                        self.delegate?.hvEmailAlreadyExists(email: email)
//                    } else if self.customErrorPresenter?.willPresentError(error: error, from: self) == true { } else {
//                        self.showError(message: message)
//                    }
//                case .notAvailable(let message):
//                    self.currentlyUsedTextField.isError = true
//                    if self.customErrorPresenter?.willPresentError(error: error, from: self) == true { } else {
//                        self.showError(message: message)
//                    }
//                }
//            }
//        } editEmail: {
//            self.unlockUI()
//            self.nextButton.isSelected = false
//            _ = self.currentlyUsedTextField.becomeFirstResponder()
//        }
//    }

    private func showError(message: String) {
        showBanner(message: message, position: PMBannerPosition.top)
    }

    private func requestValidationToken(email: String) {
        lockUI()
//        viewModel?.requestValidationToken(email: email, completion: { result in
//            self.unlockUI()
//            self.nextButton.isSelected = false
//            switch result {
//            case .success:
//                self.delegate?.validatedName(name: email, signupAccountType: self.signupAccountType)
//            case .failure(let error):
//                if self.customErrorPresenter?.willPresentError(error: error, from: self) == true { } else { self.showError(error: error) }
//                self.currentlyUsedTextField.isError = true
//            }
//        })
    }

    // MARK: - Keyboard

    private func setupNotifications() {
        NotificationCenter.default
            .setupKeyboardNotifications(target: self, show: #selector(keyboardWillShow), hide: #selector(keyboardWillHide))
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        adjust(scrollView, notification: notification, topView: currentlyUsedTextField, bottomView: signinButton)
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        adjust(scrollView, notification: notification, topView: createAccountTitleLabel, bottomView: signinButton)
    }
}

extension SignupViewController: PMTextFieldDelegate {
    func didChangeValue(_ textField: PMTextField, value: String) {
        validateNextButton()
    }

    func didEndEditing(textField: PMTextField) {
        validateNextButton()
    }

    func textFieldShouldReturn(_ textField: PMTextField) -> Bool {
        _ = currentlyUsedTextField.resignFirstResponder()
        return true
    }

    func didBeginEditing(textField: PMTextField) {

    }
}

// MARK: - Additional errors handling

extension SignupViewController: SignUpErrorCapable {
    var bannerPosition: PMBannerPosition { .top }
}

extension SignupViewController: PMActionSheetEventsListener {
    func willPresent() {
        tapGesture?.cancelsTouchesInView = false
        domainsButton?.isSelected = true
    }

    func willDismiss() {
        tapGesture?.cancelsTouchesInView = true
        domainsButton?.isSelected = false
    }
    
    func didDismiss() { }
}
