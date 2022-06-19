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
    
    static var sampleRates: [Rate] {
        var tempRates = [Rate]()
        for _ in 1...20 {
            let randomNumber = Double(Array(0...1000).randomElement()!)
            let randomCurrency = ["BTC", "ETH", "LOL", "XPR", "WTF"].randomElement()!
            
            let sampleRates = Rate(time: "0328197'30218", shortCurrencyCode: randomCurrency, rate: randomNumber)
            tempRates.insert(sampleRates, at: 0)
        }
        return tempRates
    }
}
