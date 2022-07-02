//
//  SolBalanceView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SolanaPackage
import SwiftUI

public struct BalanceUIView: View {

    @State private var viewModel: BalanceViewModel
    
    public init(viewModel: BalanceViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        HStack {
            Text("\((viewModel.uiModel.balance?.lamports ?? 0) / 1000000000) SOL")
                .font(Font.title)
                .italic()
                .shadow(color: .white, radius: 5)
        }
        .foregroundColor(.white)
        .fixedSize()
        .padding()
    }
}

struct SolBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceUIView(viewModel: BalanceViewModel(remoteBalanceLoader: RemoteBalanceLoader(url: URL(string: SolanaClusterRPCEndpoints.devNet.rawValue), publicAddress: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi", client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)))))
    }
}
