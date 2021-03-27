//
//  SignUpScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 07.03.2021.
//

import UIKit

class SignUpScreenViewController: UIViewController {
    // MARK: - UI components
    private lazy var signUpScreenView: SignUpScreenView = {
        return SignUpScreenView()
    }()
    
    // MARK: - Properties
    private let defaultUserName = "Somebody"
    private let defaultEmail = "some@some.ru"
    private let defaultGender = "m"
    private let defaultCreditCard = "9872389-2424-234224-234"
    private let defaultBio = "This is good! I think I will switch to another language"
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
        configureSendDataForSignUpButton()
        configureCancelAndReturnButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clearSignUpScreenTextFields()
    }
    
    override func loadView() {
        view = signUpScreenView
    }
    
    //MARK: - Configuration Methods
    func configureViewController() {
        view.backgroundColor = .rsnLightBlueColor
    }
    
    func configureSendDataForSignUpButton() {
        signUpScreenView.sendDataForSignUpButton.addTarget(self, action: #selector(tapSendDataForSignUpButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapSendDataForSignUpButton(_ sender: Any?) {
        if (!(signUpScreenView.userNameTextField.text?.isTrimmedEmpty ?? true) &&
                !(signUpScreenView.emailTextField.text?.isTrimmedEmpty ?? true) &&
                !(signUpScreenView.genderTextField.text?.isTrimmedEmpty ?? true) &&
                !(signUpScreenView.creditCardTextField.text?.isTrimmedEmpty ?? true) &&
                !(signUpScreenView.bioTextField.text?.isTrimmedEmpty ?? true) &&
                !(signUpScreenView.passwordTextField.text?.isTrimmedEmpty ?? true) &&
                !(signUpScreenView.repeatedPasswordTextField.text?.isTrimmedEmpty ?? true)) {
            if signUpScreenView.passwordTextField.text ==
                signUpScreenView.repeatedPasswordTextField.text {
                let registerUser = requestFactory.makeSignUpRequestFactory()
                registerUser.signUp(userID: 123,
                                    userName: signUpScreenView.userNameTextField.text ?? defaultUserName,
                                    password: signUpScreenView.passwordTextField.text ?? defaultPassword,
                                    email: signUpScreenView.emailTextField.text ?? defaultEmail,
                                    gender: signUpScreenView.genderTextField.text ?? defaultGender,
                                    creditCard: signUpScreenView.creditCardTextField.text ?? defaultCreditCard,
                                    bio: signUpScreenView.bioTextField.text ?? defaultBio) {
                    response in
                    switch response.result {
                    case .success(let signUp):
                        DispatchQueue.main.async {
                            let logInScreenViewController = LogInScreenViewController(requestFactory: self.requestFactory)
                            logInScreenViewController.modalPresentationStyle = .fullScreen
                            self.present(logInScreenViewController, animated: true, completion: nil)
                        }
                        print(signUp)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                print("Password and password confirmation do not match")
            }
        } else {
            print("You need to fill in all the fields for sign up")
        }
    }
    
    func configureCancelAndReturnButton() {
        signUpScreenView.cancelAndReturnButton.addTarget(self, action: #selector(tapCancelAndReturnButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapCancelAndReturnButton(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func clearSignUpScreenTextFields() {
        signUpScreenView.userNameTextField.text = ""
        signUpScreenView.emailTextField.text = ""
        signUpScreenView.genderTextField.text = ""
        signUpScreenView.creditCardTextField.text = ""
        signUpScreenView.bioTextField.text = ""
        signUpScreenView.passwordTextField.text = ""
        signUpScreenView.repeatedPasswordTextField.text = ""
    }
}

//MARK: - Keyboard configuration
extension SignUpScreenViewController {
    func configureKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap))
        signUpScreenView.scrollView.addGestureRecognizer(tapGesture)
    }
  
    @objc func hideKeyboardByTap() {
        signUpScreenView.scrollView.endEditing(true)
    }
}
