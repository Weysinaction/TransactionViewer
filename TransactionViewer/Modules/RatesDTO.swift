//
//  RatesDTO.swift
//  TransactionViewer
//
//  Created by Липатов Константин Евгеньевич on 17.09.2024.
//

import Foundation

struct RatesDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case from, rate, to
    }

    let from: String
    let rate: String
    let to: String
}
