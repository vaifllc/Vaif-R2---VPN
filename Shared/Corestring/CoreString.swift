//
//  CoreString.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/26/22.
//

import Foundation

public var CoreString = LocalizedString()

public class LocalizedString {

    // Human verification

    /// Title
    public lazy var _hv_title = NSLocalizedString("Human Verification", comment: "Title")

    /// Captcha method name
    public lazy var _hv_captha_method_name = NSLocalizedString("CAPTCHA", comment: "captha method name")

    /// sms method name
    public lazy var _hv_sms_method_name = NSLocalizedString("SMS", comment: "SMS method name")

    /// email method name
    public lazy var _hv_email_method_name = NSLocalizedString("Email", comment: "email method name")

    /// Help button
    public lazy var _hv_help_button = NSLocalizedString("Help", comment: "Help button")

    /// OK button
    public lazy var _hv_ok_button = NSLocalizedString("OK", comment: "OK button")

    /// Cancel button
    public lazy var _hv_cancel_button = NSLocalizedString("Cancel", comment: "Cancel button")

    // Human verification - email method

    /// Email enter label
    public lazy var _hv_email_enter_label = NSLocalizedString("Your email will only be used for this one-time verification.", comment: "Enter email label")

    /// Email  label
    public lazy var _hv_email_label = NSLocalizedString("Email", comment: "Email label")

    /// Email  verification button
    public lazy var _hv_email_verification_button = NSLocalizedString("Get verification code", comment: "Verification button")

    // Human verification - sms method

    /// SMS enter label
    public lazy var _hv_sms_enter_label = NSLocalizedString("Your phone number will only be used for this one-time verification.", comment: "Enter SMS label")

    /// SMS  label
    public lazy var _hv_sms_label = NSLocalizedString("Phone number", comment: "SMS label")

    /// Search country placeholder
    public lazy var _hv_sms_search_placeholder = NSLocalizedString("Search country", comment: "Search country placeholder")

    // Human verification - verification

    /// Verification enter sms code label
    public lazy var _hv_verification_enter_sms_code = NSLocalizedString("Enter the verification code that was sent to %@", comment: "Enter sms code label")

    /// Verification enter email code label
    public lazy var _hv_verification_enter_email_code = NSLocalizedString("Enter the verification code that was sent to %@. If you don't find the email in your inbox, please check your spam folder.", comment: "Enter email code label")

    /// Verification code label
    public lazy var _hv_verification_code = NSLocalizedString("Verification code", comment: "Verification code label")

    /// Verification code hint label
    public lazy var _hv_verification_code_hint = NSLocalizedString("Enter the 6-digit code.", comment: "Verification code hint label")

    /// Verification code Verify button
    public lazy var _hv_verification_verify_button = NSLocalizedString("Verify", comment: "Verify button")

    /// Verification code Verifying button
    public lazy var _hv_verification_verifying_button = NSLocalizedString("Verifying", comment: "Verifying button")

    public lazy var _hv_verification_not_receive_code_button = NSLocalizedString("Did not receive the code?", comment: "Not receive code button")

    /// Verification code error alert title
    public lazy var _hv_verification_error_alert_title = NSLocalizedString("Invalid verification code", comment: "alert title")

    /// Verification code error alert message
    public lazy var _hv_verification_error_alert_message = NSLocalizedString("Would you like to receive a new verification code or use an alternative verification method?", comment: "alert message")

    /// Verification code error alert resend button
    public lazy var _hv_verification_error_alert_resend = NSLocalizedString("Resend", comment: "resend alert button")

    /// Verification code error alert try other method button
    public lazy var _hv_verification_error_alert_other_method = NSLocalizedString("Try other method", comment: "other method alert button")

    /// Verification new code alert title
    public lazy var _hv_verification_new_alert_title = NSLocalizedString("Request new code?", comment: "alert title")

    /// Verification new code alert message
    public lazy var _hv_verification_new_alert_message = NSLocalizedString("Get a replacement code sent to %@.", comment: "alert message")

    /// Verification new code alert new code button
    public lazy var _hv_verification_new_alert_button = NSLocalizedString("Request new code", comment: "new code alert button")

    /// Verification new code sent banner title
    public lazy var _hv_verification_sent_banner = NSLocalizedString("Code sent to %@", comment: "sent baner title")

    // Human verification - help

    /// Verification help header title
    public lazy var _hv_help_header = NSLocalizedString("Need help with human verification?", comment: "help header title")

    /// Verification help request item title
    public lazy var _hv_help_request_item_title = NSLocalizedString("Request an invite", comment: "request item title")

    /// Verification help request item message
    public lazy var _hv_help_request_item_message = NSLocalizedString("If you are having trouble creating your account, please request an invitation and we will respond within 1 business day.", comment: "request item message")

    /// Verification help visit item title
    public lazy var _hv_help_visit_item_title = NSLocalizedString("Visit our Help Center", comment: "visit item title")

    /// Verification help visit item message
    public lazy var _hv_help_visit_item_message = NSLocalizedString("Learn more about human verification and why we ask for it.", comment: "visit item message")

    // Force upgrade

    /// Force upgrade alert title
    public lazy var _fu_alert_title = NSLocalizedString("Update required", comment: "alert title")

    /// Force upgrade alert leran more button
    public lazy var _fu_alert_learn_more_button = NSLocalizedString("Learn more", comment: "learn more button")

    /// Force upgrade alert update button
    public lazy var _fu_alert_update_button = NSLocalizedString("Update", comment: "update button")

    /// Force upgrade alert quit button
    public lazy var _fu_alert_quit_button = NSLocalizedString("Quit", comment: "quit button")

    // Login screen

    /// Login screen title
    public lazy var _ls_screen_title = NSLocalizedString("Sign in", comment: "Login screen title")

    /// Login screen subtitle
    public lazy var _ls_screen_subtitle = NSLocalizedString("Enter your R2 Account information.", comment: "Login screen subtitle")

    /// Username field title
    public lazy var _ls_username_title = NSLocalizedString("Email address", comment: "Username field title")

    /// Password field title
    public lazy var _ls_password_title = NSLocalizedString("Password", comment: "Password field title")

    /// Help button
    public lazy var _ls_help_button = NSLocalizedString("Need help?", comment: "Help button")

    /// Sign in button
    public lazy var _ls_sign_in_button = NSLocalizedString("Sign in", comment: "Sign in button")

    /// Sign up button
    public lazy var _ls_create_account_button = NSLocalizedString("Create an account", comment: "Create account button")
    
    /// retry button
    public lazy var _retry_button = NSLocalizedString("Retry", comment: "Retry")

    // Login welcome screen

    public lazy var _ls_welcome_footer = NSLocalizedString("One account for all Proton services.", comment: "Welcome screen footer label")

    // Login help

    /// Login help screen title
    public lazy var _ls_help_screen_title = NSLocalizedString("How can we help?", comment: "Login help screen title")

    /// Forgot username help button
    public lazy var _ls_help_forgot_username = NSLocalizedString("Forgot username", comment: "Forgot username help button")

    /// Forgot password help button
    public lazy var _ls_help_forgot_password = NSLocalizedString("Forgot password", comment: "Forgot password help button")

    /// Other sign-in issues help button
    public lazy var _ls_help_other_issues = NSLocalizedString("Other sign-in issues", comment: "Other sign-in issues button")

    /// Customer support help button
    public lazy var _ls_help_customer_support = NSLocalizedString("Customer support", comment: "Customer support button")

    /// More help button
    public lazy var _ls_help_more_help = NSLocalizedString("Still need help? Contact us directly.", comment: "Customer support button")

    // Login validation

    /// Invalid username hint
    public lazy var _ls_validation_invalid_username = NSLocalizedString("Please enter your R2 Account email address.", comment: "Invalid username hint")

    /// Invalid password hint
    public lazy var _ls_validation_invalid_password = NSLocalizedString("Please enter your R2 Account password.", comment: "Invalid password hint")

    // Login errors

    /// Dialog button for missing keys error
    public lazy var _ls_error_missing_keys_text_button = NSLocalizedString("Complete Setup", comment: "Dialog button for missing keys error")

    /// Dialog text for missing keys error
    public lazy var _ls_error_missing_keys_text = NSLocalizedString("Your account is missing keys, please sign in on web to automatically generate required keys. Once you have signed in on web, please return to the app and sign in.", comment: "Dialog text for missing keys error")

    /// Dialog title for missing keys error
    public lazy var _ls_error_missing_keys_title = NSLocalizedString("Account setup required", comment: "Dialog title for missing keys error")

    /// Incorrect mailbox password error
    public lazy var _ls_error_invalid_mailbox_password = NSLocalizedString("Incorrect mailbox password", comment: "Incorrect mailbox password error")

    /// Generic error message when no better error can be displayed
    public lazy var _ls_error_generic = NSLocalizedString("An error has occured", comment: "Generic error message when no better error can be displayed")

    // Login choose username

    /// Screen title for picking Proton mail username
    public lazy var _ls_username_screen_title = NSLocalizedString("Create Proton Mail address", comment: "Screen title for creating Proton Mail address")

    /// Info about existing external Proton Mail address
    public lazy var _ls_username_screen_info = NSLocalizedString("Your Proton Account is associated with %@. To use %@, please create an address.", comment: "Info about existing external Proton Mail address")

    /// Username field title
    public lazy var _ls_username_username_title = NSLocalizedString("Username", comment: "Username field title")

    /// Action button title for picking Proton Mail username
    public lazy var _ls_username_button_title = NSLocalizedString("Next", comment: "Action button title for picking Proton Mail username")

    /// Username field error message
    public lazy var _ls_username_username_error = NSLocalizedString("Please enter a username.", comment: "Username field error message")

    // Login create address

    /// Action button title for creating Proton Mail address
    public lazy var _ls_create_address_button_title = NSLocalizedString("Create address", comment: "Action button title for creating Proton Mail address")

    /// Info about Proton Mail address usage
    public lazy var _ls_create_address_info = NSLocalizedString("You will use this email address to log into all Proton services.", comment: "Info about Proton Mail address usage")

    /// Recovery address label title
    public lazy var _ls_create_address_recovery_title = NSLocalizedString("Your recovery email address:", comment: "Recovery address label title")

    /// Terms and conditions note
    public lazy var _ls_create_address_terms_full = NSLocalizedString("By clicking Create address, you agree with Proton's Terms and Conditions.", comment: "Terms and conditions note")

    /// Terms and conditions link in the note
    public lazy var _ls_create_address_terms_link = NSLocalizedString("Terms and Conditions", comment: "Terms and conditions link in the note")

    /// Proton Mail address availability
    public lazy var _ls_create_address_available = NSLocalizedString("%@ is available", comment: "Proton Mail address availability")

    // Login unlock mailbox

    /// Mailbox unlock screen title
    public lazy var _ls_login_mailbox_screen_title = NSLocalizedString("Unlock your mailbox", comment: "Mailbox unlock screen title")

    /// Mailbox password field title
    public lazy var _ls_login_mailbox_field_title = NSLocalizedString("Mailbox password", comment: "Mailbox password field title")

    /// Mailbox unlock screen action button title
    public lazy var _ls_login_mailbox_button_title = NSLocalizedString("Unlock", comment: "Mailbox unlock screen action button title")

    /// Forgot password button title
    public lazy var _ls_login_mailbox_forgot_password = NSLocalizedString("Forgot password", comment: "Forgot password button title")

    // Login 2FA

    /// 2FA screen title
    public lazy var _ls_login_2fa_screen_title = NSLocalizedString("Two-factor authentication", comment: "2FA screen title")

    /// 2FA screen action button title
    public lazy var _ls_login_2fa_action_button_title = NSLocalizedString("Authenticate", comment: "2FA screen action button title")

    /// 2FA screen field title
    public lazy var _ls_login_2fa_field_title = NSLocalizedString("Two-factor code", comment: "2FA screen field title")

    /// 2FA screen recovery field title
    public lazy var _ls_login_2fa_recovery_field_title = NSLocalizedString("Recovery code", comment: "2FA screen recovery field title")

    /// 2FA screen recovery button title
    public lazy var _ls_login_2fa_recovery_button_title = NSLocalizedString("Use recovery code", comment: "2FA screen recovery button title")

    /// 2FA screen 2FA button title
    public lazy var _ls_login_2fa_2fa_button_title = NSLocalizedString("Use two-factor code", comment: "2FA screen 2FA button title")

    /// 2FA screen field info
    public lazy var _ls_login_2fa_field_info = NSLocalizedString("Enter the 6-digit code.", comment: "2FA screen field info")

    /// 2FA screen recovery field info
    public lazy var _ls_login_2fa_recovery_field_info = NSLocalizedString("Enter an 8-character recovery code.", comment: "2FA screen recovery field info")

    // Payments

    public lazy var _error_occured = NSLocalizedString("Error occured", comment: "Error alert title")

    /// "OK"
    public lazy var _general_ok_action = NSLocalizedString("OK", comment: "Action")

    /// "Warning"
    public lazy var _warning = NSLocalizedString("Warning", comment: "Title")

    /// UIAlerts
    public lazy var _do_you_want_to_bypass_validation = NSLocalizedString("Do you want to activate the purchase for %@ address?", comment: "Question is user wants to bypass username validation and activate plan for current username")

    public lazy var _yes_bypass_validation = NSLocalizedString("Yes, activate it for ", comment: "Warning message option to bypass validation and activate plan for current username")

    public lazy var _no_dont_bypass_validation = NSLocalizedString("No, for another Proton Mail account", comment: "Warning message option when user want to relogin to another account")
    
    public lazy var _popup_credits_applied_message = NSLocalizedString("We were unable to upgrade your account to the plan you selected, so we added your payment as credits to your account. For more information and to complete your upgrade, please contact Support.", comment: "Message shown to the user if we had to top up the account with credits instead of purchasing a plan")
    
    public lazy var _popup_credits_applied_confirmation = NSLocalizedString("Contact Support", comment: "Confirmation for the credits applied popup, will result in showing customer support contact form")
    
    public lazy var _popup_credits_applied_cancellation = NSLocalizedString("Dismiss", comment: "Cancellation for the credits applied popup")

    public lazy var _error_apply_payment_on_registration_title = NSLocalizedString("Payment failed", comment: "Error applying credit after registration alert")

    public lazy var _error_apply_payment_on_registration_message = NSLocalizedString("You have successfully registered but your payment was not processed. To resend your payment information, click Retry. You will only be charged once. If the problem persists, please contact customer support.", comment: "Error applying credit after registration alert")

    public lazy var _retry = NSLocalizedString("Retry", comment: "Button in some alerts")

    public lazy var _error_apply_payment_on_registration_support = NSLocalizedString("Contact customer support", comment: "Error applying credit after registration alert")

    /// Errors
    public lazy var _error_unavailable_product = NSLocalizedString("Failed to get list of available products from App Store.", comment: "Error message")

    public lazy var _error_invalid_purchase = NSLocalizedString("Purchase is not possible.", comment: "Error message")

    public lazy var _error_reciept_lost = NSLocalizedString("Apple informed us you've upgraded the service plan, but some technical data was missing. Please fill in the bug report and our customer support team will contact you.", comment: "Error message")

    public lazy var _error_another_user_transaction = NSLocalizedString("Apple informed us you've upgraded the service plan, but we detected you have logged out of the account since then.", comment: "Error message")

    public lazy var _error_backend_mismatch = NSLocalizedString("It wasn't possible to match your purchased App Store product to any products on our server. Please fill in the bug report and our customer support team will contact you.", comment: "Error message")

    public lazy var _error_sandbox_receipt = NSLocalizedString("Sorry, we cannot process purchases in the beta version of the iOS app. Thank you for participating in our public beta!", comment: "Error message for beta users")

    public lazy var _error_no_hashed_username_arrived_in_transaction = NSLocalizedString("We have been notified of an App Store purchase but cannot match the purchase with an account of yours.", comment: "Error message")

    public lazy var _error_no_active_username_in_user_data_service = NSLocalizedString("Please log in to the Proton Mail account you're upgrading the service plan for so we can complete the purchase.", comment: "Error message")

    public lazy var _error_transaction_failed_by_unknown_reason = NSLocalizedString("Apple informed us they could not process the purchase.", comment: "Error message")

    public lazy var _error_no_new_subscription_in_response = NSLocalizedString("We have successfully activated your subscription. Please relaunch the app to start using your new service plan.", comment: "Error message")

    public lazy var _error_unlock_to_proceed_with_iap = NSLocalizedString("Please unlock the app to proceed with your service plan activation", comment: "Error message")

    public lazy var _error_please_sign_in_iap = NSLocalizedString("Please log in to the Proton Mail account you're upgrading the service plan for so we can complete the service plan activation.", comment: "Error message")

    public lazy var _error_credits_applied = NSLocalizedString("Contact support@protonvpn.com to complete your purchase.", comment: "In App Purchase error")

    public lazy var _error_wrong_token_status = NSLocalizedString("Wrong payment token status. Please relaunch the app. If error persists, contact support.", comment: "In App Purchase error")

    //  Login upgrade username-only account

    /// Dialog title for organization user first login
    public lazy var _login_username_org_dialog_title = NSLocalizedString("Change your password", comment: "Dialog title for organization user first login")

    /// Dialog action button title for organization user first login
    public lazy var _login_username_org_dialog_action_button = NSLocalizedString("Change password", comment: "Dialog action button title for organization user first login")

    /// Dialog message for organization user first login
    public lazy var _login_username_org_dialog_message = NSLocalizedString("To use the Proton app as a member of an organization, you first need to change your password by signing into Proton through a browser.", comment: "Dialog message for organization user first login")
    
