//
//  LogInScreenView.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 09.03.2021.
//

import UIKit

class LogInScreenView: UIView {
    private(set) lazy var scrollView: UIScrollView = {
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight - 170)
        return scrollView
    }()
    
    private(set) lazy var logoLogInScreenImageView: UIImageView = {
        let logoLogInScreenImageView = UIImageView()
        logoLogInScreenImageView.translatesAutoresizingMaskIntoConstraints = false
        logoLogInScreenImageView.layer.masksToBounds = true
        logoLogInScreenImageView.image = UIImage(systemName: "network")
        logoLogInScreenImageView.tintColor = .rsnPurpleColor
        return logoLogInScreenImageView
    }()
    
    private(set) lazy var logoLogInScreenLabel: UILabel = {
        let logoLogInScreenLabel = UILabel()
        logoLogInScreenLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLogInScreenLabel.textColor = .rsnPurpleColor
        logoLogInScreenLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        logoLogInScreenLabel.text = "Let's log in"
        return logoLogInScreenLabel
    }()
    
    private(set) lazy var enterDataForLogInLabel: UILabel = {
        let enterDataForLogInLabel = UILabel()
        enterDataForLogInLabel.translatesAutoresizingMaskIntoConstraints = false
        enterDataForLogInLabel.textColor = .white
        enterDataForLogInLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        enterDataForLogInLabel.text = "Enter data for log in:"
        return enterDataForLogInLabel
    }()
    
    private(set) lazy var userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        userNameTextField.placeholder = "User name"
        userNameTextField.font = UIFont.systemFont(ofSize: 17)
        return userNameTextField
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 17)
        return passwordTextField
    }()
    
    private(set) lazy var sendDataForLogInButton: UIButton = {
        let sendDataForLogInButton = UIButton()
        sendDataForLogInButton.translatesAutoresizingMaskIntoConstraints = false
        sendDataForLogInButton.setTitle("Log in", for: .normal)
        sendDataForLogInButton.backgroundColor = .rsnLightGreenColor
        sendDataForLogInButton.layer.cornerRadius = 12.0
        sendDataForLogInButton.layer.masksToBounds = true
        return sendDataForLogInButton
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
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
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
