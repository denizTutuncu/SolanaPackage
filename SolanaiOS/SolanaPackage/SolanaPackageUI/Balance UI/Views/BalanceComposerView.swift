//
//  BalanceComposerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 7/1/22.
//

import SwiftUI

public struct BalanceComposerView: View {
    
    private let balanceView: BalanceView
    private let errorView: BalanceErrorView
    private let loadingView: BalanceLoadingView
    
    public init(balanceView: BalanceView, errorView: BalanceErrorView, loadingView: BalanceLoadingView) {
        self.balanceView = balanceView
        self.errorView = errorView
        self.loadingView = loadingView
    }
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
