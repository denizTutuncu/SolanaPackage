//
//  MainView.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 1/28/23.
//

import SwiftUI
import SolanaPackageUI

public struct Wallet {
    public let address: String?
}

public final class WalletViewModel: ObservableObject {
    @Published public var wallet: Wallet?
}

struct MainView: View {
    @ObservedObject var walletViewModel: WalletViewModel
    
    var body: some View {
        (walletViewModel.wallet != nil) ?
        AnyView(BalanceContainerView(result: .success("100000000"), title: "Balance", currencyName: "SOL", onHide: {}))
        :
        AnyView(Button(action: {
            
        }, label: {
            Text("Create Wallet")
        }))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView(walletViewModel: WalletViewModel())
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Main View")
        }
    }
}
