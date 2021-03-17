//
//  EntranceScreenView.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 05.03.2021.
//

import UIKit

class EntranceScreenView: UIView {
    // MARK: - UI components
    private(set) lazy var logoEntranceScreenImageView: UIImageView = {
        let logoEntranceScreenImageView = UIImageView()
        logoEntranceScreenImageView.translatesAutoresizingMaskIntoConstraints = false
        logoEntranceScreenImageView.layer.masksToBounds = true
        logoEntranceScreenImageView.image = UIImage(systemName: "sparkles")
        logoEntranceScreenImageView.tintColor = .rsnPurpleColor
        return logoEntranceScreenImageView
    }()
    
    private(set) lazy var logoEntranceScreenLabel: UILabel = {
        let logoEntranceScreenLabel = UILabel()
        logoEntranceScreenLabel.translatesAutoresizingMaskIntoConstraints = false
        logoEntranceScreenLabel.textColor = .rsnPurpleColor
        logoEntranceScreenLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        logoEntranceScreenLabel.text = "GBShopRSN"
        return logoEntranceScreenLabel
    }()
    
    private(set) lazy var signUpOrLogOnLabel: UILabel = {
        let signUpLabel = UILabel()
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.textColor = .white
        signUpLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        signUpLabel.text = "Select sign up or log in"
        return signUpLabel
    }()
    
    private(set) lazy var signUpButton: UIButton = {
        let signUpButton = UIButton()
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.backgroundColor = .rsnPinkColor
        signUpButton.layer.cornerRadius = 12.0
        signUpButton.layer.masksToBounds = true
        return signUpButton
    }()
    
    private(set) lazy var logInButton: UIButton = {
        let logInButton = UIButton()
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.setTitle("Log in", for: .normal)
        logInButton.backgroundColor = .rsnLightGreenColor
        logInButton.layer.cornerRadius = 12.0
        logInButton.layer.masksToBounds = true
        return logInButton
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
        addSubview(logoEntranceScreenImageView)
        addSubview(logoEntranceScreenLabel)
        addSubview(signUpOrLogOnLabel)
        addSubview(signUpButton)
        addSubview(logInButton)
        
        NSLayoutConstraint.activate([
            logoEntranceScreenImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50.0),
            logoEntranceScreenImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoEntranceScreenImageView.heightAnchor.constraint(equalToConstant: 270.0),
            logoEntranceScreenImageView.widthAnchor.constraint(equalToConstant: 270.0),
            
            logoEntranceScreenLabel.topAnchor.constraint(equalTo: logoEntranceScreenImageView.bottomAnchor, constant: 10.0),
            logoEntranceScreenLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            signUpOrLogOnLabel.topAnchor.constraint(equalTo: logoEntranceScreenLabel.bottomAnchor, constant: 100.0),
            signUpOrLogOnLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: signUpOrLogOnLabel.bottomAnchor, constant: 30.0),
            signUpButton.heightAnchor.constraint(equalToConstant: 40.0),
            signUpButton.widthAnchor.constraint(equalToConstant: 100.0),
            signUpButton.leftAnchor.constraint(equalTo: centerXAnchor, constant: -115.0),
            
            logInButton.topAnchor.constraint(equalTo: signUpOrLogOnLabel.bottomAnchor, constant: 30.0),
            logInButton.heightAnchor.constraint(equalToConstant: 40.0),
            logInButton.widthAnchor.constraint(equalToConstant: 100.0),
            logInButton.leftAnchor.constraint(equalTo: centerXAnchor, constant: 15.0),

        ])
    }
}
