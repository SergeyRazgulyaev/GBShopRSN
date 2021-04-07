//
//  UserInfoScreenView.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 10.03.2021.
//

import UIKit

class UserInfoScreenView: UIView, UIComponentsMakeable {
    // MARK: - UI components
    private(set) lazy var scrollView: UIScrollView = {
        makeScrollView()
    }()
    
    private(set) lazy var logoUserInfoScreenImageView: UIImageView = {
        makeSystemImageView(systemImage: UIImage(systemName: "person.circle")!, tintColor: .rsnPurpleColor)
    }()
    
    private(set) lazy var logoUserInfoScreenLabel: UILabel = {
        makeLabel(text: "User info",
                       textColor: .rsnPurpleColor,
                       font: .boldSystemFont(ofSize: 30.0))
    }()
    
    private(set) lazy var changeUserInfoLabel: UILabel = {
        makeLabel(text: "Change user info if needed:",
                       textColor: .lightGray,
                       font: .boldSystemFont(ofSize: 20.0))
    }()
    
    private(set) lazy var userNameTextField: UITextField = {
        makeTextField(placeholder: "User name",
                           font: .systemFont(ofSize: 17),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var userLastNameTextField: UITextField = {
        makeTextField(placeholder: "User last name",
                           font: .systemFont(ofSize: 17),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var emailTextField: UITextField = {
        makeTextField(placeholder: "E-mail",
                           font: .systemFont(ofSize: 17),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var genderTextField: UITextField = {
        makeTextField(placeholder: "Your gender (m/w)",
                           font: .systemFont(ofSize: 17),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var creditCardTextField: UITextField = {
        makeTextField(placeholder: "Credit card number",
                           font: .systemFont(ofSize: 17),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var bioTextField: UITextField = {
        makeTextField(placeholder: "Your bio",
                           font: .systemFont(ofSize: 17),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        makeTextField(placeholder: "New password",
                           font: .systemFont(ofSize: 17),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var repeatedPasswordTextField: UITextField = {
        makeTextField(placeholder: "Repeat new password",
                           font: .systemFont(ofSize: 17),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var changeAndSaveUserInfoButton: UIButton = {
        makeButton(title: "Change and Save user info",
                        font: .boldSystemFont(ofSize: 17),
                        backgroundColor: .rsnLightGreenColor,
                        cornerRadius: 8.0)
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Methods
    func configureUI() {
        addSubview(scrollView)
        scrollView.addSubview(logoUserInfoScreenImageView)
        scrollView.addSubview(logoUserInfoScreenLabel)
        scrollView.addSubview(changeUserInfoLabel)
        scrollView.addSubview(userNameTextField)
        scrollView.addSubview(userLastNameTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(genderTextField)
        scrollView.addSubview(creditCardTextField)
        scrollView.addSubview(bioTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(repeatedPasswordTextField)
        scrollView.addSubview(changeAndSaveUserInfoButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.rightAnchor),
            
            logoUserInfoScreenImageView.topAnchor.constraint(
                equalTo: scrollView.topAnchor,
                constant: 20.0),
            logoUserInfoScreenImageView.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            logoUserInfoScreenImageView.heightAnchor.constraint(
                equalToConstant: 150.0),
            logoUserInfoScreenImageView.widthAnchor.constraint(
                equalToConstant: 160.0),
            
            logoUserInfoScreenLabel.topAnchor.constraint(
                equalTo: logoUserInfoScreenImageView.bottomAnchor,
                constant: 10.0),
            logoUserInfoScreenLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor),

            changeUserInfoLabel.topAnchor.constraint(
                equalTo: logoUserInfoScreenLabel.bottomAnchor,
                constant: 10.0),
            changeUserInfoLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor),

            userNameTextField.topAnchor.constraint(
                equalTo: changeUserInfoLabel.bottomAnchor,
                constant: 15.0),
            userNameTextField.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            userNameTextField.heightAnchor.constraint(
                equalToConstant: 25.0),
            userNameTextField.widthAnchor.constraint(
                equalToConstant: 270.0),
            
            userLastNameTextField.topAnchor.constraint(
                equalTo: userNameTextField.bottomAnchor,
                constant: 15.0),
            userLastNameTextField.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            userLastNameTextField.heightAnchor.constraint(
                equalToConstant: 25.0),
            userLastNameTextField.widthAnchor.constraint(
                equalToConstant: 270.0),
            
            
            emailTextField.topAnchor.constraint(
                equalTo: userLastNameTextField.bottomAnchor,
                constant: 10.0),
            emailTextField.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            emailTextField.heightAnchor.constraint(
                equalToConstant: 25.0),
            emailTextField.widthAnchor.constraint(
                equalToConstant: 270.0),
            
            genderTextField.topAnchor.constraint(
                equalTo: emailTextField.bottomAnchor,
                constant: 10.0),
            genderTextField.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            genderTextField.heightAnchor.constraint(
                equalToConstant: 25.0),
            genderTextField.widthAnchor.constraint(
                equalToConstant: 270.0),
            
            creditCardTextField.topAnchor.constraint(
                equalTo: genderTextField.bottomAnchor,
                constant: 10.0),
            creditCardTextField.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            creditCardTextField.heightAnchor.constraint(
                equalToConstant: 25.0),
            creditCardTextField.widthAnchor.constraint(
                equalToConstant: 270.0),
            
            bioTextField.topAnchor.constraint(
                equalTo: creditCardTextField.bottomAnchor,
                constant: 10.0),
            bioTextField.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            bioTextField.heightAnchor.constraint(
                equalToConstant: 25.0),
            bioTextField.widthAnchor.constraint(
                equalToConstant: 270.0),
            
            passwordTextField.topAnchor.constraint(
                equalTo: bioTextField.bottomAnchor, 
                constant: 10.0),
            passwordTextField.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            passwordTextField.heightAnchor.constraint(
                equalToConstant: 25.0),
            passwordTextField.widthAnchor.constraint(
                equalToConstant: 270.0),
            
            repeatedPasswordTextField.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor, 
                constant: 10.0),
            repeatedPasswordTextField.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            repeatedPasswordTextField.heightAnchor.constraint(
                equalToConstant: 25.0),
            repeatedPasswordTextField.widthAnchor.constraint(
                equalToConstant: 270.0),
            
            changeAndSaveUserInfoButton.topAnchor.constraint(
                equalTo: repeatedPasswordTextField.bottomAnchor, 
                constant: 20.0),
            changeAndSaveUserInfoButton.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            changeAndSaveUserInfoButton.heightAnchor.constraint(
                equalToConstant: 30.0),
            changeAndSaveUserInfoButton.widthAnchor.constraint(
                equalToConstant: 270.0)
        ])
    }
}
