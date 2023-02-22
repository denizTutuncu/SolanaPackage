//
//  BankNavigationView.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import SwiftUI
import SolanaPackageUI

class BankNavigationStore: ObservableObject {
    enum CurrentView {
        case balance(BalanceView)
        case createWallet(CreateWalletButton)
    }
    
    @Published var currentView: CurrentView?
    
    var view: AnyView {
        switch currentView {
        case let .balance(view): return AnyView(view)
        case let .createWallet(view): return AnyView(view)
        case .none: return AnyView(EmptyView())
        }
    }
}

struct BankNavigationView: View {
    @ObservedObject var store: BankNavigationStore
    
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
        BankNavigationView(store: BankNavigationStore())
    }
}
