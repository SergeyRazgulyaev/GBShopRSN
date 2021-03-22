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
    private let productID: Int
    private var displayedProduct = Product(productID: 0, productName: "", productPrice: 0, productDescription: "", quantityInBasket: 0)
    
    // MARK: - Init
    init(requestFactory: RequestFactory, productID: Int) {
        self.requestFactory = requestFactory
        self.productID = productID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        loadProductData()
        loadReviewsData()
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
    
    func configureProductDataLabels() {
        productScreenHeaderView.productIDLabel.text = "Product ID:  \(displayedProduct.productID)"
        productScreenHeaderView.productNameLabel.text = "Name: \(displayedProduct.productName)"
        productScreenHeaderView.productPriceLabel.text = "Price: \(displayedProduct.productPrice)" 
        productScreenHeaderView.productQuantityInBasketLabel.text = "Quantity in basket: \(displayedProduct.quantityInBasket)" 
        productScreenHeaderView.productDescriptionLabel.text = "Description: \(displayedProduct.productDescription)"
    }
    
    //MARK: - Interaction with Network
    func loadProductData() {
        let getProduct = requestFactory.makeGetProductRequestFactory()
        getProduct.getProduct(productID: productID) { response in
            switch response.result {
            case .success(let getProduct):
                self.displayedProduct = getProduct.product
                print(getProduct)
                DispatchQueue.main.async {
                    self.configureProductDataLabels()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadReviewsData() {
        let getReviews = requestFactory.makeGetReviewsRequestFactory()
        getReviews.getReviews(pageNumber: 1, productID: productID) { response in
            switch response.result {
            case .success(let getReviews):
                self.reviewsArray = getReviews.reviews
                DispatchQueue.main.async {
                    if self.reviewsArray.count != 0 {
                        self.productScreenHeaderView.reviewsTitleLabel.text = "Reviews"
                    }
                    self.productScreenHeaderView.reviewsTitleLabel.isHidden = false
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reviewsArray.count == 0 {
            return 0
        } else {
            return reviewsArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        230.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130.0
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
        cell.reviewIDCommentLabel.text = "Review: \(reviewsArray[indexPath.row].idComment)"
        cell.reviewUserIDLabel.text = "UserID: \(reviewsArray[indexPath.row].userID)"
        cell.reviewTextLabel.text = "Content: \(reviewsArray[indexPath.row].text)"
        return cell
    }
    
}
