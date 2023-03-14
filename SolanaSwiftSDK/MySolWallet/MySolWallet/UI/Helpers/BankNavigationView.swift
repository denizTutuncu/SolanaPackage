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
        case wallet(WalletView)
        case seed(SeedListView)
    }
    
    @Published var currentView: CurrentView?
    
    var view: AnyView {
        switch currentView {
        case let .wallet(view): return AnyView(view)
        case let .seed(view): return AnyView(view)
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
