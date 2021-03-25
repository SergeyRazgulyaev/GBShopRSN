//
//  ProductScreenHeaderView.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 22.03.2021.
//

import UIKit

class ProductScreenHeaderView: UIView, UIComponentsMakeable {
    // MARK: - UI components
    private(set) lazy var productImageView: UIImageView = {
        configureSystemImageView(systemImage: UIImage(systemName: "barcode")!, tintColor: .rsnPurpleColor)
    }()
    
    private(set) lazy var addOrDeleteBasketButton: UIButton = {
        configureButton(title: "Add to basket",
                        font: .boldSystemFont(ofSize: 12),
                        backgroundColor: .lightGray,
                        cornerRadius: 8.0)
    }()
    
    private(set) lazy var increaseProductForBasketCounterButton: UIButton = {
        configureButton(title: "Add to basket",
                        font: .boldSystemFont(ofSize: 14),
                        backgroundColor: .white,
                        cornerRadius: 0.0)
    }()
    
    private(set) lazy var decreaseProductForBasketCounterButton: UIButton = {
        configureButton(title: "Add to basket",
                        font: .boldSystemFont(ofSize: 14),
                        backgroundColor: .white,
                        cornerRadius: 0.0)
    }()
    
    private(set) lazy var productForBasketCounterTextField: UITextField = {
        configureTextField(placeholder: "",
                           font: .systemFont(ofSize: 14),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var productIDLabel: UILabel = {
        configureLabel(text: "Product ID: ",
                       textColor: .black,
                       font: .boldSystemFont(ofSize: 17.0))
    }()
    
    private(set) lazy var productNameLabel: UILabel = {
        configureLabel(text: "Name: ",
                       textColor: .black,
                       font: .boldSystemFont(ofSize: 17.0))
    }()
    
    private(set) lazy var productPriceLabel: UILabel = {
        configureLabel(text: "Price: ",
                       textColor: .black,
                       font: .systemFont(ofSize: 17.0))
    }()
    
    private(set) lazy var productQuantityInBasketLabel: UILabel = {
        configureLabel(text: "Quantity in basket: ",
                       textColor: .black,
                       font: .systemFont(ofSize: 17.0))
    }()
    
    private(set) lazy var productDescriptionLabel: UILabel = {
        configureLabel(text: "Description: ",
                       textColor: .black,
                       font: .systemFont(ofSize: 17.0))
    }()
    
    private(set) lazy var reviewsTitleLabel: UILabel = {
        configureLabel(text: "No reviews",
                       textColor: .rsnPurpleColor,
                       font: .boldSystemFont(ofSize: 30.0))
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
        decreaseProductForBasketCounterButton.setImage(UIImage(systemName: "minus.square"), for: .normal)
        decreaseProductForBasketCounterButton.tintColor = .rsnPurpleColor
        
        increaseProductForBasketCounterButton.setImage(UIImage(systemName: "plus.square"), for: .normal)
        increaseProductForBasketCounterButton.tintColor = .rsnPurpleColor
        
        productForBasketCounterTextField.textAlignment = .center
        productForBasketCounterTextField.keyboardType = .numberPad
        
        productDescriptionLabel.numberOfLines = 0
        
        reviewsTitleLabel.isHidden = true
        
        backgroundColor = .white
        addSubview(productImageView)
        addSubview(addOrDeleteBasketButton)
        addSubview(decreaseProductForBasketCounterButton)
        addSubview(increaseProductForBasketCounterButton)
        addSubview(productForBasketCounterTextField)
        addSubview(productIDLabel)
        addSubview(productNameLabel)
        addSubview(productPriceLabel)
        addSubview(productQuantityInBasketLabel)
        addSubview(productDescriptionLabel)
        addSubview(reviewsTitleLabel)

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            productImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8.0),
            productImageView.heightAnchor.constraint(equalToConstant: 38.0),
            productImageView.widthAnchor.constraint(equalToConstant: 150.0),
            
            addOrDeleteBasketButton.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 3.0),
            addOrDeleteBasketButton.heightAnchor.constraint(equalToConstant: 30.0),
            addOrDeleteBasketButton.widthAnchor.constraint(equalToConstant: 121.0),
            addOrDeleteBasketButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 23.0),
            
            decreaseProductForBasketCounterButton.topAnchor.constraint(equalTo: addOrDeleteBasketButton.bottomAnchor, constant: 8.0),
            decreaseProductForBasketCounterButton.rightAnchor.constraint(equalTo: productForBasketCounterTextField.leftAnchor, constant: -5.0),
            decreaseProductForBasketCounterButton.heightAnchor.constraint(equalToConstant: 20.0),
            decreaseProductForBasketCounterButton.widthAnchor.constraint(equalToConstant: 20.0),
            
            productForBasketCounterTextField.topAnchor.constraint(equalTo: addOrDeleteBasketButton.bottomAnchor, constant: 8.0),
            productForBasketCounterTextField.heightAnchor.constraint(equalToConstant: 20.0),
            productForBasketCounterTextField.widthAnchor.constraint(equalToConstant: 70.0),
            productForBasketCounterTextField.centerXAnchor.constraint(equalTo: addOrDeleteBasketButton.centerXAnchor),

            increaseProductForBasketCounterButton.topAnchor.constraint(equalTo: addOrDeleteBasketButton.bottomAnchor, constant: 8.0),
            increaseProductForBasketCounterButton.heightAnchor.constraint(equalToConstant: 20.0),
            increaseProductForBasketCounterButton.widthAnchor.constraint(equalToConstant: 20.0),
            increaseProductForBasketCounterButton.leftAnchor.constraint(equalTo: productForBasketCounterTextField.rightAnchor, constant: 5.0),
            
            productIDLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15.0),
            productIDLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 8.0),
            productIDLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            productIDLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            productNameLabel.topAnchor.constraint(equalTo: productIDLabel.bottomAnchor, constant: 5.0),
            productNameLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 8.0),
            productNameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            productNameLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 5.0),
            productPriceLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 8.0),
            productPriceLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            productPriceLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            productQuantityInBasketLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 5.0),
            productQuantityInBasketLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 8.0),
            productQuantityInBasketLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            productQuantityInBasketLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: decreaseProductForBasketCounterButton.bottomAnchor, constant: 5.0),
            productDescriptionLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 23.0),
            productDescriptionLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            productDescriptionLabel.heightAnchor.constraint(equalToConstant: 65.0),
            
            reviewsTitleLabel.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 20.0),
            reviewsTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
