//
//  ProductScreenHeaderView.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 22.03.2021.
//

import UIKit

class ProductScreenHeaderView: UIView, UIComponentsMakeable {
    // MARK: - UI components
    private(set) lazy var barcodeImageView: UIImageView = {
        makeSystemImageView(systemImage: UIImage(systemName: "barcode")!,
                                 tintColor: .rsnPurpleColor)
    }()
    
    private(set) lazy var productForBasketCounterTextField: UITextField = {
        makeTextField(placeholder: "",
                           font: .systemFont(ofSize: 14),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var decreaseProductForBasketCounterButton: UIButton = {
        makeButton(title: "",
                        font: .boldSystemFont(ofSize: 12),
                        backgroundColor: .white,
                        cornerRadius: 0.0)
    }()
    
    private(set) lazy var increaseProductForBasketCounterButton: UIButton = {
        makeButton(title: "",
                        font: .boldSystemFont(ofSize: 12),
                        backgroundColor: .white,
                        cornerRadius: 0.0)
    }()
    
    private(set) lazy var updateBasketButton: UIButton = {
        makeButton(title: "Update basket",
                        font: .boldSystemFont(ofSize: 12),
                        backgroundColor: .rsnLightGreenColor,
                        cornerRadius: 8.0)
    }()
    
    private(set) lazy var deleteFromBasketButton: UIButton = {
        makeButton(title: "Delete from basket",
                        font: .boldSystemFont(ofSize: 12),
                        backgroundColor: .rsnPinkColor,
                        cornerRadius: 8.0)
    }()
    
    private(set) lazy var addReviewButton: UIButton = {
        makeButton(title: "Add review",
                        font: .boldSystemFont(ofSize: 12),
                        backgroundColor: .lightGray,
                        cornerRadius: 8.0)
    }()
    
    private(set) lazy var productIDLabel: UILabel = {
        makeLabel(text: "Product ID: ",
                       textColor: .black,
                       font: .boldSystemFont(ofSize: 14.0))
    }()
    
    private(set) lazy var productNameLabel: UILabel = {
        makeLabel(text: "Name: ",
                       textColor: .black,
                       font: .boldSystemFont(ofSize: 14.0))
    }()
    
    private(set) lazy var productPriceLabel: UILabel = {
        makeLabel(text: "Price: ",
                       textColor: .black,
                       font: .systemFont(ofSize: 14.0))
    }()
    
    private(set) lazy var quantityInBasketLabel: UILabel = {
        makeLabel(text: "Quantity in basket: ",
                       textColor: .black,
                       font: .systemFont(ofSize: 14.0))
    }()
    
    private(set) lazy var productDescriptionLabel: UILabel = {
        makeLabel(text: "Description: ",
                       textColor: .black,
                       font: .systemFont(ofSize: 14.0))
    }()
    
    private(set) lazy var userReviewTextField: UITextField = {
        makeTextField(placeholder: "Enter your review",
                           font: .systemFont(ofSize: 14),
                           borderStyle: .roundedRect)
    }()
    
    private(set) lazy var reviewsTitleLabel: UILabel = {
        makeLabel(text: "No reviews",
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
        addSubview(barcodeImageView)
        addSubview(productForBasketCounterTextField)
        addSubview(decreaseProductForBasketCounterButton)
        addSubview(increaseProductForBasketCounterButton)
        addSubview(updateBasketButton)
        addSubview(deleteFromBasketButton)
        addSubview(addReviewButton)
        addSubview(productIDLabel)
        addSubview(productNameLabel)
        addSubview(productPriceLabel)
        addSubview(quantityInBasketLabel)
        addSubview(productDescriptionLabel)
        addSubview(userReviewTextField)
        addSubview(reviewsTitleLabel)

        NSLayoutConstraint.activate([
            barcodeImageView.topAnchor.constraint(
                equalTo: topAnchor, constant: 12.0),
            barcodeImageView.leftAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leftAnchor,
                constant: 8.0),
            barcodeImageView.heightAnchor.constraint(
                equalToConstant: 35.0),
            barcodeImageView.widthAnchor.constraint(
                equalToConstant: 150.0),
            
            decreaseProductForBasketCounterButton.topAnchor.constraint(
                equalTo: barcodeImageView.bottomAnchor,
                constant: 3.0),
            decreaseProductForBasketCounterButton.rightAnchor.constraint(
                equalTo: productForBasketCounterTextField.leftAnchor,
                constant: -5.0),
            decreaseProductForBasketCounterButton.heightAnchor.constraint(
                equalToConstant: 20.0),
            decreaseProductForBasketCounterButton.widthAnchor.constraint(
                equalToConstant: 20.0),
            
            productForBasketCounterTextField.topAnchor.constraint(
                equalTo: barcodeImageView.bottomAnchor,
                constant: 3.0),
            productForBasketCounterTextField.heightAnchor.constraint(
                equalToConstant: 20.0),
            productForBasketCounterTextField.widthAnchor.constraint(
                equalToConstant: 70.0),
            productForBasketCounterTextField.centerXAnchor.constraint(
                equalTo: updateBasketButton.centerXAnchor),

            increaseProductForBasketCounterButton.topAnchor.constraint(
                equalTo: barcodeImageView.bottomAnchor,
                constant: 3.0),
            increaseProductForBasketCounterButton.heightAnchor.constraint(
                equalToConstant: 20.0),
            increaseProductForBasketCounterButton.widthAnchor.constraint(
                equalToConstant: 20.0),
            increaseProductForBasketCounterButton.leftAnchor.constraint(
                equalTo: productForBasketCounterTextField.rightAnchor,
                constant: 5.0),
            
            updateBasketButton.topAnchor.constraint(
                equalTo: decreaseProductForBasketCounterButton.bottomAnchor, constant: 8.0),
            updateBasketButton.heightAnchor.constraint(
                equalToConstant: 30.0),
            updateBasketButton.widthAnchor.constraint(
                equalToConstant: 121.0),
            updateBasketButton.leftAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leftAnchor,
                constant: 23.0),
            
            deleteFromBasketButton.topAnchor.constraint(
                equalTo: updateBasketButton.bottomAnchor,
                constant: 8.0),
            deleteFromBasketButton.heightAnchor.constraint(
                equalToConstant: 30.0),
            deleteFromBasketButton.widthAnchor.constraint(
                equalToConstant: 121.0),
            deleteFromBasketButton.leftAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leftAnchor,
                constant: 23.0),
            
            addReviewButton.topAnchor.constraint(
                equalTo: deleteFromBasketButton.bottomAnchor,
                constant: 8.0),
            addReviewButton.heightAnchor.constraint(
                equalToConstant: 30.0),
            addReviewButton.widthAnchor.constraint(
                equalToConstant: 121.0),
            addReviewButton.leftAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leftAnchor,
                constant: 23.0),
            
            productIDLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 16.0),
            productIDLabel.leftAnchor.constraint(
                equalTo: barcodeImageView.rightAnchor,
                constant: 8.0),
            productIDLabel.rightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.rightAnchor,
                constant: -15.0),
            productIDLabel.heightAnchor.constraint(
                equalToConstant: 20.0),
            
