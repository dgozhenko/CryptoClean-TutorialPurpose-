//
//  CryptoRepository.swift
//  Crypto
//
//  Created by Daniil Gozhenko on 16.06.2022.
//

import Foundation

protocol CryptoRepository {
  // what is preview mode? It sounds like something related to UI or to mock data
  // Question: How you can avoid of passing such Bool variable and have 2 repositories (one with mock data and other with real data)?
    func getCryptoList(currency: String, previewMode: Bool) async throws -> Crypto
}
