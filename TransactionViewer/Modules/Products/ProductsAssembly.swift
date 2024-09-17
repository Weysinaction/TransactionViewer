//
//  ProductsAssembly.swift
//  TransactionViewer
//
//  Created by Липатов Константин Евгеньевич on 17.09.2024.
//

import Foundation
import UIKit

class ProductsAssembly {
    func createModule() -> UIViewController {
        let model = ProductsModel()
        let presenter = ProductsPresenter(model: model)
        let viewController = ProductsViewController(presenter: presenter)

        return viewController
    }
}
