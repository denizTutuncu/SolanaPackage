//
//  BalanceLoadingView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/16/23.
//

import SwiftUI

struct BalanceErrorComposerView: View {
    let errorMessage: String
    let tryAgain: () -> Void
    @State var balance: String?
    
    var body: some View {
        if balance != nil {
            BalanceView(balance: balance!)
        } else {
            ErrorView(message: errorMessage, onHide: tryAgain)
        }
    }
}

struct BalanceErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BalanceErrorTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Balance Loading Test View")
        }
    }
}

struct BalanceErrorTestView: View {
    
    var body: some View {
        VStack {
            BalanceErrorComposerView(
                errorMessage: "Couldn't connect to network.",
                tryAgain: { },
                balance: nil)
            
            BalanceErrorComposerView(
                errorMessage: "Couldn't connect to network.",
                tryAgain: { },
                balance: "10000000000.0000")
        }
    }
}
