//
//  MySolWalletApp.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI
import SolanaPackage

@main
struct MySolWalletApp: App {
    let appStore = MainAppStore()
    
    @StateObject var navigationStore = MainAppNavigationStore()
    
    var body: some Scene {
        WindowGroup {
            MainAppNavigationView(store: navigationStore)
                .onAppear{ startBank() }
        }
    }
    
    private func startBank() {
        let adapter = iOSSwiftUINavigationAdapter(navigation: navigationStore,
                                                  publicKeyPublisher:  appStore.makeLocalPublicKeyPublisher(),
                                                  seedPublisher: appStore.makeLocalSeedPublisher())
        
        appStore.mainApp = MainApp.start(publickeys: [],
                                         seed: [],
                                         delegate: adapter)
    }
}   
