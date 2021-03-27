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
    private let requestFactory: RequestFactory
    private var reviewsArray: Array = [Review]()
    private let reuseIdentifierTableViewCell = "ProductScreenTableViewCell"
    private let currencyUnit: String = "rub."
    private let productID: Int
    private var increaseDecreaseCounter: Int = 0
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
        configureAddToBasketButton()
        configureDeleteFromBasketButton()
        configureDecreaseProductForBasketCounterButton()
        configureIncreaseProductForBasketCounterButton()
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
    
    func configureProductDataLabels() {
        productScreenHeaderView.productIDLabel.text = "Product ID: \(displayedProduct.productID)"
        productScreenHeaderView.productNameLabel.text = "Name: \(displayedProduct.productName)"
        productScreenHeaderView.productPriceLabel.text = "Price: \(displayedProduct.productPrice) \(currencyUnit)" 
        productScreenHeaderView.productQuantityInBasketLabel.text = "Quantity in basket: \(displayedProduct.quantityInBasket)" 
        productScreenHeaderView.productDescriptionLabel.text = "Description: \(displayedProduct.productDescription)"
        productScreenHeaderView.productForBasketCounterTextField.text = "\(displayedProduct.quantityInBasket)"
    }
    
    func configureAddToBasketButton() {
        productScreenHeaderView.addToBasketButton.addTarget(self, action: #selector(tapAddToBasketButton(_:)), for: .touchUpInside)
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
            deleteProductFromBasket(productID: productID)
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
                print(getReviews)
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
    
    func addProductToBasket() {
        let addToBasket = requestFactory.makeAddToBasketRequestFactory()
        addToBasket.addToBasket(productID: 123, quantityInBasket: ((productScreenHeaderView.productForBasketCounterTextField.text ?? "000") as NSString).integerValue) { response in
            switch response.result {
            case .success(let addProductToBasket):
                print(addProductToBasket)
                DispatchQueue.main.async {
                    self.productScreenHeaderView.productQuantityInBasketLabel.text = "Quantity in basket: \(self.productScreenHeaderView.productForBasketCounterTextField.text ?? "000")"
                    self.displayedProduct.quantityInBasket = ((self.productScreenHeaderView.productForBasketCounterTextField.text ?? "000") as NSString).integerValue
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteProductFromBasket(productID: Int) {
        let deleteFromBasket = requestFactory.makeDeleteFromBasketRequestFactory()
        deleteFromBasket.deleteFromBasket(productID: productID) { response in
            switch response.result {
            case .success(let deleteProductFromBasket):
                print(deleteProductFromBasket)
                DispatchQueue.main.async {
                    self.productScreenHeaderView.productQuantityInBasketLabel.text = "Quantity in basket: 0"
                    self.displayedProduct.quantityInBasket = 0
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
        265.0
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
        guard let cell = tableViewCell else {
            print("Error with Cell")
            return UITableViewCell()
        }
        cell.reviewIDCommentLabel.text = "Review \(reviewsArray[indexPath.row].commentID)"
        cell.reviewUserNameAndLastnameLabel.text = "User: \(reviewsArray[indexPath.row].userName) \(reviewsArray[indexPath.row].userLastname)"
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
