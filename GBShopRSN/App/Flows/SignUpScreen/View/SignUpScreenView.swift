//
//  SignUpScreenView.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 07.03.2021.
//

import UIKit

class SignUpScreenView: UIView, UIComponentsMakeable {
    // MARK: - UI components
    private(set) lazy var scrollView: UIScrollView = {
        makeScrollView()
    }()
    
    private(set) lazy var logoSignUpScreenImageView: UIImageView = {
        makeSystemImageView(systemImage: UIImage(systemName: "figure.wave")!,
                                 tintColor: .rsnPurpleColor)
    }()
    
    private(set) lazy var logoSignUpScreenLabel: UILabel = {
        makeLabel(text: "Let's sign up",
                       textColor: .rsnPurpleColor,
                       font: .boldSystemFont(ofSize: 30.0))
    }()
    
    private(set) lazy var userLoginTextField: UITextField = {
        makeTextField(placeholder: "User login",
                           font: .systemFont(ofSize: 17),
                           borderStyle: .roundedRect)
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
        makeTextField(placeholder: "Сreate and enter a password",
                           font: .systemFont(ofSize: 17),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var repeatedPasswordTextField: UITextField = {
        makeTextField(placeholder: "Repeat password",
                           font: .systemFont(ofSize: 17),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var sendDataForSignUpButton: UIButton = {
        makeButton(title: "Sign up",
                        font: .boldSystemFont(ofSize: 17),
                        backgroundColor: .rsnPinkColor,
                        cornerRadius: 8.0)
    }()
    
    private(set) lazy var cancelAndReturnButton: UIButton = {
        makeButton(title: "Сancel and return",
                        font: .boldSystemFont(ofSize: 17),
                        backgroundColor: .lightGray,
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
        scrollView.addSubview(logoSignUpScreenImageView)
        scrollView.addSubview(logoSignUpScreenLabel)
        scrollView.addSubview(userLoginTextField)
        scrollView.addSubview(userNameTextField)
        scrollView.addSubview(userLastNameTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(genderTextField)
        scrollView.addSubview(creditCardTextField)
        scrollView.addSubview(bioTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(repeatedPasswordTextField)
        scrollView.addSubview(sendDataForSignUpButton)
        scrollView.addSubview(cancelAndReturnButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.rightAnchor),
            
            logoSignUpScreenImageView.topAnchor.constraint(
                equalTo: scrollView.topAnchor,
                constant: 50.0),
            logoSignUpScreenImageView.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            logoSignUpScreenImageView.heightAnchor.constraint(
                equalToConstant: 150.0),
            logoSignUpScreenImageView.widthAnchor.constraint(
                equalToConstant: 100.0),
            
            logoSignUpScreenLabel.topAnchor.constraint(
                equalTo: logoSignUpScreenImageView.bottomAnchor,
                constant: 10.0),
            logoSignUpScreenLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor),

            userLoginTextField.topAnchor.constraint(
                equalTo: logoSignUpScreenLabel.bottomAnchor,
                constant: 10.0),
            userLoginTextField.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            userLoginTextField.heightAnchor.constraint(
                equalToConstant: 25.0),
            userLoginTextField.widthAnchor.constraint(
                equalToConstant: 270.0),
            
            userNameTextField.topAnchor.constraint(
                equalTo: userLoginTextField.bottomAnchor,
                constant: 10.0),
            userNameTextField.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            userNameTextField.heightAnchor.constraint(
                equalToConstant: 25.0),
            userNameTextField.widthAnchor.constraint(
                equalToConstant: 270.0),
            
            userLastNameTextField.topAnchor.constraint(
                equalTo: userNameTextField.bottomAnchor,
                constant: 10.0),
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
            
            sendDataForSignUpButton.topAnchor.constraint(
                equalTo: repeatedPasswordTextField.bottomAnchor,
                constant: 20.0),
            sendDataForSignUpButton.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            sendDataForSignUpButton.heightAnchor.constraint(
                equalToConstant: 30.0),
            sendDataForSignUpButton.widthAnchor.constraint(
                equalToConstant: 100.0),
            
            cancelAndReturnButton.topAnchor.constraint(
                equalTo: sendDataForSignUpButton.bottomAnchor,
                constant: 20.0),
            cancelAndReturnButton.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            cancelAndReturnButton.heightAnchor.constraint(
                equalToConstant: 30.0),
            cancelAndReturnButton.widthAnchor.constraint(
                equalToConstant: 180.0)
        ])
    }
}
