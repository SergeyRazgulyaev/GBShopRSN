//
//  UserInfoScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 05.03.2021.
//

import UIKit
import FirebaseAnalytics
import os.log

class UserInfoScreenViewController: UIViewController, AnalyticsSendable, Alertable {
    // MARK: - UI components
    private lazy var userInfoScreenView: UserInfoScreenView = {
        return UserInfoScreenView()
    }()
    private lazy var logOutButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(tapLogOutButton))
    
    // MARK: - Properties
    private let requestFactory: RequestFactory
    private let defaultUserName = ""
    private let defaultUserLastName = ""
    private let defaultEmail = ""
    private let defaultGender = ""
    private let defaultCreditCard = ""
    private let defaultBio = ""
    private let defaultPassword = ""
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
        configureViewController()
        configureUIComponents()
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
        title = "User info"
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.rightBarButtonItem = logOutButton
    }
    
    func configureUIComponents() {
        configureTextFields()
        configureSaveUserInfoButton()
    }
    
    func configureTextFields() {
        userInfoScreenView.logoUserInfoScreenLabel.text = user.userLogin
        userInfoScreenView.userNameTextField.text = user.userName
        userInfoScreenView.userLastNameTextField.text = user.userLastName
        userInfoScreenView.emailTextField.text = user.email
        userInfoScreenView.genderTextField.text = user.gender
        userInfoScreenView.creditCardTextField.text = user.creditCard
        userInfoScreenView.bioTextField.text = user.bio
    }
    
    func configureSaveUserInfoButton() {
        userInfoScreenView.changeAndSaveUserInfoButton.addTarget(self, action: #selector(tapSaveUserInfoButton(_:)), for: .touchUpInside)
    }
    @objc func tapSaveUserInfoButton(_ sender: Any?) {
        if isFilledTextFields() {
            if areEqualPasswordAndConfirmationPassword() {
                changeUserData()
            } else {
                self.showAttantionAlert(
                    viewController: self,
                    message: "Password and password confirmation do not match")
            }
        } else {
            self.showAttantionAlert(
                viewController: self,
                message: "You need to fill in all the fields for change user info")
        }
    }
    
    func isFilledTextFields() -> Bool {
        if (!(userInfoScreenView.userNameTextField.text?.isTrimmedEmpty ?? true) &&
                !(userInfoScreenView.emailTextField.text?.isTrimmedEmpty ?? true) &&
                !(userInfoScreenView.genderTextField.text?.isTrimmedEmpty ?? true) &&
                !(userInfoScreenView.creditCardTextField.text?.isTrimmedEmpty ?? true) &&
                !(userInfoScreenView.bioTextField.text?.isTrimmedEmpty ?? true)) {
            return true
        } else { return false }
    }
    
    func areEqualPasswordAndConfirmationPassword() -> Bool {
        if userInfoScreenView.passwordTextField.text ==
            userInfoScreenView.repeatedPasswordTextField.text {
            return true
        } else {
            return false
        }
    }
    
    @objc func tapLogOutButton() {
        logOutUser()
    }
    
    //MARK: - Interaction with Network
    func changeUserData() {
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
                self.sendAnalyticsChangeUserDataSuccess(userID: changeUserData.userID)
                DispatchQueue.main.async {
                    self.showAttantionAlert(
                        viewController: self,
                        message: "User info changed")
                }
            case .failure(let error):
                self.sendAnalyticsFailure(
                    failureName: "change_user_data_failure",
                    errorDescription: error.localizedDescription)
                Logger.viewCycle.debug("\(error.localizedDescription)")
            }
        }
    }
    
    func logOutUser() {
        let logOutUser = requestFactory.makeLogOutRequestFactory()
        logOutUser.logOut(userID: user.userID) { response in
            switch response.result {
            case .success(let logOut):
                self.sendAnalyticsLogOutSuccess(userID: logOut.loggedOutUserID)
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                self.sendAnalyticsFailure(
                    failureName: "log_out_failure",
                    errorDescription: error.localizedDescription)
                Logger.viewCycle.debug("\(error.localizedDescription)")
            }
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
