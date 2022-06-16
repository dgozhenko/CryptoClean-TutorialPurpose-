//
//  Crypto.swift
//  Crypto
//
//  Created by Daniil Gozhenko on 16.06.2022.
//

import Foundation

struct CryptoResponse: Codable {
    let asset_id_base: String
    let rates: [RateResponse]
}

struct RateResponse: Codable, Identifiable {
    let id = UUID()
    let time: String
    let asset_id_quote: String
    let rate: Double
}

