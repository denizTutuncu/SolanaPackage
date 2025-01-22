//
//  ImportSeedListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 8/19/23.
//

import SwiftUI

struct ImportSeedListView: View {
    @ObservedObject private var viewModel: SeedListViewModel

    init(viewModel: SeedListViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        List {
            ForEach(viewModel.model.indices, id: \..self) { index in
                ImportSingleSeedCellView(index: index, model: $viewModel.model[index])
                    .listRowSeparatorTint(.primary)
            }
        }
    }
}


struct ProvidedSeedListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProvidedSeedListTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Import Seed List Test View")
        }
    }
    
    struct ProvidedSeedListTestView: View {
        var body: some View {
            VStack {
                ImportSeedListView(viewModel: .init(model: [PresentableSeed(value: "seed"),
                                                              PresentableSeed(value: "phrase"),
                                                              PresentableSeed(value: "important"),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: ""),
                                                              PresentableSeed(value: "")]))
            }
        }
    }
}
