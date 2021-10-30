//
//  BasketScreenViewController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 26.03.2021.
//

import UIKit
import FirebaseAnalytics
import os.log

class BasketScreenViewController: UITableViewController, AnalyticsSendable, Alertable {
    // MARK: - UI components
    private lazy var basketScreenFooterView: BasketScreenFooterView = {
        return BasketScreenFooterView()
    }()
    
    // MARK: - Properties
    private let requestFactory: RequestFactory
    private let user: User
    private var productsInBasketArray: Array = [Product]()
    private var payAmount = 0
    private let reuseIdentifierTableViewCell = "BasketScreenTableViewCell"
    private let currencyUnit: String = "rub."
    
    // MARK: - Init
    init(requestFactory: RequestFactory, user: User) {
        self.requestFactory = requestFactory
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
    
    func updatePayBasketButtonText() {
        if productsInBasketArray.count == 0 {
            basketScreenFooterView.basketPayButton.setTitle("Basket is empty", for: .normal)
            basketScreenFooterView.basketPayButton.backgroundColor = .lightGray
        } else {
            basketScreenFooterView.basketPayButton.setTitle("Pay basket of \(calculatePayAmount()) rub.", for: .normal)
            basketScreenFooterView.basketPayButton.backgroundColor = .rsnLightGreenColor
        }
        self.payAmount = 0
    }
    
    func configurePayBasketButton() {
        basketScreenFooterView.basketPayButton.addTarget(self, action: #selector(tapPayBasketButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapPayBasketButton(_ sender: UIButton) {
        if productsInBasketArray.count != 0 {
            payBasket(payAmount: calculatePayAmount())
        } else {
            self.showAttantionAlert(
                viewController: self,
                message: "There are no purchases in your basket")
        }
    }
    
    func calculatePayAmount() -> Int {
        productsInBasketArray.forEach { product in
            payAmount += (product.productPrice * product.quantityInBasket)
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
        getBasket.getBasket(userID: user.userID) { response in
            switch response.result {
            case .success(let getBasket):
                self.sendAnalyticsGetBasketSuccess(
                    userID: self.user.userID,
                    amount: getBasket.amount,
                    typeOfGoodsCount: getBasket.countGoods)
                DispatchQueue.main.async {
                    self.productsInBasketArray = getBasket.contents
                    self.updatePayBasketButtonText()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.sendAnalyticsFailure(
                    failureName: "get_basket_failure",
                    errorDescription: error.localizedDescription)
                Logger.viewCycle.debug("\(error.localizedDescription)")
            }
        }
    }
    
    func payBasket(payAmount: Int) {
        let payBasket = requestFactory.makePayBasketRequestFactory()
        payBasket.payBasket(userID: user.userID, payAmount: payAmount) { response in
            switch response.result {
            case .success(let payBasket):
                self.sendAnalyticsPayBasketSuccess(
                    userID: self.user.userID,
                    payAmount: payAmount,
                    accountBalance: payBasket.accountBalance)
                DispatchQueue.main.async {
                    if payBasket.result == 1 {
                        self.showAttantionAlert(
                            viewController: self,
                            message: "You paid for purchases\nin the amount of \(payAmount) rub.\nNow your balance is \(payBasket.accountBalance) rub.")
                        self.updatePayBasketButtonText()
                        self.tableView.reloadData()
                    } else {
                        self.showAttantionAlert(
                            viewController: self,
                            message: "You don't have enough money to pay for items in your basket")
                    }
                }
                self.payAmount = 0
            case .failure(let error):
                self.sendAnalyticsFailure(
                    failureName: "pay_basket_failure",
                    errorDescription: error.localizedDescription)
                Logger.viewCycle.debug("\(error.localizedDescription)")
            }
        }
    }
    
    func deleteProductFromBasket(productID: Int) {
        let deleteFromBasket = requestFactory.makeDeleteFromBasketRequestFactory()
        deleteFromBasket.deleteFromBasket(deletedProductID: productID) { response in
            switch response.result {
            case .success(let deleteProductFromBasket):
                self.sendAnalyticsDeleteFromBasketSuccess(
                    deletedProductID: deleteProductFromBasket.deletedProductID,
                    deletedProductQuantityInBasket: deleteProductFromBasket.deletedProductQuantityInBasket)
                DispatchQueue.main.async {
                    self.updatePayBasketButtonText()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.sendAnalyticsFailure(
                    failureName: "delete_from_basket_failure",
                    errorDescription: error.localizedDescription)
                Logger.viewCycle.debug("\(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsInBasketArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        60.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250.0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return basketScreenFooterView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        configureTableViewCell(indexPath: indexPath)
    }
    
    func configureTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableViewCell, for: indexPath) as? BasketScreenTableViewCell
        guard let cell = tableViewCell else { return UITableViewCell() }
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
