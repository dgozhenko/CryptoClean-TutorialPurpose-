//
//  CryptoDataSource.swift
//  Crypto
//
//  Created by Daniil Gozhenko on 16.06.2022.
//

import Foundation

protocol CryptoDataSource {
    func getCryptoList(currency: String, previewMode: Bool) async throws -> Crypto
}
