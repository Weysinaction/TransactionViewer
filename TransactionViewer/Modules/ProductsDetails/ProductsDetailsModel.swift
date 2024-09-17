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
}

class ProductsDetailsModel {
    var transactionsByProduct: [ProductsDTO]?
    var rates: [RatesDTO]?

    init(transactionsByProduct: [ProductsDTO]?, rates: [RatesDTO]?) {
        self.transactionsByProduct = transactionsByProduct
        self.rates = rates
    }
}

extension ProductsDetailsModel: ProductsDetailsModelProtocol {
    func getTransactionsByProduct() -> [ProductsDTO]? {
        transactionsByProduct
    }

    func getRates() -> [RatesDTO]? {
        rates
    }
}
