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
    func getConvertedValuesIfNeeded(indexPath: IndexPath) -> (inputAmount: String, convertedAmount: String) {
        guard let transaction = transactions?[safe: indexPath.row] else { return ("", "") }

        var convertedAmount = transaction.currency == "GBP" ? transaction.amount : getConvertedAmount(transaction: transaction)
        let symbol = getSymbolByCurrency(currency: transaction.currency)
        return (symbol + transaction.amount, convertedAmount)
    }

    // MARK: - Private methods
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
        guard let currencyRates = model.getRates(),
              let currentRate = currencyRates.first(where: { $0.from == transaction.currency && $0.to == "GBP" })?.rate else {
            return ""
        }

        let convertedValue = (Float(transaction.amount) ?? 0.00) * (Float(currentRate) ?? 0.00)
        return String(format: "%.2f", convertedValue)
    }
}

// MARK: - ProductsDetailsPresenterProtocol
extension ProductsDetailsPresenter: ProductsDetailsPresenterProtocol {
    var transactions: [ProductsDTO]? {
        model.getTransactionsByProduct()
    }
}
