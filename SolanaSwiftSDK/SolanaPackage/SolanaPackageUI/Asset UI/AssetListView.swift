//
//  AssetListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/13/25.
//

import SwiftUI

struct AssetListView: View {
    @State var viewModel: PresentableAssetViewModel
    let selection: (String) -> Void
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.model, id: \.id) { model in
                    SingleAssetSelectionCellView(asset: model, selection: { selection($0) })
                        .listRowSeparatorTint(.primary)
                }
            }
        }
    }
}

struct AssetListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AssetListTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Wallet List Test View")
        }
    }
    
    struct AssetListTestView: View {
        @State var selection: String = "none"
        
        var body: some View {
            VStack {
                AssetListView(
                    viewModel: .init(model: [
                        PresentableAsset(name: "SOL", price: "182.20", imageURL: "An Image URL"),
                        PresentableAsset(name: "BTC", price: "93081.11", imageURL: "An Image URL"),
                        PresentableAsset(name: "SHDW", price: "0.4779", imageURL: "An Image URL"),
                    ]),
                    selection: { selection = $0 })
                
                Text("Last selection: " + selection).padding()
            }
        }
    }
}
