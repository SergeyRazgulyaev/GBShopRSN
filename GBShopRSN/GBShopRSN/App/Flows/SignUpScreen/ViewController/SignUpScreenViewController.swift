//
//  SignUpScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 07.03.2021.
//

import UIKit
import FirebaseAnalytics
import os.log

class SignUpScreenViewController: UIViewController, AnalyticsSendable, Alertable {
    // MARK: - UI components
    private lazy var signUpScreenView: SignUpScreenView = {
        return SignUpScreenView()
    }()
    
    // MARK: - Properties
    private let requestFactory: RequestFactory
    private let defaultUserID = 0
    private let defaultUserLogin = ""
    private let defaultUserName = ""
    private let defaultUserLastName = ""
    private let defaultUserEmail = ""
    private let defaultUserGender = ""
    private let defaultUserCreditCard = ""
    private let defaultUserBio = ""
    private let defaultUserPassword = ""
    
    // MARK: - Init
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureUIComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardAddObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clearSignUpScreenTextFields()
        keyboardRemoveObserver()
    }
    
    override func loadView() {
        view = signUpScreenView
    }
    
    //MARK: - Configuration Methods
    func configureViewController() {
        view.backgroundColor = .rsnLightBlueColor
    }
    
    func configureUIComponents() {
        configureTextFields()
        configureSendDataForSignUpButton()
        configureCancelAndReturnButton()
    }
    
    func configureTextFields() {
        signUpScreenView.userLoginTextField.text = defaultUserLogin
        signUpScreenView.userNameTextField.text = defaultUserName
        signUpScreenView.userLastNameTextField.text = defaultUserLastName
        signUpScreenView.emailTextField.text = defaultUserEmail
        signUpScreenView.genderTextField.text = defaultUserGender
        signUpScreenView.creditCardTextField.text = defaultUserCreditCard
        signUpScreenView.bioTextField.text = defaultUserBio
    }
    
    func clearSignUpScreenTextFields() {
        signUpScreenView.userNameTextField.text = ""
        signUpScreenView.userLastNameTextField.text = ""
        signUpScreenView.emailTextField.text = ""
        signUpScreenView.genderTextField.text = ""
        signUpScreenView.creditCardTextField.text = ""
        signUpScreenView.bioTextField.text = ""
        signUpScreenView.passwordTextField.text = ""
        signUpScreenView.repeatedPasswordTextField.text = ""
    }
    
    func configureSendDataForSignUpButton() {
        signUpScreenView.sendDataForSignUpButton.addTarget(self, action: #selector(tapSendDataForSignUpButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapSendDataForSignUpButton(_ sender: Any?) {
        if isFilledTextFields() {
            if areEqualPasswordAndConfirmationPassword() {
                sendDataForSignUp()
            } else {
                self.showAttantionAlert(
                    viewController: self,
                    message: "Password and password confirmation do not match")
            }
        } else {
            self.showAttantionAlert(
                viewController: self,
                message: "You need to fill in all the fields for sign up")
        }
    }
    
    func isFilledTextFields() -> Bool {
        if (!(signUpScreenView.userNameTextField.text?.isTrimmedEmpty ?? true) &&
                !(signUpScreenView.emailTextField.text?.isTrimmedEmpty ?? true) &&
                !(signUpScreenView.genderTextField.text?.isTrimmedEmpty ?? true) &&
                !(signUpScreenView.creditCardTextField.text?.isTrimmedEmpty ?? true) &&
                !(signUpScreenView.bioTextField.text?.isTrimmedEmpty ?? true) &&
                !(signUpScreenView.passwordTextField.text?.isTrimmedEmpty ?? true) &&
                !(signUpScreenView.repeatedPasswordTextField.text?.isTrimmedEmpty ?? true)) {
            return true
        } else { return false }
    }
    
    func areEqualPasswordAndConfirmationPassword() -> Bool {
        if signUpScreenView.passwordTextField.text ==
            signUpScreenView.repeatedPasswordTextField.text {
            return true
        } else {
            return false
        }
    }
    
    func configureCancelAndReturnButton() {
        signUpScreenView.cancelAndReturnButton.addTarget(self, action: #selector(tapCancelAndReturnButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapCancelAndReturnButton(_ sender: Any?) {
        // fatalError() may be installed there specifically for sending analytics in Firebase about an application crash
        // fatalError()
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Interaction with Network
    func sendDataForSignUp() {
        let registerUser = requestFactory.makeSignUpRequestFactory()
        registerUser.signUp(userID: defaultUserID,
                            userLogin: signUpScreenView.userLoginTextField.text ?? defaultUserLogin,
                            userName: signUpScreenView.userNameTextField.text ?? defaultUserName,
                            userLastName: signUpScreenView.userLastNameTextField.text ?? defaultUserLastName,
                            password: signUpScreenView.passwordTextField.text ?? defaultUserPassword,
                            email: signUpScreenView.emailTextField.text ?? defaultUserEmail,
                            gender: signUpScreenView.genderTextField.text ?? defaultUserGender,
                            creditCard: signUpScreenView.creditCardTextField.text ?? defaultUserCreditCard,
                            bio: signUpScreenView.bioTextField.text ?? defaultUserBio) {
            response in
            switch response.result {
            case .success(let signUp):
                self.sendAnalyticsSignUpSuccess(
                    assignedUserId: signUp.assignedUserId,
                    signedUpUserLogin: signUp.signedUpUserLogin,
                    signedUpUserName: signUp.signedUpUserName,
                    signedUpUserLastName: signUp.signedUpUserLastName,
                    signedUpEmail:signUp.signedUpEmail,
                    signedUpGender:signUp.signedUpBio,
                    signedUpCreditCard: signUp.signedUpCreditCard,
                    signedUpBio: signUp.signedUpBio,
                    userMessage: signUp.userMessage)
                DispatchQueue.main.async {
                    let logInScreenViewController = LogInScreenViewController(requestFactory: self.requestFactory)
                    logInScreenViewController.modalPresentationStyle = .fullScreen
                    self.present(logInScreenViewController, animated: true, completion: nil)
                }
            case .failure(let error):
                self.sendAnalyticsFailure(
                    failureName: "sign_up_failure",
                    errorDescription: error.localizedDescription)
                Logger.viewCycle.debug("\(error.localizedDescription)")
            }
        }
    }
}

//MARK: - Keyboard configuration
extension SignUpScreenViewController {
    func keyboardAddObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        signUpScreenView.scrollView.addGestureRecognizer(tapGesture)
    }
    
    func keyboardRemoveObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let keyboardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        signUpScreenView.scrollView.contentInset = contentInsets
        signUpScreenView.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        signUpScreenView.scrollView.contentInset = UIEdgeInsets.zero
        signUpScreenView.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc func hideKeyboard() {
        signUpScreenView.scrollView.endEditing(true)
    }
}

