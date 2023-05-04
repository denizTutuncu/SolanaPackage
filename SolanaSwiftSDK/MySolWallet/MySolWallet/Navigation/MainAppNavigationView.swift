//
//  BankNavigationView.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import SwiftUI
import SolanaPackageUI

class MainAppNavigationStore: ObservableObject {
    enum CurrentView {
        case creation(CreationOptionView)
        case walletList(WalletListUIComposerView)
        case seed(WalletCreationComposerView)
    }
    
    @Published var currentView: CurrentView?
    
    var view: AnyView {
        switch currentView {
        case let .creation(view): return AnyView(view)
        case let .walletList(view): return AnyView(view)
        case let .seed(view): return AnyView(view)
        case .none: return AnyView(EmptyView())
        }
    }
}

struct MainAppNavigationView: View {
    @ObservedObject var store: MainAppNavigationStore
    
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

struct BankNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppNavigationView(store: MainAppNavigationStore())
    }
}
