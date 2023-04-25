//
//  WalletListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import SwiftUI

public struct WalletListView: View {
    
    @State public var viewModel: PublicKeyViewModel

    public let selection: (PresentablePublicKey) -> Void
    
    public var body: some View {
            List {
                ForEach(viewModel.publicKeys.indices, id: \.self) { i in
                    SinglePublicKeySelectionCellView(
                        wallet: $viewModel.publicKeys[i],
                        selection: { selection(viewModel.publicKeys[i].toggleSelection()) })
                }
            }
    }
}

struct WalletListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WalletListTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Wallet List Test View")
        }
    }
    
    struct WalletListTestView: View {
        @State var selection: String = "none"
        
        var body: some View {
            VStack {
                WalletListView(
                    viewModel: .init(publicKeys: [
                        PresentablePublicKey(id: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi"),
                        PresentablePublicKey(id: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD"),
                        PresentablePublicKey(id: "POhasdyasd454cxgcxT7yYUuyn6UgMJddBHKl21bhduA")
                    ], handler: { selection = $0.id }),
                    selection: { selection = $0.id })
                
                Text("Last selection: " + selection).padding()
            }
        }
    }
}
