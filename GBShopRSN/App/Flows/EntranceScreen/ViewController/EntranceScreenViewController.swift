//
//  EntranceScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 05.03.2021.
//

import UIKit
import FirebaseAnalytics

class EntranceScreenViewController: UIViewController {
    // MARK: - UI components
    private lazy var entranceScreenView: EntranceScreenView = {
        return EntranceScreenView()
    }()
    
    // MARK: - Properties
    private let requestFactory: RequestFactory
    
    // MARK: - Init
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureUIComponents()
    }
    
    override func loadView() {
        view = entranceScreenView
    }
    
    //MARK: - Configuration Methods
    func configureViewController() {
        view.backgroundColor = .rsnLightBlueColor
    }
    
    func configureUIComponents() {
        configureSignUpButton()
        configureLogInButton()
    }
    
    func configureSignUpButton() {
        entranceScreenView.signUpButton.addTarget(self, action: #selector(tapSignUpButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapSignUpButton(_ sender: Any?) {
        let signUpScreenViewController = SignUpScreenViewController(requestFactory: requestFactory)
        signUpScreenViewController.modalPresentationStyle = .fullScreen
        self.present(signUpScreenViewController, animated: true, completion: nil)
    }
    
    func configureLogInButton() {
        entranceScreenView.logInButton.addTarget(self, action: #selector(tapLogInButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapLogInButton(_ sender: Any?) {
        let logInScreenViewController = LogInScreenViewController(requestFactory: requestFactory)
        logInScreenViewController.modalPresentationStyle = .fullScreen
        self.present(logInScreenViewController, animated: true, completion: nil)
    }
}
