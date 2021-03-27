//
//  LogInScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 07.03.2021.
//

import UIKit

class LogInScreenViewController: UIViewController {
    // MARK: - UI components
    private lazy var logInScreenView: LogInScreenView = {
        return LogInScreenView()
    }()
    
    // MARK: - Properties
    private let defaultUserName = "Somebody"
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
    func configureKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap))
        logInScreenView.scrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboardByTap() {
        logInScreenView.scrollView.endEditing(true)
    }
}
