//
//  CryptoRepository.swift
//  Crypto
//
//  Created by Daniil Gozhenko on 16.06.2022.
//

import Foundation

protocol CryptoRepository {
    
    func getCryptoList(currency: String, previewMode: Bool) async throws -> Crypto
}
