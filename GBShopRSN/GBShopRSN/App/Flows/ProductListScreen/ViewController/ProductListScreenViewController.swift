//
//  ProductListScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 16.03.2021.
//

import UIKit

class ProductListScreenViewController: UITableViewController {
    // MARK: - UI components
    private lazy var productListScreenHeaderView: ProductListScreenHeaderView = {
        return ProductListScreenHeaderView()
    }()
    
    // MARK: - Properties
    private var productsArray: Array = [Product]()
    private let currencyUnit: String = "rub."
    private let reuseIdentifierTableViewCell = "ProductListScreenTableViewCell"
    private let requestFactory: RequestFactory
    
    // MARK: - Init
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
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
        if (!(productListScreenHeaderView.selectProductsCategoryTextField.text?.isTrimmedEmpty ?? true)) {
            loadProductListData()
        } else {
            print("You need to fill in all the fields for sign up")
        }
    }
    
    //MARK: - Interaction with Network
    func loadProductListData() {
        let getProductList = requestFactory.makeGetProductListRequestFactory()
        getProductList.getProductList(pageNumber: 1,
                                      idCategory: ((productListScreenHeaderView.selectProductsCategoryTextField.text ?? "1") as NSString).integerValue) { response in
            switch response.result {
            case .success(let getProductList):
                self.productsArray = getProductList.productList
                print(getProductList)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productsArray.count == 0 {
            return 0
        } else {
            return productsArray.count
        }
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
        guard let cell = tableViewCell else {
            print("Error with Cell")
            return UITableViewCell()
        }
        if productsArray.count != 0 {
            cell.productIDLabel.text = "Product ID: \(productsArray[indexPath.row].productID)"
            cell.productNameLabel.text = "Name: \(productsArray[indexPath.row].productName)"
            cell.productPriceLabel.text = "Price: \(productsArray[indexPath.row].productPrice) \(currencyUnit)"
            cell.productQuantityInBasketLabel.text = "Quantity in basket: \(productsArray[indexPath.row].quantityInBasket)"
            cell.productDescriptionLabel.text = "Description: \(productsArray[indexPath.row].productDescription)"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if productsArray.count != 0 {
            let productScreenViewController = ProductScreenViewController(requestFactory: requestFactory, productID: productsArray[indexPath.row].productID)
            navigationController?.pushViewController(productScreenViewController, animated: true)
        }
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
