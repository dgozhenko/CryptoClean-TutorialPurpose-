//
//  Crypto.swift
//  Crypto
//
//  Created by Daniil Gozhenko on 16.06.2022.
//

import Foundation

struct CryptoResponse: Codable {
  // not following naming conventions: use custom CodingKey and normal property name
    let asset_id_base: String
    let rates: [RateResponse]
}

struct RateResponse: Codable, Identifiable {
    let id = UUID()
    let time: String
  // not following naming conventions: use custom CodingKey and normal property name
    let asset_id_quote: String
  // never use Double type for money
  // why: https://www.dropbox.com/s/xto7c1fqve5312l/Issue%20with%20using%20Double.pdf?dl=0
  // Only Decimal or Int (count coins, without decimal part, for example: 2.05 -> 205 if you will use Int)
    let rate: Double
}

