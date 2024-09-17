//
//  ProductsDetailsModel.swift
//  TransactionViewer
//
//  Created by Липатов Константин Евгеньевич on 17.09.2024.
//

import Foundation

protocol ProductsDetailsModelProtocol {
    func getTransactionsByProduct() -> [ProductsDTO]?
    func getRates() -> [RatesDTO]?
    func setTotalAmount(amount: Float)
    func getTotalAmount() -> Float?
}

class ProductsDetailsModel {
    var transactionsByProduct: [ProductsDTO]?
    var rates: [RatesDTO]?
    private var totalAmount: Float?

    init(transactionsByProduct: [ProductsDTO]?, rates: [RatesDTO]?) {
        self.transactionsByProduct = transactionsByProduct
        self.rates = rates
    }
}

extension ProductsDetailsModel: ProductsDetailsModelProtocol {
    func setTotalAmount(amount: Float) {
        totalAmount = amount
    }

    func getTotalAmount() -> Float? {
        totalAmount
    }
    
    func getTransactionsByProduct() -> [ProductsDTO]? {
        transactionsByProduct
    }

    func getRates() -> [RatesDTO]? {
        rates
    }
}
