//
//  ProvidedSeedListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 8/19/23.
//

import SwiftUI

struct ProvidedSeedListView: View {
    @State private var viewModel: SeedViewModel
    
    init(viewModel: SeedViewModel) {
        self.viewModel =  viewModel
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.model.indices, id: \.self) { index in
                    ProvidedSingleSeedCellView(index: (index + 1),
                                               model: $viewModel.model[index])
                    .listRowSeparatorTint(.primary)
                }
            }
        }
    }
}

struct ProvidedSeedListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProvidedSeedListTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Seed List Test View")
        }
    }
    
    struct ProvidedSeedListTestView: View {
        var body: some View {
            VStack {
                ProvidedSeedListView(viewModel: .init(model: ["seed",
                                                              "phrase",
                                                              "important",
                                                              "who",
                                                              "has",
                                                              "seed",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              ""],
                                                      handler: { _ in }))
                
            }
        }
    }
}
