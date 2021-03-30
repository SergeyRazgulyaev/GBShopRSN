//
//  UserInfoScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 05.03.2021.
//

import UIKit
import FirebaseAnalytics

class UserInfoScreenViewController: UIViewController, AnalyticsSendable {
    // MARK: - UI components
    private lazy var userInfoScreenView: UserInfoScreenView = {
        return UserInfoScreenView()
    }()
    private lazy var logOutButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(tapLogOutButton))
    
    // MARK: - Properties
    private let defaultUserName = "Sergey"
    private let defaultUserLastName = "Razgulyaev"
    private let defaultEmail = "razgulyaev.sergey@gmail.com"
    private let defaultGender = "m"
    private let defaultCreditCard = "9872389-2424-234224-234"
    private let defaultBio = "This is good! I think I will switch to another language"
    private let defaultPassword = "mypassword"
    private let requestFactory: RequestFactory
    private let user: User
    
    // MARK: - Init
    init(requestFactory: RequestFactory, user: User) {
        self.requestFactory = requestFactory
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        configureSaveUserInfoButton()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureKeyboard()
    }
    
    override func loadView() {
        self.view = userInfoScreenView
    }
    
    //MARK: - Configuration Methods
    func configureViewController() {
        title = "User info"
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.rightBarButtonItem = logOutButton
    }
    
    @objc func tapLogOutButton() {
        let logOutUser = requestFactory.makeLogOutRequestFactory()
        logOutUser.logOut(userID: user.userID) { response in
            switch response.result {
            case .success(let logOut):
                self.sendAnalyticsLogOutSuccess(
                    viewController: self,
                    userID: self.user.userID)
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                print(logOut)
            case .failure(let error):
                self.sendAnalyticsFailure(
                    failureName: "log_out_failure",
                    viewController: self,
                    errorDescription: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
    
    func configureTextFields() {
        userInfoScreenView.userNameTextField.text = defaultUserName
        userInfoScreenView.userLastNameTextField.text = defaultUserLastName
        userInfoScreenView.emailTextField.text = defaultEmail
        userInfoScreenView.genderTextField.text = defaultGender
        userInfoScreenView.creditCardTextField.text = defaultCreditCard
        userInfoScreenView.bioTextField.text = defaultBio
    }
    
    func configureSaveUserInfoButton() {
        userInfoScreenView.changeAndSaveUserInfoButton.addTarget(self, action: #selector(tapSaveUserInfoButton(_:)), for: .touchUpInside)
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
                changeData.changeUserData(userID: user.userID,
                                          userName: userInfoScreenView.userNameTextField.text ?? defaultUserName,
                                          userLastName: userInfoScreenView.userLastNameTextField.text ?? defaultUserLastName,
                                          password: userInfoScreenView.passwordTextField.text ?? defaultPassword,
                                          email: userInfoScreenView.emailTextField.text ?? defaultEmail,
                                          gender: userInfoScreenView.genderTextField.text ?? defaultGender,
                                          creditCard: userInfoScreenView.creditCardTextField.text ?? defaultCreditCard,
                                          bio: userInfoScreenView.bioTextField.text ?? defaultBio) {
                    response in
                    switch response.result {
                    case .success(let changeUserData):
                        print(changeUserData)
                        self.sendAnalyticsChangeUserDataSuccess(
                            viewController: self,
                            userID: self.user.userID)
                    case .failure(let error):
                        self.sendAnalyticsFailure(
                            failureName: "change_user_data_failure",
                            viewController: self,
                            errorDescription: error.localizedDescription)
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
    func configureKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap))
        userInfoScreenView.scrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboardByTap() {
        userInfoScreenView.scrollView.endEditing(true)
    }
}
