//
//  EntranceScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 05.03.2021.
//

import UIKit

class EntranceScreenViewController: UIViewController {
    private var entranceScreenView: EntranceScreenView {
        return self.view as! EntranceScreenView
    }
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSignUpButton()
        configureLogInButton()
    }
    
    override func loadView() {
        self.view = EntranceScreenView()
    }
    
    func configureViewController() {
        self.view.backgroundColor = UIColor(red: 100.0/255.0,
                                            green: 180.0/255.0,
                                            blue: 220.0/255.0,
                                            alpha: 1.0)
    }
    
    func configureSignUpButton() {
        entranceScreenView.signUpButton.addTarget(self, action: #selector(tapSignUpButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapSignUpButton(_ sender: Any?) {
        let signUpScreenViewController = SignUpScreenViewController()
        signUpScreenViewController.modalPresentationStyle = .fullScreen
        self.present(signUpScreenViewController, animated: true, completion: nil)
    }
    
    func configureLogInButton() {
        entranceScreenView.logInButton.addTarget(self, action: #selector(tapLogInButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapLogInButton(_ sender: Any?) {
        let logInScreenViewController = LogInScreenViewController()
        logInScreenViewController.modalPresentationStyle = .fullScreen
        self.present(logInScreenViewController, animated: true, completion: nil)
    }
}
