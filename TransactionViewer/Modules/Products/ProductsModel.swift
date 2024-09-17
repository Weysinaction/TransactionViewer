//
//  ProductsModel.swift
//  TransactionViewer
//
//  Created by Липатов Константин Евгеньевич on 17.09.2024.
//

import Foundation

protocol ProductsModelProtocol {
    func getProducts() -> [ProductsDTO]?
    func setProducts(products: [ProductsDTO])
    func getProductsNames() -> [String]?
    func setProductsNames(productsNames: [String])
    func getRates() -> [RatesDTO]?
    func setRates(rates: [RatesDTO])
}

class ProductsModel {
    private var products: [ProductsDTO]?
    private var productsNames: [String]?
    private var rates: [RatesDTO]?
}

extension ProductsModel: ProductsModelProtocol {
    func getProducts() -> [ProductsDTO]? {
        return products
    }

    func setProducts(products: [ProductsDTO]) {
        self.products = products
    }

    func getProductsNames() -> [String]? {
        return productsNames
    }

    func setProductsNames(productsNames: [String]) {
        self.productsNames = productsNames
    }

    func getRates() -> [RatesDTO]? {
        return rates
    }

    func setRates(rates: [RatesDTO]) {
        self.rates = rates
    }
}
