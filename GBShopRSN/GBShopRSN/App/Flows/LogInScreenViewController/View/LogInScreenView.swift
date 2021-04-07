//
//  LogInScreenView.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 09.03.2021.
//

import UIKit

class LogInScreenView: UIView, UIComponentsMakeable {
    // MARK: - UI components
    private(set) lazy var scrollView: UIScrollView = {
        configureScrollView(increaseInScreenHeight: -80.0)
    }()
    
    private(set) lazy var logoLogInScreenImageView: UIImageView = {
        configureSystemImageView(systemImage: UIImage(systemName: "network")!, tintColor: .rsnPurpleColor)
    }()
    
    private(set) lazy var logoLogInScreenLabel: UILabel = {
        configureLabel(text: "Let's log in",
                       textColor: .rsnPurpleColor,
                       font: .boldSystemFont(ofSize: 30.0))
    }()
    
    private(set) lazy var enterDataForLogInLabel: UILabel = {
        configureLabel(text: "Enter data for log in:",
                       textColor: .white,
                       font: .boldSystemFont(ofSize: 20.0))
    }()
    
    private(set) lazy var userNameTextField: UITextField = {
        configureTextField(placeholder: "User name",
                           font: .systemFont(ofSize: 17),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        configureTextField(placeholder: "Password",
                           font: .systemFont(ofSize: 17),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var sendDataForLogInButton: UIButton = {
        configureButton(title: "Log in",
                        backgroundColor: .rsnLightGreenColor,
                        cornerRadius: 12.0)
    }()
    
    private(set) lazy var cancelAndReturnButton: UIButton = {
        configureButton(title: "Сancel and return",
                        backgroundColor: .lightGray,
                        cornerRadius: 12.0)
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
        scrollView.addSubview(logoLogInScreenImageView)
        scrollView.addSubview(logoLogInScreenLabel)
        scrollView.addSubview(enterDataForLogInLabel)
        scrollView.addSubview(userNameTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(sendDataForLogInButton)
        scrollView.addSubview(cancelAndReturnButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            logoLogInScreenImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50.0),
            logoLogInScreenImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoLogInScreenImageView.heightAnchor.constraint(equalToConstant: 150.0),
            logoLogInScreenImageView.widthAnchor.constraint(equalToConstant: 160.0),
            
            logoLogInScreenLabel.topAnchor.constraint(equalTo: logoLogInScreenImageView.bottomAnchor, constant: 10.0),
            logoLogInScreenLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            enterDataForLogInLabel.topAnchor.constraint(equalTo: logoLogInScreenLabel.bottomAnchor, constant: 100.0),
            enterDataForLogInLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            userNameTextField.topAnchor.constraint(equalTo: enterDataForLogInLabel.bottomAnchor, constant: 10.0),
            userNameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 25.0),
            userNameTextField.widthAnchor.constraint(equalToConstant: 270.0),
            
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 10.0),
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 25.0),
            passwordTextField.widthAnchor.constraint(equalToConstant: 270.0),
            
            sendDataForLogInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20.0),
            sendDataForLogInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            sendDataForLogInButton.heightAnchor.constraint(equalToConstant: 40.0),
            sendDataForLogInButton.widthAnchor.constraint(equalToConstant: 100.0),
            
            cancelAndReturnButton.topAnchor.constraint(equalTo: sendDataForLogInButton.bottomAnchor, constant: 20.0),
            cancelAndReturnButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            cancelAndReturnButton.heightAnchor.constraint(equalToConstant: 40.0),
            cancelAndReturnButton.widthAnchor.constraint(equalToConstant: 180.0)
        ])
    }
}
