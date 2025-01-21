//
//  AppInitializer.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 1/14/25.
//

import SwiftUI

struct AppInitializer: View {
    @StateObject private var viewModel: AppInitializerViewModel
    
    init(appStore: AppStore, navigationStore: AppNavigationStore) {
        _viewModel = StateObject(wrappedValue: AppInitializerViewModel(appStore: appStore, navigationStore: navigationStore))
    }
    
    var body: some View {
        AppNavigationView(store: viewModel.exposedNavigationStore)
            .onAppear {
                viewModel.initializeApp()
            }
    }
}
