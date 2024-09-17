//
//  ProductsDTO.swift
//  TransactionViewer
//
//  Created by Липатов Константин Евгеньевич on 17.09.2024.
//

import Foundation

struct ProductsDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case amount, currency, sku
    }

    let amount: String
    let currency: String
    let sku: String
}
