//
//  MySolWalletApp.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI

@main
struct MySolWalletApp: App {
    private let appStore = AppStore()
    private let navigationStore = AppNavigationStore()
    
    var body: some Scene {
        WindowGroup {
            AppInitializer(appStore: appStore, navigationStore: navigationStore)
        }
    }
}