    /// Account deletion
    
    public lazy var _ad_delete_account_title = NSLocalizedString("Delete account", comment: "Delete account screen title")
    
    public lazy var _ad_delete_account_button = NSLocalizedString("Delete account", comment: "Delete account button title")
    
    public lazy var _ad_delete_account_message = NSLocalizedString("This will permanently delete your account and all of its data. You will not be able to reactivate this account.", comment: "Delete account explaination under button")
    
    public lazy var _ad_delete_account_success = NSLocalizedString("Account deleted.\nLogging out...", comment: "Delete account success")
    
    public lazy var _ad_delete_network_error = NSLocalizedString("A networking error has occured", comment: "A generic error message when we have no better message from the backend")
    
    public lazy var _ad_delete_close_button = NSLocalizedString("Close", comment: "Button title shown when a error has occured, causes the screen to close")

    /// Account switcher

    public lazy var _as_switch_to_title = NSLocalizedString("switch to", comment: "Section title of account switcher")

    public lazy var _as_accounts = NSLocalizedString("Accounts", comment: "Title of account switcher")

    public lazy var _as_manage_accounts = NSLocalizedString("Manage accounts", comment: "Manage accounts button")

    public lazy var _as_signed_in_to_protonmail = NSLocalizedString("Signed in to Proton Mail", comment: "Section title of account manager")

    public lazy var _as_signed_out_of_protonmail = NSLocalizedString("Signed out of Proton Mail", comment: "Section title of account manager")

    public lazy var _as_signout = NSLocalizedString("Sign out", comment: "Sign out button/ title")

    public lazy var _as_remove_account = NSLocalizedString("Remove account", comment: "remove account button")

    public lazy var _as_remove_account_alert_text = NSLocalizedString("You will be signed out and all the data associated with this account will be removed from this device.", comment: "Alert message of remove account")

    public lazy var _as_remove_button = NSLocalizedString("Remove", comment: "Remove button")

    public lazy var _as_signout_alert_text = NSLocalizedString("Are you sure you want to sign out %@?", comment: "Alert message of sign out the email address")

    public lazy var _as_dismiss_button = NSLocalizedString("Dismiss account switcher", comment: "Button for dismissing account switcher")
    
    public lazy var _as_sign_in_button = NSLocalizedString("Sign in to another account", comment: "Button for signing into another account")

    // Signup

    /// Signup main view title
    public lazy var _su_main_view_title = NSLocalizedString("Create your Proton Account", comment: "Signup main view title")

    /// Signup main view description
    public lazy var _su_main_view_desc = NSLocalizedString("One account for all Proton services.", comment: "Signup main view description")

    /// Next button
    public lazy var _su_next_button = NSLocalizedString("Next", comment: "Next button")

    /// Sign in button
    public lazy var _su_signin_button = NSLocalizedString("Sign in", comment: "Sign in button")

    /// Email address button
    public lazy var _su_email_address_button = NSLocalizedString("Use your current email instead", comment: "Email address button")

    /// Proton Mail address  button
    public lazy var _su_proton_address_button = NSLocalizedString("Create a secure Proton Mail address instead", comment: "Proton Mail address button")

    /// Username field title
    public lazy var _su_username_field_title = NSLocalizedString("Username", comment: "Username field title")

    /// Email field title
    public lazy var _su_email_field_title = NSLocalizedString("Email", comment: "Email field title")

    /// Signup password proton view title
    public lazy var _su_password_proton_view_title = NSLocalizedString("Create your password", comment: "Signup password proton view title")

    /// Signup password email view title
    public lazy var _su_password_email_view_title = NSLocalizedString("Create a Proton account with your current email", comment: "Signup password email view title")

    /// Password field title
    public lazy var _su_password_field_title = NSLocalizedString("Password", comment: "Password field title")

    public lazy var _su_password_field_hint = NSLocalizedString("Password must contain at least 8 characters", comment: "Password field hint about minimum length")

    /// Repeat password field title
    public lazy var _su_repeat_password_field_title = NSLocalizedString("Repeat password", comment: "Repeat password field title")
    
    public lazy var _su_domains_sheet_title = NSLocalizedString("Domain", comment: "Title of domains bottom action sheet")

    // TODO: CP-2352 — remove the default value once the text is translated to all languages
    
    /// Signup recovery view title
    public lazy var _su_recovery_view_title = NSLocalizedString(
        "Set recovery method",
        tableName: nil,
       
        value: _su_recovery_method_button,
        comment: "Recovery view title"
    )
    
    /// Signup recovery view title optional
    public lazy var _su_recovery_view_title_optional = NSLocalizedString(
        "Set recovery method (optional)",
        tableName: nil,
       
        value: _su_recovery_method_button,
        comment: "Recovery view title optional"
    )

    // TODO: CP-2352 — remove the string once the new text (below) is translated to all languages
    /// Signup recovery view description — old string
    public lazy var _su_recovery_view_desc_old = NSLocalizedString("This will help you access your account in case you forget your password or get locked out of your account.", comment: "Recovery view description (old string, replaced)")

    // TODO: CP-2352 — remove the default value once the text is translated to all languages
    /// Signup recovery view description
    public lazy var _su_recovery_view_desc = NSLocalizedString(
        "We will send recovery instructions to this email or phone number if you get locked out of your account.",
        tableName: nil,
       
        value: _su_recovery_view_desc_old,
        comment: "Recovery view description"
    )
    
    public lazy var _su_recovery_email_only_view_desc = NSLocalizedString(
        "We will send recovery instructions to this email if you get locked out of your account.",
        tableName: nil,
       
        value: _su_recovery_view_desc_old,
        comment: "Recovery view description"
    )

    /// Signup recovery segmented email
    public lazy var _su_recovery_seg_email = NSLocalizedString("Email", comment: "Recovery segmenet email")

    /// Signup recovery segmented phone
    public lazy var _su_recovery_seg_phone = NSLocalizedString("Phone", comment: "Recovery segmenet phone")

    /// Signup recovery email field title
    public lazy var _su_recovery_email_field_title = NSLocalizedString("Recovery email", comment: "Recovery email field title")

    /// Signup recovery phone field title
    public lazy var _su_recovery_phone_field_title = NSLocalizedString("Recovery phone number", comment: "Recovery phone field title")

    /// Signup recovery terms and conditions description
    public lazy var _su_recovery_t_c_desc = NSLocalizedString("By clicking Next, you agree with Proton's Terms and Conditions", comment: "Recovery terms and conditions description")

    /// Signup recovery terms and conditions link
    public lazy var _su_recovery_t_c_link = NSLocalizedString("Terms and Conditions", comment: "Recovery terms and conditions link")

    /// Skip button
    public lazy var _su_skip_button = NSLocalizedString("Skip", comment: "Skip button")

    /// Recovery skip title
    public lazy var _su_recovery_skip_title = NSLocalizedString("Skip recovery method?", comment: "Recovery skip title")

    /// Recovery skip description
    public lazy var _su_recovery_skip_desc = NSLocalizedString("A recovery method will help you access your account in case you forget your password or get locked out of your account.", comment: "Recovery skip description")

    /// Recovery method button
    public lazy var _su_recovery_method_button = NSLocalizedString("Set recovery method", comment: "Set recovery method button")

    /// Signup complete view title
    public lazy var _su_complete_view_title = NSLocalizedString("Your account is being created", comment: "Complete view title")

    /// Signup complete view description
    public lazy var _su_complete_view_desc = NSLocalizedString("This should take no more than a minute.", comment: "Complete view description")

    /// Signup complete progress step creation
    public lazy var _su_complete_step_creation = NSLocalizedString("Creating your account", comment: "Signup complete progress step creation")
    
    /// Signup complete progress step address generation
    public lazy var _su_complete_step_address_generation = NSLocalizedString("Generating your address", comment: "Signup complete progress step address generation")
    
    /// Signup complete progress step keys generation
    public lazy var _su_complete_step_keys_generation = NSLocalizedString("Securing your account", comment: "Signup complete progress step keys generation")
    
    /// Signup complete progress step payment validation
    public lazy var _su_complete_step_payment_verification = NSLocalizedString("Verifying your payment", comment: "Signup complete progress step payment verification")
    
    /// Signup complete progress step payment validated
    public lazy var _su_complete_step_payment_validated = NSLocalizedString("Payment validated", comment: "Signup complete progress step payment validated")

    /// Signup email verification view title
    public lazy var _su_email_verification_view_title = NSLocalizedString("Account verification", comment: "Email verification view title")

    /// Signup email verification view description
    public lazy var _su_email_verification_view_desc = NSLocalizedString("For your security, we must verify that the address you entered belongs to you. We sent a verification code to %@. Please enter the code below:", comment: "Email verification view description")

    /// Signup email verification code name
    public lazy var _su_email_verification_code_name = NSLocalizedString("Verification code", comment: "Email verification code name")

    /// Signup email verification code description
    public lazy var _su_email_verification_code_desc = NSLocalizedString("Enter the 6-digit code.", comment: "Email verification code description")

    /// Did not receive code button
    public lazy var _su_did_not_receive_code_button = NSLocalizedString("Did not receive a code?", comment: "Did not receive code button")

    /// Signup terms and conditions view title
    public lazy var _su_terms_conditions_view_title = NSLocalizedString("Terms and Conditions", comment: "Terms and conditions view title")

    /// Signup error invalid token request
    public lazy var _su_error_invalid_token_request = NSLocalizedString("Invalid token request", comment: "Invalid token request error")

    /// Signup error invalid token
    public lazy var _su_error_invalid_token = NSLocalizedString("Invalid token error", comment: "Invalid token error")

    /// Signup error create user failed
    public lazy var _su_error_create_user_failed = NSLocalizedString("Create user failed", comment: "Create user failed error")

    /// Signup error invalid hashed password
    public lazy var _su_error_invalid_hashed_password = NSLocalizedString("Invalid hashed password", comment: "Invalid hashed password error")

    /// Signup error password empty
    public lazy var _su_error_password_empty = NSLocalizedString("Password can not be empty.\nPlease try again.", comment: "Password empty error")

    public lazy var _su_error_password_too_short = NSLocalizedString("Password must contain at least %@ characters.", comment: "Password too short error")

    /// Signup error password not equal
    public lazy var _su_error_password_not_equal = NSLocalizedString("Passwords do not match.\nPlease try again.", comment: "Password not equal error")

    /// Signup error email address already used
    public lazy var _su_error_email_already_used = NSLocalizedString("Email address already used.", comment: "Email address already used error")
    
    /// Signup error email address already used
    public lazy var _su_error_missing_sub_user_configuration = NSLocalizedString("Please ask your admin to configure your sub-user.", comment: "Sub-user configuration error")

    /// Signup invalid verification alert message
    public lazy var _su_invalid_verification_alert_message = NSLocalizedString("Would you like to receive a new verification code or use an alternate email address?", comment: "Invalid verification alert message")

    /// Signup invalid verification change email address button
    public lazy var _su_invalid_verification_change_email_button = NSLocalizedString("Change email address", comment: "Change email address button")
    
    /// Signup summary title
    public lazy var _su_summary_title = NSLocalizedString("Congratulations", comment: "Signup summary title")
    
    /// Signup summary free plan description
    public lazy var _su_summary_free_description = NSLocalizedString("Your Proton Free account was successfully created.", comment: "Signup summary free plan description")
    
    /// Signup summary free plan description replacement
    public lazy var _su_summary_free_description_replacement = NSLocalizedString("Proton Free", comment: "Signup summary free plan description replacement")
    
    /// Signup summary paid plan description
    public lazy var _su_summary_paid_description = NSLocalizedString("Your payment was confirmed and your %@ account successfully created.", comment: "Signup summary paid plan description")
    
    /// Signup summary welcome text
    public lazy var _su_summary_welcome = NSLocalizedString("Enjoy the world of privacy.", comment: "Signup summary welcome text")
    
    // Payments UI
    
    /// Select a plan title
    public lazy var _pu_select_plan_title = NSLocalizedString("Select a plan", comment: "Plan selection title")

    /// Current plan title
    public lazy var _pu_current_plan_title = NSLocalizedString("Current plan", comment: "Plan selection title")
    
    /// Subscription title
    public lazy var _pu_subscription_title = NSLocalizedString("Subscription", comment: "Subscription title")
  
    /// Upgrade plan title
    public lazy var _pu_upgrade_plan_title = NSLocalizedString("Upgrade your plan", comment: "Plan selection title")
    
    /// Plan footer description
    public lazy var _pu_plan_footer_desc = NSLocalizedString("Only annual subscriptions without auto-renewal are available inside the mobile app.", comment: "Plan footer description")

    /// Plan footer description purchased
    public lazy var _pu_plan_footer_desc_purchased = NSLocalizedString("You cannot manage subscriptions inside the mobile application.", comment: "Plan footer purchased description")
    
    /// Select plan button
    public lazy var _pu_select_plan_button = NSLocalizedString("Select", comment: "Select plan button")
    
    /// Upgrade plan button
    public lazy var _pu_upgrade_plan_button = NSLocalizedString("Upgrade", comment: "Upgrade plan button")
   
    /// Plan details renew automatically expired
    public lazy var _pu_plan_details_renew_auto_expired = NSLocalizedString("Your plan will automatically renew on %@", comment: "Plan details renew automatically expired")
    
    /// Plan details renew expired
    public lazy var _pu_plan_details_renew_expired = NSLocalizedString("Current plan will expire on %@", comment: "Plan details renew expired")

    /// Plan details unavailable contact administrator
    public lazy var _pu_plan_details_plan_details_unavailable_contact_administrator = NSLocalizedString("Contact an administrator to make changes to your Proton subscription.", comment: "Plan details unavailable contact administrator")
    
    /// Plan details storage
    public lazy var _pu_plan_details_storage = NSLocalizedString("%@ storage", comment: "Plan details storage")

    /// Plan details storage per user
    public lazy var _pu_plan_details_storage_per_user = NSLocalizedString("%@ storage / user", comment: "Plan details storage per user")

    /// Plan details medium speed
    public lazy var _pu_plan_details_vpn_free_speed = NSLocalizedString("Medium speed", comment: "Plan details medium speed")
    
    /// Plan details custom email addresses
    public lazy var _pu_plan_details_custom_email = NSLocalizedString("Custom email addresses", comment: "Plan details custom email addresses")
    
    /// Plan details priority customer support
    public lazy var _pu_plan_details_priority_support = NSLocalizedString("Priority customer support", comment: "Plan details priority customer support")
    
    /// Plan details adblocker
    public lazy var _pu_plan_details_adblocker = NSLocalizedString("Adblocker (NetShield)", comment: "Plan details adblocker")
    
    /// Plan details adblocker
    public lazy var _pu_plan_details_streaming_service = NSLocalizedString("Streaming service support", comment: "Plan details streaming service support")

    /// Plan details n uneven amount of addresses & calendars
    public lazy var _pu_plan_details_n_uneven_amounts_of_addresses_and_calendars = NSLocalizedString("%@ & %@", comment: "Plan details n uneven amount of addresses & calendars, like: 1 address & 2 calendars")

    /// Plan details high speed message
    public lazy var _pu_plan_details_high_speed = NSLocalizedString("High speed", comment: "Plan details high speed message")

    /// Plan details highest speed message
    public lazy var _pu_plan_details_highest_speed = NSLocalizedString("Highest speed", comment: "Plan details highest speed message")

    /// Plan details high speed message
    public lazy var _pu_plan_details_multi_user_support = NSLocalizedString("Multi-user support", comment: "Plan details multi-user support message")
    
    /// Plan details free description
    public lazy var _pu_plan_details_free_description = NSLocalizedString("The basic for private and secure communications.", comment: "Plan details free description")
    
    /// Plan details plus description
    public lazy var _pu_plan_details_plus_description = NSLocalizedString("Full-featured mailbox with advanced protection.", comment: "Plan details plus description")
    
    /// Plan details plus description
    public lazy var _pu_plan_details_pro_description = NSLocalizedString("Proton Mail for professionals and businesses", comment: "Plan details pro description")
    
    /// Plan details visionary description
    public lazy var _pu_plan_details_visionary_description = NSLocalizedString("Mail + VPN bundle for families and small businesses", comment: "Plan details visionary description")
    
    /// Unfinished operation error dialog title
    public lazy var _pu_plan_unfinished_error_title = NSLocalizedString("Complete payment?", comment: "Unfinished operation error dialog title")
    
    /// Unfinished operation error dialog description
    public lazy var _pu_plan_unfinished_error_desc = NSLocalizedString("A purchase for a Proton Bundle plan has already been initiated. Press continue to complete the payment processing and create your account", comment: "Unfinished operation error dialog description")
    
    /// Unfinished operation error dialog retry button
    public lazy var _pu_plan_unfinished_error_retry_button = NSLocalizedString("Complete payment", comment: "Unfinished operation error dialog retry button")
    
    /// Unfinished operation dialog description
    public lazy var _pu_plan_unfinished_desc = NSLocalizedString("The account setup process could not be finalized due to an unexpected error.\nPlease try again.", comment: "Unfinished operation dialog description")
    
    // IAP in progress banner message
    public lazy var _pu_iap_in_progress_banner = NSLocalizedString("The IAP purchase process has started. Please follow Apple's instructions to either complete or cancel the purchase.", comment: "IAP in progress banner message")

// Splash

    /// Part of "Made by Proton" text at the bottom of the splash screen
    public lazy var _splash_made_by = NSLocalizedString("Made by", comment: "Made by")

// Networking

