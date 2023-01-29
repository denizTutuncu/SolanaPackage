//
//  BalanceContainerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/20/23.
//

import SwiftUI

public struct BalanceContainerView: View {
    @State private var errorMessage: String
    @State private var progress: CGFloat
    @State private var title: String
    @State private var amount: String
    @State private var currencyName: String
    private let onHide: (() -> Void)?
    
    public init(errorMessage: String = "", progress: CGFloat = 0.0, title: String = "Balance", amount: String, currencyName: String, onHide: (() -> Void)?) {
        self.errorMessage = errorMessage
        self.progress = progress
        self.title = title
        self.amount = amount
        self.currencyName = currencyName
        self.onHide = onHide
    }
    
    public var body: some View {
        ZStack {
            ErrorView(message: errorMessage, onHide: onHide)
            LoadingView(progress: progress)
            BalanceView(title: title, amount: amount, currencyName: currencyName)
        }
    }
}

struct BalanceContainerView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceContainerView(amount: "100000000", currencyName: "lamports", onHide: { print("Trying again.") })
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Balance Container View")
    }
}
