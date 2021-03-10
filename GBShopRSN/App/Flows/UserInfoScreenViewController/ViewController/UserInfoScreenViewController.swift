//
//  UserInfoScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 05.03.2021.
//

import UIKit

class UserInfoScreenViewController: UIViewController {
    let requestFactory = RequestFactory()
    
    private var userInfoScreenView: UserInfoScreenView {
        return self.view as! UserInfoScreenView
    }
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
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
        self.view = UserInfoScreenView()
    }
    
    func configureViewController() {
        self.view.backgroundColor = UIColor(red: 100.0/255.0,
                                            green: 180.0/255.0,
                                            blue: 220.0/255.0,
                                            alpha: 1.0)
    }
    
    func configureSaveUserInfoButton() {
        userInfoScreenView.saveUserInfoButton.addTarget(self, action: #selector(tapSaveUserInfoButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapSaveUserInfoButton(_ sender: Any?) {
        if (userInfoScreenView.userNameTextField.text != "" &&
                userInfoScreenView.emailTextField.text != "" &&
                userInfoScreenView.genderTextField.text != "" &&
                userInfoScreenView.creditCardTextField.text != "" &&
                userInfoScreenView.bioTextField.text != "" &&
                userInfoScreenView.passwordTextField.text != "" &&
                userInfoScreenView.repeatedPasswordTextField.text != "") {
            if userInfoScreenView.passwordTextField.text ==
                userInfoScreenView.repeatedPasswordTextField.text {
                let changeData = requestFactory.makeChangeUserDataRequestFactory()
                changeData.changeUserData(userID: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") { response in
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
