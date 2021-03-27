//
//  BasketScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.03.2021.
//

import UIKit

class BasketScreenViewController: UITableViewController {
    // MARK: - UI components
    private lazy var basketScreenHeaderView: BasketScreenHeaderView = {
        return BasketScreenHeaderView()
    }()
    
    // MARK: - Properties
    private let requestFactory: RequestFactory
    private var productsInBasketArray: Array = [Product]()
    private let reuseIdentifierTableViewCell = "BasketScreenTableViewCell"
    private let currencyUnit: String = "rub."
    
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
        configurePayBasketButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBasketData()
        configureKeyboard()
    }
    
    //MARK: - Configuration Methods
    func configureViewController() {
        navigationController?.navigationBar.barTintColor = .white
        title = "Basket"
    }
    
    func configureTableView() {
        tableView.register(BasketScreenTableViewCell.self, forCellReuseIdentifier: reuseIdentifierTableViewCell)
    }
    
    func configurePayBasketButton() {
        basketScreenHeaderView.basketPayButton.addTarget(self, action: #selector(tapPayBasketButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapPayBasketButton(_ sender: UIButton) {
        if productsInBasketArray.count != 0 {
            payBasket(payAmount: calculatePayAmount())
        }
    }
    
    func calculatePayAmount() -> Int {
        var payAmount = 0
        productsInBasketArray.forEach { product in
            payAmount += product.productPrice
        }
        return payAmount
    }
    
    func configureDeleteFromBasketButton(button: UIButton) {
        button.addTarget(self, action: #selector(tapDeleteFromBasketButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapDeleteFromBasketButton(_ sender: UIButton) {
        deleteProductFromBasket(productID: sender.tag)
        productsInBasketArray = productsInBasketArray.filter{$0.productID != sender.tag}
        tableView.reloadData()
    }
    
    //MARK: - Interaction with Network
    func loadBasketData() {
        let getBasket = requestFactory.makeGetBasketRequestFactory()
        getBasket.getBasket(userID: 123) { response in
            switch response.result {
            case .success(let getBasket):
                print(getBasket)
                self.productsInBasketArray = getBasket.contents
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func payBasket(payAmount: Int) {
        let payBasket = requestFactory.makePayBasketRequestFactory()
        payBasket.payBasket(userID: 123, payAmount: payAmount) { response in
            switch response.result {
            case .success(let payBasket):
                print(payBasket)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //
    func deleteProductFromBasket(productID: Int) {
        let deleteFromBasket = requestFactory.makeDeleteFromBasketRequestFactory()
        deleteFromBasket.deleteFromBasket(productID: productID) { response in
            switch response.result {
            case .success(let deleteProductFromBasket):
                print(deleteProductFromBasket)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productsInBasketArray.count == 0 {
            return 0
        } else {
            return productsInBasketArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return basketScreenHeaderView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        configureTableViewCell(indexPath: indexPath)
    }
    
    func configureTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableViewCell, for: indexPath) as? BasketScreenTableViewCell
        guard let cell = tableViewCell else {
            print("Error with Cell")
            return UITableViewCell()
        }
        cell.basketProductIDLabel.text = "Product ID: \(productsInBasketArray[indexPath.row].productID)"
        cell.basketProductNameLabel.text = "Name: \(productsInBasketArray[indexPath.row].productName)"
        cell.basketProductPriceLabel.text = "Price: \(productsInBasketArray[indexPath.row].productPrice) \(currencyUnit)"
        cell.basketProductQuantityInBasketLabel.text = "Quantity in basket: \(productsInBasketArray[indexPath.row].quantityInBasket)"
        cell.basketProductDescriptionLabel.text = "Description: \(productsInBasketArray[indexPath.row].productDescription)"
        cell.basketDeleteButton.tag = productsInBasketArray[indexPath.row].productID
        configureDeleteFromBasketButton(button: cell.basketDeleteButton)
        return cell
    }
}

//MARK: - Keyboard configuration
extension BasketScreenViewController {
    func configureKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap))
        tableView.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboardByTap() {
        tableView.endEditing(true)
    }
}
