//
//  UserInfoScreenView.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 10.03.2021.
//

import UIKit

class UserInfoScreenView: UIView {
    private(set) lazy var scrollView: UIScrollView = {
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 70.0)
        return scrollView
    }()
    
    private(set) lazy var logoUserInfoScreenImageView: UIImageView = {
        let logoUserInfoScreenImageView = UIImageView()
        logoUserInfoScreenImageView.translatesAutoresizingMaskIntoConstraints = false
        logoUserInfoScreenImageView.layer.masksToBounds = true
        logoUserInfoScreenImageView.image = UIImage(systemName: "person.circle")
        logoUserInfoScreenImageView.tintColor = UIColor(red: 120.0/255.0,
                                                green: 80.0/255.0,
                                                blue: 155.0/255.0,
                                                alpha: 1.0)
        return logoUserInfoScreenImageView
    }()
    
    private(set) lazy var logoUserInfoScreenLabel: UILabel = {
        let logoUserInfoScreenLabel = UILabel()
        logoUserInfoScreenLabel.translatesAutoresizingMaskIntoConstraints = false
        logoUserInfoScreenLabel.textColor = UIColor(red: 120.0/255.0,
                                            green: 80.0/255.0,
                                            blue: 155.0/255.0,
                                            alpha: 1.0)
        logoUserInfoScreenLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        logoUserInfoScreenLabel.text = "User info"
        return logoUserInfoScreenLabel
    }()
    
    private(set) lazy var changeUserInfoLabel: UILabel = {
        let changeUserInfoLabel = UILabel()
        changeUserInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        changeUserInfoLabel.textColor = .white
        changeUserInfoLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        changeUserInfoLabel.text = "Change user info if needed:"
        return changeUserInfoLabel
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
        passwordTextField.placeholder = "New password"
        passwordTextField.font = UIFont.systemFont(ofSize: 17)
        return passwordTextField
    }()
    
    private(set) lazy var repeatedPasswordTextField: UITextField = {
        let repeatedPasswordTextField = UITextField()
        repeatedPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        repeatedPasswordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        repeatedPasswordTextField.placeholder = "Repeat new password"
        repeatedPasswordTextField.font = UIFont.systemFont(ofSize: 17)
        return repeatedPasswordTextField
    }()
    
    private(set) lazy var saveUserInfoButton: UIButton = {
        let saveUserInfoButton = UIButton()
        saveUserInfoButton.translatesAutoresizingMaskIntoConstraints = false
        saveUserInfoButton.setTitle("Save user info", for: .normal)
        saveUserInfoButton.backgroundColor = UIColor(red: 220.0/255.0,
                                               green: 100.0/255.0,
                                               blue: 180.0/255.0,
                                               alpha: 1.0)
        saveUserInfoButton.layer.cornerRadius = 12.0
        saveUserInfoButton.layer.masksToBounds = true
        return saveUserInfoButton
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.addSubview(scrollView)
        scrollView.addSubview(logoUserInfoScreenImageView)
        scrollView.addSubview(logoUserInfoScreenLabel)
        scrollView.addSubview(changeUserInfoLabel)
        scrollView.addSubview(userNameTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(genderTextField)
        scrollView.addSubview(creditCardTextField)
        scrollView.addSubview(bioTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(repeatedPasswordTextField)
        scrollView.addSubview(saveUserInfoButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            logoUserInfoScreenImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20.0),
            logoUserInfoScreenImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoUserInfoScreenImageView.heightAnchor.constraint(equalToConstant: 150.0),
            logoUserInfoScreenImageView.widthAnchor.constraint(equalToConstant: 160.0),
            
            logoUserInfoScreenLabel.topAnchor.constraint(equalTo: logoUserInfoScreenImageView.bottomAnchor, constant: 10.0),
            logoUserInfoScreenLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            changeUserInfoLabel.topAnchor.constraint(equalTo: logoUserInfoScreenLabel.bottomAnchor, constant: 10.0),
            changeUserInfoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            userNameTextField.topAnchor.constraint(equalTo: changeUserInfoLabel.bottomAnchor, constant: 10.0),
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
            
            saveUserInfoButton.topAnchor.constraint(equalTo: repeatedPasswordTextField.bottomAnchor, constant: 20.0),
            saveUserInfoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveUserInfoButton.heightAnchor.constraint(equalToConstant: 40.0),
            saveUserInfoButton.widthAnchor.constraint(equalToConstant: 150.0)
        ])
    }
}
