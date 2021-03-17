//
//  SignUpScreenView.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 07.03.2021.
//

import UIKit

class SignUpScreenView: UIView {
    // MARK: - UI components
    private(set) lazy var scrollView: UIScrollView = {
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 70.0)
        return scrollView
    }()
    
    private(set) lazy var logoSignUpScreenImageView: UIImageView = {
        let logoSignUpScreenImageView = UIImageView()
        logoSignUpScreenImageView.translatesAutoresizingMaskIntoConstraints = false
        logoSignUpScreenImageView.layer.masksToBounds = true
        logoSignUpScreenImageView.image = UIImage(systemName: "figure.wave")
        logoSignUpScreenImageView.tintColor = .rsnPurpleColor
        return logoSignUpScreenImageView
    }()
    
    private(set) lazy var logoSignUpScreenLabel: UILabel = {
        let logoSignUpScreenLabel = UILabel()
        logoSignUpScreenLabel.translatesAutoresizingMaskIntoConstraints = false
        logoSignUpScreenLabel.textColor = .rsnPurpleColor
        logoSignUpScreenLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        logoSignUpScreenLabel.text = "Let's sign up"
        return logoSignUpScreenLabel
    }()
    
    private(set) lazy var enterDataForSignUpLabel: UILabel = {
        let enterDataForSignUpLabel = UILabel()
        enterDataForSignUpLabel.translatesAutoresizingMaskIntoConstraints = false
        enterDataForSignUpLabel.textColor = .white
        enterDataForSignUpLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        enterDataForSignUpLabel.text = "Enter data for sign up:"
        return enterDataForSignUpLabel
    }()
    
    private(set) lazy var userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        userNameTextField.placeholder = "User name"
        userNameTextField.font = UIFont.systemFont(ofSize: 17)
        return userNameTextField
    }()
    
    private(set) lazy var emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.borderStyle = UITextField.BorderStyle.roundedRect
        emailTextField.placeholder = "E-mail"
        emailTextField.font = UIFont.systemFont(ofSize: 17)
        return emailTextField
    }()
    
    private(set) lazy var genderTextField: UITextField = {
        let genderTextField = UITextField()
        genderTextField.translatesAutoresizingMaskIntoConstraints = false
        genderTextField.borderStyle = UITextField.BorderStyle.roundedRect
        genderTextField.placeholder = "Your gender (m/w)"
        genderTextField.font = UIFont.systemFont(ofSize: 17)
        return genderTextField
    }()
    
    private(set) lazy var creditCardTextField: UITextField = {
        let creditCardTextField = UITextField()
        creditCardTextField.translatesAutoresizingMaskIntoConstraints = false
        creditCardTextField.borderStyle = UITextField.BorderStyle.roundedRect
        creditCardTextField.placeholder = "Credit card number"
        creditCardTextField.font = UIFont.systemFont(ofSize: 17)
        return creditCardTextField
    }()
    
    private(set) lazy var bioTextField: UITextField = {
        let bioTextField = UITextField()
        bioTextField.translatesAutoresizingMaskIntoConstraints = false
        bioTextField.borderStyle = UITextField.BorderStyle.roundedRect
        bioTextField.placeholder = "Your bio"
        bioTextField.font = UIFont.systemFont(ofSize: 17)
        return bioTextField
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.placeholder = "Сreate and enter a password"
        passwordTextField.font = UIFont.systemFont(ofSize: 17)
        return passwordTextField
    }()
    
    private(set) lazy var repeatedPasswordTextField: UITextField = {
        let repeatedPasswordTextField = UITextField()
        repeatedPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        repeatedPasswordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        repeatedPasswordTextField.placeholder = "Repeat password"
        repeatedPasswordTextField.font = UIFont.systemFont(ofSize: 17)
        return repeatedPasswordTextField
    }()
    
    private(set) lazy var sendDataForSignUpButton: UIButton = {
        let sendDataForSignUpButton = UIButton()
        sendDataForSignUpButton.translatesAutoresizingMaskIntoConstraints = false
        sendDataForSignUpButton.setTitle("Sign up", for: .normal)
        sendDataForSignUpButton.backgroundColor = .rsnPinkColor
        sendDataForSignUpButton.layer.cornerRadius = 12.0
        sendDataForSignUpButton.layer.masksToBounds = true
        return sendDataForSignUpButton
    }()
    
    private(set) lazy var cancelAndReturnButton: UIButton = {
        let cancelAndReturnButton = UIButton()
        cancelAndReturnButton.translatesAutoresizingMaskIntoConstraints = false
        cancelAndReturnButton.setTitle("Сancel and return", for: .normal)
        cancelAndReturnButton.backgroundColor = .lightGray
        cancelAndReturnButton.layer.cornerRadius = 12.0
        cancelAndReturnButton.layer.masksToBounds = true
        return cancelAndReturnButton
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
        scrollView.addSubview(enterDataForSignUpLabel)
        scrollView.addSubview(userNameTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(genderTextField)
        scrollView.addSubview(creditCardTextField)
        scrollView.addSubview(bioTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(repeatedPasswordTextField)
        scrollView.addSubview(sendDataForSignUpButton)
        scrollView.addSubview(cancelAndReturnButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            logoSignUpScreenImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50.0),
            logoSignUpScreenImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoSignUpScreenImageView.heightAnchor.constraint(equalToConstant: 150.0),
            logoSignUpScreenImageView.widthAnchor.constraint(equalToConstant: 100.0),
            
            logoSignUpScreenLabel.topAnchor.constraint(equalTo: logoSignUpScreenImageView.bottomAnchor, constant: 10.0),
            logoSignUpScreenLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            enterDataForSignUpLabel.topAnchor.constraint(equalTo: logoSignUpScreenLabel.bottomAnchor, constant: 10.0),
            enterDataForSignUpLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            userNameTextField.topAnchor.constraint(equalTo: enterDataForSignUpLabel.bottomAnchor, constant: 10.0),
            userNameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 25.0),
            userNameTextField.widthAnchor.constraint(equalToConstant: 270.0),
            
            emailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 10.0),
            emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 25.0),
            emailTextField.widthAnchor.constraint(equalToConstant: 270.0),
            
            genderTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10.0),
            genderTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            genderTextField.heightAnchor.constraint(equalToConstant: 25.0),
            genderTextField.widthAnchor.constraint(equalToConstant: 270.0),
            
            creditCardTextField.topAnchor.constraint(equalTo: genderTextField.bottomAnchor, constant: 10.0),
            creditCardTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            creditCardTextField.heightAnchor.constraint(equalToConstant: 25.0),
            creditCardTextField.widthAnchor.constraint(equalToConstant: 270.0),
            
            bioTextField.topAnchor.constraint(equalTo: creditCardTextField.bottomAnchor, constant: 10.0),
            bioTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            bioTextField.heightAnchor.constraint(equalToConstant: 25.0),
            bioTextField.widthAnchor.constraint(equalToConstant: 270.0),
            
            passwordTextField.topAnchor.constraint(equalTo: bioTextField.bottomAnchor, constant: 10.0),
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 25.0),
            passwordTextField.widthAnchor.constraint(equalToConstant: 270.0),
            
            repeatedPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10.0),
            repeatedPasswordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            repeatedPasswordTextField.heightAnchor.constraint(equalToConstant: 25.0),
            repeatedPasswordTextField.widthAnchor.constraint(equalToConstant: 270.0),
            
            sendDataForSignUpButton.topAnchor.constraint(equalTo: repeatedPasswordTextField.bottomAnchor, constant: 20.0),
            sendDataForSignUpButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            sendDataForSignUpButton.heightAnchor.constraint(equalToConstant: 40.0),
            sendDataForSignUpButton.widthAnchor.constraint(equalToConstant: 100.0),
            
            cancelAndReturnButton.topAnchor.constraint(equalTo: sendDataForSignUpButton.bottomAnchor, constant: 20.0),
            cancelAndReturnButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            cancelAndReturnButton.heightAnchor.constraint(equalToConstant: 40.0),
            cancelAndReturnButton.widthAnchor.constraint(equalToConstant: 180.0)
        ])
    }
}
