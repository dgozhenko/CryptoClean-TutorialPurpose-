//
//  CryptoApp.swift
//  Crypto
//
//  Created by Daniil Gozhenko on 16.06.2022.
//

import SwiftUI

@main
struct CryptoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CryptoExchangeView()
            }
        }
    }
}
