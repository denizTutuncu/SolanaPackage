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
    private let errorView: ErrorView
    private let loadingView: LoadingView
    
    public init(viewModel: BalanceViewModel) {
        self.viewModel = viewModel
        self.balanceView = BalanceUIView(viewModel: viewModel)
        self.errorView = ErrorView(error: viewModel.uiModel.error)
        self.loadingView = LoadingView(title: viewModel.loadingTitle)
    }
    
    public var body: some View {
        let screenSize = UIScreen.main.bounds.size
        HStack(alignment: .center, spacing: 0) {
            Text("\(viewModel.labelTitle)")
                .font(Font.headline)
                .bold()
                .padding()
                
            viewModel.uiModel.isLoading ? AnyView(self.loadingView) : (viewModel.uiModel.error != nil) ? AnyView(self.errorView) : AnyView(self.balanceView)
        }
        .onAppear(perform: {
            self.viewModel.loadBalance()
        })
        .frame(width: screenSize.width / 1.2, height: screenSize.height / 10, alignment: .center)
        .background(.purple)
        .foregroundColor(.white)
        .cornerRadius(8)
        .shadow(color: .purple, radius: 5)
    }
}

struct BalanceComposerView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceComposerView(viewModel:  BalanceViewModel(remoteBalanceLoader: RemoteBalanceLoader(url: URL(string: SolanaClusterRPCEndpoints.devNet.rawValue), publicKey: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi", client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)))))
    }
}
