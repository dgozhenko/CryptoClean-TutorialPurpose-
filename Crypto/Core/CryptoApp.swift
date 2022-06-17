//
//  CryptoApp.swift
//  Crypto
//
//  Created by Daniil Gozhenko on 16.06.2022.
//

import SwiftUI

// Question: Where is .gitignore?
// Question: Where is formatters and linters?
// Question: What is `-` at the end of project name?
// Question: In commit bbcfe91ecdeceee4408ffc1c761eca3a30f9b563 you added references to files CryptoExchangeView.swift, CryptoExchangeViewModel.swift and others to the project, but not files itself. Why? How you can "split" big changes into few commits? How can you deal with pbxproj file problem?

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
