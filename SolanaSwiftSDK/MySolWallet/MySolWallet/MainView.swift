//
//  MainView.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 1/28/23.
//

import SwiftUI
import SolanaPackageUI

struct MainView: View {
    @Binding var hasWallet: Bool
    
    var body: some View {
        (self.hasWallet) ?
        AnyView(BalanceContainerView(result: .success("100000000"), title: "Balance", currencyName: "SOL", onHide: {}))
        :
        AnyView(Button(action: {
            
        }, label: {
            Text("Create Wallet").padding()
        }))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView(hasWallet: .constant(true))
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Main View with No Wallet")
            
            MainView(hasWallet: .constant(false))
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Main View With Wallet")
        }
    }
}
