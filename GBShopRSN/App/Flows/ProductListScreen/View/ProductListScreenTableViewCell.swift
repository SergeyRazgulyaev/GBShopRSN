//
//  ProductListScreenTableViewCell.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 16.03.2021.
//

import UIKit

class ProductListScreenTableViewCell: UITableViewCell, UIComponentsMakeable {
    // MARK: - UI components
    private(set) lazy var productQRCodeImageView: UIImageView = {
        makeSystemImageView(systemImage: UIImage(systemName: "qrcode")!, tintColor: .rsnPurpleColor)
    }()
    
    private(set) lazy var productIDLabel: UILabel = {
        makeLabel(text: "Product ID: ",
                       textColor: .black,
                       font: .boldSystemFont(ofSize: 17.0))
    }()
    
    private(set) lazy var productNameLabel: UILabel = {
        makeLabel(text: "Name: ",
                       textColor: .black,
                       font: .boldSystemFont(ofSize: 17.0))
    }()
    
    private(set) lazy var productPriceLabel: UILabel = {
        makeLabel(text: "Price: ",
                       textColor: .black,
                       font: .systemFont(ofSize: 17.0))
    }()
    
    private(set) lazy var productDescriptionLabel: UILabel = {
        makeLabel(text: "Description: ",
                       textColor: .black,
                       font: .systemFont(ofSize: 17.0))
    }()
    
    private(set) lazy var productQuantityInBasketLabel: UILabel = {
        makeLabel(text: "Quantity in basket: ",
                       textColor: .black,
                       font: .systemFont(ofSize: 17.0))
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
        selectionStyle = UITableViewCell.SelectionStyle.none
        productDescriptionLabel.numberOfLines = 0
        contentView.addSubview(productQRCodeImageView)
        contentView.addSubview(productIDLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(productQuantityInBasketLabel)
        contentView.addSubview(productDescriptionLabel)

        NSLayoutConstraint.activate([
            productQRCodeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            productQRCodeImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10.0),
            productQRCodeImageView.heightAnchor.constraint(equalToConstant: 70.0),
            productQRCodeImageView.widthAnchor.constraint(equalToConstant: 70.0),
            
            productIDLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            productIDLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15.0),
            productIDLabel.rightAnchor.constraint(equalTo: productQRCodeImageView.leftAnchor, constant: -10.0),
            productIDLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            productNameLabel.topAnchor.constraint(equalTo: productIDLabel.bottomAnchor, constant: 5.0),
            productNameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15.0),
            productNameLabel.rightAnchor.constraint(equalTo: productQRCodeImageView.leftAnchor, constant: -10.0),
            productNameLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 5.0),
            productPriceLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15.0),
            productPriceLabel.rightAnchor.constraint(equalTo: productQRCodeImageView.leftAnchor, constant: -10.0),
            productPriceLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 5.0),
            productDescriptionLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15.0),
            productDescriptionLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            productDescriptionLabel.heightAnchor.constraint(equalToConstant: 65.0),
            
            productQuantityInBasketLabel.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 5.0),
            productQuantityInBasketLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15.0),
            productQuantityInBasketLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            productQuantityInBasketLabel.heightAnchor.constraint(equalToConstant: 20.0)
        ])
    }
}
