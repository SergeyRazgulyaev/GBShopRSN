//
//  ProductListScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 16.03.2021.
//

import UIKit
import os.log

class ProductListScreenViewController: UITableViewController, AnalyticsSendable, Alertable {
    // MARK: - UI components
    private lazy var productListScreenHeaderView: ProductListScreenHeaderView = {
        return ProductListScreenHeaderView()
    }()
    
    // MARK: - Properties
    private var productsArray: Array = [Product]()
    private let defaultPageNumber: Int = 1
    private let user: User
    private let currencyUnit: String = "rub."
    private let reuseIdentifierTableViewCell = "ProductListScreenTableViewCell"
    private let requestFactory: RequestFactory
    
    // MARK: - Init
    init(requestFactory: RequestFactory, user: User) {
        self.requestFactory = requestFactory
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        configureSelectProductsCategoryButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProductListData()
        configureKeyboard()
    }
    
    //MARK: - Configuration Methods
    func configureViewController() {
        navigationController?.navigationBar.barTintColor = .white
        title = "Products"
    }
    
    func configureTableView() {
        tableView.register(ProductListScreenTableViewCell.self, forCellReuseIdentifier: reuseIdentifierTableViewCell)
    }
    
    func configureSelectProductsCategoryButton() {
        productListScreenHeaderView.selectProductsCategoryButton.addTarget(self, action: #selector(tapSelectProductsCategoryButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapSelectProductsCategoryButton(_ sender: Any?) {
        if isFilledProductsCategoryTextField() {
            loadProductListData()
        } else {
            self.showAttantionAlert(
                viewController: self,
                message: "You need to fill in the text field to upload the product list")
        }
    }
    
    func isFilledProductsCategoryTextField() -> Bool {
        if !(productListScreenHeaderView.selectProductsCategoryTextField.text?.isTrimmedEmpty ?? true) {
            return true
        } else { return false }
    }
    
    //MARK: - Interaction with Network
    func loadProductListData() {
        let getProductList = requestFactory.makeGetProductListRequestFactory()
        getProductList.getProductList(pageNumber: defaultPageNumber,
                                      idCategory: ((productListScreenHeaderView.selectProductsCategoryTextField.text ?? "1") as NSString).integerValue) { response in
            switch response.result {
            case .success(let getProductList):
                self.sendAnalyticsOpenProductListSuccess(productListCount: getProductList.productList.count)
                DispatchQueue.main.async {
                    self.productsArray = getProductList.productList
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.sendAnalyticsFailure(
                    failureName: "open_product_list_failure",
                    errorDescription: error.localizedDescription)
                Logger.viewCycle.debug("\(error.localizedDescription)")
            }
        }
    }
        
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        195.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return productListScreenHeaderView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        configureTableViewCell(indexPath: indexPath)
    }
    
    func configureTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableViewCell, for: indexPath) as? ProductListScreenTableViewCell
        guard let cell = tableViewCell else { return UITableViewCell() }
        cell.productIDLabel.text = "Product ID: \(productsArray[indexPath.row].productID)"
        cell.productNameLabel.text = "Name: \(productsArray[indexPath.row].productName)"
        cell.productPriceLabel.text = "Price: \(productsArray[indexPath.row].productPrice) \(currencyUnit)"
        cell.productQuantityInBasketLabel.text = "Quantity in basket: \(productsArray[indexPath.row].quantityInBasket)"
        cell.productDescriptionLabel.text = "Description: \(productsArray[indexPath.row].productDescription)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productScreenViewController = ProductScreenViewController(
            requestFactory: requestFactory,
            productID: productsArray[indexPath.row].productID,
            user: user)
        navigationController?.pushViewController(productScreenViewController, animated: true)
    }
}

//MARK: - Keyboard configuration
extension ProductListScreenViewController {
    func configureKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap))
        productListScreenHeaderView.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboardByTap() {
        productListScreenHeaderView.endEditing(true)
    }
}
