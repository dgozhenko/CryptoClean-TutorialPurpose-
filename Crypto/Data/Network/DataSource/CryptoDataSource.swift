//
//  CryptoDataSource.swift
//  Crypto
//
//  Created by Daniil Gozhenko on 16.06.2022.
//

import Foundation

// Data source will be very bad naming for this entity because you will always mess it with UITableView data source
protocol CryptoDataSource {
  // What is previewMode? It sounds something like from UI layer (which shouldn't be there), I see that it is not used nowhere
    func getCryptoList(currency: String, previewMode: Bool) async throws -> Crypto
}
