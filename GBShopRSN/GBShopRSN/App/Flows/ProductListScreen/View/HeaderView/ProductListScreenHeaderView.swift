//
//  ProductListScreenHeaderView.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 16.03.2021.
//

import UIKit

class ProductListScreenHeaderView: UIView {
    // MARK: - UI components
    private(set) lazy var selectProductsCategoryImageView: UIImageView = {
        let selectProductsCategoryImageView = UIImageView()
        selectProductsCategoryImageView.translatesAutoresizingMaskIntoConstraints = false
        selectProductsCategoryImageView.layer.masksToBounds = true
        selectProductsCategoryImageView.image = UIImage(systemName: "cube.box.fill")
        selectProductsCategoryImageView.tintColor = .rsnPurpleColor
        return selectProductsCategoryImageView
    }()
    
    private(set) lazy var selectProductsCategoryTextField: UITextField = {
        let selectProductsCategoryTextField = UITextField()
        selectProductsCategoryTextField.translatesAutoresizingMaskIntoConstraints = false
        selectProductsCategoryTextField.borderStyle = UITextField.BorderStyle.roundedRect
        selectProductsCategoryTextField.placeholder = "Select products category"
        selectProductsCategoryTextField.font = UIFont.systemFont(ofSize: 17)
        return selectProductsCategoryTextField
    }()
    
    private(set) lazy var selectProductsCategoryButton: UIButton = {
        let selectProductsCategoryButton = UIButton()
        selectProductsCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        selectProductsCategoryButton.setTitle("Show", for: .normal)
        selectProductsCategoryButton.backgroundColor = .rsnLightGreenColor
        selectProductsCategoryButton.layer.cornerRadius = 8.0
        selectProductsCategoryButton.layer.masksToBounds = true
        return selectProductsCategoryButton
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
