//
//  ProductsPresenter.swift
//  TransactionViewer
//
//  Created by Липатов Константин Евгеньевич on 17.09.2024.
//

import Foundation

protocol ProductsPresenterProtocol {
    var products: [String] { get }
    func viewDidLoad()
    func getTransactionCountForProduct(productName: String) -> Int?
}

class ProductsPresenter: ProductsPresenterProtocol {
    // MARK: - Public properties
    var model: ProductsModelProtocol
    var products: [String] {
        model.getProductsNames() ?? []
    }

    // MARK: - init
    init(model: ProductsModelProtocol) {
        self.model = model
    }

    // MARK: - Public methods
    func viewDidLoad() {
        getRates()
        getProducts()
    }

    func getTransactionCountForProduct(productName: String) -> Int? {
        guard let products = model.getProducts() else { return nil }

        return products.filter({ $0.sku == productName }).count
    }

    // MARK: - Private methods
    private func getRates() {
        let url = Bundle.main.url(forResource: "rates", withExtension: "plist")!
        do {
            let data = try Data(contentsOf: url)
            let rates = try PropertyListDecoder().decode([RatesDTO].self, from: data)
            model.setRates(rates: rates)
        } catch {

        }
    }

    private func getProducts() {
        let url = Bundle.main.url(forResource: "transactions", withExtension: "plist")!
        do {
            let data = try Data(contentsOf: url)
            let transactions = try PropertyListDecoder().decode([ProductsDTO].self, from: data)
            model.setProducts(products: transactions)
            model.setProductsNames(productsNames: getProductsNames(transactions: transactions))
        } catch {

        }
    }

    private func getProductsNames(transactions: [ProductsDTO]) -> [String] {
        var set: Set<String> = []
        transactions.forEach({ transaction in
            set.insert(transaction.sku)
        })

        return Array(set)
    }
}

