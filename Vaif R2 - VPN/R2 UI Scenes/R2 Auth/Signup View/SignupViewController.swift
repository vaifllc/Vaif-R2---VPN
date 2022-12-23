//
//  SignupViewController.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

//
//  SignupViewController.swift
//  ProtonCore-Login - Created on 11/03/2021.
//
//  Copyright (c) 2022 Proton Technologies AG
//
//  This file is part of Proton Technologies AG and ProtonCore.
//
//  ProtonCore is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  ProtonCore is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with ProtonCore.  If not, see <https://www.gnu.org/licenses/>.

import UIKit
import Foundation
import PromiseKit
import CocoaLumberjackSwift
import FirebaseAuth
import FirebaseFirestore
import Navajo_Swift


protocol SignupViewControllerDelegate: AnyObject {
    func validatedName(name: String, signupAccountType: SignupAccountType)
    func validatedEmail(email: String, signupAccountType: SignupAccountType)
    func validatedPassword(password: String, completionHandler: (() -> Void)?)
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
    private var isBannerShown = false
    var minimumAccountType: AccountType?
    var tapGesture: UITapGestureRecognizer?
    var viewModel2: LoginViewModel!
    var signupPasswordRestrictions: SignupPasswordRestrictions!
    lazy var db = Firestore.firestore()
    
    
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
            internalNameTextField.title = CoreString._su_email_field_title
            internalNameTextField.autocorrectionType = .no
            internalNameTextField.keyboardType = .emailAddress
            internalNameTextField.textContentType = .emailAddress
            internalNameTextField.isPassword = false
            internalNameTextField.delegate = self
            internalNameTextField.autocapitalizationType = .none
            internalNameTextField.spellCheckingType = .no
        }
    }
    
    @IBOutlet weak var passwordTextField: PMTextField!
    {
        didSet {
            passwordTextField.title = CoreString._ls_password_title
            passwordTextField.autocorrectionType = .no
            passwordTextField.textContentType = .password
            passwordTextField.isPassword = true
            passwordTextField.delegate = self
            passwordTextField.autocapitalizationType = .none
            passwordTextField.spellCheckingType = .no
        }
    }
    @IBOutlet weak var confirmPasswordTextField: PMTextField!{
        didSet{
            confirmPasswordTextField.title = CoreString._ls_confirmpassword_title
            confirmPasswordTextField.autocorrectionType = .no
            confirmPasswordTextField.textContentType = .password
            confirmPasswordTextField.isPassword = true
            confirmPasswordTextField.delegate = self
            confirmPasswordTextField.autocapitalizationType = .none
            confirmPasswordTextField.spellCheckingType = .no
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
        passwordTextField.assistiveText = CoreString._su_password_field_hint
        confirmPasswordTextField.assistiveText = CoreString._su_password_field_hint
        if let image = LoginUIImages.brandLogo {
            brandLogo.image = image
            brandLogo.isHidden = false
        }
        setupDomainsView()
        setupGestures()
        setupNotifications()
        otherAccountButton.isHidden = !showOtherAccountButton
        
        focusOnce(view: currentlyUsedTextField, delay: .milliseconds(750))
        
        setUpCloseButton(showCloseButton: showCloseButton, action: #selector(SignupViewController.onCloseButtonTap(_:)))
        requestDomain()
        configureAccountType()
        generateAccessibilityIdentifiers()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBarAdjuster.setUp(for: scrollView, shouldAdjustNavigationBar: showCloseButton, parent: parent)
        scrollView.adjust(forKeyboardVisibilityNotification: nil)
    }
    
    
    
    // MARK: Actions
    
    @IBAction func onOtherAccountButtonTap(_ sender: ProtonButton) {
        cancelFocus()
        PMBanner.dismissAll(on: self)
        let isFirstResponder = currentlyUsedTextField.isFirstResponder
        if isFirstResponder { _ = currentlyUsedTextField.resignFirstResponder() }
        contentView.fadeOut(withDuration: 0.5) { [self] in
            self.contentView.fadeIn(withDuration: 0.5)
            self.currentlyUsedTextField.isError = false
            if self.signupAccountType == .internal {
                signupAccountType = .external
            } else {
                signupAccountType = .internal
            }
            configureAccountType()
            if isFirstResponder { _ = currentlyUsedTextField.becomeFirstResponder() }
        }
    }
    
    @IBAction func onNextButtonTap(_ sender: ProtonButton) {
        cancelFocus()
        PMBanner.dismissAll(on: self)
        clearError(textField: internalNameTextField)
        clearError(textField: confirmPasswordTextField)
        clearError(textField: passwordTextField)
        //nextButton.isSelected = true
        currentlyUsedTextField.isError = false
        R1Signup()
        
        
    }
    
    private func R1Signup(){
        let r1email = internalNameTextField.value
        let r1password = passwordTextField.value
        let rr1password = confirmPasswordTextField.value
        let lengthRule = LengthRule(min: 6, max: 24)
        let uppercaseRule = RequiredCharacterRule(preset: .symbolCharacter)
        let validator = PasswordValidator(rules: [lengthRule, uppercaseRule])
        
        
        
        if let failingRules = validator.validate(r1password) {
            passwordTextField.isError = true
            passwordTextField.errorMessage = failingRules.map({ return $0.localizedErrorDescription }).joined(separator: "\n")
            return
        } else {
            passwordTextField.isError = false
        }
        
        if let failingRules = validator.validate(rr1password) {
            confirmPasswordTextField.isError = true
            passwordTextField.errorMessage = failingRules.map({ return $0.localizedErrorDescription }).joined(separator: "\n")
            return
        } else {
            confirmPasswordTextField.isError = false
        }
        
//        guard Validators.isFilled(email: r1email, password: r1password, confirmPassword: rr1password) else {
//            internalNameTextField.isError = true
//            passwordTextField.isError = true
//            confirmPasswordTextField.isError = true
//            internalNameTextField.errorMessage = "Please fill in all fields"
//            passwordTextField.errorMessage = "Passwords must match"
//            confirmPasswordTextField.errorMessage = "Passwords must match"
//            return
//        }
        
        if r1email.contains("") || r1password.contains("") || rr1password.contains("") {
            internalNameTextField.isError = true
            passwordTextField.isError = true
            confirmPasswordTextField.isError = true
            internalNameTextField.errorMessage = "Please fill in all fields"
            passwordTextField.errorMessage = "Passwords must match"
            confirmPasswordTextField.errorMessage = "Passwords must match"
        } else {
            internalNameTextField.isError = false
            passwordTextField.isError = false
            confirmPasswordTextField.isError = false
        }


        
        guard r1password == rr1password else {
            passwordTextField.isError = true
            confirmPasswordTextField.isError = true
            passwordTextField.errorMessage = "Passwords must match"
            confirmPasswordTextField.errorMessage = "Passwords must match"
            return
            
        }
        
        
        Auth.auth().createUser(withEmail: r1email, password: r1password) { auth, authError in
            //self.hideHUD()
            if let maybeError = authError { //if there was an error, handle it
                let err = maybeError as NSError
                switch err.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    self.internalNameTextField.isError = true
                    self.internalNameTextField.errorMessage = "Email address is already in use."
                    print("Email address is already in use.")
                case AuthErrorCode.operationNotAllowed.rawValue:
                    print("Operation not allowedl")
                case AuthErrorCode.invalidEmail.rawValue:
                    self.internalNameTextField.isError = true
                    self.internalNameTextField.errorMessage = "Invalid Email"
                    print("Invalid email")
                default:
                    print("unknown error: \(err.localizedDescription)")
                }
            } else { //there was no error so the user could be auth'd or maybe not!
                if let auth = auth, let email = auth.user.email {
                    WitWork.shared.user = auth.user
                    let data:[String: Any] = [
                        "createAt": Date(),
                        "deviceInfo": WitWork.shared.getDeviceInfo(),
                        "lastLogin": Date(),
                        "email": email
                    ]
                    let ref = self.db.collection("users").document(email)
                    ref.setData(data) { updateError in
                        if let updateError = updateError {
                            let updateErrorBanner = PMBanner(message: "\(updateError.localizedDescription).", style: PMBannerNewStyle.error, icon: IconProvider.exclamationCircleFilled, dismissDuration: 2.5)
                            self.isBannerShown = false
                            updateErrorBanner.dismiss()
                        }else {
                            /// SHOW SPLASH SCREEN TO MAIN
                            
                        }
                    }
                } else {
                    let updateErrorBanner = PMBanner(message: "R2 Systematic Error. Please Contact Support", style: PMBannerNewStyle.error, icon: IconProvider.exclamationCircleFilled, dismissDuration: 3.5)
                    self.isBannerShown = false
                    updateErrorBanner.dismiss()
                }
            }
        }
    }
    
    
    
    @IBAction func onSignInButtonTap(_ sender: ProtonButton) {
        cancelFocus()
        PMBanner.dismissAll(on: self)
        delegate?.signinButtonPressed()
    }
    
    @IBAction private func onDomainsButtonTapped() {
        dismissKeyboard()
        var sheet: PMActionSheet?
        let currentDomain = viewModel.currentlyChosenSignUpDomain
        let items = viewModel.allSignUpDomains.map { [weak self] domain in
            PMActionSheetPlainItem(title: "@\(domain)", icon: nil, isOn: domain == currentDomain) { [weak self] _ in
                sheet?.dismiss(animated: true)
                self?.viewModel.currentlyChosenSignUpDomain = domain
                self?.configureDomainSuffix()
            }
        }
        let header = PMActionSheetHeaderView(title: CoreString._su_domains_sheet_title,
                                             subtitle: nil,
                                             leftItem: PMActionSheetPlainItem(title: nil, icon: IconProvider.crossSmall) { _ in sheet?.dismiss(animated: true) },
                                             rightItem: nil,
                                             hasSeparator: false)
        let itemGroup = PMActionSheetItemGroup(items: items, style: .clickable)
        sheet = PMActionSheet(headerView: header, itemGroups: [itemGroup], showDragBar: false)
        sheet?.eventsListener = self
        sheet?.presentAt(self, animated: true)
    }
    
    @objc func onCloseButtonTap(_ sender: UIButton) {
        cancelFocus()
        delegate?.signupCloseButtonPressed()
    }
    
    // MARK: Private methods
    
    private func requestDomain() {
        viewModel.updateAvailableDomain { [weak self] _ in
            self?.configureDomainSuffix()
        }
    }
    
    private func configureAccountType() {
        internalNameTextField.value = ""
        externalEmailTextField.value = ""
        passwordTextField.value = ""
        confirmPasswordTextField.value = ""
        switch signupAccountType {
        case .external:
            externalEmailTextField.isHidden = true
            usernameAndDomainsView.isHidden = false
            domainsView.isHidden = false
            domainsBottomSeparatorView.isHidden = false
            internalNameTextField.isHidden = false
            passwordTextField.isHidden = false
            confirmPasswordTextField.isHidden = false
        case .internal:
            externalEmailTextField.isHidden = true
            usernameAndDomainsView.isHidden = false
            domainsView.isHidden = false
            domainsBottomSeparatorView.isHidden = false
            internalNameTextField.isHidden = false
            passwordTextField.isHidden = false
            confirmPasswordTextField.isHidden = false
        case .none: break
        }
        let title = signupAccountType == .external ? CoreString._su_email_address_button
        : CoreString._su_proton_address_button
        otherAccountButton.setTitle(title, for: .normal)
        configureDomainSuffix()
    }
    
    private func configureDomainSuffix() {
        guard minimumAccountType != .external else {
            domainsView.isHidden = false
            domainsBottomSeparatorView.isHidden = false
            return
        }
        
        guard showSeparateDomainsButton else {
            domainsView.isHidden = true
            domainsBottomSeparatorView.isHidden = true
            internalNameTextField.suffix = "@\(viewModel.currentlyChosenSignUpDomain)"
            return
        }
        
        domainsView.isHidden = false
        domainsButton.setTitle("System: \(viewModel.currentlyChosenSignUpDomain)", for: .normal)
        
        if viewModel.allSignUpDomains.count > 1 {
            domainsButton.isUserInteractionEnabled = true
            domainsButton.setMode(mode: .outlined)
        } else {
            domainsButton.isUserInteractionEnabled = false
            domainsButton.setMode(mode: .outlined)
        }
    }
    
    private func setupDomainsView() {
        domainsButton.setMode(mode: .outlined)
        domainsLabel.textColor = ColorProvider.TextNorm
        domainsLabel.text = "Auth Version"
    }
    
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
            nextButton.isEnabled = viewModel.isEmailValid(email: internalNameTextField.value)
        } else {
            nextButton.isEnabled = viewModel.isEmailValid(email: internalNameTextField.value)
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
        
    }
    
    private func checkEmail(email: String) {
        lockUI()
        viewModel.checkExternalEmailAccount(email: email) { result in
            self.unlockUI()
            self.nextButton.isSelected = false
            switch result {
            case .success:
                self.delegate?.validatedEmail(email: email, signupAccountType: self.signupAccountType)
            case .failure(let error):
                switch error {
                case .generic(let message, let code, _):
                    if code == APIErrorCode.humanVerificationAddressAlreadyTaken {
                        self.delegate?.hvEmailAlreadyExists(email: email)
                    } else if self.customErrorPresenter?.willPresentError(error: error, from: self) == true { } else {
                        self.showError(message: message)
                    }
                case .notAvailable(let message):
                    self.currentlyUsedTextField.isError = true
                    if self.customErrorPresenter?.willPresentError(error: error, from: self) == true { } else {
                        self.showError(message: message)
                    }
                }
            }
        } editEmail: {
            self.unlockUI()
            self.nextButton.isSelected = false
            _ = self.currentlyUsedTextField.becomeFirstResponder()
        }
    }
    
    private func showError(message: String) {
        showBanner(message: message, position: PMBannerPosition.top)
    }
    
    private func requestValidationToken(email: String) {
        lockUI()
        
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
