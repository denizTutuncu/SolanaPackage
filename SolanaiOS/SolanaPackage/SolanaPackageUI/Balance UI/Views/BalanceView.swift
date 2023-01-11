//
//  SolBalanceView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI
import SolanaPackage

public struct BalanceView: View {

    @State private var viewModel: BalanceViewModel
    
    public init(viewModel: BalanceViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        HStack {
            Text("\((viewModel.uiModel.balance?.lamports ?? 0) / 1000000000) SOL")
                .font(Font.title)
                .italic()
                .shadow(color: Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)), radius: 3)
        }
        .foregroundColor(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
        
        .padding()
    }
}

struct SolBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView(viewModel: BalanceViewModel(remoteBalanceLoader: RemoteBalanceLoader(url: URL(string: BalanceEndpoints.devNet.rawValue), publicAddress: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi", client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)))))
    }
}
