//
//  ProductScreenTableViewCell.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 22.03.2021.
//

import UIKit

class ProductScreenTableViewCell: UITableViewCell, UIComponentsMakeable {
    // MARK: - UI components
    private(set) lazy var reviewIDCommentLabel: UILabel = {
        configureLabel(text: "Review: ",
                       textColor: .black,
                       font: .systemFont(ofSize: 14.0))
    }()
    
    private(set) lazy var reviewUserIDLabel: UILabel = {
        configureLabel(text: "UserID: ",
                       textColor: .black,
                       font: .systemFont(ofSize: 14.0))
    }()
    
    private(set) lazy var reviewTextLabel: UILabel = {
        configureLabel(text: "Content: ",
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
        reviewTextLabel.numberOfLines = 0
        addSubview(reviewIDCommentLabel)
        addSubview(reviewUserIDLabel)
        addSubview(reviewTextLabel)

        NSLayoutConstraint.activate([
            reviewIDCommentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            reviewIDCommentLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15.0),
            reviewIDCommentLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            reviewIDCommentLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            reviewUserIDLabel.topAnchor.constraint(equalTo: reviewIDCommentLabel.bottomAnchor, constant: 5.0),
            reviewUserIDLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15.0),
            reviewUserIDLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            reviewUserIDLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            reviewTextLabel.topAnchor.constraint(equalTo: reviewUserIDLabel.bottomAnchor, constant: 5.0),
            reviewTextLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15.0),
            reviewTextLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15.0),
            reviewTextLabel.heightAnchor.constraint(equalToConstant: 70.0)
        ])
    }

}
