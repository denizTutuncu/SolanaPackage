//
//  BalanceComposerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 7/1/22.
//

import SolanaPackage
import SwiftUI

public struct BalanceComposerView: View {
    
    @ObservedObject private var viewModel: BalanceViewModel
    
    private let balanceView: BalanceUIView
    private let errorView: BalanceUIErrorView
    private let loadingView: BalanceUILoadingView
    
    public init(viewModel: BalanceViewModel) {
        self.viewModel = viewModel
        self.balanceView = BalanceUIView(viewModel: viewModel)
        self.errorView = BalanceUIErrorView(errorMessage: "Any Error")
        self.loadingView = BalanceUILoadingView(title: "Loading Balance...")
    }
    
    public var body: some View {
        VStack {
            viewModel.uiModel.isLoading ? AnyView(self.loadingView) : (viewModel.uiModel.error != nil) ? AnyView(self.errorView) : AnyView(self.balanceView)
          
        }
        .onAppear(perform: {
            self.viewModel.loadBalance()
        })
    }
}

struct BalanceComposerView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceComposerView(viewModel:  BalanceViewModel(remoteBalanceLoader: RemoteBalanceLoader(url: URL(string: SolanaClusterRPCEndpoints.devNet.rawValue), methodName: "getBalance", publicKey: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi", client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)))))
    }
}
