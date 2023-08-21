//
//  SeedListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/18/23.
//

import SwiftUI

struct SeedListView: View {
    @Binding var viewModel: SeedViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.model.indices, id: \.self) { index in
                    SingleSeedCellView(index: (index + 1),
                                       model: $viewModel.model[index])
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
                SeedListView(viewModel: .constant(.init(model: ["seed",
                                                                "phrase",
                                                                "important",
                                                                "who",
                                                                "has",
                                                                "seed",
                                                                "has",
                                                                "access",
                                                                "wallet",
                                                                "secure",
                                                                "crucial",
                                                                "ownership",
                                                                "must",
                                                                "keep",
                                                                "offline",
                                                                "physical",
                                                                "share",
                                                                "with",
                                                                "love",
                                                                "ones",
                                                                "teach",
                                                                "them",
                                                                "early",
                                                                "crypto"],
                                                        handler: { _ in })))
                
            }
        }
    }
}
