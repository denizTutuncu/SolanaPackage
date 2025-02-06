//
//  AppNavigationView.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import SwiftUI
import SolanaPackageUI

class AppNavigationStore: ObservableObject {
    enum CurrentView {
        case onboarding(WalletSetupView)
        case walletList(WalletListView)
        case walletDetail(WalletDetailView)
        case exportSeed(ExportSeedView)
        case importSeed(ImportSeedView)
    }
    
    @Published var currentView: CurrentView?
    
    var view: AnyView {
        switch currentView {
        case let .onboarding(view): return AnyView(view)
        case let .walletList(view): return AnyView(view)
        case let .walletDetail(view): return AnyView(view)
        case let .exportSeed(view): return AnyView(view)
        case let .importSeed(view): return AnyView(view)
        case .none: return AnyView(EmptyView())
        }
    }
}

struct AppNavigationView: View {
    @ObservedObject var store: AppNavigationStore
    
    var body: some View {
        store.view
            .transition(
                AnyTransition
                    .opacity
                    .combined(with: .move(edge: .trailing))
            )
            .id(UUID())
    }
}

struct AppNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavigationView(store: AppNavigationStore())
    }
}
