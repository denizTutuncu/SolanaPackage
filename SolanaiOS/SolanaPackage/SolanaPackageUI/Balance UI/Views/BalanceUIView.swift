//
//  SolBalanceView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SolanaPackage
import SwiftUI
import Combine

public struct BalanceUIView: View {

    @State private var viewModel: BalanceViewModel
    
    public init(viewModel: BalanceViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        let screenSize = UIScreen.main.bounds.size
        VStack {
            Text("Solana")
                .font(Font.largeTitle)
                .bold()
                .padding()
            Text("\((viewModel.uiModel.balance?.lamports ?? 0) / 1000000000) SOL")
                .font(Font.title)
                .italic()
                .padding()
        }
        .frame(width: screenSize.width / 1.5, alignment: .center)
        .background(.purple)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

struct SolBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceUIView(viewModel: BalanceViewModel(remoteBalanceLoader: RemoteBalanceLoader(url: URL(string: SolanaClusterRPCEndpoints.devNet.rawValue), methodName: "getBalance", publicKey: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi", client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)))))
    }
}
