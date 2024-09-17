//
//  ProductsDetailsPresenter.swift
//  TransactionViewer
//
//  Created by Липатов Константин Евгеньевич on 17.09.2024.
//

import Foundation

protocol ProductsDetailsPresenterProtocol {
    var transactions: [ProductsDTO]? { get }
    func getConvertedValuesIfNeeded(indexPath: IndexPath) -> (inputAmount: String, convertedAmount: String)
    func viewDidLoad()
}

class ProductsDetailsPresenter {
    // MARK: - Public properties
    weak var viewController: ProductsDetailsViewControllerProtocol?

    // MARK: - Private properties
    private var model: ProductsDetailsModelProtocol

    // MARK: - Init
    init(model: ProductsDetailsModelProtocol) {
        self.model = model
    }

    // MARK: - Public methods
    func viewDidLoad() {
        getTotalAmount()
    }

    func getConvertedValuesIfNeeded(indexPath: IndexPath) -> (inputAmount: String, convertedAmount: String) {
        guard let transaction = transactions?[safe: indexPath.row] else { return ("", "") }

        let convertedAmount = transaction.currency == "GBP" ? transaction.amount : getConvertedAmount(transaction: transaction)
        let symbol = getSymbolByCurrency(currency: transaction.currency)

        return (symbol + transaction.amount, convertedAmount)
    }

    // MARK: - Private methods
    private func getTotalAmount() {
        guard let transactions else { return }

        var totalAmount: Float = 0.0
        transactions.forEach({ transaction in
            if transaction.currency == "GBP" {
                totalAmount += Float(transaction.amount) ?? 0.0
            } else {
                totalAmount += Float(getConvertedAmount(transaction: transaction)) ?? 0.0
            }
        })

        model.setTotalAmount(amount: totalAmount)
        viewController?.setTotalAmount(amount: "\(totalAmount)")
    }

    private func getSymbolByCurrency(currency: String) -> String {
        switch currency {
            case "GBP":
                return "£"
            case "USD":
                return "$"
            case "CAD":
                return "CA$"
            case "AUD":
                return "A$"
            default:
                return ""
        }
    }
    private func getConvertedAmount(transaction: ProductsDTO) -> String {
        guard let currencyRates = model.getRates() else { return "" }

        var currentRate: Float = 0.0
        var usdRate: Float = 1
        if let rate = currencyRates.first(where: { $0.from == transaction.currency && $0.to == "GBP" })?.rate {
            currentRate = Float(rate) ?? 0.0
        } else if let rate = currencyRates.first(where: { $0.from == transaction.currency && $0.to == "USD" })?.rate,
                  let rateForUsd = currencyRates.first(where: { $0.from == "USD" && $0.to == "GBP" })?.rate {
            currentRate = Float(rate) ?? 0.0
            usdRate = Float(rateForUsd) ?? 0.0
        }

        let convertedValue = (Float(transaction.amount) ?? 0.00) * currentRate * usdRate
        return String(format: "%.2f", convertedValue)
    }
}

// MARK: - ProductsDetailsPresenterProtocol
extension ProductsDetailsPresenter: ProductsDetailsPresenterProtocol {
    var transactions: [ProductsDTO]? {
        model.getTransactionsByProduct()
    }
}