    /// Networking connection error
    public lazy var _net_connection_error = NSLocalizedString("Network connection error", comment: "Networking connection error")
    
    /// Networking connection error
    public lazy var _net_insecure_connection_error = NSLocalizedString("The TLS certificate validation failed when trying to connect to the Proton API. Your current Internet connection may be monitored. To keep your data secure, we are preventing the app from accessing the Proton API.\nTo log in or access your account, switch to a new network and try to connect again.", comment: "Networking insecure connection error")
    
    public static var _5Connections: String { return LocalizedString.tr("Localizable", "_5_connections") }
    /// Connect up to 5 devices
    /// at the same time
    public static var _5ConnectionsDescription: String { return LocalizedString.tr("Localizable", "_5_connections_description") }
    /// About
    public static var about: String { return LocalizedString.tr("Localizable", "_about") }
    /// Account
    public static var account: String { return LocalizedString.tr("Localizable", "_account") }
    /// Deleting your account will end your VPN session.
    public static var accountDeletionConnectionWarning: String { return LocalizedString.tr("Localizable", "_account_deletion_connection_warning") }
    /// Error
    public static var accountDeletionError: String { return LocalizedString.tr("Localizable", "_account_deletion_error") }
    /// Account plan
    public static var accountPlan: String { return LocalizedString.tr("Localizable", "_account_plan") }
    /// Account type
    public static var accountType: String { return LocalizedString.tr("Localizable", "_account_type") }
    /// Acknowledgements
    public static var acknowledgements: String { return LocalizedString.tr("Localizable", "_acknowledgements") }
    /// Action
    public static var action: String { return LocalizedString.tr("Localizable", "_action") }
    /// Your connection needs to be restarted to apply this change
    public static var actionRequiresReconnect: String { return LocalizedString.tr("Localizable", "_action_requires_reconnect") }
    /// Activate Widget
    public static var activateWidget: String { return LocalizedString.tr("Localizable", "_activate_widget") }
    /// From your homescreen, swipe to the left most screen to access your widgets.
    public static var activateWidgetStep1: String { return LocalizedString.tr("Localizable", "_activate_widget_step_1") }
    /// Scroll all the way down and tap the edit button.
    public static var activateWidgetStep2: String { return LocalizedString.tr("Localizable", "_activate_widget_step_2") }
    /// Add the Proton VPN widget to the list of active widgets.
    public static var activateWidgetStep3: String { return LocalizedString.tr("Localizable", "_activate_widget_step_3") }
    /// Adblocker (NetShield)
    public static var adblockerNetshieldFeature: String { return LocalizedString.tr("Localizable", "_adblocker_netshield_feature") }
    /// Advanced
    public static var advanced: String { return LocalizedString.tr("Localizable", "_advanced") }
    /// + Advanced features
    public static var advancedFeatures: String { return LocalizedString.tr("Localizable", "_advanced_features") }
    /// Unable to obtain vpn information
    public static var aeVpnInfoNotReceived: String { return LocalizedString.tr("Localizable", "_ae_vpn_info_not_received") }
    /// Wrong username or password
    public static var aeWrongLoginCredentials: String { return LocalizedString.tr("Localizable", "_ae_wrong_login_credentials") }
    /// 60+ countries
    public static var allCountries: String { return LocalizedString.tr("Localizable", "_all_countries") }
    /// All servers in this country are under maintenance. Please connect to another country.
    public static var allServersInCountryUnderMaintenance: String { return LocalizedString.tr("Localizable", "_all_servers_in_country_under_maintenance") }
    /// Profile server(s) under maintenance
    public static var allServersInProfileUnderMaintenance: String { return LocalizedString.tr("Localizable", "_all_servers_in_profile_under_maintenance") }
    /// All servers are under maintenance. This usually means either there are technical difficulties on Proton VPN's side, or your network is limited.
    public static var allServersUnderMaintenance: String { return LocalizedString.tr("Localizable", "_all_servers_under_maintenance") }
    /// Allow
    public static var allow: String { return LocalizedString.tr("Localizable", "_allow") }
    /// In order to allow LAN access, kill switch must be turned off.
    ///
    /// Continue?
    public static var allowLanDescription: String { return LocalizedString.tr("Localizable", "_allow_lan_description") }
    /// Allows to bypass the VPN and connect to devices on your local network, like your printer.
    public static var allowLanInfo: String { return LocalizedString.tr("Localizable", "_allow_lan_info") }
    /// Note that your connection needs to be restarted to apply this change
    public static var allowLanNote: String { return LocalizedString.tr("Localizable", "_allow_lan_note") }
    /// Allow LAN connections
    public static var allowLanTitle: String { return LocalizedString.tr("Localizable", "_allow_lan_title") }
    /// I already have an account
    public static var alreadyHaveAccount: String { return LocalizedString.tr("Localizable", "_already_have_account") }
    /// Always-on VPN
    public static var alwaysOnVpn: String { return LocalizedString.tr("Localizable", "_always_on_vpn") }
    /// Always-on VPN reestablishes a secure VPN connection swiftly and automatically. For your security, this feature is always on.
    public static var alwaysOnVpnTooltipIos: String { return LocalizedString.tr("Localizable", "_always_on_vpn_tooltip_ios") }
    /// Always-on VPN will reconnect you automatically
    public static var alwaysOnWillReconnect: String { return LocalizedString.tr("Localizable", "_always_on_will_reconnect") }
    /// Application Logs
    public static var applicationLogs: String { return LocalizedString.tr("Localizable", "_application_logs") }
    /// Applying settings
    public static var applyingSettings: String { return LocalizedString.tr("Localizable", "_applying_settings_") }
    /// Auto assigned
    public static var autoAssigned: String { return LocalizedString.tr("Localizable", "_auto_assigned") }
    /// Auto Connect
    public static var autoConnect: String { return LocalizedString.tr("Localizable", "_auto_connect") }
    /// On app start, you are connected to the selected profile
    public static var autoConnectTooltip: String { return LocalizedString.tr("Localizable", "_auto_connect_tooltip") }
    /// All traffic on your phone will be managed through OpenVPN, therefore iOS will allocate the battery usage of other apps to Proton VPN.
    public static var batteryDescription: String { return LocalizedString.tr("Localizable", "_battery_description") }
    /// Want to learn more?
    public static var batteryMore: String { return LocalizedString.tr("Localizable", "_battery_more") }
    /// Battery usage
    public static var batteryTitle: String { return LocalizedString.tr("Localizable", "_battery_title") }
    /// Cancel
    public static var cancel: String { return LocalizedString.tr("Localizable", "_cancel") }
    /// This will cancel any re-connection attempt and leave you disconnected
    public static var cancelReconnection: String { return LocalizedString.tr("Localizable", "_cancel_reconnection") }
    /// Changing protocols will end your current VPN session.
    public static var changeProtocolDisconnectWarning: String { return LocalizedString.tr("Localizable", "_change_protocol_disconnect_warning") }
    /// Change settings
    public static var changeSettings: String { return LocalizedString.tr("Localizable", "_change_settings") }
    /// Changelog
    public static var changelog: String { return LocalizedString.tr("Localizable", "_changelog") }
    /// Please check if all the fields are filled in
    public static var checkIfFieldsPresent: String { return LocalizedString.tr("Localizable", "_check_if_fields_present") }
    /// Choose Subscription
    public static var choosePlan: String { return LocalizedString.tr("Localizable", "_choose_plan") }
    /// City
    public static var city: String { return LocalizedString.tr("Localizable", "_city") }
    /// Clear Application Data
    public static var clearApplicationData: String { return LocalizedString.tr("Localizable", "_clear_application_data") }
    /// Close
    public static var close: String { return LocalizedString.tr("Localizable", "_close") }
    /// Collapse list of servers
    public static var collapseListOfServers: String { return LocalizedString.tr("Localizable", "_collapse_list_of_servers") }
    /// Color
    public static var color: String { return LocalizedString.tr("Localizable", "_color") }
    /// Common sign in issues
    public static var commonIssues: String { return LocalizedString.tr("Localizable", "_common_issues") }
    /// Connect
    public static var connect: String { return LocalizedString.tr("Localizable", "_connect") }
    /// Connected
    public static var connected: String { return LocalizedString.tr("Localizable", "_connected") }
    /// Connected to
    public static var connectedTo: String { return LocalizedString.tr("Localizable", "_connected_to") }
    /// Connected to %@
    public static func connectedToVpn(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_connected_to_vpn", String(describing: p1))
    }
    /// Connecting
    public static var connecting: String { return LocalizedString.tr("Localizable", "_connecting") }
    /// Connecting to %@
    public static func connectingTo(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_connecting_to", String(describing: p1))
    }
    /// Connecting %@
    public static func connectingVpn(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_connecting_vpn", String(describing: p1))
    }
    /// Connecting...
    public static var connectingDotDotDot: String { return LocalizedString.tr("Localizable", "_connectingDotDotDot") }
    /// Connection
    public static var connection: String { return LocalizedString.tr("Localizable", "_connection") }
    /// Connection Failed
    public static var connectionFailed: String { return LocalizedString.tr("Localizable", "_connection_failed") }
    /// Connection settings
    public static var connectionSettings: String { return LocalizedString.tr("Localizable", "_connection_settings") }
    /// Contact our support
    public static var contactOurSupport: String { return LocalizedString.tr("Localizable", "_contact_our_support") }
    /// Continue
    public static var `continue`: String { return LocalizedString.tr("Localizable", "_continue") }
    /// Countries
    public static var countries: String { return LocalizedString.tr("Localizable", "_countries") }
    /// Plural format key: "%#@VARIABLE@"
    public static func countriesCount(_ p1: Int) -> String {
      return LocalizedString.tr("Localizable", "_countries_count", p1)
    }
    /// Plural format key: "%#@VARIABLE@"
    public static func countriesCountPlus(_ p1: Int) -> String {
      return LocalizedString.tr("Localizable", "_countries_count_plus", p1)
    }
    /// Free countries
    public static var countriesFree: String { return LocalizedString.tr("Localizable", "_countries_free") }
    /// Premium countries
    public static var countriesPremium: String { return LocalizedString.tr("Localizable", "_countries_premium") }
    /// Choose which country and server you would like to use for your end IP address.
    public static var countriesTourDescription: String { return LocalizedString.tr("Localizable", "_countries_tour_description") }
    /// Countries
    public static var countriesTourTitle: String { return LocalizedString.tr("Localizable", "_countries_tour_title") }
    /// Country
    public static var country: String { return LocalizedString.tr("Localizable", "_country") }
    /// Please select a country
    public static var countrySelectionIsRequired: String { return LocalizedString.tr("Localizable", "_country_selection_is_required") }
    /// %@ servers under maintenance
    public static func countryServersUnderMaintenance(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_country_servers_under_maintenance", String(describing: p1))
    }
    /// Create Account
    public static var createAccount: String { return LocalizedString.tr("Localizable", "_create_account") }
    /// Create Profile
    public static var createNewProfile: String { return LocalizedString.tr("Localizable", "_create_new_profile") }
    /// Create Profile
    public static var createProfile: String { return LocalizedString.tr("Localizable", "_create_profile") }
    /// By continuing, current selection will be lost. Do you want to continue?
    public static var currentSelectionWillBeLost: String { return LocalizedString.tr("Localizable", "_current_selection_will_be_lost") }
    /// Agree & Continue
    public static var dataDisclaimerAgree: String { return LocalizedString.tr("Localizable", "_data_disclaimer_agree") }
    /// Your device model and OS version
    public static var dataDisclaimerDeviceDetails: String { return LocalizedString.tr("Localizable", "_data_disclaimer_device_details") }
    /// Proton VPN is committed to protecting and respecting your privacy. It is our overriding policy to collect as little user data as possible to ensure a private and anonymous user experience in the use of the App, specifically:
    ///
    /// %@ – to log you in, help to recover a lost password, and send important service updates.
    ///
    /// %@ – for crash reports and errors only.
    ///
    /// The Proton VPN App does not process any user information besides this data. We don't log your online activity nor any personal identifiable information. All data listed above is stored and processed on Proton VPN's own system, with no third party ever having access to it.
    public static func dataDisclaimerText(_ p1: Any, _ p2: Any) -> String {
      return LocalizedString.tr("Localizable", "_data_disclaimer_text", String(describing: p1), String(describing: p2))
    }
    /// Protect yourself online
    public static var dataDisclaimerTitle: String { return LocalizedString.tr("Localizable", "_data_disclaimer_title") }
    /// Username, email address
    public static var dataDisclaimerUserDetails: String { return LocalizedString.tr("Localizable", "_data_disclaimer_user_details") }
    /// "Quick Connect" button uses default profile.
    ///
    public static var defaultProfileTooltip: String { return LocalizedString.tr("Localizable", "_default_profile_tooltip") }
    /// Delete
    public static var delete: String { return LocalizedString.tr("Localizable", "_delete") }
    /// All Proton VPN data will be deleted and the application will quit. Do you wish to continue?
    public static var deleteApplicationDataPopupBody: String { return LocalizedString.tr("Localizable", "_delete_application_data_popup_body") }
    /// Clear application data
    public static var deleteApplicationDataPopupTitle: String { return LocalizedString.tr("Localizable", "_delete_application_data_popup_title") }
    /// Delete profile
    public static var deleteProfile: String { return LocalizedString.tr("Localizable", "_delete_profile") }
    /// Delete Profile
    public static var deleteProfileHeader: String { return LocalizedString.tr("Localizable", "_delete_profile_header") }
    /// The profile will be permanently deleted. Do you want to continue?
    public static var deleteProfileWarning: String { return LocalizedString.tr("Localizable", "_delete_profile_warning") }
    /// You will be able to access premium features again after these are paid.
    public static var delinquentDescription: String { return LocalizedString.tr("Localizable", "_delinquent_description") }
    /// You will be able to access premium features again after these are paid. For now, we are reconnecting to the fastest Free plan server available.
    public static var delinquentReconnectionDescription: String { return LocalizedString.tr("Localizable", "_delinquent_reconnection_description") }
    /// Your VPN account has pending invoices
    public static var delinquentTitle: String { return LocalizedString.tr("Localizable", "_delinquent_title") }
    /// Your account currently has an overdue invoice. Please pay all unpaid invoices at account.protonvpn.com
    public static var delinquentUserDescription: String { return LocalizedString.tr("Localizable", "_delinquent_user_description") }
    /// Unpaid invoice
    public static var delinquentUserTitle: String { return LocalizedString.tr("Localizable", "_delinquent_user_title") }
    /// Different server each time
    public static var differentServerEachTime: String { return LocalizedString.tr("Localizable", "_different_server_each_time") }
    /// Disable
    public static var disable: String { return LocalizedString.tr("Localizable", "_disable") }
    /// Disabled
    public static var disabled: String { return LocalizedString.tr("Localizable", "_disabled") }
    /// Disconnect
    public static var disconnect: String { return LocalizedString.tr("Localizable", "_disconnect") }
    /// Disconnected
    public static var disconnected: String { return LocalizedString.tr("Localizable", "_disconnected") }
    /// Disconnecting
    public static var disconnecting: String { return LocalizedString.tr("Localizable", "_disconnecting") }
    /// Discover the app
    public static var discoverTheApp: String { return LocalizedString.tr("Localizable", "_discover_the_app") }
    /// DNS Leak Protection
    public static var dnsLeakProtection: String { return LocalizedString.tr("Localizable", "_dns_leak_protection") }
    /// Prevent leaking details of DNS queries to third parties. Always on.
    public static var dnsLeakProtectionTooltip: String { return LocalizedString.tr("Localizable", "_dns_leak_protection_tooltip") }
    /// Do you want to activate the purchased subscription for
    public static var doYouWantToActivateSubscriptionFor: String { return LocalizedString.tr("Localizable", "_do_you_want_to_activate_subscription_for") }
    /// Done
    public static var done: String { return LocalizedString.tr("Localizable", "_done") }
    /// Early Access
    public static var earlyAccess: String { return LocalizedString.tr("Localizable", "_early_access") }
    /// Be the first to get the latest updates. Please keep in mind that early versions may be less stable.
    public static var earlyAccessTooltip: String { return LocalizedString.tr("Localizable", "_early_access_tooltip") }
    /// Edit
    public static var edit: String { return LocalizedString.tr("Localizable", "_edit") }
    /// Enabled
    public static var enabled: String { return LocalizedString.tr("Localizable", "_enabled") }
    /// End Tour
    public static var endTour: String { return LocalizedString.tr("Localizable", "_end_tour") }
    /// Enjoy %@ for free!
    public static func enjoyForFree(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_enjoy_for_free", String(describing: p1))
    }
    /// Enter email address
    public static var enterEmailAddress: String { return LocalizedString.tr("Localizable", "_enter_email_address") }
    /// Enter Profile Name
    public static var enterProfileName: String { return LocalizedString.tr("Localizable", "_enter_profile_name") }
    /// 123 456
    public static var enterVerificationCode: String { return LocalizedString.tr("Localizable", "_enter_verification_code") }
    /// The Proton VPN API is currently offline
    public static var errorApiOffline: String { return LocalizedString.tr("Localizable", "_error_api_offline") }
    /// Contact support@protonvpn.com to complete your purchase.
    public static var errorCreditApplied: String { return LocalizedString.tr("Localizable", "_error_credit_applied") }
    /// Failed to decode archived data in class: %@
    public static func errorDecode(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_error_decode", String(describing: p1))
    }
    /// Email verification temporarily disabled
    public static var errorEmailVerificationDisabled: String { return LocalizedString.tr("Localizable", "_error_email_verification_disabled") }
    /// Can't connect to server because it already has an active session from user
    public static var errorExistingSessionToServer: String { return LocalizedString.tr("Localizable", "_error_existing_session_to_server") }
    /// Can't find user from the session
    public static var errorFetchSession: String { return LocalizedString.tr("Localizable", "_error_fetch_session") }
    /// The email address is not in the right format
    public static var errorFieldEmailWrongFormat: String { return LocalizedString.tr("Localizable", "_error_field_email_wrong_format") }
    /// Passwords do not match
    public static var errorFieldPasswordsDontMatch: String { return LocalizedString.tr("Localizable", "_error_field_passwords_dont_match") }
    /// This field is required
    public static var errorFieldRequired: String { return LocalizedString.tr("Localizable", "_error_field_required") }
    /// Please check this field
    public static var errorFieldUnknown: String { return LocalizedString.tr("Localizable", "_error_field_unknown") }
    /// SRP generation failed
    public static var errorGenerateSrp: String { return LocalizedString.tr("Localizable", "_error_generate_srp") }
    /// Can't hash user password
    public static var errorHashPassword: String { return LocalizedString.tr("Localizable", "_error_hash_password") }
    /// Internal API error
    public static var errorInternalError: String { return LocalizedString.tr("Localizable", "_error_internal_error") }
    /// Keychain error.
    public static var errorKeychainFetch: String { return LocalizedString.tr("Localizable", "_error_keychain_fetch") }
    /// Proton couldn't communicate with your device. Please try again later.
    public static var errorKeychainWrite: String { return LocalizedString.tr("Localizable", "_error_keychain_write") }
    /// Can't update server loads
    public static var errorLoads: String { return LocalizedString.tr("Localizable", "_error_loads") }
    /// The TLS certificate validation failed when trying to connect to the Proton VPN API. Your current internet connection may be monitored. To keep your data secure, we are preventing the app from accessing the Proton VPN API.
    /// To log in or access your account, switch to a new network and try to connect again.
    public static var errorMitmDescription: String { return LocalizedString.tr("Localizable", "_error_mitm_description") }
    /// Insecure connection
    public static var errorMitmTitle: String { return LocalizedString.tr("Localizable", "_error_mitm_title") }
    /// The TLS certificate validation failed when trying to connect to the VPN server. Your current internet connection may be monitored. To keep your data secure, we are preventing the app from accessing this VPN server.
    /// Please select other server.
    public static var errorMitmVpnDescription: String { return LocalizedString.tr("Localizable", "_error_mitm_vpn_description") }
    /// Modulus signature is empty
    public static var errorModulusSignature: String { return LocalizedString.tr("Localizable", "_error_modulus_signature") }
    /// Please login with the account you're upgrading the service plan for so we can complete your purchase.
    public static var errorNoActiveUsername: String { return LocalizedString.tr("Localizable", "_error_no_active_username") }
    /// Your subscription upgrade was successful. Please relaunch the app to benefit from your new service plan.
    public static var errorNoNewSubscriptionInSuccessfullResponse: String { return LocalizedString.tr("Localizable", "_error_no_new_subscription_in_successfull_response") }
    /// We were not available to match App Store product with products on our server. Please contact support.
    public static var errorPurchasedPlanDoesNotMatchAvailable: String { return LocalizedString.tr("Localizable", "_error_purchased_plan_does_not_match_available") }
    /// App Store receipt lost. Please contact support if your plan was not activated.
    public static var errorReceiptLost: String { return LocalizedString.tr("Localizable", "_error_receipt_lost") }
    /// Purchases are not available in the beta version of the iOS app. You have not been charged.
    public static var errorSandboxReceipt: String { return LocalizedString.tr("Localizable", "_error_sandbox_receipt") }
    /// Can't parse the servers info
    public static var errorServerInfoParser: String { return LocalizedString.tr("Localizable", "_error_server_info_parser") }
    /// Can't parse session count
    public static var errorSessionCountParser: String { return LocalizedString.tr("Localizable", "_error_session_count_parser") }
    /// Your Proton Mail account is already configured for VPN. Please log in with your existing credentials.
    public static var errorSignupUsingProtonmailAddress: String { return LocalizedString.tr("Localizable", "_error_signup_using_protonmail_address") }
    /// Can't parse subscription info
    public static var errorSubscriptionParser: String { return LocalizedString.tr("Localizable", "_error_subscription_parser") }
    /// TLS initialisation error
    public static var errorTlsInitialisation: String { return LocalizedString.tr("Localizable", "_error_tls_initialisation") }
    /// Server certificate can't be verified.
    public static var errorTlsServerVerification: String { return LocalizedString.tr("Localizable", "_error_tls_server_verification") }
    /// App Store could not process your purchase.
    public static var errorTransactionFailedByUnknownReason: String { return LocalizedString.tr("Localizable", "_error_transaction_failed_by_unknown_reason") }
    /// A purchase was started with a different Proton VPN username.
    public static var errorTransactionOfOtherUser: String { return LocalizedString.tr("Localizable", "_error_transaction_of_other_user") }
    /// Failed to get list of available products from App Store.
    public static var errorUnavailableProduct: String { return LocalizedString.tr("Localizable", "_error_unavailable_product") }
    /// Unknown error
    public static var errorUnknownTitle: String { return LocalizedString.tr("Localizable", "_error_unknown_title") }
    /// Operation cancelled
    public static var errorUserCancelled: String { return LocalizedString.tr("Localizable", "_error_user_cancelled") }
    /// Account creation failed
    public static var errorUserCreation: String { return LocalizedString.tr("Localizable", "_error_user_creation") }
    /// User credentials have expired. Please log in
    public static var errorUserCredentialsExpired: String { return LocalizedString.tr("Localizable", "_error_user_credentials_expired") }
    /// User credentials are missing. Unable to login
    public static var errorUserCredentialsMissing: String { return LocalizedString.tr("Localizable", "_error_user_credentials_missing") }
    /// We have not been able to verify that you are human. Please try again or purchase a premium plan.
    public static var errorUserFailedHumanValidation: String { return LocalizedString.tr("Localizable", "_error_user_failed_human_validation") }
    /// Your account does not have VPN Access. Please contact your Account Administrator
    public static var errorUserHasNoVpnAccess: String { return LocalizedString.tr("Localizable", "_error_user_has_no_vpn_access") }
    /// You have not yet signed up for Proton VPN
    public static var errorUserHasNotSignedUp: String { return LocalizedString.tr("Localizable", "_error_user_has_not_signed_up") }
    /// You are currently in the Waitlist and your account is not yet ready
    public static var errorUserIsOnWaitlist: String { return LocalizedString.tr("Localizable", "_error_user_is_on_waitlist") }
    /// Username already taken
    public static var errorUsernameUnavailable: String { return LocalizedString.tr("Localizable", "_error_username_unavailable") }
    /// Can't parse verfication methods
    public static var errorVerificationMethodsParser: String { return LocalizedString.tr("Localizable", "_error_verification_methods_parser") }
    /// VPN credentials are missing from the keychain
    public static var errorVpnCredentialsMissing: String { return LocalizedString.tr("Localizable", "_error_vpn_credentials_missing") }
    /// Can't fetch VPN properties!
    public static var errorVpnProperties: String { return LocalizedString.tr("Localizable", "_error_vpn_properties") }
    /// Proton VPN session is active
    public static var errorVpnSessionIsActive: String { return LocalizedString.tr("Localizable", "_error_vpn_session_is_active") }
    /// Wrong payment token status. Please relaunch the app. If error persists, contact support.
    public static var errorWrongPaymentTokenStatus: String { return LocalizedString.tr("Localizable", "_error_wrong_payment_token_status") }
    /// Proton VPN uses a packet filter firewall to implement a kill switch. By enabling kill switch, you will overwrite your device's current firewall settings. If you rely on this firewall configuration, you should not use kill switch.
    ///
    /// To use kill switch and overwrite your current firewall settings, select CONTINUE.
    ///
    /// To turn off kill switch and continue using your current firewall, select CANCEL.
    public static var existingFirewallPopupBody: String { return LocalizedString.tr("Localizable", "_existing_firewall_popup_body") }
    /// Firewall detected
    public static var existingFirewallPopupTitle: String { return LocalizedString.tr("Localizable", "_existing_firewall_popup_title") }
    /// Server Unavailable
    public static var existingSession: String { return LocalizedString.tr("Localizable", "_existing_session") }
    /// Please select a different server.
    public static var existingSessionToServer: String { return LocalizedString.tr("Localizable", "_existing_session_to_server") }
    /// Expand list of servers
    public static var expandListOfServers: String { return LocalizedString.tr("Localizable", "_expand_list_of_servers") }
    /// EXPIRED
    public static var expired: String { return LocalizedString.tr("Localizable", "_expired") }
    /// Extensions
    public static var extensions: String { return LocalizedString.tr("Localizable", "_extensions") }
    /// failed
    public static var failed: String { return LocalizedString.tr("Localizable", "_failed") }
    /// Failed to retrieve VPN credentials, please log back in to resolve the issue.
    public static var failedToAccessVpnCredentialsDescription: String { return LocalizedString.tr("Localizable", "_failed_to_access_vpn_credentials_description") }
    /// VPN credentials missing
    public static var failedToAccessVpnCredentialsTitle: String { return LocalizedString.tr("Localizable", "_failed_to_access_vpn_credentials_title") }
    /// Fastest
    public static var fastest: String { return LocalizedString.tr("Localizable", "_fastest") }
    /// Fastest available server
    public static var fastestAvailableServer: String { return LocalizedString.tr("Localizable", "_fastest_available_server") }
    /// Fastest Connection
    public static var fastestConnection: String { return LocalizedString.tr("Localizable", "_fastest_connection") }
    /// Feature
    public static var feature: String { return LocalizedString.tr("Localizable", "_feature") }
    /// Access blocked content
    public static var featureBlockedContent: String { return LocalizedString.tr("Localizable", "_feature_blocked_content") }
    /// BitTorrent/file-sharing support
    public static var featureBt: String { return LocalizedString.tr("Localizable", "_feature_bt") }
    /// Simultaneous VPN connections
    public static var featureConnections: String { return LocalizedString.tr("Localizable", "_feature_connections") }
    /// These servers give the best performance for BitTorrent and file sharing.
    public static var featureP2pDescription: String { return LocalizedString.tr("Localizable", "_feature_p2p_description") }
    /// Secure Core
    public static var featureSecureCore: String { return LocalizedString.tr("Localizable", "_feature_secure_core") }
    /// Secure Streaming
    public static var featureSecureStreaming: String { return LocalizedString.tr("Localizable", "_feature_secure_streaming") }
    /// Connect to servers in
    public static var featureServerCount: String { return LocalizedString.tr("Localizable", "_feature_server_count") }
    /// This technology allows Proton VPN to provide higher speed and security in difficult-to-serve countries.
    public static var featureSmartRoutingDescription: String { return LocalizedString.tr("Localizable", "_feature_smart_routing_description") }
    /// Speed
    public static var featureSpeed: String { return LocalizedString.tr("Localizable", "_feature_speed") }
    /// Plus servers support streaming (Netflix, Disney+, etc) from anywhere in the world.
    public static var featureStreamingDescription: String { return LocalizedString.tr("Localizable", "_feature_streaming_description") }
    /// Tor over VPN
    public static var featureTor: String { return LocalizedString.tr("Localizable", "_feature_tor") }
    /// Route your internet traffic through the Tor network. Slower, but more private.
    public static var featureTorDescription: String { return LocalizedString.tr("Localizable", "_feature_tor_description") }
    /// Features
    public static var featuresTitle: String { return LocalizedString.tr("Localizable", "_features_title") }
    /// The version of Proton VPN application you are currently using is no longer supported. Please update to the latest version.
    public static var forceUpgradeMessage: String { return LocalizedString.tr("Localizable", "_force_upgrade_message") }
    /// Application upgrade needed
    public static var forceUpgradeTitle: String { return LocalizedString.tr("Localizable", "_force_upgrade_title") }
    /// Forgot Password?
    public static var forgotPassword: String { return LocalizedString.tr("Localizable", "_forgot_password") }
    /// Forgot Username
    public static var forgotUsername: String { return LocalizedString.tr("Localizable", "_forgot_username") }
    /// Free
    public static var free: String { return LocalizedString.tr("Localizable", "_free") }
    /// 3 Countries
    public static var freeCountries: String { return LocalizedString.tr("Localizable", "_free_countries") }
    /// Free Servers
    public static var freeServers: String { return LocalizedString.tr("Localizable", "_free_servers") }
    /// Upgrade to %@ and continue enjoying these features:
    public static func freeTrialAboutToExpireDescription(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_free_trial_about_to_expire_description", String(describing: p1))
    }
    /// Your free trial is about to expire!
    public static var freeTrialAboutToExpireTitle: String { return LocalizedString.tr("Localizable", "_free_trial_about_to_expire_title") }
    /// Your account has been downgraded to Proton VPN Free.
    /// Here's what you will miss from %@:
    public static func freeTrialExpiredDescription(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_free_trial_expired_description", String(describing: p1))
    }
    /// Your free trial %@
    public static func freeTrialExpiredTitle(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_free_trial_expired_title", String(describing: p1))
    }
    /// From Server:
    public static var fromServerTitle: String { return LocalizedString.tr("Localizable", "_from_server_title") }
    /// General
    public static var general: String { return LocalizedString.tr("Localizable", "_general") }
    /// Get %@ Plan
    public static func getPlan(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_get_plan", String(describing: p1))
    }
    /// Get Proton VPN Plus to unlock this and other features.
    public static var getPlusForFeature: String { return LocalizedString.tr("Localizable", "_get_plus_for_feature") }
    /// Get verification email
    public static var getVerificationEmail: String { return LocalizedString.tr("Localizable", "_get_verification_email") }
    /// Get verification SMS
    public static var getVerificationSms: String { return LocalizedString.tr("Localizable", "_get_verification_sms") }
    /// Got it!
    public static var gotIt: String { return LocalizedString.tr("Localizable", "_got_it") }
    /// Help
    public static var help: String { return LocalizedString.tr("Localizable", "_help") }
    /// HIDE
    public static var hide: String { return LocalizedString.tr("Localizable", "_hide") }
    /// High
    public static var high: String { return LocalizedString.tr("Localizable", "_high") }
    /// Highest
    public static var highest: String { return LocalizedString.tr("Localizable", "_highest") }
    /// Ignore
    public static var ignore: String { return LocalizedString.tr("Localizable", "_ignore") }
    /// IKEv2
    public static var ikev2: String { return LocalizedString.tr("Localizable", "_ikev2") }
    /// Information
    public static var informationTitle: String { return LocalizedString.tr("Localizable", "_information_title") }
    /// Initializing Connection...
    public static var initializingConnection: String { return LocalizedString.tr("Localizable", "_initializing_connection") }
    /// Session expired
    public static var invalidRefreshToken: String { return LocalizedString.tr("Localizable", "_invalid_refresh_token") }
    /// It's been a while since you last used the Proton VPN app. Please log back in.
    public static var invalidRefreshTokenPleaseLogin: String { return LocalizedString.tr("Localizable", "_invalid_refresh_token_please_login") }
    /// From the scientists and engineers that created Proton Mail, welcome to a more secure and private internet.
    public static var iosOnboardingPage1Description: String { return LocalizedString.tr("Localizable", "_ios_onboarding_page1_description") }
    /// Welcome to a better internet
    public static var iosOnboardingPage1Title: String { return LocalizedString.tr("Localizable", "_ios_onboarding_page1_title") }
    /// Beat censorship and regional restrictions. We have no ads, no bandwidth limits, and don’t sell your data.
    public static var iosOnboardingPage2Description: String { return LocalizedString.tr("Localizable", "_ios_onboarding_page2_description") }
    /// We believe the internet should be free
    public static var iosOnboardingPage2Title: String { return LocalizedString.tr("Localizable", "_ios_onboarding_page2_title") }
    /// We are a security company. Whether it is our Secure Core architecture or advanced encryption, security always comes first.
    public static var iosOnboardingPage3Description: String { return LocalizedString.tr("Localizable", "_ios_onboarding_page3_description") }
    /// Your security is our priority
    public static var iosOnboardingPage3Title: String { return LocalizedString.tr("Localizable", "_ios_onboarding_page3_title") }
    /// IP
    public static var ip: String { return LocalizedString.tr("Localizable", "_ip") }
    /// IP: %@
    public static func ipValue(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_ip_value", String(describing: p1))
    }
    /// Your IP will not be exposed.
    public static var ipWillNotBeExposed: String { return LocalizedString.tr("Localizable", "_ip_will_not_be_exposed") }
    /// Kill switch
    public static var killSwitch: String { return LocalizedString.tr("Localizable", "_kill_switch") }
    /// Kill switch is protecting your IP
    ///
    /// Your internet connection will resume as soon as Proton VPN reconnects to a server. To resume without VPN protection, disable the kill switch.
    public static var killSwitchBlockingBody: String { return LocalizedString.tr("Localizable", "_kill_switch_blocking_body") }
    /// Kill switch blocking all connections
    public static var killSwitchBlockingConnection: String { return LocalizedString.tr("Localizable", "_kill_switch_blocking_connection") }
    /// Kill switch
    public static var killSwitchBlockingTitle: String { return LocalizedString.tr("Localizable", "_kill_switch_blocking_title") }
    /// Disable Kill switch
    public static var killSwitchDisable: String { return LocalizedString.tr("Localizable", "_kill_switch_disable") }
    /// Terminate those apps to fix the problem.
    /// To keep browsing without kill switch, click Continue.
    public static var killSwitchErrorFoot: String { return LocalizedString.tr("Localizable", "_kill_switch_error_foot") }
    /// Some apps, like anti-viruses or firewalls, might conflict with kill switch, making it not functioning properly.
    public static var killSwitchErrorHead: String { return LocalizedString.tr("Localizable", "_kill_switch_error_head") }
    /// Kill switch works with the macOS Firewall.
    /// If there are other apps associated with the Firewall, they may interfere with Proton VPN's kill switch. Terminating those apps can restore the Firewall rules set by kill switch.
    public static var killSwitchErrorInfo: String { return LocalizedString.tr("Localizable", "_kill_switch_error_info") }
    /// A kill switch error has been detected
    public static var killSwitchErrorTitle: String { return LocalizedString.tr("Localizable", "_kill_switch_error_title") }
    /// There was a problem installing or updating kill switch.
    ///
    /// To try again, click RETRY.
    ///
    /// To continue without kill switch, click DISABLE.
    public static var killSwitchHelperInstallIssuePopupBody: String { return LocalizedString.tr("Localizable", "_kill_switch_helper_install_issue_popup_body") }
    /// To enable kill switch, you may be asked to provide your computer account password. If a request appears, enter your %@ and accept.
    ///
    /// You may see this request again occasionally when the Proton VPN app receives updates.
    public static func killSwitchHelperInstallPopupBody(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_kill_switch_helper_install_popup_body", String(describing: p1))
    }
    /// The most recent update you downloaded requires you to provide your computer account password. When the request appears, please enter your %@ and accept.
    ///
    /// If you do not enter your Mac password, kill switch will be turned off.
    public static func killSwitchHelperUpdatePopupBody(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_kill_switch_helper_update_popup_body", String(describing: p1))
    }
    /// Your internet connection will resume as soon as Proton VPN reconnects to a server.
    /// To use the internet without VPN and kill switch protection, cancel the reconnection to the server.
    public static var killSwitchReconnection: String { return LocalizedString.tr("Localizable", "_kill_switch_reconnection") }
    /// without
    public static var killSwitchReconnectionBold1: String { return LocalizedString.tr("Localizable", "_kill_switch_reconnection_bold1") }
    /// Kill switch protection
    public static var killSwitchReconnectionBold2: String { return LocalizedString.tr("Localizable", "_kill_switch_reconnection_bold2") }
    /// Cancel reconnection
    public static var killSwitchReconnectionCancel: String { return LocalizedString.tr("Localizable", "_kill_switch_reconnection_cancel") }
    /// Kill switch is protecting your IP
    public static var killSwitchReconnectionHeader: String { return LocalizedString.tr("Localizable", "_kill_switch_reconnection_header") }
    /// Blocks all network traffic when VPN tunnel is lost.
    public static var killSwitchTooltip: String { return LocalizedString.tr("Localizable", "_kill_switch_tooltip") }
    /// Don't ask me again
    public static var ksDontAsk: String { return LocalizedString.tr("Localizable", "_ks_dont_ask") }
    /// To enable kill switch, you need to download and install the %@.
    /// Please install it before enabling kill switch.
    public static func ksRequiresSwift5PopupMsg(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_ks_requires_swift5_popup_msg", String(describing: p1))
    }
    /// Proton VPN couldn't detect the %@. To enable kill switch, please install software first.
    public static func ksRequiresSwift5PopupMsg2(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_ks_requires_swift5_popup_msg2", String(describing: p1))
    }
    /// Swift 5 Runtime Support library
    public static var ksSwift5LibName: String { return LocalizedString.tr("Localizable", "_ks_swift5_lib_name") }
    /// Learn more
    public static var learnMore: String { return LocalizedString.tr("Localizable", "_learn_more") }
    /// Learn more about Secure Core
    public static var learnMoreAboutSecureCore: String { return LocalizedString.tr("Localizable", "_learn_more_about_secure_core") }
    /// Less info
    public static var lessInfo: String { return LocalizedString.tr("Localizable", "_less_info") }
    /// Load
    public static var load: String { return LocalizedString.tr("Localizable", "_load") }
    /// Loading connection info
    public static var loadingConnectionInfo: String { return LocalizedString.tr("Localizable", "_loading_connection_info") }
    /// Loading connection info for %@
    public static func loadingConnectionInfoFor(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_loading_connection_info_for", String(describing: p1))
    }
    /// Secure Internet Anywhere
    public static var loadingScreenSlogan: String { return LocalizedString.tr("Localizable", "_loading_screen_slogan") }
    /// You are not allowed to connect to the server. Choose a different server or upgrade your plan.
    public static var localAgentPolicyViolationErrorMessage: String { return LocalizedString.tr("Localizable", "_local_agent_policy_violation_error_message") }
    /// Policy violation
    public static var localAgentPolicyViolationErrorTitle: String { return LocalizedString.tr("Localizable", "_local_agent_policy_violation_error_title") }
    /// An error occured on the server. Please connect to another server.
    public static var localAgentServerErrorMessage: String { return LocalizedString.tr("Localizable", "_local_agent_server_error_message") }
    /// Server error
    public static var localAgentServerErrorTitle: String { return LocalizedString.tr("Localizable", "_local_agent_server_error_title") }
    /// Location
    public static var location: String { return LocalizedString.tr("Localizable", "_location") }
    /// All Locations
    public static var locationsAll: String { return LocalizedString.tr("Localizable", "_locations_all") }
    /// Free Locations
    public static var locationsFree: String { return LocalizedString.tr("Localizable", "_locations_free") }
    /// Plus Locations
    public static var locationsPlus: String { return LocalizedString.tr("Localizable", "_locations_plus") }
    /// Log In
    public static var logIn: String { return LocalizedString.tr("Localizable", "_log_in") }
    /// Please log in to get started
    public static var logInToUseWidget: String { return LocalizedString.tr("Localizable", "_log_in_to_use_widget") }
    /// Log Out
    public static var logOut: String { return LocalizedString.tr("Localizable", "_log_out") }
    /// Logging out will end your VPN session.
    public static var logOutWarning: String { return LocalizedString.tr("Localizable", "_log_out_warning") }
    /// Logging out of the application will disconnect the active VPN connection. Do you want to continue?
    public static var logOutWarningLong: String { return LocalizedString.tr("Localizable", "_log_out_warning_long") }
    /// Sign in
    public static var login: String { return LocalizedString.tr("Localizable", "_login") }
    /// Logs
    public static var logs: String { return LocalizedString.tr("Localizable", "_logs") }
    /// Mac password
    public static var macPassword: String { return LocalizedString.tr("Localizable", "_mac_password") }
    /// Maintenance
    public static var maintenance: String { return LocalizedString.tr("Localizable", "_maintenance") }
    /// Reconnecting you to the fastest available server.
    public static var maintenanceOnServerDetectedDescription: String { return LocalizedString.tr("Localizable", "_maintenance_on_server_detected_description") }
    /// The server you were connected to is on maintenance
    public static var maintenanceOnServerDetectedSubtitle: String { return LocalizedString.tr("Localizable", "_maintenance_on_server_detected_subtitle") }
    /// The VPN server is on maintenance
    public static var maintenanceOnServerDetectedTitle: String { return LocalizedString.tr("Localizable", "_maintenance_on_server_detected_title") }
    /// Make Default Profile
    public static var makeDefaultProfile: String { return LocalizedString.tr("Localizable", "_make_default_profile") }
    /// Manage Profiles
    public static var manageProfiles: String { return LocalizedString.tr("Localizable", "_manage_profiles") }
    /// Manage Subscription
    public static var manageSubscription: String { return LocalizedString.tr("Localizable", "_manage_subscription") }
    /// Manage your subscription in the web dashboard
    public static var manageSubscriptionOnWeb: String { return LocalizedString.tr("Localizable", "_manage_subscription_on_web") }
    /// Map
    public static var map: String { return LocalizedString.tr("Localizable", "_map") }
    /// Hide map
    public static var mapHide: String { return LocalizedString.tr("Localizable", "_map_hide") }
    /// Show map
    public static var mapShow: String { return LocalizedString.tr("Localizable", "_map_show") }
    /// Please disconnect another device to connect to this one.
    public static var maximumDeviceReachedDescription: String { return LocalizedString.tr("Localizable", "_maximum_device_reached_description") }
    /// You have reached your maximum device limit
    public static var maximumDeviceTitle: String { return LocalizedString.tr("Localizable", "_maximum_device_title") }
    /// Maybe Later
    public static var maybeLater: String { return LocalizedString.tr("Localizable", "_maybe_later") }
    /// Medium
    public static var medium: String { return LocalizedString.tr("Localizable", "_medium") }
    /// About Proton VPN
    public static var menuAbout: String { return LocalizedString.tr("Localizable", "_menu_about") }
    /// Check for Updates...
    public static var menuCheckUpdates: String { return LocalizedString.tr("Localizable", "_menu_check_updates") }
    /// Hide Others
    public static var menuHideOthers: String { return LocalizedString.tr("Localizable", "_menu_hide_others") }
    /// Hide Proton VPN
    public static var menuHideSelf: String { return LocalizedString.tr("Localizable", "_menu_hide_self") }
    /// Log Out
    public static var menuLogout: String { return LocalizedString.tr("Localizable", "_menu_logout") }
    /// Minimize
    public static var menuMinimize: String { return LocalizedString.tr("Localizable", "_menu_minimize") }
    /// Preferences
    public static var menuPreferences: String { return LocalizedString.tr("Localizable", "_menu_preferences") }
    /// Quit Proton VPN
    public static var menuQuit: String { return LocalizedString.tr("Localizable", "_menu_quit") }
    /// Show All
    public static var menuShowAll: String { return LocalizedString.tr("Localizable", "_menu_show_all") }
    /// Window
    public static var menuWindow: String { return LocalizedString.tr("Localizable", "_menu_window") }
    /// Enable Moderate NAT
    public static var moderateNatChangeTitle: String { return LocalizedString.tr("Localizable", "_moderate_nat_change_title") }
    /// Enable Moderate NAT
    public static var moderateNatEnableTitle: String { return LocalizedString.tr("Localizable", "_moderate_nat_enable_title") }
    /// Moderate NAT disables randomization of local address mapping. This can slightly reduce your security, but allows peer-to-peer applications such as online games to establish direct connections.
    /// Learn more
    public static var moderateNatExplanation: String { return LocalizedString.tr("Localizable", "_moderate_nat_explanation") }
    /// Learn more
    public static var moderateNatExplanationLink: String { return LocalizedString.tr("Localizable", "_moderate_nat_explanation_link") }
    /// Moderate NAT
    public static var moderateNatTitle: String { return LocalizedString.tr("Localizable", "_moderate_nat_title") }
    /// More info
    public static var moreInfo: String { return LocalizedString.tr("Localizable", "_more_info") }
    /// Most popular
    public static var mostPopular: String { return LocalizedString.tr("Localizable", "_most_popular") }
    /// Multiple countries
    public static var multipleCountries: String { return LocalizedString.tr("Localizable", "_multiple_countries") }
    /// Hundreds of servers
    /// around the world
    public static var multipleServersDescription: String { return LocalizedString.tr("Localizable", "_multiple_servers_description") }
    /// Multiple Servers
    public static var multipleServersTitle: String { return LocalizedString.tr("Localizable", "_multiple_servers_title") }
    /// My Profiles
    public static var myProfiles: String { return LocalizedString.tr("Localizable", "_my_profiles") }
    /// Name
    public static var name: String { return LocalizedString.tr("Localizable", "_name") }
    /// We could not reach Proton servers
    public static var neCouldntReachServer: String { return LocalizedString.tr("Localizable", "_ne_couldnt_reach_server") }
    /// Network connection lost
    public static var neNetworkConnectionLost: String { return LocalizedString.tr("Localizable", "_ne_network_connection_lost") }
    /// Not connected to the internet
    public static var neNotConnectedToTheInternet: String { return LocalizedString.tr("Localizable", "_ne_not_connected_to_the_internet") }
    /// Network request timed out
    public static var neRequestTimedOut: String { return LocalizedString.tr("Localizable", "_ne_request_timed_out") }
    /// Troubleshoot
    public static var neTroubleshoot: String { return LocalizedString.tr("Localizable", "_ne_troubleshoot") }
    /// Service unreachable
    public static var neUnableToConnectToHost: String { return LocalizedString.tr("Localizable", "_ne_unable_to_connect_to_host") }
    /// Always Allow
    public static var neagentAlwaysAllow: String { return LocalizedString.tr("Localizable", "_neagent_always_allow") }
    /// You may be asked to provide your %@
    /// to connect to the Proton VPN service. If this request appears,
    /// enter your %@ %@ and click ‘%@’ %@.
    public static func neagentDescription(_ p1: Any, _ p2: Any, _ p3: Any, _ p4: Any, _ p5: Any) -> String {
      return LocalizedString.tr("Localizable", "_neagent_description", String(describing: p1), String(describing: p2), String(describing: p3), String(describing: p4), String(describing: p5))
    }
    /// (1)
    public static var neagentFirstStep: String { return LocalizedString.tr("Localizable", "_neagent_first_step") }
    /// computer account password
    public static var neagentPassword: String { return LocalizedString.tr("Localizable", "_neagent_password") }
    /// (2)
    public static var neagentSecondStep: String { return LocalizedString.tr("Localizable", "_neagent_second_step") }
    /// Need Help?
    public static var needHelp: String { return LocalizedString.tr("Localizable", "_need_help") }
    /// Enable anyway
    public static var neksT2Connect: String { return LocalizedString.tr("Localizable", "_neks_t2_connect") }
    /// The use of kill switch is unstable on this device.
    ///
    /// Your device has a T2 Security Chip, which can result in system stability issues if the kill switch functionality of macOS is used by Proton VPN.
    public static var neksT2Description: String { return LocalizedString.tr("Localizable", "_neks_t2_description") }
    /// T2 Security Chip
    public static var neksT2Hyperlink: String { return LocalizedString.tr("Localizable", "_neks_t2_hyperlink") }
    /// Kill switch Stability Warning
    public static var neksT2Title: String { return LocalizedString.tr("Localizable", "_neks_t2_title") }
    /// Your connection will be restarted to change the NetShield mode.
    public static var netshieldAlertReconnectDescriptionOff: String { return LocalizedString.tr("Localizable", "_netshield_alert_reconnect_description_off") }
    /// Your connection will be restarted to change the NetShield mode.
    /// Note: If some sites don't load, try disabling NetShield.
    public static var netshieldAlertReconnectDescriptionOn: String { return LocalizedString.tr("Localizable", "_netshield_alert_reconnect_description_on") }
    /// NetShield increases your privacy by blocking advertisements and trackers.
    public static var netshieldAlertUpgradeDescription: String { return LocalizedString.tr("Localizable", "_netshield_alert_upgrade_description") }
    /// Block malware
    public static var netshieldLevel1: String { return LocalizedString.tr("Localizable", "_netshield_level1") }
    /// Block malware, ads, & trackers
    public static var netshieldLevel2: String { return LocalizedString.tr("Localizable", "_netshield_level2") }
    /// Off
    public static var netshieldOff: String { return LocalizedString.tr("Localizable", "_netshield_off") }
    /// Malware & Ads Blocker
    public static var netshieldSectionTitle: String { return LocalizedString.tr("Localizable", "_netshield_section_title") }
    /// NetShield
    public static var netshieldTitle: String { return LocalizedString.tr("Localizable", "_netshield_title") }
    /// Block advertisements, trackers and malware
    public static var netshieldTitleTooltip: String { return LocalizedString.tr("Localizable", "_netshield_title_tooltip") }
    /// Network Unreachable
    public static var networkUnreachable: String { return LocalizedString.tr("Localizable", "_network_unreachable") }
    /// News
    public static var newsTitle: String { return LocalizedString.tr("Localizable", "_news_title") }
    /// Next
    public static var next: String { return LocalizedString.tr("Localizable", "_next") }
    /// Next Tip
    public static var nextTip: String { return LocalizedString.tr("Localizable", "_next_tip") }
    /// No description available
    public static var noDescriptionAvailable: String { return LocalizedString.tr("Localizable", "_no_description_available") }
    /// There are currently no servers to show here.
    public static var noServersToShow: String { return LocalizedString.tr("Localizable", "_no_servers_to_show") }
    /// No thanks
    public static var noThanks: String { return LocalizedString.tr("Localizable", "_no_thanks") }
    /// Enable Non-standard ports
    public static var nonStandardPortsChangeTitle: String { return LocalizedString.tr("Localizable", "_non_standard_ports_change_title") }
    /// Use Proton VPN for any special need by allowing traffic to non-standard ports through the VPN network.
    /// Learn more
    public static var nonStandardPortsExplanation: String { return LocalizedString.tr("Localizable", "_non_standard_ports_explanation") }
    /// Learn more
    public static var nonStandardPortsExplanationLink: String { return LocalizedString.tr("Localizable", "_non_standard_ports_explanation_link") }
    /// Non-standard ports
    public static var nonStandardPortsTitle: String { return LocalizedString.tr("Localizable", "_non_standard_ports_title") }
    /// Not Connected
    public static var notConnected: String { return LocalizedString.tr("Localizable", "_not_connected") }
    /// Unable to establish VPN connection. You are not connected to the internet.
    public static var notConnectedToTheInternet: String { return LocalizedString.tr("Localizable", "_not_connected_to_the_internet") }
    /// Not now
    public static var notNow: String { return LocalizedString.tr("Localizable", "_not_now") }
    /// OK
    public static var ok: String { return LocalizedString.tr("Localizable", "_ok") }
    /// On maintenance
    public static var onMaintenance: String { return LocalizedString.tr("Localizable", "_on_maintenance") }
    /// Show Proton VPN to log in...
    public static var openAppToLogIn: String { return LocalizedString.tr("Localizable", "_open_app_to_log_in") }
    /// OpenVPN Logs
    public static var openVpnLogs: String { return LocalizedString.tr("Localizable", "_open_vpn_logs") }
    /// OpenVPN
    public static var openvpn: String { return LocalizedString.tr("Localizable", "_openvpn") }
    /// Overview
    public static var overview: String { return LocalizedString.tr("Localizable", "_overview") }
    /// P2P
    public static var p2p: String { return LocalizedString.tr("Localizable", "_p2p") }
    /// Supports P2P traffic
    public static var p2pDescription: String { return LocalizedString.tr("Localizable", "_p2p_description") }
    /// Your connection has been disabled because you are using a server that does not support peer-to-peer (P2P) traffic. P2P is not supported on free servers or servers that are numbered 100 or greater.
    public static var p2pDetectedPopupBody: String { return LocalizedString.tr("Localizable", "_p2p_detected_popup_body") }
    /// P2P traffic is not permitted on this server
    public static var p2pDetectedPopupTitle: String { return LocalizedString.tr("Localizable", "_p2p_detected_popup_title") }
    /// Your connection has been automatically rerouted through another server because some servers do not support P2P traffic. This may reduce your connection speed. Please use servers with the P2P label to avoid rerouting.
    public static var p2pForwardedPopupBody: String { return LocalizedString.tr("Localizable", "_p2p_forwarded_popup_body") }
    /// Your connection has been automatically rerouted through another server because certain servers do not support P2P traffic. This may reduce your connection speed. Please use servers with the
    public static var p2pForwardedPopupBodyP1: String { return LocalizedString.tr("Localizable", "_p2p_forwarded_popup_body_p1") }
    /// icon to avoid traffic rerouting.
    public static var p2pForwardedPopupBodyP2: String { return LocalizedString.tr("Localizable", "_p2p_forwarded_popup_body_p2") }
    /// Connection rerouted
    public static var p2pForwardedPopupTitle: String { return LocalizedString.tr("Localizable", "_p2p_forwarded_popup_title") }
    /// P2P Server
    public static var p2pServer: String { return LocalizedString.tr("Localizable", "_p2p_server") }
    /// P2P servers
    public static var p2pServers: String { return LocalizedString.tr("Localizable", "_p2p_servers") }
    /// P2P/BitTorrent
    public static var p2pTitle: String { return LocalizedString.tr("Localizable", "_p2p_title") }
    /// Paid Proton VPN plan required
    public static var paidRequired: String { return LocalizedString.tr("Localizable", "_paid_required") }
    /// Password
    public static var password: String { return LocalizedString.tr("Localizable", "_password") }
    /// Confirm password
    public static var passwordConfirm: String { return LocalizedString.tr("Localizable", "_password_confirm") }
    /// / yr
    public static var perYearShort: String { return LocalizedString.tr("Localizable", "_per_year_short") }
    /// Servers with high load are slower than servers with low load.
    public static var performanceLoadDescription: String { return LocalizedString.tr("Localizable", "_performance_load_description") }
    /// High
    public static var performanceLoadHigh: String { return LocalizedString.tr("Localizable", "_performance_load_high") }
    /// Low
    public static var performanceLoadLow: String { return LocalizedString.tr("Localizable", "_performance_load_low") }
    /// Medium
    public static var performanceLoadMedium: String { return LocalizedString.tr("Localizable", "_performance_load_medium") }
    /// Performance
    public static var performanceTitle: String { return LocalizedString.tr("Localizable", "_performance_title") }
    /// Code
    public static var phoneCountryCodePlaceholder: String { return LocalizedString.tr("Localizable", "_phone_country_code_placeholder") }
    /// Enter phone number
    public static var phoneNumberPlaceholder: String { return LocalizedString.tr("Localizable", "_phone_number_placeholder") }
    /// Your plan doesn't include Secure Core feature.
    public static var planDoesNotIncludeSecureCore: String { return LocalizedString.tr("Localizable", "_plan_does_not_include_secure_core") }
    /// Fastest speed
    public static var planSpeedFastest: String { return LocalizedString.tr("Localizable", "_plan_speed_fastest") }
    /// High speed
    public static var planSpeedHigh: String { return LocalizedString.tr("Localizable", "_plan_speed_high") }
    /// Medium speed
    public static var planSpeedMedium: String { return LocalizedString.tr("Localizable", "_plan_speed_medium") }
    /// Plural format key: "%#@VARIABLE@"
    public static func plansConnections(_ p1: Int) -> String {
      return LocalizedString.tr("Localizable", "_plans_connections", p1)
    }
    /// Upon confirming your purchase of a paid plan, your iTunes account will be charged the amount displayed, which includes taxes and additional platform fees (which are not charged by Proton directly). After making the purchase, you will automatically be upgraded to the selected plan for a 1 year period, after which time you can renew or cancel, either online or through our iOS app.
    public static var plansFooter: String { return LocalizedString.tr("Localizable", "_plans_footer") }
    /// Plus
    public static var plus: String { return LocalizedString.tr("Localizable", "_plus") }
    /// Plus Servers
    /// Secure Core
    /// Tor Servers
    public static var plusPlanFeatures: String { return LocalizedString.tr("Localizable", "_plus_plan_features") }
    /// Plus or Visionary subscription required
    public static var plusRequired: String { return LocalizedString.tr("Localizable", "_plus_required") }
    /// Plus Servers
    public static var plusServers: String { return LocalizedString.tr("Localizable", "_plus_servers") }
    /// Preferences
    public static var preferences: String { return LocalizedString.tr("Localizable", "_preferences") }
    /// Premium server
    public static var premiumDescription: String { return LocalizedString.tr("Localizable", "_premium_description") }
    /// Premium Server
    public static var premiumServer: String { return LocalizedString.tr("Localizable", "_premium_server") }
    /// Checking server availability
    public static var preparingConnection: String { return LocalizedString.tr("Localizable", "_preparing_connection") }
    /// Privacy Policy
    public static var privacyPolicy: String { return LocalizedString.tr("Localizable", "_privacy_policy") }
    /// Profile
    public static var profile: String { return LocalizedString.tr("Localizable", "_profile") }
    /// New Profile saved
    public static var profileCreatedSuccessfully: String { return LocalizedString.tr("Localizable", "_profile_created_successfully") }
    /// Profile could not be created
    public static var profileCreationFailed: String { return LocalizedString.tr("Localizable", "_profile_creation_failed") }
    /// Profile has been deleted
    public static var profileDeletedSuccessfully: String { return LocalizedString.tr("Localizable", "_profile_deleted_successfully") }
    /// Profile could not be deleted
    public static var profileDeletionFailed: String { return LocalizedString.tr("Localizable", "_profile_deletion_failed") }
    /// Profile updated
    public static var profileEditedSuccessfully: String { return LocalizedString.tr("Localizable", "_profile_edited_successfully") }
    /// Please enter a name
    public static var profileNameIsRequired: String { return LocalizedString.tr("Localizable", "_profile_name_is_required") }
    /// Maximum profile name length is 25 characters
    public static var profileNameIsTooLong: String { return LocalizedString.tr("Localizable", "_profile_name_is_too_long") }
    /// Profile with same name already exists
    public static var profileNameNeedsToBeUnique: String { return LocalizedString.tr("Localizable", "_profile_name_needs_to_be_unique") }
    /// Profile settings
    public static var profileSettings: String { return LocalizedString.tr("Localizable", "_profile_settings") }
    /// Profiles
    public static var profiles: String { return LocalizedString.tr("Localizable", "_profiles") }
    /// Profiles Overview
    public static var profilesOverview: String { return LocalizedString.tr("Localizable", "_profiles_overview") }
    /// Save your preferred settings and servers for future use.
    public static var profilesTourDescription: String { return LocalizedString.tr("Localizable", "_profiles_tour_description") }
    /// Profiles
    public static var profilesTourTitle: String { return LocalizedString.tr("Localizable", "_profiles_tour_title") }
    /// Protocol
    public static var `protocol`: String { return LocalizedString.tr("Localizable", "_protocol") }
    /// Proton VPN macOS
    public static var protonvpnMacos: String { return LocalizedString.tr("Localizable", "_protonvpn_macos") }
    /// Proton VPN Plus
    public static var protonvpnPlus: String { return LocalizedString.tr("Localizable", "_protonvpn_plus") }
    /// Public IP: %@
    public static func publicIp(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_public_ip", String(describing: p1))
    }
    /// Quick Connect
    public static var quickConnect: String { return LocalizedString.tr("Localizable", "_quick_connect") }
    /// Quick Connect button will connect you to the selected profile
    public static var quickConnectTooltip: String { return LocalizedString.tr("Localizable", "_quick_connect_tooltip") }
    /// Automatically connect to the server that will provide you with the fastest connection.
    public static var quickConnectTourDescription: String { return LocalizedString.tr("Localizable", "_quick_connect_tour_description") }
    /// Quick Connect
    public static var quickConnectTourTitle: String { return LocalizedString.tr("Localizable", "_quick_connect_tour_title") }
    /// Get Plus
    public static var quickSettingsGetPlus: String { return LocalizedString.tr("Localizable", "_quick_settings_get_plus") }
    /// Disables internet if the VPN connection drops to prevent accidental IP leak.
    public static var quickSettingsKillSwitchDescription: String { return LocalizedString.tr("Localizable", "_quick_settings_killSwitch_description") }
    /// If you can't connect to devices on your local network, try disabling kill switch.
    public static var quickSettingsKillSwitchNote: String { return LocalizedString.tr("Localizable", "_quick_settings_killSwitch_note") }
    /// Browse the internet without ads and malware.
    public static var quickSettingsNetShieldDescription: String { return LocalizedString.tr("Localizable", "_quick_settings_netShield_description") }
    /// If websites don’t load, try disabling NetShield
    public static var quickSettingsNetShieldNote: String { return LocalizedString.tr("Localizable", "_quick_settings_netShield_note") }
    /// Block malware only
    public static var quickSettingsNetshieldOptionLevel1: String { return LocalizedString.tr("Localizable", "_quick_settings_netshield_option_level1") }
    /// Block malware, ads, & trackers
    public static var quickSettingsNetshieldOptionLevel2: String { return LocalizedString.tr("Localizable", "_quick_settings_netshield_option_level2") }
    /// Don't block
    public static var quickSettingsNetshieldOptionOff: String { return LocalizedString.tr("Localizable", "_quick_settings_netshield_option_off") }
    /// Route your most sensitive data through our safest servers in privacy-friendly countries.
    public static var quickSettingsSecureCoreDescription: String { return LocalizedString.tr("Localizable", "_quick_settings_secureCore_description") }
    /// Secure Core may reduce VPN speed
    public static var quickSettingsSecureCoreNote: String { return LocalizedString.tr("Localizable", "_quick_settings_secureCore_note") }
    /// Increase your security with one click:
    public static var quickSettingsTourDescription: String { return LocalizedString.tr("Localizable", "_quick_settings_tour_description") }
    /// Add one extra layer of security with Secure Core.
    public static var quickSettingsTourFeature1: String { return LocalizedString.tr("Localizable", "_quick_settings_tour_feature_1") }
    /// Surf the web freely from malware and ads with NetShield.
    public static var quickSettingsTourFeature2: String { return LocalizedString.tr("Localizable", "_quick_settings_tour_feature_2") }
    /// Prevent your IP to be exposed by turning on kill switch.
    public static var quickSettingsTourFeature3: String { return LocalizedString.tr("Localizable", "_quick_settings_tour_feature_3") }
    /// Quick Settings
    public static var quickSettingsTourTitle: String { return LocalizedString.tr("Localizable", "_quick_settings_tour_title") }
    /// Quit
    public static var quit: String { return LocalizedString.tr("Localizable", "_quit") }
    /// Quitting the application will disconnect the active VPN connection. Do you want to continue?
    public static var quitWarning: String { return LocalizedString.tr("Localizable", "_quit_warning") }
    /// Random
    public static var random: String { return LocalizedString.tr("Localizable", "_random") }
    /// Random available server
    public static var randomAvailableServer: String { return LocalizedString.tr("Localizable", "_random_available_server") }
    /// Random Connection
    public static var randomConnection: String { return LocalizedString.tr("Localizable", "_random_connection") }
    /// Recommended
    public static var recommended: String { return LocalizedString.tr("Localizable", "_recommended") }
    /// Change protocol
    public static var reconnectOnProtocolChangeTitle: String { return LocalizedString.tr("Localizable", "_reconnect_on_protocol_change_title") }
    /// Your connection needs to be restarted to apply this change.
    public static var reconnectOnSettingsChangeBody: String { return LocalizedString.tr("Localizable", "_reconnect_on_settings_change_body") }
    /// We are reconnecting to the fastest server available.
    public static var reconnectTitle: String { return LocalizedString.tr("Localizable", "_reconnect_title") }
    /// Reconnecting to %@
    public static func reconnectingTo(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_reconnecting_to", String(describing: p1))
    }
    /// Reconnection Required
    public static var reconnectionRequired: String { return LocalizedString.tr("Localizable", "_reconnection_required") }
    /// Re-establishing VPN connection.
    public static var reestablishVpnConnection: String { return LocalizedString.tr("Localizable", "_reestablish_vpn_connection_") }
    /// Release date:
    public static var releaseDate: String { return LocalizedString.tr("Localizable", "_release_date") }
    /// Remember Login
    public static var rememberLogin: String { return LocalizedString.tr("Localizable", "_remember_login") }
    /// Report
    public static var report: String { return LocalizedString.tr("Localizable", "_report") }
    /// Report an Issue...
    public static var reportAnIssue: String { return LocalizedString.tr("Localizable", "_report_an_issue") }
    /// Attachments
    public static var reportAttachments: String { return LocalizedString.tr("Localizable", "_report_attachments") }
    /// Include app logs and system details
    public static var reportAttachmentsCheckbox: String { return LocalizedString.tr("Localizable", "_report_attachments_checkbox") }
    /// Report an issue
    public static var reportBug: String { return LocalizedString.tr("Localizable", "_report_bug") }
    /// Providing the following details, our team can identify your problem and a possible solution with higher chances and shorter time:
    /// • Proton VPN app logs
    /// • OpenVPN logs
    /// • WireGuard logs
    public static var reportDescription: String { return LocalizedString.tr("Localizable", "_report_description") }
    /// Email:
    public static var reportFieldEmail: String { return LocalizedString.tr("Localizable", "_report_field_email") }
    /// What went wrong?
    public static var reportFieldFeedback: String { return LocalizedString.tr("Localizable", "_report_field_feedback") }
    /// Start typing...
    public static var reportFieldPlaceholder: String { return LocalizedString.tr("Localizable", "_report_field_placeholder") }
    /// What are the exact steps you performed?
    public static var reportFieldSteps: String { return LocalizedString.tr("Localizable", "_report_field_steps") }
    /// VPN logs
    public static var reportLogs: String { return LocalizedString.tr("Localizable", "_report_logs") }
    /// Enabling this will add your client side VPN logs to this report
    public static var reportLogsDescription: String { return LocalizedString.tr("Localizable", "_report_logs_description") }
    /// Contact email
    public static var reportPlaceholderEmail: String { return LocalizedString.tr("Localizable", "_report_placeholder_email") }
    /// Your message...
    public static var reportPlaceholderMessage: String { return LocalizedString.tr("Localizable", "_report_placeholder_message") }
    /// Report message
    public static var reportReport: String { return LocalizedString.tr("Localizable", "_report_report") }
    /// Send Report
    public static var reportSend: String { return LocalizedString.tr("Localizable", "_report_send") }
    /// Thank you for your report
    public static var reportSuccess: String { return LocalizedString.tr("Localizable", "_report_success") }
    /// Request manual activation
    public static var requestInvitation: String { return LocalizedString.tr("Localizable", "_request_invitation") }
    /// Request new code
    public static var resendCode: String { return LocalizedString.tr("Localizable", "_resend_code") }
    /// Didn't get the code?
    public static var resendNoCode: String { return LocalizedString.tr("Localizable", "_resend_no_code") }
    /// New code requested
    public static var resendSuccess: String { return LocalizedString.tr("Localizable", "_resend_success") }
    /// Reset Password
    public static var resetPassword: String { return LocalizedString.tr("Localizable", "_reset_password") }
    /// Retry
    public static var retry: String { return LocalizedString.tr("Localizable", "_retry") }
    /// Save
    public static var save: String { return LocalizedString.tr("Localizable", "_save") }
    /// Save as Profile
    public static var saveAsProfile: String { return LocalizedString.tr("Localizable", "_save_as_profile") }
    /// Search for country
    public static var searchForCountry: String { return LocalizedString.tr("Localizable", "_search_for_country") }
    /// Search country
    public static var searchPhoneCountryCodePlaceholder: String { return LocalizedString.tr("Localizable", "_search_phone_country_code_placeholder") }
    /// Secure Core
    public static var secureCore: String { return LocalizedString.tr("Localizable", "_secure_core") }
    /// Secure Core %@
    public static func secureCoreCountry(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_secure_core_country", String(describing: p1))
    }
    /// Ultra secure servers
    /// hosted by us
    public static var secureCoreDescription: String { return LocalizedString.tr("Localizable", "_secure_core_description") }
    /// Provides additional protection against VPN server compromise by routing traffic through our Secure Core Network
    public static var secureCoreInfo: String { return LocalizedString.tr("Localizable", "_secure_core_info") }
    /// Secure streaming of your
    /// favorite content
    public static var secureStreamingDescription: String { return LocalizedString.tr("Localizable", "_secure_streaming_description") }
    /// Secure Streaming
    public static var secureStreamingTitle: String { return LocalizedString.tr("Localizable", "_secure_streaming_title") }
    /// Security
    public static var security: String { return LocalizedString.tr("Localizable", "_security") }
    /// Security Options
    public static var securityOptions: String { return LocalizedString.tr("Localizable", "_security_options") }
    /// Select Country
    public static var selectCountry: String { return LocalizedString.tr("Localizable", "_select_country") }
    /// Select Country Code
    public static var selectPhoneCountryCode: String { return LocalizedString.tr("Localizable", "_select_phone_country_code") }
    /// Select plan
    public static var selectPlan: String { return LocalizedString.tr("Localizable", "_select_plan") }
    /// Select profile color
    public static var selectProfileColor: String { return LocalizedString.tr("Localizable", "_select_profile_color") }
    /// Select Server
    public static var selectServer: String { return LocalizedString.tr("Localizable", "_select_server") }
    /// Please select a verification option to proceed:
    public static var selectVerificationOption: String { return LocalizedString.tr("Localizable", "_select_verification_option") }
    /// To prevent abuse, you must verify you are a human.
    public static var selectVerificationOptionTopMessage: String { return LocalizedString.tr("Localizable", "_select_verification_option_top_message") }
    /// Server
    public static var server: String { return LocalizedString.tr("Localizable", "_server") }
    /// Server IP:
    public static var serverIp: String { return LocalizedString.tr("Localizable", "_server_ip") }
    /// Server Load:
    public static var serverLoad: String { return LocalizedString.tr("Localizable", "_server_load") }
    /// Server Load
    public static var serverLoadTitle: String { return LocalizedString.tr("Localizable", "_server_load_title") }
    /// Please select a server
    public static var serverSelectionIsRequired: String { return LocalizedString.tr("Localizable", "_server_selection_is_required") }
    /// Server under maintenance
    public static var serverUnderMaintenance: String { return LocalizedString.tr("Localizable", "_server_under_maintenance") }
    /// Session Time
    public static var sessionTime: String { return LocalizedString.tr("Localizable", "_session_time") }
    /// Settings
    public static var settings: String { return LocalizedString.tr("Localizable", "_settings") }
    /// Setup Complete
    public static var setupComplete: String { return LocalizedString.tr("Localizable", "_setup_complete") }
    /// You are now signed up for a Proton VPN Free plan. To get you started, enjoy seven days of our Proton VPN Plus plan for free.
    public static var setupCompleteFree: String { return LocalizedString.tr("Localizable", "_setup_complete_free") }
    /// Your purchase was successful. Your Proton VPN Plus plan is now active.
    public static var setupCompletePlus: String { return LocalizedString.tr("Localizable", "_setup_complete_plus") }
    /// SHOW
    public static var show: String { return LocalizedString.tr("Localizable", "_show") }
    /// Show instructions
    public static var showInstructions: String { return LocalizedString.tr("Localizable", "_show_instructions") }
    /// Show Proton VPN
    public static var showProtonvpn: String { return LocalizedString.tr("Localizable", "_show_protonvpn") }
    /// Sign Up
    public static var signUp: String { return LocalizedString.tr("Localizable", "_sign_up") }
    /// Skip
    public static var skip: String { return LocalizedString.tr("Localizable", "_skip") }
    /// Enable Smart Protocol to automatically use the protocol and port that offers the best connectivity.
    public static var smartProtocolDescription: String { return LocalizedString.tr("Localizable", "_smart_protocol_description") }
    /// Your connection will be restarted to change the Smart Protocol mode.
    public static var smartProtocolReconnectModalBody: String { return LocalizedString.tr("Localizable", "_smart_protocol_reconnect_modal_body") }
    /// Reconnection required
    public static var smartProtocolReconnectModalTitle: String { return LocalizedString.tr("Localizable", "_smart_protocol_reconnect_modal_title") }
    /// Smart Protocol
    public static var smartProtocolTitle: String { return LocalizedString.tr("Localizable", "_smart_protocol_title") }
    /// Smart Routing
    public static var smartRoutingTitle: String { return LocalizedString.tr("Localizable", "_smart_routing_title") }
    /// Smart
    public static var smartTitle: String { return LocalizedString.tr("Localizable", "_smart_title") }
    /// %@ speed
    public static func speed(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_speed", String(describing: p1))
    }
    /// Standard
    public static var standard: String { return LocalizedString.tr("Localizable", "_standard") }
    /// Start Minimized
    public static var startMinimized: String { return LocalizedString.tr("Localizable", "_start_minimized") }
    /// Start on Boot
    public static var startOnBoot: String { return LocalizedString.tr("Localizable", "_start_on_boot") }
    /// Status
    public static var status: String { return LocalizedString.tr("Localizable", "_status") }
    /// Connect to a Plus server in this country to start streaming.
    public static var streamingServersDescription: String { return LocalizedString.tr("Localizable", "_streaming_servers_description") }
    /// and more
    public static var streamingServersExtra: String { return LocalizedString.tr("Localizable", "_streaming_servers_extra") }
    /// Note: Turn off the Location Service and clear the cache of the streaming apps to ensure new content appears.
    public static var streamingServersNote: String { return LocalizedString.tr("Localizable", "_streaming_servers_note") }
    /// Streaming
    public static var streamingTitle: String { return LocalizedString.tr("Localizable", "_streaming_title") }
    /// Submit
    public static var submitVerificationCode: String { return LocalizedString.tr("Localizable", "_submit_verification_code") }
    /// Extend plan for 1 year
    /// %@.
    public static func subscriptionButton(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_subscription_button", String(describing: p1))
    }
    /// You can purchase more credits to automatically extend your current plan. At the end of your current subscription period, these credits will be applied to continue your plan.
    public static var subscriptionDescription: String { return LocalizedString.tr("Localizable", "_subscription_description") }
    /// Your subscription has been downgraded.
    public static var subscriptionExpiredDescription: String { return LocalizedString.tr("Localizable", "_subscription_expired_description") }
    /// Your subscription has been downgraded, so we are reconnecting to the fastest available server.
    public static var subscriptionExpiredReconnectionDescription: String { return LocalizedString.tr("Localizable", "_subscription_expired_reconnection_description") }
    /// Your VPN subscription plan has expired
    public static var subscriptionExpiredTitle: String { return LocalizedString.tr("Localizable", "_subscription_expired_title") }
    /// You have successfully bought credits to extend your current plan.
    public static var subscriptionExtendedSuccess: String { return LocalizedString.tr("Localizable", "_subscription_extended_success") }
    /// Subscription Plan
    public static var subscriptionPlan: String { return LocalizedString.tr("Localizable", "_subscription_plan") }
    /// Plural format key: "%#@VARIABLE@"
    public static func subscriptionUpgradeOption1(_ p1: Int) -> String {
      return LocalizedString.tr("Localizable", "_subscription_upgrade_option1", p1)
    }
    /// Plural format key: "%#@VARIABLE@"
    public static func subscriptionUpgradeOption2(_ p1: Int) -> String {
      return LocalizedString.tr("Localizable", "_subscription_upgrade_option2", p1)
    }
    /// Advanced features: NetShield, Secure Core, Tor, P2P
    public static var subscriptionUpgradeOption3: String { return LocalizedString.tr("Localizable", "_subscription_upgrade_option3") }
    /// Upgrade again to enjoy all the features:
    public static var subscriptionUpgradeTitle: String { return LocalizedString.tr("Localizable", "_subscription_upgrade_title") }
    /// Current plan will expire on %@.
    public static func subscriptionWillExpire(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_subscription_will_expire", String(describing: p1))
    }
    /// Current plan will automatically renew on %@.
    public static func subscriptionWillRenew(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_subscription_will_renew", String(describing: p1))
    }
    /// Assign VPN connections
    public static var subuserAlertAssignConnectionsButton: String { return LocalizedString.tr("Localizable", "_subuser_alert_assign_connections_button") }
    /// To start your journey in Proton VPN please assign VPN connections to your account or any other sub-account.
    public static var subuserAlertDescription1: String { return LocalizedString.tr("Localizable", "_subuser_alert_description1") }
    /// This step will take just a few minutes. After that you will be able to log in and protect all your devices.
    public static var subuserAlertDescription2: String { return LocalizedString.tr("Localizable", "_subuser_alert_description2") }
    /// Login again
    public static var subuserAlertLoginButton: String { return LocalizedString.tr("Localizable", "_subuser_alert_login_button") }
    /// Thanks for upgrading to Professional/Visionary
    public static var subuserAlertTitle: String { return LocalizedString.tr("Localizable", "_subuser_alert_title") }
    /// Successfully Connected
    public static var successfullyConnected: String { return LocalizedString.tr("Localizable", "_successfully_connected") }
    /// OFF
    public static var switchSideButtonOff: String { return LocalizedString.tr("Localizable", "_switch_side_button_off") }
    /// ON
    public static var switchSideButtonOn: String { return LocalizedString.tr("Localizable", "_switch_side_button_on") }
    /// Cannot enable System Extension
    public static var sysexCannotEnable: String { return LocalizedString.tr("Localizable", "_sysex_cannot_enable") }
    /// Configuration completed. Now you can browse the internet faster with the best VPN technologies.
    public static var sysexEnabledDescription: String { return LocalizedString.tr("Localizable", "_sysex_enabled_description") }
    /// Configuration completed
    public static var sysexEnabledTitle: String { return LocalizedString.tr("Localizable", "_sysex_enabled_title") }
    /// An error occurred while installing System Extension.
    /// Reinstall Proton VPN, making sure it is located in the Applications folder, to fix this problem. Alternatively, contact our support.
    public static var sysexErrorDescription: String { return LocalizedString.tr("Localizable", "_sysex_error_description") }
    /// Proton VPN requires to load a System Extension to leverage Smart Protocol, OpenVPN and WireGuard.
    public static var sysexSettingsDescription: String { return LocalizedString.tr("Localizable", "_sysex_settings_description") }
    /// Two dialogs will appear. Click on "Open Security Preferences".
    /// Alternatively, click here to open preferences.
    public static var sysexWizardStep1Description: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step1_description") }
    /// A security dialog has appeared. Click on "Open Security Preferences".
    /// Alternatively, click here to open preferences.
    public static var sysexWizardStep1Description1: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step1_description_1") }
    /// Open System Preferences: click here.
    /// Then, go to the "Security & Privacy" pane.
    public static var sysexWizardStep1DescriptionGoToSystemPreferences: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step1_description_go_to_system_preferences") }
    /// click here
    public static var sysexWizardStep1DescriptionLink: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step1_description_link") }
    /// Open Security Preferences
    public static var sysexWizardStep1Title: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step1_title") }
    /// Open Security Preferences
    public static var sysexWizardStep1Title1: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step1_title_1") }
    /// Click the lock to make changes
    public static var sysexWizardStep2Description: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step2_description") }
    /// Unlock to make changes
    public static var sysexWizardStep2Title: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step2_title") }
    /// Enter your macOS credentials to authenticate
    public static var sysexWizardStep3Description: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step3_description") }
    /// Enter credentials
    public static var sysexWizardStep3Title: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step3_title") }
    /// Click the “Details...” button
    public static var sysexWizardStep4Description: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step4_description") }
    /// Click the “Allow” button
    public static var sysexWizardStep4Description1: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step4_description_1") }
    /// “Details...” button
    public static var sysexWizardStep4Title: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step4_title") }
    /// “Allow” button
    public static var sysexWizardStep4Title1: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step4_title_1") }
    /// Select both Proton VPN items to enable custom protocols and click “OK”
    public static var sysexWizardStep5Description: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step5_description") }
    /// Selecting Proton VPN items
    public static var sysexWizardStep5Title: String { return LocalizedString.tr("Localizable", "_sysex_wizard_step5_title") }
    /// In order to do so, follow the steps below:
    public static var sysexWizardSubtitle: String { return LocalizedString.tr("Localizable", "_sysex_wizard_subtitle") }
    /// You’re now ready to use Proton VPN with the latest and fastest VPN technologies available!
    public static var sysexWizardTextUnderSteps: String { return LocalizedString.tr("Localizable", "_sysex_wizard_text_under_steps") }
    /// Enjoy the fastest connections by enabling custom protocols
    public static var sysexWizardTitle: String { return LocalizedString.tr("Localizable", "_sysex_wizard_title") }
    /// Enabling custom protocols
    public static var sysexWizardWindowTitle: String { return LocalizedString.tr("Localizable", "_sysex_wizard_window_title") }
    /// System Notifications
    public static var systemNotifications: String { return LocalizedString.tr("Localizable", "_system_notifications") }
    /// Take a Tour
    public static var takeTour: String { return LocalizedString.tr("Localizable", "_take_tour") }
    /// TCP
    public static var tcp: String { return LocalizedString.tr("Localizable", "_tcp") }
    /// Technical Details
    public static var technicalDetails: String { return LocalizedString.tr("Localizable", "_technical_details") }
    /// Terms and Conditions
    public static var termsAndConditions: String { return LocalizedString.tr("Localizable", "_terms_and_conditions") }
    /// By using Proton VPN, you agree to our
    /// %@ and %@
    public static func termsAndConditionsDisclaimer(_ p1: Any, _ p2: Any) -> String {
      return LocalizedString.tr("Localizable", "_terms_and_conditions_disclaimer", String(describing: p1), String(describing: p2))
    }
    /// TEST Servers
    public static var testServers: String { return LocalizedString.tr("Localizable", "_test_servers") }
    /// Free
    public static var tierFree: String { return LocalizedString.tr("Localizable", "_tier_free") }
    /// Plus
    public static var tierPlus: String { return LocalizedString.tr("Localizable", "_tier_plus") }
    /// Visionary
    public static var tierVisionary: String { return LocalizedString.tr("Localizable", "_tier_visionary") }
    /// timed out
    public static var timedOut: String { return LocalizedString.tr("Localizable", "_timed_out") }
    /// Another application might be interfering with kill switch. To fix this problem, switch to the OpenVPN protocol or disable kill switch and retry.
    public static var timeoutKsIkeDescritpion: String { return LocalizedString.tr("Localizable", "_timeout_ks_ike_descritpion") }
    /// Switch to OpenVPN and retry
    public static var timeoutKsIkeSwitchProtocol: String { return LocalizedString.tr("Localizable", "_timeout_ks_ike_switch_protocol") }
    /// To Server:
    public static var toServerTitle: String { return LocalizedString.tr("Localizable", "_to_server_title") }
    /// TOR
    public static var tor: String { return LocalizedString.tr("Localizable", "_tor") }
    /// Connects to TOR network
    public static var torDescription: String { return LocalizedString.tr("Localizable", "_tor_description") }
    /// Tor Server
    public static var torServer: String { return LocalizedString.tr("Localizable", "_tor_server") }
    /// Tor
    public static var torTitle: String { return LocalizedString.tr("Localizable", "_tor_title") }
    /// Your 7 day free trial of Proton VPN Plus has expired. You can continue to use Proton VPN Free, but if you would like to support the project and have access to more countries and features, please upgrade to a paid plan.
    public static var trialExpiredAlertBodyIOS: String { return LocalizedString.tr("Localizable", "_trial_expired_alert_body_iOS") }
    /// Proton VPN Plus trial expired
    public static var trialExpiredAlertTitleIOS: String { return LocalizedString.tr("Localizable", "_trial_expired_alert_title_iOS") }
    /// To have permanent access to Proton VPN Plus features, you can upgrade your plan.
    public static var trialPopupCallToUpgrade: String { return LocalizedString.tr("Localizable", "_trial_popup_call_to_upgrade") }
    /// Enjoy the full benefits of secure internet anywhere with Proton VPN
    public static var trialPopupEnjoy: String { return LocalizedString.tr("Localizable", "_trial_popup_enjoy") }
    /// As a welcome gift, you have access to a %@, including advanced features for the first few days! Your welcome trial ends in
    public static func trialPopupExplanation(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_trial_popup_explanation", String(describing: p1))
    }
    /// free upgrade to Proton VPN Plus
    public static var trialPopupFreeUpgrade: String { return LocalizedString.tr("Localizable", "_trial_popup_free_upgrade") }
    /// full Proton VPN subscription
    public static var trialPopupFullSubscription: String { return LocalizedString.tr("Localizable", "_trial_popup_full_subscription") }
    /// We have given you a %@ which includes more servers and additional features. Your Proton VPN Plus trial ends in 7 days.
    public static func trialPopupIntroduction(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_trial_popup_introduction", String(describing: p1))
    }
    /// Thank you for using Proton VPN!
    public static var trialPopupThanks: String { return LocalizedString.tr("Localizable", "_trial_popup_thanks") }
    /// Proton VPN Trial
    public static var trialPopupTitle: String { return LocalizedString.tr("Localizable", "_trial_popup_title") }
    /// As a welcome gift you have access to a full Proton VPN subscription including advanced features for the first days!
    public static var trialWelcomeDescriptionIOS: String { return LocalizedString.tr("Localizable", "_trial_welcome_description_iOS") }
    /// Your trial ends in
    public static var trialWelcomeEndsInIOS: String { return LocalizedString.tr("Localizable", "_trial_welcome_ends_in_iOS") }
    /// Welcome on board
    public static var trialWelcomeHeadingIOS: String { return LocalizedString.tr("Localizable", "_trial_welcome_heading_iOS") }
    /// In case Proton sites are blocked, this setting allows the app to try alternative network routing to reach Proton, which can be useful for bypassing firewalls or network issues. We recommend keeping this setting on for greater reliability.
    /// Learn more
    public static var troubleshootItemAltDescription: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_alt_description") }
    /// Learn more
    public static var troubleshootItemAltLink1: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_alt_link1") }
    /// Allow alternative routing
    public static var troubleshootItemAltTitle: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_alt_title") }
    /// Temporarily disable or remove your antivirus software.
    public static var troubleshootItemAntivirusDescription: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_antivirus_description") }
    /// Antivirus interference
    public static var troubleshootItemAntivirusTitle: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_antivirus_title") }
    /// Your country may be blocking access to Proton. Try using Tor to access Proton.
    public static var troubleshootItemGovDescription: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_gov_description") }
    /// Tor
    public static var troubleshootItemGovLink1: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_gov_link1") }
    /// Government block
    public static var troubleshootItemGovTitle: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_gov_title") }
    /// Try connecting to Proton from a different network (or Tor).
    public static var troubleshootItemIspDescription: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_isp_description") }
    /// Tor
    public static var troubleshootItemIspLink1: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_isp_link1") }
    /// Internet Service Provider (ISP) problem
    public static var troubleshootItemIspTitle: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_isp_title") }
    /// Please make sure that your internet connection is working.
    public static var troubleshootItemNointernetDescription: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_nointernet_description") }
    /// No internet connection
    public static var troubleshootItemNointernetTitle: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_nointernet_title") }
    /// Contact us directly through our support form, email (%@), or Twitter.
    public static func troubleshootItemOtherDescription(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_troubleshoot_item_other_description", String(describing: p1))
    }
    /// support form
    public static var troubleshootItemOtherLink1: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_other_link1") }
    /// email
    public static var troubleshootItemOtherLink2: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_other_link2") }
    /// Twitter
    public static var troubleshootItemOtherLink3: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_other_link3") }
    /// Still can’t find a solution
    public static var troubleshootItemOtherTitle: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_other_title") }
    /// Check Proton Status for our system status.
    public static var troubleshootItemProtonDescription: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_proton_description") }
    /// Proton Status
    public static var troubleshootItemProtonLink1: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_proton_link1") }
    /// Proton is down
    public static var troubleshootItemProtonTitle: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_proton_title") }
    /// Disable any proxies or firewalls, or contact your network administrator.
    public static var troubleshootItemProxyDescription: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_proxy_description") }
    /// Proxy/Firewall interference
    public static var troubleshootItemProxyTitle: String { return LocalizedString.tr("Localizable", "_troubleshoot_item_proxy_title") }
    /// Troubleshooting
    public static var troubleshootTitle: String { return LocalizedString.tr("Localizable", "_troubleshoot_title") }
    /// Try again
    public static var tryAgain: String { return LocalizedString.tr("Localizable", "_try_again") }
    /// Disable kill switch and retry
    public static var tryAgainWithoutKillswitch: String { return LocalizedString.tr("Localizable", "_try_again_without_killswitch") }
    /// By activating kill switch, you won't be able to access devices on your local network.
    ///
    /// Continue?
    public static var turnKsOnDescription: String { return LocalizedString.tr("Localizable", "_turn_ks_on_description") }
    /// Turn kill switch on?
    public static var turnKsOnTitle: String { return LocalizedString.tr("Localizable", "_turn_ks_on_title") }
    /// Turn on
    public static var turnOn: String { return LocalizedString.tr("Localizable", "_turn_on") }
    /// UDP
    public static var udp: String { return LocalizedString.tr("Localizable", "_udp") }
    /// Unavailable
    public static var unavailable: String { return LocalizedString.tr("Localizable", "_unavailable") }
    /// Notify unprotected networks
    public static var unprotectedNetwork: String { return LocalizedString.tr("Localizable", "_unprotected_network") }
    /// Receive a notification when Proton VPN detects you are connected to an unprotected network.
    public static var unprotectedNetworkTooltip: String { return LocalizedString.tr("Localizable", "_unprotected_network_tooltip") }
    /// Insecure WiFi connection detected
    public static var unsecureWifi: String { return LocalizedString.tr("Localizable", "_unsecure_wifi") }
    /// Learn More
    public static var unsecureWifiLearnMore: String { return LocalizedString.tr("Localizable", "_unsecure_wifi_learn_more") }
    /// Insecure WiFi Detected
    public static var unsecureWifiTitle: String { return LocalizedString.tr("Localizable", "_unsecure_wifi_title") }
    /// UPDATE MY BILLING
    public static var updateBilling: String { return LocalizedString.tr("Localizable", "_update_billing") }
    /// Update required
    public static var updateRequired: String { return LocalizedString.tr("Localizable", "_update_required") }
    /// This version of Proton VPN is no longer supported, please update the app to continue using it.
    public static var updateRequiredNoLongerSupported: String { return LocalizedString.tr("Localizable", "_update_required_no_longer_supported") }
    /// Contact support
    public static var updateRequiredSupport: String { return LocalizedString.tr("Localizable", "_update_required_support") }
    /// Update
    public static var updateRequiredUpdate: String { return LocalizedString.tr("Localizable", "_update_required_update") }
    /// Upgrade
    public static var upgrade: String { return LocalizedString.tr("Localizable", "_upgrade") }
    /// UPGRADE AGAIN
    public static var upgradeAgain: String { return LocalizedString.tr("Localizable", "_upgrade_again") }
    /// to use Secure Core
    public static var upgradeForSecureCore: String { return LocalizedString.tr("Localizable", "_upgrade_for_secure_core") }
    /// Upgrade My Plan
    public static var upgradeMyPlan: String { return LocalizedString.tr("Localizable", "_upgrade_my_plan") }
    /// Upgrade Now
    public static var upgradeNow: String { return LocalizedString.tr("Localizable", "_upgrade_now") }
    /// Sorry, no servers available for your subscription tier in this country right now. If you would like to access more servers, consider upgrading your subscription.
    public static var upgradePlanToAccessCountry: String { return LocalizedString.tr("Localizable", "_upgrade_plan_to_access_country") }
    /// Secure Core is a premium feature which requires Proton VPN Plus or higher. Secure Core adds advanced protection against VPN server monitoring.
    public static var upgradePlanToAccessSecureCoreP1: String { return LocalizedString.tr("Localizable", "_upgrade_plan_to_access_secure_core_p1") }
    /// To access Secure Core, check out our other subscription plans which include this feature.
    public static var upgradePlanToAccessSecureCoreP2: String { return LocalizedString.tr("Localizable", "_upgrade_plan_to_access_secure_core_p2") }
    /// Sorry, this server is not available for your subscription tier. If you would like to access more servers, consider upgrading your subscription.
    public static var upgradePlanToAccessServer: String { return LocalizedString.tr("Localizable", "_upgrade_plan_to_access_server") }
    /// Upgrade Required
    public static var upgradeRequired: String { return LocalizedString.tr("Localizable", "_upgrade_required") }
    /// Secure Core is available with a Plus plan. Upgrade now to route traffic through our safest servers in privacy-friendly countries.
    public static var upgradeRequiredSecurecoreDescription: String { return LocalizedString.tr("Localizable", "_upgrade_required_securecore_description") }
    /// Upgrade Subscription
    public static var upgradeSubscription: String { return LocalizedString.tr("Localizable", "_upgrade_subscription") }
    /// Upgrade to Plus
    public static var upgradeToPlus: String { return LocalizedString.tr("Localizable", "_upgrade_to_plus") }
    /// Your Proton VPN subscription cannot be upgraded from within the app, please visit account.protonvpn.com to upgrade.
    public static var upgradeUnavailableBody: String { return LocalizedString.tr("Localizable", "_upgrade_unavailable_body") }
    /// Upgrade Unavailable in App
    public static var upgradeUnavailableTitle: String { return LocalizedString.tr("Localizable", "_upgrade_unavailable_title") }
    /// Verify with CAPTCHA
    public static var useCaptchaVerification: String { return LocalizedString.tr("Localizable", "_use_captcha_verification") }
    /// Verify with email
    public static var useOtherEmailAddress: String { return LocalizedString.tr("Localizable", "_use_other_email_address") }
    /// Secure Core
    public static var useSecureCore: String { return LocalizedString.tr("Localizable", "_use_secure_core") }
    /// Verify with SMS
    public static var useSmsVerification: String { return LocalizedString.tr("Localizable", "_use_sms_verification") }
    /// Username
    public static var username: String { return LocalizedString.tr("Localizable", "_username") }
    /// A verification code has been sent to you, please enter it below.
    public static var verificationInstructions: String { return LocalizedString.tr("Localizable", "_verification_instructions") }
    /// Version
    public static var version: String { return LocalizedString.tr("Localizable", "_version") }
    /// Current version:
    public static var versionCurrent: String { return LocalizedString.tr("Localizable", "_version_current") }
    /// via
    public static var via: String { return LocalizedString.tr("Localizable", "_via") }
    /// via %@
    public static func viaCountry(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_via_country", String(describing: p1))
    }
    /// View Logs
    public static var viewLogs: String { return LocalizedString.tr("Localizable", "_view_logs") }
    /// Toggling Secure Core will end your current connection.
    public static var viewToggleWillCauseDisconnect: String { return LocalizedString.tr("Localizable", "_view_toggle_will_cause_disconnect") }
    /// Change VPN Accelerator
    public static var vpnAcceleratorChangeTitle: String { return LocalizedString.tr("Localizable", "_vpn_accelerator_change_title") }
    /// VPN Accelerator enables a set of unique performance enhancing technologies which can increase VPN speeds by up to 400%%.
    /// Learn more
    public static var vpnAcceleratorDescription: String { return LocalizedString.tr("Localizable", "_vpn_accelerator_description") }
    /// Learn more
    public static var vpnAcceleratorDescriptionAltLink: String { return LocalizedString.tr("Localizable", "_vpn_accelerator_description_alt_link") }
    /// VPN Accelerator
    public static var vpnAcceleratorTitle: String { return LocalizedString.tr("Localizable", "_vpn_accelerator_title") }
    /// VPN Connection Active
    public static var vpnConnectionActive: String { return LocalizedString.tr("Localizable", "_vpn_connection_active") }
    /// VPN Protocol
    public static var vpnProtocol: String { return LocalizedString.tr("Localizable", "_vpn_protocol") }
    /// Your device failed to terminate a previous VPN session. You will need to restart your device before you can establish a new VPN connection.
    public static var vpnStuckDisconnectingBody: String { return LocalizedString.tr("Localizable", "_vpn_stuck_disconnecting_body") }
    /// Connection error
    public static var vpnStuckDisconnectingTitle: String { return LocalizedString.tr("Localizable", "_vpn_stuck_disconnecting_title") }
    /// Failed to refresh VPN certificate. Please check your connection
    public static var vpnauthCertfailDescription: String { return LocalizedString.tr("Localizable", "_vpnauth_certfail_description") }
    /// Authentication error
    public static var vpnauthCertfailTitle: String { return LocalizedString.tr("Localizable", "_vpnauth_certfail_title") }
    /// You reached the maximum number of setting changes. Please try again in a few minutes
    public static var vpnauthTooManyCertsDescription: String { return LocalizedString.tr("Localizable", "_vpnauth_too_many_certs_description") }
    /// Plural format key: "%#@VARIABLE@"
    public static func vpnauthTooManyCertsRetryAfter(_ p1: Int) -> String {
      return LocalizedString.tr("Localizable", "_vpnauth_too_many_certs_retry_after", p1)
    }
    /// Authentication error
    public static var vpnauthTooManyCertsTitle: String { return LocalizedString.tr("Localizable", "_vpnauth_too_many_certs_title") }
    /// You are not logged in to Proton VPN. Open the Proton VPN app and sign in.
    public static var vpnstatusNotLoggedin: String { return LocalizedString.tr("Localizable", "_vpnstatus_not_loggedin") }
    /// Warning
    public static var warning: String { return LocalizedString.tr("Localizable", "_warning") }
    /// Another user's Proton VPN session is active on this device. Continuing with the log in process will cause the current session to end. Do you want to continue?
    public static var warningVpnSessionIsActive: String { return LocalizedString.tr("Localizable", "_warning_vpn_session_is_active") }
    /// High-speed Swiss VPN that safeguards your privacy by encrypting your internet connection.
    public static var welcomeBody: String { return LocalizedString.tr("Localizable", "_welcome_body") }
    /// Thanks for using Proton VPN. Take a quick look
    /// at the main app features.
    public static var welcomeDescription: String { return LocalizedString.tr("Localizable", "_welcome_description") }
    /// As a welcome gift, you are granted a 7-day access to a
    /// %@ subscription which gives you:
    public static func welcomeGiftDescription(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "_welcome_gift_description", String(describing: p1))
    }
    /// Protect yourself online
    public static var welcomeHeadline: String { return LocalizedString.tr("Localizable", "_welcome_headline") }
    /// WELCOME ON BOARD!
    public static var welcomeTitle: String { return LocalizedString.tr("Localizable", "_welcome_title") }
    /// Kill switch is preventing the VPN to connect to the internet. This might be due to an incompatibility with your operating system (macOS Catalina 10.15).
    ///
    /// To resolve this problem, update your operating system to the latest version.
    ///
    /// Alternatively, you can switch to the OpenVPN protocol or disable kill switch.
    public static var wgksDescription: String { return LocalizedString.tr("Localizable", "_wgks_description") }
    /// Disable kill switch
    public static var wgksKsOff: String { return LocalizedString.tr("Localizable", "_wgks_ks_off") }
    /// Switch to OpenVPN
    public static var wgksOvpn: String { return LocalizedString.tr("Localizable", "_wgks_ovpn") }
    /// Kill switch is preventing the VPN to connect to internet
    public static var wgksTitle: String { return LocalizedString.tr("Localizable", "_wgks_title") }
    /// iOS Widget
    public static var widget: String { return LocalizedString.tr("Localizable", "_widget") }
    /// WireGuard
    public static var wireguard: String { return LocalizedString.tr("Localizable", "_wireguard") }
    /// WireGuard Logs
    public static var wireguardLogs: String { return LocalizedString.tr("Localizable", "_wireguard_logs") }
    /// You are not connected
    public static var youAreNotConnected: String { return LocalizedString.tr("Localizable", "_you_are_not_connected") }
    /// Apply
    public static var applyCoupon: String { return LocalizedString.tr("Localizable", "apply_coupon") }
    /// Authenticate
    public static var authenticate: String { return LocalizedString.tr("Localizable", "authenticate") }
    /// Coupon has been applied successfully.
    public static var couponApplied: String { return LocalizedString.tr("Localizable", "coupon_applied") }
    /// Coupon has been applied successfully. Your subscription will be upgraded within a few minutes.
    public static var couponAppliedPlanNotUpgradedYet: String { return LocalizedString.tr("Localizable", "coupon_applied_plan_not_upgraded_yet") }
    /// Coupon code
    public static var couponCode: String { return LocalizedString.tr("Localizable", "coupon_code") }
    /// Configuring your VPN access
    public static var loginFetchVpnData: String { return LocalizedString.tr("Localizable", "login_fetch_vpn_data") }
    /// Start using Proton VPN
    public static var loginSummaryButton: String { return LocalizedString.tr("Localizable", "login_summary_button") }
    /// Invalid login method. Please contact support.
    public static var loginUnsupportedState: String { return LocalizedString.tr("Localizable", "login_unsupported_state") }
    /// Please disconnect another device to connect to this one or upgrade to %@
    public static func maximumDevicePlanLimitPart1(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "maximum_device_plan_limit_part_1", String(describing: p1))
    }
    /// Plural format key: " to get up to %#@num_devices@ connected at the same time."
    public static func maximumDevicePlanLimitPart2(_ p1: Int) -> String {
      return LocalizedString.tr("Localizable", "maximum_device_plan_limit_part_2", p1)
    }
    /// The Proton VPN website might be temporarily unreachable due to network restrictions. Please use the mobile app to create a new Proton account.
    public static var protonWebsiteUnreachable: String { return LocalizedString.tr("Localizable", "proton_website_unreachable") }
    /// Recovery code
    public static var recoveryCode: String { return LocalizedString.tr("Localizable", "recovery_code") }
    /// Two-factor authentication
    public static var twoFactorAuthentication: String { return LocalizedString.tr("Localizable", "two_factor_authentication") }
    /// Two-factor code
    public static var twoFactorCode: String { return LocalizedString.tr("Localizable", "two_factor_code") }
    /// Use coupon
    public static var useCoupon: String { return LocalizedString.tr("Localizable", "use_coupon") }
    /// Use recovery code
    public static var useRecoveryCode: String { return LocalizedString.tr("Localizable", "use_recovery_code") }
    /// Use two-factor code
    public static var useTwoFactorCode: String { return LocalizedString.tr("Localizable", "use_two_factor_code") }
    /// %@ setting could not be changed. Please try again later or connect to a different server
    public static func vpnFeatureCannotBeSetError(_ p1: Any) -> String {
      return LocalizedString.tr("Localizable", "vpn_feature_cannot_be_set_error", String(describing: p1))
    }
  }
  // swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
  // swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

  // MARK: - Implementation Details

  extension LocalizedString {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
      let format = localizeStringAndFallbackToEn(key, table)
      return String(format: format, locale: Locale.current, arguments: args)
    }
}

