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
    
    private(set) lazy var productIDLabel: UILabel = {
        configureLabel(text: "Product ID: ",
                       textColor: .black,
                       font: .boldSystemFont(ofSize: 14.0))
    }()
    
    private(set) lazy var productNameLabel: UILabel = {
        configureLabel(text: "Name: ",
                       textColor: .black,
                       font: .boldSystemFont(ofSize: 14.0))
    }()
    
    private(set) lazy var productPriceLabel: UILabel = {
        configureLabel(text: "Price: ",
                       textColor: .black,
                       font: .boldSystemFont(ofSize: 14.0))
    }()
    
    private(set) lazy var productDescriptionLabel: UILabel = {
        configureLabel(text: "Description: ",
                       textColor: .black,
                       font: .boldSystemFont(ofSize: 14.0))
    }()
    
    private(set) lazy var productQuantityInBasketLabel: UILabel = {
        configureLabel(text: "Quantity in basket: ",
                       textColor: .black,
                       font: .boldSystemFont(ofSize: 14.0))
    }()
    
    private(set) lazy var reviewsLogoLabel: UILabel = {
        configureLabel(text: "Reviews",
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
        addSubview(productImageView)
        addSubview(productIDLabel)
        addSubview(productNameLabel)
        addSubview(productPriceLabel)
        addSubview(productQuantityInBasketLabel)
        addSubview(productDescriptionLabel)
        addSubview(reviewsLogoLabel)

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            productImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8.0),
            productImageView.heightAnchor.constraint(equalToConstant: 110.0),
            productImageView.widthAnchor.constraint(equalToConstant: 150.0),
            
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
            
            productDescriptionLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8.0),
            productDescriptionLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 22.0),
            productDescriptionLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            productDescriptionLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            reviewsLogoLabel.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 40.0),
            reviewsLogoLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
