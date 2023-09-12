//
//  PublicKeyListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import SwiftUI

struct PublicKeyListView: View {
    @State var viewModel: PublicKeyViewModel
    let selection: (String) -> Void
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.model, id: \.id) { model in
                    SinglePublicKeySelectionCellView(publicKey: model, selection: { selection($0) })
                        .listRowSeparatorTint(.primary)
                }
            }
        }
    }
}

struct PublicKeyListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PublicKeyListTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Wallet List Test View")
        }
    }
    
    struct PublicKeyListTestView: View {
        @State var selection: String = "none"
        
        var body: some View {
            VStack {
                PublicKeyListView(
                    viewModel: .init(model: [
                        "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                        "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                        "POhasdyasd454cxgcxT7yYUuyn6UgMJddBHKl21bhduA"
                    ]),
                    selection: { selection = $0 })
                
                Text("Last selection: " + selection).padding()
            }
        }
    }
}
