//
//  LoginViewController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation
import UIKit
import PromiseKit
import CocoaLumberjackSwift
import FirebaseAuth
import FirebaseFirestore

protocol LoginStepsDelegate: AnyObject {
    func twoFactorCodeNeeded()
    func mailboxPasswordNeeded()
    func createAddressNeeded(data: CreateAddressData)
    func userAccountSetupNeeded()
    func firstPasswordChangeNeeded()
}

protocol LoginViewControllerDelegate: LoginStepsDelegate {
    func userDidDismissLoginViewController()
    func userDidRequestSignup()
    func userDidRequestHelp()
    func loginViewControllerDidFinish(endLoading: @escaping () -> Void, data: LoginData)
}

final class LoginViewController: UIViewController, AccessibleView, Focusable {
    
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
    
    weak var delegate: LoginViewControllerDelegate?
    var initialError: LoginError?
    var showCloseButton = true
    var isSignupAvailable = true
    lazy var db = Firestore.firestore()
    var viewModel: LoginViewModel!
    var customErrorPresenter: LoginErrorPresenter?
    var initialUsername: String?
    public var readyGroup: DispatchGroup? = DispatchGroup()
    var focusNoMore: Bool = false
    private let navigationBarAdjuster = NavigationBarAdjustingScrollViewDelegate()
    private lazy var navigationService: NavigationService = container.makeNavigationService()
    static let accountStateDidChange = Notification.Name("AccountUIAccountStateDidChangeNotification")
    private var isBannerShown = false
    private let container = DependencyContainer()
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
        
        setUpCloseButton(showCloseButton: showCloseButton, action: #selector(LoginViewController.closePressed(_:)))
        
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
        signUpButton.setTitle(CoreString._ls_create_account_button, for: .normal)
        helpButton.setTitle(CoreString._ls_help_button, for: .normal)
        signInButton.setTitle(CoreString._ls_sign_in_button, for: .normal)
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
        
        let usernameValid = validateUsername()
        let passwordValid = validatePassword()
        
        guard usernameValid, passwordValid else {
            return
        }
        
        clearErrors()
        
        viewModel.isLoading.value = true
        
        R1Login()
        //R2Login()
        
    }
    
    //    private func R1LoginV2(){
    //        let r1email = loginTextField.value
    //        let r2password = passwordTextField.value
    //        AuthService.shared.login(email: r1email,
    //                                 password: r2password) { (result) in
    //            switch result {
    //            case .success(let user):
    //                self.showAlert(with: "Success!", and: "You are authorized!") {
    //                    FirestoreService.shared.getUserData(user: user) { (result) in
    //
    //                        switch result {
    //
    //                        case .success(let muser):
    //                            let mainTabBar = MainTabBarController(currentUser: muser)
    //                            mainTabBar.modalPresentationStyle = .fullScreen
    //                            self.present(mainTabBar, animated: true, completion: nil)
    //
    //                        case .failure(let error):
    //                            self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
    //                        }
    //                    }
    //                }
    //
    //            case .failure(let error):
    //                self.showAlert(with: "Error!", and: error.localizedDescription)
    //            }
    //    }
    //    }
    
