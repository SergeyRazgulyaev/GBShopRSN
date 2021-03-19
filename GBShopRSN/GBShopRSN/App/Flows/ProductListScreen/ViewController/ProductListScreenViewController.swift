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
    private let reuseIdentifierTableViewCell = "TableViewCell"
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
        configureTableView()
        configureSelectProductsCategoryButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardAddObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardRemoveObserver()
    }

    //MARK: - Configuration Methods
    func configureTableView() {
        tableView.register(ProductListScreenTableViewCell.self, forCellReuseIdentifier: reuseIdentifierTableViewCell)
        navigationController?.navigationBar.barTintColor = .white
        title = "Product list"
    }
    
    //MARK: - Interaction with Network
    func loadData() {
        let getProductList = requestFactory.makeGetProductListRequestFactory()
        getProductList.getProductList(pageNumber: 1,
                                      idCategory: ((productListScreenHeaderView.selectProductsCategoryTextField.text ?? "1") as NSString).integerValue) { response in
            switch response.result {
            case .success(let getProductList):
                self.productsArray = getProductList.productList
                print(getProductList)
                print(self.productsArray)
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
            return 1
        } else {
            return productsArray.count
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150.0
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
    
    func configureSelectProductsCategoryButton() {
        productListScreenHeaderView.selectProductsCategoryButton.addTarget(self, action: #selector(tapSelectProductsCategoryButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapSelectProductsCategoryButton(_ sender: Any?) {
        if (!(productListScreenHeaderView.selectProductsCategoryTextField.text?.isTrimmedEmpty ?? true)) {
            loadData()
        } else {
            print("You need to fill in all the fields for sign up")
        }
    }
}

//MARK: - Keyboard configuration
extension ProductListScreenViewController {
    func keyboardAddObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tableView.addGestureRecognizer(tapGesture)
    }
    
    func keyboardRemoveObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let keyboardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        tableView.contentInset = UIEdgeInsets.zero
        tableView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc func hideKeyboard() {
        tableView.endEditing(true)
    }
}
