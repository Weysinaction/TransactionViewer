//
//  ProductsDetailsAssembly.swift
//  TransactionViewer
//
//  Created by Липатов Константин Евгеньевич on 17.09.2024.
//

import Foundation
import UIKit

class ProductsDetailsAssembly {
    func createModule(transactionsByProduct: [ProductsDTO]?, rates: [RatesDTO]?) -> UIViewController {
        let model = ProductsDetailsModel(transactionsByProduct: transactionsByProduct, rates: rates)
        let presenter = ProductsDetailsPresenter(model: model)
        let viewController = ProductsDetailsViewController(presenter: presenter)
        presenter.viewController = viewController

        return viewController
    }
}
