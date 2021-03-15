//
//  LogInScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 07.03.2021.
//

import UIKit

class LogInScreenViewController: UIViewController {
    private lazy var logInScreenView: LogInScreenView = {
        return LogInScreenView()
    }()
    let defaultUserName = "Somebody"
    let defaultPassword = "mypassword"
    
    let requestFactory: RequestFactory
    
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
        keyboardAddObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardRemoveObserver()
    }
    
    override func loadView() {
        self.view = logInScreenView
    }
    
    func configureViewController() {
        self.view.backgroundColor = .rsnLightBlueColor
    }
    
    func configureSendDataForLogInButton() {
        logInScreenView.sendDataForLogInButton.addTarget(self, action: #selector(tapSendDataForLogInButton(_:)), for: .touchUpInside)
    }
    //
    @objc func tapSendDataForLogInButton(_ sender: Any?) {
        if (!(logInScreenView.userNameTextField.text?.isTrimmedEmpty ?? true) &&
                !(logInScreenView.passwordTextField.text?.isTrimmedEmpty ?? true)) {
            let logInUser = requestFactory.makeLogInRequestFactory()
            logInUser.logIn(userName: logInScreenView.userNameTextField.text ?? defaultUserName,
                            password: logInScreenView.passwordTextField.text ?? defaultPassword) {
                response in
                switch response.result {
                case .success(let login):
                    DispatchQueue.main.async {
                        let tabBarController = TabBarController(requestFactory: self.requestFactory)
                        tabBarController.modalPresentationStyle = .fullScreen
                        self.present(tabBarController, animated: true, completion: nil)
                    }
                    print(login)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            print("You need to fill in all the fields for sign up")
        }
    }
    
    func configureCancelAndReturnButton() {
        logInScreenView.cancelAndReturnButton.addTarget(self, action: #selector(tapCancelAndReturnButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapCancelAndReturnButton(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Keyboard configuration
extension LogInScreenViewController {
    func keyboardAddObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        logInScreenView.scrollView.addGestureRecognizer(tapGesture)
    }
    
    func keyboardRemoveObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let keyboardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        logInScreenView.scrollView.contentInset = contentInsets
        logInScreenView.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        logInScreenView.scrollView.contentInset = UIEdgeInsets.zero
        logInScreenView.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc func hideKeyboard() {
        logInScreenView.scrollView.endEditing(true)
    }
}
