//
//  CryptoDataSourceImpl.swift
//  Crypto
//
//  Created by Daniil Gozhenko on 16.06.2022.
//

import Foundation

enum NetworkServiceError: Error{
    case badUrl, requestError, decodingError, statusNotOK
}

struct CryptoDataSourceImpl: CryptoDataSource {
    let API_KEY = "D81668B4-B26F-4F5A-A1B5-6C477AB36B7C"
    
    func getCryptoList(currency: String, previewMode: Bool) async throws -> Crypto {
        let urlString = "https://rest.coinapi.io/v1/exchangerate/\(currency)?invert=false&apikey=\(API_KEY)"
        
        guard let url = URL(string: urlString) else {
            throw NetworkServiceError.badUrl
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw NetworkServiceError.requestError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkServiceError.statusNotOK
        }
        
        guard let result = try? JSONDecoder().decode(CryptoResponse.self, from: data) else {
            throw NetworkServiceError.decodingError
        }
        
        return Crypto(id: result.asset_id_base, rates: result.rates.map({ item in
            Rate(
                time: item.time,
                shortCurrencyCode: item.asset_id_quote,
                rate: item.rate
            )
        }))
    }
}
