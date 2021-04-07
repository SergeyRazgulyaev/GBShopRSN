//
//  EntranceScreenView.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 05.03.2021.
//

import UIKit

class EntranceScreenView: UIView, UIComponentsMakeable {
    // MARK: - UI components
    private(set) lazy var logoEntranceScreenImageView: UIImageView = {
        makeSystemImageView(systemImage: UIImage(systemName: "sparkles")!,
                                 tintColor: .rsnPurpleColor)
    }()
    
    private(set) lazy var logoEntranceScreenLabel: UILabel = {
        makeLabel(text: "GBShopRSN",
                       textColor: .rsnPurpleColor,
                       font: .boldSystemFont(ofSize: 30.0))
    }()
    
    private(set) lazy var signUpOrLogOnLabel: UILabel = {
        makeLabel(text: "Select sign up or log in",
                       textColor: .white,
                       font: .boldSystemFont(ofSize: 20.0))
    }()
    
    private(set) lazy var signUpButton: UIButton = {
        makeButton(title: "Sign up",
                        font: .boldSystemFont(ofSize: 17),
                        backgroundColor: .rsnPinkColor,
                        cornerRadius: 8.0)
    }()
    
    private(set) lazy var logInButton: UIButton = {
        makeButton(title: "Log in",
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
        logInButton.accessibilityIdentifier = "showLogInScreenButton"
        
        addSubview(logoEntranceScreenImageView)
        addSubview(logoEntranceScreenLabel)
        addSubview(signUpOrLogOnLabel)
        addSubview(signUpButton)
        addSubview(logInButton)
        
        NSLayoutConstraint.activate([
            logoEntranceScreenImageView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 50.0),
            logoEntranceScreenImageView.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            logoEntranceScreenImageView.heightAnchor.constraint(
                equalToConstant: 270.0),
            logoEntranceScreenImageView.widthAnchor.constraint(
                equalToConstant: 270.0),
            
            logoEntranceScreenLabel.topAnchor.constraint(
                equalTo: logoEntranceScreenImageView.bottomAnchor,
                constant: 10.0),
            logoEntranceScreenLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            
            signUpOrLogOnLabel.topAnchor.constraint(
                equalTo: logoEntranceScreenLabel.bottomAnchor,
                constant: 100.0),
            signUpOrLogOnLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            
            signUpButton.topAnchor.constraint(
                equalTo: signUpOrLogOnLabel.bottomAnchor,
                constant: 30.0),
            signUpButton.heightAnchor.constraint(
                equalToConstant: 30.0),
            signUpButton.widthAnchor.constraint(
                equalToConstant: 100.0),
            signUpButton.leftAnchor.constraint(
                equalTo: centerXAnchor, constant: -115.0),
            
            logInButton.topAnchor.constraint(
                equalTo: signUpOrLogOnLabel.bottomAnchor,
                constant: 30.0),
            logInButton.heightAnchor.constraint(
                equalToConstant: 30.0),
            logInButton.widthAnchor.constraint(
                equalToConstant: 100.0),
            logInButton.leftAnchor.constraint(
                equalTo: centerXAnchor,
                constant: 15.0),

        ])
    }
}
