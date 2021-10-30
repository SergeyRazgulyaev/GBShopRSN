//
//  ProductScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 22.03.2021.
//

import UIKit
import os.log

class ProductScreenViewController: UITableViewController, AnalyticsSendable, Alertable {
    // MARK: - UI components
    private lazy var productScreenHeaderView: ProductScreenHeaderView = {
        return ProductScreenHeaderView()
    }()
    private lazy var assignedСommentID: Int? = {
        self.reviewsArray.filter({$0.userID == self.user.userID}).first?.commentID
    }()

    
    // MARK: - Properties
    private let requestFactory: RequestFactory
    private var reviewsArray: Array = [Review]()
    private let defaultPageNumber: Int = 1
    private let reuseIdentifierTableViewCell = "ProductScreenTableViewCell"
    private let currencyUnit: String = "rub."
    private let productID: Int
    private let user: User
    private var increaseDecreaseCounter: Int = 0
    private var displayedProduct = Product(productID: 0, productName: "", productPrice: 0, productDescription: "", quantityInBasket: 0)
    
    // MARK: - Init
    init(requestFactory: RequestFactory, productID: Int, user: User) {
        self.requestFactory = requestFactory
        self.productID = productID
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        configureUIComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProductData()
        loadReviewsData()
        configureKeyboard()
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
    
    func configureUIComponents() {
        configureAddToBasketButton()
        configureDeleteFromBasketButton()
        configureDecreaseProductForBasketCounterButton()
        configureIncreaseProductForBasketCounterButton()
        configureAddReviewButton()
    }
    
    func configureAddToBasketButton() {
        productScreenHeaderView.updateBasketButton.addTarget(self, action: #selector(tapAddToBasketButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapAddToBasketButton(_ sender: Any?) {
        if (((productScreenHeaderView.productForBasketCounterTextField.text ?? "000") as NSString).integerValue != self.displayedProduct.quantityInBasket) && !(productScreenHeaderView.productForBasketCounterTextField.text?.isTrimmedEmpty ?? true) && (((productScreenHeaderView.productForBasketCounterTextField.text ?? "000") as NSString).integerValue > 0) {
            addProductToBasket()
        }
    }
    
    func configureDeleteFromBasketButton() {
        productScreenHeaderView.deleteFromBasketButton.addTarget(self, action: #selector(tapDeleteFromBasketButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapDeleteFromBasketButton(_ sender: Any?) {
        if self.displayedProduct.quantityInBasket != 0 {
            deleteProductFromBasket()
        }
    }
    
    func configureDecreaseProductForBasketCounterButton() {
        productScreenHeaderView.decreaseProductForBasketCounterButton.addTarget(self, action: #selector(tapDecreaseProductForBasketCounterButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapDecreaseProductForBasketCounterButton(_ sender: Any?) {
        if ((productScreenHeaderView.productForBasketCounterTextField.text ?? "000") as NSString).integerValue > 0 {
            increaseDecreaseCounter = ((productScreenHeaderView.productForBasketCounterTextField.text ?? "000") as NSString).integerValue
            increaseDecreaseCounter -= 1
            productScreenHeaderView.productForBasketCounterTextField.text = "\(increaseDecreaseCounter)"
        }
    }
    
    func configureIncreaseProductForBasketCounterButton() {
        productScreenHeaderView.increaseProductForBasketCounterButton.addTarget(self, action: #selector(tapIncreaseProductForBasketCounterButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapIncreaseProductForBasketCounterButton(_ sender: Any?) {
        increaseDecreaseCounter = ((productScreenHeaderView.productForBasketCounterTextField.text ?? "000") as NSString).integerValue
        increaseDecreaseCounter += 1
        productScreenHeaderView.productForBasketCounterTextField.text = "\(increaseDecreaseCounter)"
    }
    
    func configureAddReviewButton() {
        productScreenHeaderView.addReviewButton.addTarget(self, action: #selector(tapAddReviewButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapAddReviewButton(_ sender: Any?) {
        if productScreenHeaderView.addReviewButton.titleLabel?.text == "Add review" {
            if !(productScreenHeaderView.userReviewTextField.text?.isTrimmedEmpty ?? true) {
                addUserReview()
            } else {
                self.showAttantionAlert(
                    viewController: self,
                    message: "You need to write a review to publish it")
            }
        } else {
            deleteUserReview()
        }
    }
    
    func configureProductDataLabels() {
        productScreenHeaderView.productIDLabel.text = "Product ID: \(displayedProduct.productID)"
        productScreenHeaderView.productNameLabel.text = "Name: \(displayedProduct.productName)"
        productScreenHeaderView.productPriceLabel.text = "Price: \(displayedProduct.productPrice) \(currencyUnit)"
        productScreenHeaderView.quantityInBasketLabel.text = "Quantity in basket: \(displayedProduct.quantityInBasket)"
        productScreenHeaderView.productDescriptionLabel.text = "Description: \(displayedProduct.productDescription)"
        productScreenHeaderView.productForBasketCounterTextField.text = "\(displayedProduct.quantityInBasket)"
    }
    
    //MARK: - Interaction with Network
    func loadProductData() {
        let getProduct = requestFactory.makeGetProductRequestFactory()
        getProduct.getProduct(productID: productID) { response in
            switch response.result {
            case .success(let getProduct):
                self.displayedProduct = getProduct.product
                self.sendAnalyticsOpenProductSuccess(
                    productID: self.productID,
                    productName: getProduct.product.productName,
                    productPrice: getProduct.product.productPrice,
                    productDescription: getProduct.product.productDescription,
                    quantityInBasket: getProduct.product.quantityInBasket)
                DispatchQueue.main.async {
                    self.configureProductDataLabels()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.sendAnalyticsFailure(
                    failureName: "open_product_failure",
                    errorDescription: error.localizedDescription)
                Logger.viewCycle.debug("\(error.localizedDescription)")
            }
        }
    }
    
    func addProductToBasket() {
        let addToBasket = requestFactory.makeAddToBasketRequestFactory()
        addToBasket.addToBasket(
            addedProductID: productID,
            updatedQuantityInBasket: ((productScreenHeaderView.productForBasketCounterTextField.text ?? "000") as NSString).integerValue) { response in
            switch response.result {
            case .success(let addProductToBasket):
                self.sendAnalyticsAddToBasketSuccess(
                    addedProductID: self.productID,
                    updatedQuantityInBasket: addProductToBasket.updatedQuantityInBasket)
                DispatchQueue.main.async {
                    self.productScreenHeaderView.quantityInBasketLabel.text = "Quantity in basket: \(addProductToBasket.updatedQuantityInBasket)"
                    self.displayedProduct.quantityInBasket = addProductToBasket.updatedQuantityInBasket
                }
            case .failure(let error):
                self.sendAnalyticsFailure(
                    failureName: "add_to_basket_failure",
                    errorDescription: error.localizedDescription)
                Logger.viewCycle.debug("\(error.localizedDescription)")
            }
        }
    }
    
    func deleteProductFromBasket() {
        let deleteFromBasket = requestFactory.makeDeleteFromBasketRequestFactory()
        deleteFromBasket.deleteFromBasket(deletedProductID: productID) { response in
            switch response.result {
            case .success(let deleteProductFromBasket):
                self.sendAnalyticsDeleteFromBasketSuccess(
                    deletedProductID: deleteProductFromBasket.deletedProductID,
                    deletedProductQuantityInBasket: deleteProductFromBasket.deletedProductQuantityInBasket)
                DispatchQueue.main.async {
                    self.productScreenHeaderView.quantityInBasketLabel.text = "Quantity in basket: \(deleteProductFromBasket.deletedProductQuantityInBasket)"
                    self.displayedProduct.quantityInBasket = deleteProductFromBasket.deletedProductQuantityInBasket
                    self.productScreenHeaderView.productForBasketCounterTextField.text = "0"
                }
            case .failure(let error):
                self.sendAnalyticsFailure(
                    failureName: "delete_from_basket_failure",
                    errorDescription: error.localizedDescription)
                Logger.viewCycle.debug("\(error.localizedDescription)")
            }
        }
    }
    
    func loadReviewsData() {
        let getReviews = requestFactory.makeGetReviewsRequestFactory()
        getReviews.getReviews(pageNumber: defaultPageNumber, productID: productID) { response in
            switch response.result {
            case .success(let getReviews):
                self.sendAnalyticsGetReviewsSuccess(
                    reviewsCount: getReviews.reviews.count)
                DispatchQueue.main.async {
                    self.reviewsArray = getReviews.reviews
                    if self.reviewsArray.count != 0 {
                        self.productScreenHeaderView.reviewsTitleLabel.text = "Reviews"
                    }
                    self.productScreenHeaderView.reviewsTitleLabel.isHidden = false
                    if self.reviewsArray.filter({$0.userID == self.user.userID}).first?.userID != nil {
                        self.productScreenHeaderView.addReviewButton.setTitle("Delete review", for: .normal)
                    }
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.sendAnalyticsFailure(
                    failureName: "get_reviews_failure",
                    errorDescription: error.localizedDescription)
                Logger.viewCycle.debug("\(error.localizedDescription)")
            }
        }
    }
    
    func addUserReview() {
        let addReview = requestFactory.makeAddReviewRequestFactory()
        addReview.addReview(productID: productID, userID: user.userID, userName: user.userName, userLastName: user.userLastName, text: productScreenHeaderView.userReviewTextField.text ?? "no review") { response in
            switch response.result {
            case .success(let addReview):
                self.assignedСommentID = addReview.assignedСommentID
                self.loadReviewsData()
                self.sendAnalyticsAddReviewSuccess(userMessage: addReview.userMessage)
                DispatchQueue.main.async {
                    self.productScreenHeaderView.addReviewButton.setTitle("Delete review", for: .normal)
                }
            case .failure(let error):
                self.sendAnalyticsFailure(
                    failureName: "add_review_failure",
                    errorDescription: error.localizedDescription)
                Logger.viewCycle.debug("\(error.localizedDescription)")
            }
        }
    }
    
    func deleteUserReview() {
        let deleteReview = requestFactory.makeDeleteReviewRequestFactory()
        deleteReview.deleteReview(productID: productID, commentID: assignedСommentID ?? 0) { response in
            switch response.result {
            case .success(let deleteReview):
                self.loadReviewsData()
                self.sendAnalyticsDeleteReviewSuccess(deletedReviewID: deleteReview.deletedReviewID)
                DispatchQueue.main.async {
                    self.productScreenHeaderView.addReviewButton.setTitle("Add review", for: .normal)
                }
            case .failure(let error):
                self.sendAnalyticsFailure(
                    failureName: "delete_review_failure",
                    errorDescription: error.localizedDescription)
                Logger.viewCycle.debug("\(error.localizedDescription)")
            }
        }
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        275.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return productScreenHeaderView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        configureTableViewCell(indexPath: indexPath)
    }
    
    func configureTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableViewCell, for: indexPath) as? ProductScreenTableViewCell
        guard let cell = tableViewCell else { return UITableViewCell() }
        cell.reviewIDCommentLabel.text = "Review \(reviewsArray[indexPath.row].commentID)"
        cell.reviewUserNameAndLastnameLabel.text = "User: \(reviewsArray[indexPath.row].userName) \(reviewsArray[indexPath.row].userLastName)"
        cell.reviewTextLabel.text = "\(reviewsArray[indexPath.row].text)"
        return cell
    }
}

//MARK: - Keyboard configuration
extension ProductScreenViewController {
    func configureKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap))
        tableView.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboardByTap() {
        tableView.endEditing(true)
    }
}
