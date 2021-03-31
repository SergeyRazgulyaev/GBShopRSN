//
//  LogInScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 07.03.2021.
//

import UIKit
import FirebaseAnalytics
import os.log

class LogInScreenViewController: UIViewController, AnalyticsSendable {
    // MARK: - UI components
    private lazy var logInScreenView: LogInScreenView = {
        return LogInScreenView()
    }()
    
    // MARK: - Properties
    private let defaultUserLogInName = "SergeyRazgulyaev"
    private let defaultPassword = "mypassword"
    private let requestFactory: RequestFactory
    
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
        configureSendDataForLogInButton()
        configureCancelAndReturnButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearLogInScreenTextFields()
        configureKeyboard()
    }
    
    override func loadView() {
        view = logInScreenView
    }
    
    //MARK: - Configuration Methods
    func configureViewController() {
        view.backgroundColor = .rsnLightBlueColor
    }
    
    func configureSendDataForLogInButton() {
        logInScreenView.sendDataForLogInButton.addTarget(self, action: #selector(tapSendDataForLogInButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapSendDataForLogInButton(_ sender: Any?) {
        if (!(logInScreenView.userLoginTextField.text?.isTrimmedEmpty ?? true) &&
                !(logInScreenView.passwordTextField.text?.isTrimmedEmpty ?? true)) {
            let logInUser = requestFactory.makeLogInRequestFactory()
            logInUser.logIn(userLogin: logInScreenView.userLoginTextField.text ?? defaultUserLogInName,
                            password: logInScreenView.passwordTextField.text ?? defaultPassword) {
                response in
                switch response.result {
                case .success(let login):
                    self.sendAnalyticsLogInSuccess(
                        userID: login.user.userID,
                        userName: login.user.userName,
                        userLastname: login.user.userLastName)
                    DispatchQueue.main.async {
                        if login.result == 1 {
                            let tabBarController = TabBarController(requestFactory: self.requestFactory, user: login.user)
                            tabBarController.modalPresentationStyle = .fullScreen
                            self.present(tabBarController, animated: true, completion: nil)
                        } else {
                            self.showAlert(title: "Attention",
                                           message: "Invalid login or password")
                        }
                    }
                case .failure(let error):
                    self.sendAnalyticsFailure(
                        failureName: "log_in_failure",
                        errorDescription: error.localizedDescription)
                    Logger.viewCycle.debug("\(error.localizedDescription)")
                }
            }
        } else {
            self.showAlert(title: "Attention",
                           message: "You need to fill in all the fields for log in")
        }
    }
    
    func configureCancelAndReturnButton() {
        logInScreenView.cancelAndReturnButton.addTarget(self, action: #selector(tapCancelAndReturnButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapCancelAndReturnButton(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func clearLogInScreenTextFields() {
        logInScreenView.userLoginTextField.text = ""
        logInScreenView.passwordTextField.text = ""
    }
}

//MARK: - Keyboard configuration
extension LogInScreenViewController {
    func configureKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap))
        logInScreenView.scrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboardByTap() {
        logInScreenView.scrollView.endEditing(true)
    }
}

//MARK: - Alert
extension LogInScreenViewController {
    private func showAlert(title: String? = nil,
                           message: String? = nil,
                           handler: ((UIAlertAction) -> ())? = nil,
                           completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: completion)
    }
}
