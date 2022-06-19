//
//  GetCryptoList.swift
//  Crypto
//
//  Created by Daniil Gozhenko on 16.06.2022.
//

import Foundation

enum UseCaseError: Error {
    case networkError, decodingError
}

// This protocol is never used, why?
protocol GetCryptoList {
    func execute(currency: String, previewMode: Bool) async -> Result<Crypto, UseCaseError>
}

// Question: What is the purpose of UseCase class? I see that it is just wrapping repository, what is the reason to use it?
struct GetCryptoListUseCase: GetCryptoList {
  // Question: Why repository is var?
    var repository: CryptoRepository
    
    func execute(currency: String, previewMode: Bool) async -> Result<Crypto, UseCaseError> {
        do {
            let cryptoList = try await repository.getCryptoList(currency: currency, previewMode: previewMode)
            return .success(cryptoList)
        } catch(let error) {
            switch (error) {
            case NetworkServiceError.decodingError:
                return .failure(.decodingError)
            default:
                return .failure(.networkError)
            }
        }
    }
}
