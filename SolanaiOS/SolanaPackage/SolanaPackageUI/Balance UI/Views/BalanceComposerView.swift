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
    
    private let balanceView: BalanceView
    private let errorView: BalanceErrorView
    private let loadingView: LoadingView
    
    public init(viewModel: BalanceViewModel) {
        self.viewModel = viewModel
        self.balanceView = BalanceView(viewModel: viewModel)
        self.errorView = BalanceErrorView(viewModel: viewModel)
        self.loadingView = LoadingView(title: viewModel.loadingTitle)
    }
    
    public var body: some View {
        let screenSize = UIScreen.main.bounds.size
        HStack(alignment: .center, spacing: 0) {
            
            Text("\(viewModel.labelTitle)")
                .font(Font.headline)
                .bold()
                .padding()
                .foregroundColor(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                Spacer()
            viewModel.uiModel.isLoading ? AnyView(self.loadingView) : (viewModel.uiModel.error != nil) ? AnyView(self.errorView) : AnyView(self.balanceView)
        }
        .onAppear(perform: {
            self.viewModel.loadBalance()
        })
        .frame(width: screenSize.width / 1.2, height: screenSize.height / 10, alignment: .center)
        .background(Color(#colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)))
        .cornerRadius(8)
    }
}

struct BalanceComposerView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceComposerView(viewModel:  BalanceViewModel(remoteBalanceLoader: RemoteBalanceLoader(url: URL(string: SolanaClusterRPCEndpoints.devNet.rawValue), publicAddress: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi", client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)))))
    }
}
