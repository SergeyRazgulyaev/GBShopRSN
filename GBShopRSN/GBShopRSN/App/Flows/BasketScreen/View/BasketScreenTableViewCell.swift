//
//  BasketScreenTableViewCell.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.03.2021.
//

import UIKit

class BasketScreenTableViewCell: UITableViewCell, UIComponentsMakeable {
    // MARK: - UI components
    private(set) lazy var basketProductBarcodeImageView: UIImageView = {
        makeSystemImageView(systemImage: UIImage(systemName: "barcode")!,
                                 tintColor: .rsnPurpleColor)
    }()
    
    private(set) lazy var basketProductIDLabel: UILabel = {
        makeLabel(text: "Product ID: ",
                       textColor: .black,
                       font: .boldSystemFont(ofSize: 17.0))
    }()
    
    private(set) lazy var basketProductNameLabel: UILabel = {
        makeLabel(text: "Name: ",
                       textColor: .black,
                       font: .boldSystemFont(ofSize: 17.0))
    }()
    
    private(set) lazy var basketProductPriceLabel: UILabel = {
        makeLabel(text: "Price: ",
                       textColor: .black,
                       font: .systemFont(ofSize: 17.0))
    }()
    
    private(set) lazy var basketProductQuantityInBasketLabel: UILabel = {
        makeLabel(text: "Quantity in basket: ",
                       textColor: .black,
                       font: .systemFont(ofSize: 17.0))
    }()
    
    private(set) lazy var basketProductDescriptionLabel: UILabel = {
        makeLabel(text: "Description: ",
                       textColor: .black,
                       font: .systemFont(ofSize: 17.0))
    }()
    
    private(set) lazy var basketDeleteButton: UIButton = {
        makeButton(title: "Delete from basket",
                        font: .boldSystemFont(ofSize: 17),
                        backgroundColor: .rsnPinkColor,
                        cornerRadius: 8.0)
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
        basketProductDescriptionLabel.numberOfLines = 0
        
        contentView.addSubview(basketProductBarcodeImageView)
        contentView.addSubview(basketDeleteButton)
        contentView.addSubview(basketProductIDLabel)
        contentView.addSubview(basketProductNameLabel)
        contentView.addSubview(basketProductPriceLabel)
        contentView.addSubview(basketProductQuantityInBasketLabel)
        contentView.addSubview(basketProductDescriptionLabel)

        NSLayoutConstraint.activate([
            basketProductBarcodeImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 12.0),
            basketProductBarcodeImageView.leftAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leftAnchor,
                constant: 8.0),
            basketProductBarcodeImageView.heightAnchor.constraint(
                equalToConstant: 103.0),
            basketProductBarcodeImageView.widthAnchor.constraint(
                equalToConstant: 150.0),
            
            basketProductIDLabel.topAnchor.constraint(
                equalTo: topAnchor, constant: 15.0),
            basketProductIDLabel.leftAnchor.constraint(
                equalTo: basketProductBarcodeImageView.rightAnchor,
                constant: 8.0),
            basketProductIDLabel.rightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.rightAnchor,
                constant: -15.0),
            basketProductIDLabel.heightAnchor.constraint(
                equalToConstant: 20.0),
            
            basketProductNameLabel.topAnchor.constraint(
                equalTo: basketProductIDLabel.bottomAnchor,
                constant: 5.0),
            basketProductNameLabel.leftAnchor.constraint(
                equalTo: basketProductBarcodeImageView.rightAnchor,
                constant: 8.0),
            basketProductNameLabel.rightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.rightAnchor,
                constant: -15.0),
            basketProductNameLabel.heightAnchor.constraint(
                equalToConstant: 20.0),
            
            basketProductPriceLabel.topAnchor.constraint(
                equalTo: basketProductNameLabel.bottomAnchor,
                constant: 5.0),
            basketProductPriceLabel.leftAnchor.constraint(
                equalTo: basketProductBarcodeImageView.rightAnchor,
                constant: 8.0),
            basketProductPriceLabel.rightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.rightAnchor,
                constant: -15.0),
            basketProductPriceLabel.heightAnchor.constraint(
                equalToConstant: 20.0),
            
            basketProductQuantityInBasketLabel.topAnchor.constraint(
                equalTo: basketProductPriceLabel.bottomAnchor,
                constant: 5.0),
            basketProductQuantityInBasketLabel.leftAnchor.constraint(
                equalTo: basketProductBarcodeImageView.rightAnchor,
                constant: 8.0),
            basketProductQuantityInBasketLabel.rightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.rightAnchor,
                constant: -15.0),
            basketProductQuantityInBasketLabel.heightAnchor.constraint(
                equalToConstant: 20.0),
            
            basketProductDescriptionLabel.topAnchor.constraint(
                equalTo: basketProductQuantityInBasketLabel.bottomAnchor,
                constant: 5.0),
            basketProductDescriptionLabel.leftAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leftAnchor,
                constant: 23.0),
            basketProductDescriptionLabel.rightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.rightAnchor,
                constant: -15.0),
            basketProductDescriptionLabel.heightAnchor.constraint(
                equalToConstant: 65.0),
            
            basketDeleteButton.topAnchor.constraint(
                equalTo: basketProductDescriptionLabel.bottomAnchor,
                constant: 10.0),
            basketDeleteButton.heightAnchor.constraint(
                equalToConstant: 30.0),
            basketDeleteButton.widthAnchor.constraint(
                equalToConstant: 200.0),
            basketDeleteButton.centerXAnchor.constraint(
                equalTo: centerXAnchor)
        ])
    }
}
