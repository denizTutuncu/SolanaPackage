//
//  MySolWalletApp.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI

@main
struct MySolWalletApp: App {
    // Create instances of AppStore and AppNavigationStore
    private let appStore = AppStore()
    private let navigationStore = AppNavigationStore()
    
    var body: some Scene {
        WindowGroup {
            // Initialize the root view with AppInitializer
            AppInitializer(appStore: appStore, navigationStore: navigationStore)
        }
    }
}
