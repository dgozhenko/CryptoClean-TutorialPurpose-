//
//  CryptoExchangeViewModel.swift
//  Crypto
//
//  Created by Daniil Gozhenko on 16.06.2022.
//

import Foundation
import SwiftUI

// ViewModel naming is not good

// Question: Why do you need @MainActor for the view model?

    @MainActor
    class ViewModel: ObservableObject {
      // very bad practice to provide dependencies explicitly
      // Question: Why it is bad? What should you do here?

      // Why you are initializing explicit entity here (GetCryptoListUseCase) instead of defining it as protocol GetCryptoList?
        var getCryptoListUseCase = GetCryptoListUseCase(repository: CryptoRepositoryImpl(dataSource: CryptoDataSourceImpl()))
        
        @Published var rates = [Rate]()
        @Published var searchText = ""
      // Using Double for amount is bad idea. You should use Decimal (see my another similar not with explanation)
        @Published var amount: Double = 100
      // you have 3 variables to maintain state and it is easy to mess up state
      // for example: errorMessage = "Some error", hasError = true, loading = true
      // how UI will look like in such case?
      // Question: How you can improve state management in view model and refactor this code?
      // Question: What protection level you should define for state variables?
        @Published var errorMessage = ""
        @Published var hasError = false
        @Published var loading = false
        
        var filteredRates: [Rate] {
          // better to check .isEmpty
            return searchText == "" ? rates : rates.filter {
              // here you are "hardcoding" knowledge that shortCurrencyCode is coming as uppercased from the network
              // what if you will filter shortCurrencyCode somewhere else and you will forget about this?
              // Question: In which ways you can solve problem with uppercase/lowercase?
                $0.shortCurrencyCode.contains(searchText.uppercased())
            }
        }
        
        func calculateRate(rate: Rate) -> Double {
            return amount * rate.rate
        }
        
        func refreshData() async {
            loading = true
            errorMessage = ""
          // why EUR is hardcoded?
            let result = await getCryptoListUseCase.execute(currency: "EUR", previewMode: false)
            switch result {
            case .success(let cryptoList):
              // Question: Why your view model has knowledge about UI layer here?
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
