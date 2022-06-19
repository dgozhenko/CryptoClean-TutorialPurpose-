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
  // hardcoded API key, no comments, where is DI
    let API_KEY = "D81668B4-B26F-4F5A-A1B5-6C477AB36B7C"
    
    func getCryptoList(currency: String, previewMode: Bool) async throws -> Crypto {
      // hardcoded URL, no comments, where is DI
        let urlString = "https://rest.coinapi.io/v1/exchangerate/\(currency)?invert=false&apikey=\(API_KEY)"
        
        guard let url = URL(string: urlString) else {
          // you need to provide more meaningful information in such errors. At least you should provide string that caused the error
            throw NetworkServiceError.badUrl
        }

      // you should inject URLSession using DI, or even better: inject "abstract" network layer and create custom implementation of it

      // with try? URLSession.shared.data... you will not know what exact network error you get, it will be much harder to debug in case of the error
      // it is always better to provide more error information
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw NetworkServiceError.requestError
        }

      // Please read HTTP status codes list, == 200 is incorrect check for succees status code
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
          // what exactly is not ok? Is it 404 or 500 status code? Provide more meaningful info in error
            throw NetworkServiceError.statusNotOK
        }

      // Question: In which thread converting from JSON happened?

      // Same thing with try? JSONDecoder... You will not know what exactly went wrong during decoding, need to provide more info in error
        guard let result = try? JSONDecoder().decode(CryptoResponse.self, from: data) else {
            throw NetworkServiceError.decodingError
        }

      // Data provider shouldn't be responsible about mapping from JSON model to domain model
      // It is better to have separate entity for this
        return Crypto(id: result.asset_id_base, rates: result.rates.map({ item in
            Rate(
                time: item.time,
                shortCurrencyCode: item.asset_id_quote,
                rate: item.rate
            )
        }))
    }
}
