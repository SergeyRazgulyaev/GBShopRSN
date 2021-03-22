//
//  ProductScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 22.03.2021.
//

import UIKit

class ProductScreenViewController: UITableViewController {
    // MARK: - UI components
    private lazy var productScreenHeaderView: ProductScreenHeaderView = {
        return ProductScreenHeaderView()
    }()
    
    // MARK: - Properties
    private var reviewsArray: Array = [Review]()
    private let reuseIdentifierTableViewCell = "ProductScreenTableViewCell"
    private let requestFactory: RequestFactory
    
    // MARK: - Init
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }

    //MARK: - Configuration Methods
    func configureViewController() {
        navigationController?.navigationItem.backBarButtonItem?.title = "Products"
        navigationController?.navigationBar.barTintColor = .white
        title = "Product"
    }
    
    func configureTableView() {
        tableView.register(ProductScreenTableViewCell.self, forCellReuseIdentifier: reuseIdentifierTableViewCell)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        190.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return productScreenHeaderView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        configureTableViewCell(indexPath: indexPath)
    }
    
    func configureTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableViewCell, for: indexPath) as? ProductScreenTableViewCell
        guard let cell = tableViewCell else {
            print("Error with Cell")
            return UITableViewCell()
        }
        if reviewsArray.count != 0 {
            //Reviews cell configuration
        } else {
            //NO Reviews cell configuration
        }
        return cell
    }
    
}
