//
//  BasketScreenFooterView.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 27.03.2021.
//

import UIKit

class BasketScreenFooterView: UIView, UIComponentsMakeable {
    // MARK: - UI components    
    private(set) lazy var basketPayButton: UIButton = {
        makeButton(title: "Pay basket",
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
        backgroundColor = .white
        addSubview(basketPayButton)
        
        NSLayoutConstraint.activate([
            basketPayButton.heightAnchor.constraint(
                equalToConstant: 30.0),
            basketPayButton.widthAnchor.constraint(
                equalToConstant: 300.0),
            basketPayButton.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            basketPayButton.centerYAnchor.constraint(
                equalTo: centerYAnchor)
        ])
    }
}
