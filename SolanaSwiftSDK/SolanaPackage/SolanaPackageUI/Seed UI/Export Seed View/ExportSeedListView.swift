//
//  ExportSeedListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/18/23.
//

import SwiftUI

struct ExportSeedListView: View {
    @ObservedObject var viewModel: SeedListViewModel

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.model.indices, id: \.self) { index in
                    ExportSingleSeedCellView(
                        index: index + 1,
                        model: Binding(
                            get: { viewModel.model[index] },
                            set: { newValue in
                                viewModel.updateSeed(at: index, with: newValue)
                            }
                        )
                    )
                    .listRowSeparatorTint(.primary)
                }
            }
        }
    }
}

struct SeedListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SeedListTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Seed List Test View")
        }
    }
    
    struct SeedListTestView: View {
        @State var selection: [String] = []
        
        var body: some View {
            VStack {
                ExportSeedListView(viewModel: .init(model: [
                    PresentableSeed(value: "seed"),
                    PresentableSeed(value: "phrase"),
                    PresentableSeed(value: "important"),
                    PresentableSeed(value: "who"),
                    PresentableSeed(value: "has"),
                    PresentableSeed(value: "seed"),
                    PresentableSeed(value: "has"),
                    PresentableSeed(value: "access"),
                    PresentableSeed(value: "wallet"),
                    PresentableSeed(value: "secure"),
                    PresentableSeed(value: "crucial"),
                    PresentableSeed(value: "ownership"),
                    PresentableSeed(value: "must"),
                    PresentableSeed(value: "wkeepho"),
                    PresentableSeed(value: "offline"),
                    PresentableSeed(value: "physical"),
                    PresentableSeed(value: "share"),
                    PresentableSeed(value: "with"),
                    PresentableSeed(value: "love"),
                    PresentableSeed(value: "ones"),
                    PresentableSeed(value: "teach"),
                    PresentableSeed(value: "them"),
                    PresentableSeed(value: "early"),
                    PresentableSeed(value: "crypto")]))
                
            }
        }
    }
}
