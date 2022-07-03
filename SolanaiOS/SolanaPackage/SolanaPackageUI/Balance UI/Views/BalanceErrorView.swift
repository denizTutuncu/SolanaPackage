//
//  BalanceErrorView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI
import SolanaPackage

public struct BalanceErrorView: View {
    @State private var viewModel: BalanceViewModel
    
    public init(viewModel: BalanceViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        VStack {
            Text(viewModel.uiModel.error?.localizedDescription ?? "Error occurred")
                .padding()
                .lineLimit(nil)
                .minimumScaleFactor(0.55)
                .foregroundColor(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
        }
    }
}

struct BalanceErrorView_Previews: PreviewProvider {
    enum Error: Swift.Error {
        case fakeError
    }
    static var previews: some View {
        BalanceErrorView(viewModel: BalanceViewModel(remoteBalanceLoader: RemoteBalanceLoader(url: URL(string: SolanaClusterRPCEndpoints.devNet.rawValue), publicAddress: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi", client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)))))
    }
}