    private func R1Login(){
        let r1email = loginTextField.value
        let r2password = passwordTextField.value
        
        viewModel.isLoading.value = true
        Auth.auth().signIn(withEmail: r1email, password: r2password) { authData, authErro in
            if let maybeError = authErro { //if there was an error, handle it
                let err = maybeError as NSError
                switch err.code {
                case AuthErrorCode.wrongPassword.rawValue:
                    self.passwordTextField.isError = true
                    self.passwordTextField.errorMessage = "Invalid password"
                    self.viewModel.isLoading.value = false
                case AuthErrorCode.operationNotAllowed.rawValue:
                    self.viewModel.isLoading.value = false
                    print("Operation not allowedl")
                case AuthErrorCode.unverifiedEmail.rawValue:
                    self.loginTextField.isError = true
                    self.loginTextField.errorMessage = "Invalid Email"
                    self.viewModel.isLoading.value = false
                    print("Invalid email")
                default:
                    self.viewModel.isLoading.value = false
                    print("unknown error: \(err.localizedDescription)")
                }
            }else {
                let email = authData?.user.email ?? ""
                let ref = self.db.collection("users").document(email)
                ref.getDocument { snapshot, error in
                    print(snapshot?.data() ?? "")
                    if let error = error {
                        let message = error.localizedDescription
                        let banner = PMBanner(message: message, style: PMBannerNewStyle.error, dismissDuration: Double.infinity)
                        banner.addButton(text: CoreString._hv_ok_button) { _ in
                            banner.dismiss()
                        }
                        
                    }else {
                        let deviceInfo = WitWork.shared.getDeviceInfo()
                        ref.updateData(["lastLogin": Date(),
                                        "deviceInfo": deviceInfo,
                                        "password": r2password.encryptDecrypt()]) { err in
                            self.viewModel.isLoading.value = false
                            if let err = err {
                                let banner2 = PMBanner(message: "Login Error: User doesnt exist. Please check your credentials and try again", style: PMBannerNewStyle.error, icon: IconProvider.exclamationCircleFilled, dismissDuration: Double.infinity)
                                banner2.addButton(text: CoreString._hv_ok_button) { _ in
                                    self.isBannerShown = false
                                    banner2.dismiss()
                                }
                                banner2.show(at: .topCustom(.baner), on: self)
                                self.isBannerShown = true
                               // banner.show(at: .topCustom(.baner), on: self)
                                print("update error snap Id: \(err.localizedDescription)")
                            }else {
                                WitWork.shared.user = Auth.auth().currentUser
                                self.whenReady(queue: DispatchQueue.main) {
                                    NotificationCenter.default.post(name: NSNotification.Name("reauthen"), object: nil)
                                    self.navigationService.presentHomeViewController()
                                }
//                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func whenReady(queue: DispatchQueue, completion: @escaping () -> Void) {
        self.readyGroup?.notify(queue: queue) {
            completion()
            self.readyGroup = nil
        }
    }
    
    
    private func showError(message: String) {
        showBanner(message: message, position: PMBannerPosition.top)
    }
    
    private func R2Login(){
        firstly {
            try Client.signInWithEmail(email: loginTextField.value, password: passwordTextField.value)
        }
        .done { (signin: SignIn) in
            try setAPICredentials(email: self.loginTextField.value, password: self.passwordTextField.value)
            setAPICredentialsConfirmed(confirmed: true)
            self.viewModel.isLoading.value = false
            NotificationCenter.default.post(name: LoginViewModel.accountStateDidChange, object: self)
            
            let banner = PMBanner(message: "Successful Login", style: PMBannerNewStyle.success, icon: IconProvider.checkmarkCircle, dismissDuration: Double.infinity)
            banner.addButton(text: CoreString._hv_ok_button) { _ in
                // logged in and confirmed - update this email with the receipt and refresh VPN credentials
                firstly { () -> Promise<SubscriptionEvent> in
                    try Client.subscriptionEvent()
                }
                .then { (result: SubscriptionEvent) -> Promise<GetKey> in
                    try Client.getKey()
                }
                .done { (getKey: GetKey) in
                    try setVPNCredentials(id: getKey.id, keyBase64: getKey.b64)
                    if (getUserWantsVPNEnabled() == true) {
                        VPNController.shared.restart()
                    }
                }
                .catch { error in
                    // it's okay for this to error out with "no subscription in receipt"
                    DDLogError("HomeViewController ConfirmEmail subscriptionevent error (ok for it to be \"no subscription in receipt\"): \(error)")
                }
                self.isBannerShown = false
                banner.dismiss()
            }
            banner.show(at: .topCustom(.baner), on: self)
            self.isBannerShown = true
            
        }
        .catch { error in
            self.viewModel.isLoading.value = false
            var errorMessage = error.localizedDescription
            if let apiError = error as? R2ApiError {
                errorMessage = apiError.message
            }
            
            let banner2 = PMBanner(message: "Login Error: \(errorMessage)", style: PMBannerNewStyle.error, icon: IconProvider.exclamationCircleFilled, dismissDuration: Double.infinity)
            banner2.addButton(text: CoreString._hv_ok_button) { _ in
                self.isBannerShown = false
                banner2.dismiss()
            }
            banner2.show(at: .topCustom(.baner), on: self)
            self.isBannerShown = true
            
        }
    }
    
    @IBAction func signUpPressed(_ sender: ProtonButton) {
        cancelFocus()
        delegate?.userDidRequestSignup()
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

extension LoginViewController: PMTextFieldDelegate {
    
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

extension LoginViewController: LoginErrorCapable {
    func onUserAccountSetupNeeded() {
        delegate?.userAccountSetupNeeded()
    }
    
    func onFirstPasswordChangeNeeded() {
        delegate?.firstPasswordChangeNeeded()
    }
    
    var bannerPosition: PMBannerPosition { .top }
}
