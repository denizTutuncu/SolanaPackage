//
//  MainView.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 1/28/23.
//

import SwiftUI
import SolanaPackageUI

struct MainView: View {
    @Binding private var hasWallet: Bool
    private let mainContainer: () -> AnyView?
    private let createWalletContainer: () -> AnyView?
    
    init(hasWallet: Binding<Bool>, mainContainer: @escaping () -> AnyView?, createWalletContainer: @escaping () -> AnyView?) {
        self._hasWallet = hasWallet
        self.mainContainer = mainContainer
        self.createWalletContainer = createWalletContainer
    }
    
    var body: some View {
        (hasWallet) ? AnyView(mainContainer()) : AnyView(createWalletContainer())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            MainView(hasWallet: .constant(true),
//                     mainContainer: { AnyView(BalanceContainerView(result: .success("21739000000000"), title: "Balance", currencyName: "lamports", progress: 0.7, total: 1.0, onHide: {}))},
//                     createWalletContainer: { nil })
//            .previewLayout(.sizeThatFits)
//            .previewDisplayName("Main View with a wallet")
//            
//            MainView(hasWallet: .constant(false),
//                     mainContainer: { nil },
//                     createWalletContainer: { AnyView(
//                        Button(action: {
//                            
//                        }, label: {
//                            Text("Create Wallet").padding()
//                        })) })
//            .previewLayout(.sizeThatFits)
//            .previewDisplayName("Main View without a wallet")
        }
    }
}
