//
//  ProductListScreenHeaderView.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 16.03.2021.
//

import UIKit

class ProductListScreenHeaderView: UIView, UIComponentsMakeable {
    // MARK: - UI components
    private(set) lazy var selectProductsCategoryImageView: UIImageView = {
        makeSystemImageView(systemImage: UIImage(systemName: "cube.box.fill")!, tintColor: .rsnPurpleColor)
    }()
    
    private(set) lazy var selectProductsCategoryTextField: UITextField = {
        makeTextField(placeholder: "Select products category",
                           font: .systemFont(ofSize: 17),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var selectProductsCategoryButton: UIButton = {
        makeButton(title: "Show",
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
        accessibilityIdentifier = "productListScreenView"
        backgroundColor = .white
        addSubview(selectProductsCategoryImageView)
        addSubview(selectProductsCategoryTextField)
        addSubview(selectProductsCategoryButton)
        
        NSLayoutConstraint.activate([
            selectProductsCategoryImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15.0),
            selectProductsCategoryImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10.0),
            selectProductsCategoryImageView.heightAnchor.constraint(equalToConstant: 30.0),
            selectProductsCategoryImageView.widthAnchor.constraint(equalToConstant: 30.0),
            
            selectProductsCategoryTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15.0),
            selectProductsCategoryTextField.leftAnchor.constraint(equalTo: selectProductsCategoryImageView.rightAnchor, constant: 10.0),
            selectProductsCategoryTextField.rightAnchor.constraint(equalTo:safeAreaLayoutGuide.rightAnchor, constant: -90.0),
            selectProductsCategoryTextField.heightAnchor.constraint(equalToConstant: 30.0),
            
            selectProductsCategoryButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15.0),
            selectProductsCategoryButton.leftAnchor.constraint(equalTo: selectProductsCategoryTextField.rightAnchor, constant: 15.0),
            selectProductsCategoryButton.heightAnchor.constraint(equalToConstant: 30.0),
            selectProductsCategoryButton.widthAnchor.constraint(equalToConstant: 60.0)
        ])
    }
}
