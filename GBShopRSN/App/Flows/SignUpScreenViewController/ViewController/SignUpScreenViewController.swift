//
//  SignUpScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 07.03.2021.
//

import UIKit

class SignUpScreenViewController: UIViewController {
    let requestFactory = RequestFactory()
    
    private var signUpScreenView: SignUpScreenView {
        return self.view as! SignUpScreenView
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
        keyboardAddObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardRemoveObserver()
    }
    
    override func loadView() {
        self.view = SignUpScreenView()
    }
    
    func configureViewController() {
        self.view.backgroundColor = UIColor(red: 100.0/255.0,
                                            green: 180.0/255.0,
                                            blue: 220.0/255.0,
                                            alpha: 1.0)
    }
    
    func configureSendDataForSignUpButton() {
        signUpScreenView.sendDataForSignUpButton.addTarget(self, action: #selector(tapSendDataForSignUpButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapSendDataForSignUpButton(_ sender: Any?) {
        if (signUpScreenView.userNameTextField.text != "" &&
                signUpScreenView.emailTextField.text != "" &&
                signUpScreenView.genderTextField.text != "" &&
                signUpScreenView.creditCardTextField.text != "" &&
                signUpScreenView.bioTextField.text != "" &&
                signUpScreenView.passwordTextField.text != "" &&
                signUpScreenView.repeatedPasswordTextField.text != "") {
            if signUpScreenView.passwordTextField.text ==
                signUpScreenView.repeatedPasswordTextField.text {
                let registerUser = requestFactory.makeSignUpRequestFactory()
                registerUser.signUp(userID: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") { response in
                    switch response.result {
                    case .success(let signUp):
                        print(signUp)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                let logInScreenViewController = LogInScreenViewController()
                logInScreenViewController.modalPresentationStyle = .fullScreen
                self.present(logInScreenViewController, animated: true, completion: nil)
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
