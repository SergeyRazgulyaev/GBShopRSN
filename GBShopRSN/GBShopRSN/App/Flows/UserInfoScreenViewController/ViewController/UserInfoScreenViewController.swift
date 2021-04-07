//
//  UserInfoScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 05.03.2021.
//

import UIKit

class UserInfoScreenViewController: UIViewController {
    // MARK: - UI components
    private lazy var userInfoScreenView: UserInfoScreenView = {
        return UserInfoScreenView()
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
        configureTextFields()
        configureSaveUserInfoButton()
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
        self.view = userInfoScreenView
    }
    
    //MARK: - Configuration Methods
    func configureViewController() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
    }
    
    func configureTextFields() {
        userInfoScreenView.userNameTextField.text = defaultUserName
        userInfoScreenView.emailTextField.text = defaultEmail
        userInfoScreenView.genderTextField.text = defaultGender
        userInfoScreenView.creditCardTextField.text = defaultCreditCard
        userInfoScreenView.bioTextField.text = defaultBio
    }
    
    func configureSaveUserInfoButton() {
        userInfoScreenView.saveUserInfoButton.addTarget(self, action: #selector(tapSaveUserInfoButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapSaveUserInfoButton(_ sender: Any?) {
        if (!(userInfoScreenView.userNameTextField.text?.isTrimmedEmpty ?? true) &&
                !(userInfoScreenView.emailTextField.text?.isTrimmedEmpty ?? true) &&
                !(userInfoScreenView.genderTextField.text?.isTrimmedEmpty ?? true) &&
                !(userInfoScreenView.creditCardTextField.text?.isTrimmedEmpty ?? true) &&
                !(userInfoScreenView.bioTextField.text?.isTrimmedEmpty ?? true)) {
            if userInfoScreenView.passwordTextField.text ==
                userInfoScreenView.repeatedPasswordTextField.text {
                let changeData = requestFactory.makeChangeUserDataRequestFactory()
                changeData.changeUserData(userID: 123,
                                          userName: userInfoScreenView.userNameTextField.text ?? defaultUserName,
                                          password: userInfoScreenView.passwordTextField.text ?? defaultPassword,
                                          email: userInfoScreenView.emailTextField.text ?? defaultEmail,
                                          gender: userInfoScreenView.genderTextField.text ?? defaultGender,
                                          creditCard: userInfoScreenView.creditCardTextField.text ?? defaultCreditCard,
                                          bio: userInfoScreenView.bioTextField.text ?? defaultBio) {
                    response in
                    switch response.result {
                    case .success(let changeUserData):
                        print(changeUserData)
                        print("User info changed")
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
}

//MARK: - Keyboard configuration
extension UserInfoScreenViewController {
    func keyboardAddObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        userInfoScreenView.scrollView.addGestureRecognizer(tapGesture)
    }
    
    func keyboardRemoveObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let keyboardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        userInfoScreenView.scrollView.contentInset = contentInsets
        userInfoScreenView.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        userInfoScreenView.scrollView.contentInset = UIEdgeInsets.zero
        userInfoScreenView.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc func hideKeyboard() {
        userInfoScreenView.scrollView.endEditing(true)
    }
}
