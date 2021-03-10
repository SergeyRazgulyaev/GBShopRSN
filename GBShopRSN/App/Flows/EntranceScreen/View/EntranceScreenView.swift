//
//  EntranceScreenView.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 05.03.2021.
//

import UIKit

class EntranceScreenView: UIView {
    private(set) lazy var logoEntranceScreenImageView: UIImageView = {
        let logoEntranceScreenImageView = UIImageView()
        logoEntranceScreenImageView.translatesAutoresizingMaskIntoConstraints = false
        logoEntranceScreenImageView.layer.masksToBounds = true
        logoEntranceScreenImageView.image = UIImage(systemName: "sparkles")
        logoEntranceScreenImageView.tintColor = UIColor(red: 120.0/255.0,
                                      green: 80.0/255.0,
                                      blue: 155.0/255.0,
                                      alpha: 1.0)
        return logoEntranceScreenImageView
    }()
    
    private(set) lazy var logoEntranceScreenLabel: UILabel = {
        let logoEntranceScreenLabel = UILabel()
        logoEntranceScreenLabel.translatesAutoresizingMaskIntoConstraints = false
        logoEntranceScreenLabel.textColor = UIColor(red: 120.0/255.0,
                                  green: 80.0/255.0,
                                  blue: 155.0/255.0,
                                  alpha: 1.0)
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
        signUpButton.backgroundColor = UIColor(red: 220.0/255.0,
                                               green: 100.0/255.0,
                                               blue: 180.0/255.0,
                                               alpha: 1.0)
        signUpButton.layer.cornerRadius = 12.0
        signUpButton.layer.masksToBounds = true
        return signUpButton
    }()
    
    private(set) lazy var logInButton: UIButton = {
        let logInButton = UIButton()
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.setTitle("Log in", for: .normal)
        logInButton.backgroundColor = UIColor(red: 150.0/255.0,
                                               green: 200.0/255.0,
                                               blue: 120.0/255.0,
                                               alpha: 1.0)
        logInButton.layer.cornerRadius = 12.0
        logInButton.layer.masksToBounds = true
        return logInButton
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
        self.addSubview(logoEntranceScreenImageView)
        self.addSubview(logoEntranceScreenLabel)
        self.addSubview(signUpOrLogOnLabel)
        self.addSubview(signUpButton)
        self.addSubview(logInButton)
        
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
