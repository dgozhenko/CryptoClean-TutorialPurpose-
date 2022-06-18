//
//  CryptoExchangeViewModel.swift
//  Crypto
//
//  Created by Daniil Gozhenko on 16.06.2022.
//

import Foundation
import SwiftUI
    
    @MainActor
    class ViewModel: ObservableObject {
        var getCryptoListUseCase = GetCryptoListUseCase(repository: CryptoRepositoryImpl(dataSource: CryptoDataSourceImpl()))
        
        @Published var rates = [Rate]()
        @Published var searchText = ""
        @Published var amount: Double = 100
        @Published var errorMessage = ""
        @Published var hasError = false
        @Published var loading = false
        
        var filteredRates: [Rate] {
            return searchText == "" ? rates : rates.filter {
                $0.shortCurrencyCode.contains(searchText.uppercased())
            }
        }
        
        func calculateRate(rate: Rate) -> Double {
            return amount * rate.rate
        }
        
        func refreshData() async {
            loading = true
            errorMessage = ""
            let result = await getCryptoListUseCase.execute(currency: "EUR", previewMode: false)
            switch result {
            case .success(let cryptoList):
                withAnimation {
                    self.rates = cryptoList.rates
                }
                loading = false
            case .failure(let error):
                self.rates = Rate.sampleRates
                errorMessage = error.localizedDescription
                hasError = true
                loading = false
            }
        }
    }
