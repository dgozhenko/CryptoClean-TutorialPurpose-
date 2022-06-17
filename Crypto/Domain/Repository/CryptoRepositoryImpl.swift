//
//  CryptoRepositoryImpl.swift
//  Crypto
//
//  Created by Daniil Gozhenko on 16.06.2022.
//

import Foundation

struct CryptoRepositoryImpl: CryptoRepository {
  // why this property declared as var?=
    var dataSource: CryptoDataSource
    
    func getCryptoList(currency: String, previewMode: Bool) async throws -> Crypto {
        let cryptoList = try await dataSource.getCryptoList(currency: currency, previewMode: previewMode)
        return cryptoList
    }
}