            productNameLabel.topAnchor.constraint(
                equalTo: productIDLabel.bottomAnchor,
                constant: 5.0),
            productNameLabel.leftAnchor.constraint(
                equalTo: barcodeImageView.rightAnchor,
                constant: 8.0),
            productNameLabel.rightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.rightAnchor,
                constant: -15.0),
            productNameLabel.heightAnchor.constraint(
                equalToConstant: 20.0),
            
            productPriceLabel.topAnchor.constraint(
                equalTo: productNameLabel.bottomAnchor,
                constant: 5.0),
            productPriceLabel.leftAnchor.constraint(
                equalTo: barcodeImageView.rightAnchor,
                constant: 8.0),
            productPriceLabel.rightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.rightAnchor,
                constant: -15.0),
            productPriceLabel.heightAnchor.constraint(
                equalToConstant: 20.0),
            
            quantityInBasketLabel.topAnchor.constraint(
                equalTo: productPriceLabel.bottomAnchor,
                constant: 5.0),
            quantityInBasketLabel.leftAnchor.constraint(
                equalTo: barcodeImageView.rightAnchor,
                constant: 8.0),
            quantityInBasketLabel.rightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.rightAnchor,
                constant: -15.0),
            quantityInBasketLabel.heightAnchor.constraint(
                equalToConstant: 20.0),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: quantityInBasketLabel.bottomAnchor, constant: 5.0),
            productDescriptionLabel.leftAnchor.constraint(equalTo: barcodeImageView.rightAnchor, constant: 8.0),
            productDescriptionLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            productDescriptionLabel.heightAnchor.constraint(equalToConstant: 70.0),
            
            userReviewTextField.topAnchor.constraint(
                equalTo: addReviewButton.bottomAnchor,
                constant: 8.0),
            userReviewTextField.leftAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leftAnchor,
                constant: 23.0),
            userReviewTextField.rightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.rightAnchor,
                constant: -15.0),
            userReviewTextField.heightAnchor.constraint(
                equalToConstant: 30.0),
            
            reviewsTitleLabel.topAnchor.constraint(
                equalTo: userReviewTextField.bottomAnchor,
                constant: 15.0),
            reviewsTitleLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor)
        ])
    }
}
