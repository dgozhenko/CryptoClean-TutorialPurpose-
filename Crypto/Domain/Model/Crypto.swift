//
//  Crypto.swift
//  Crypto
//
//  Created by Daniil Gozhenko on 16.06.2022.
//

import Foundation

struct Crypto: Identifiable {
    let id: String
    let rates: [Rate]
}

struct Rate: Decodable, Identifiable {
    let id = UUID()
    let time: String
    let shortCurrencyCode: String
    let rate: Double

  // this way of random data generation is ok for very MVP,
  // but later it is better to move it to the separate class MockRatesGenerator or SampleRatesGenerator
    static var sampleRates: [Rate] {
        var tempRates = [Rate]()
        for _ in 1...20 {
          // Question: how you can make it much more efficient rather than generating array of 1000 elements and choosing random item out of it?
            let randomNumber = Double(Array(0...1000).randomElement()!)
            let randomCurrency = ["BTC", "ETH", "LOL", "XPR", "WTF"].randomElement()!
            
            let sampleRates = Rate(time: "0328197'30218", shortCurrencyCode: randomCurrency, rate: randomNumber)
          // Question: what is time complexity of inserting element at first position of array?
            tempRates.insert(sampleRates, at: 0)
        }
        return tempRates
    }
}
