//
//  ProductListScreenTableViewCell.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 16.03.2021.
//

import UIKit

class ProductListScreenTableViewCell: UITableViewCell {
    // MARK: - UI components
    private(set) lazy var productIDLabel: UILabel = {
        let productIDLabel = UILabel()
        productIDLabel.translatesAutoresizingMaskIntoConstraints = false
        productIDLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        productIDLabel.text = "Product ID: "
        return productIDLabel
    }()
    
    private(set) lazy var productNameLabel: UILabel = {
        let productNameLabel = UILabel()
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.font = UIFont.systemFont(ofSize: 14.0)
        productNameLabel.text = "Name: "
        return productNameLabel
    }()
    
    private(set) lazy var productPriceLabel: UILabel = {
        let productPriceLabel = UILabel()
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.font = UIFont.systemFont(ofSize: 14.0)
        productPriceLabel.text = "Price: "
        return productPriceLabel
    }()
    
    private(set) lazy var productDescriptionLabel: UILabel = {
        let productDescriptionLabel = UILabel()
        productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        productDescriptionLabel.font = UIFont.systemFont(ofSize: 14.0)
        productDescriptionLabel.text = "Description: "
        return productDescriptionLabel
    }()
    
    private(set) lazy var productQuantityInBasketLabel: UILabel = {
        let productQuantityInBasketLabel = UILabel()
        productQuantityInBasketLabel.translatesAutoresizingMaskIntoConstraints = false
        productQuantityInBasketLabel.font = UIFont.systemFont(ofSize: 14.0)
        productQuantityInBasketLabel.text = "Quantity in basket: "
        return productQuantityInBasketLabel
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }

    //MARK: - Configuration Methods
    func configureUI() {
        addSubview(productIDLabel)
        addSubview(productNameLabel)
        addSubview(productPriceLabel)
        addSubview(productQuantityInBasketLabel)
        addSubview(productDescriptionLabel)

        NSLayoutConstraint.activate([
            productIDLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            productIDLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15.0),
            productIDLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            productIDLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            productNameLabel.topAnchor.constraint(equalTo: productIDLabel.bottomAnchor, constant: 5.0),
            productNameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15.0),
            productNameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            productNameLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 5.0),
            productPriceLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15.0),
            productPriceLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            productPriceLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 5.0),
            productDescriptionLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15.0),
            productDescriptionLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            productDescriptionLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            productQuantityInBasketLabel.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 5.0),
            productQuantityInBasketLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15.0),
            productQuantityInBasketLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            productQuantityInBasketLabel.heightAnchor.constraint(equalToConstant: 20.0)
        ])
    }

}
