//
//  SeedErrorComposerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/18/23.
//

import SwiftUI

struct SeedErrorComposerView: View {
    let errorMessage: String
    let onTryAgain: () -> Void
    let selection: ([PresentableSeed]) -> Void
    @Binding var seed: [PresentableSeed]
    
    var body: some View {
        VStack {
            if !seed.isEmpty {
                SeedListView(seed: $seed)
            } else {
                ErrorView(message: errorMessage, onHide: onTryAgain)
            }
            Spacer()
        }
       
    }
}

struct SeedErrorComposerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SeedErrorComposerTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Seed Error Composer Test View")
        }
    }
}

struct SeedErrorComposerTestView: View {
    
    var body: some View {
        VStack {
            SeedErrorComposerView(errorMessage: "Cannot load seed phrase",
                                  onTryAgain: { },
                                  selection: { _ in },
                                  seed: .constant([]))
            
            SeedErrorComposerView(errorMessage: "",
                                  onTryAgain: { },
                                  selection: { _ in },
                                  seed: .constant([PresentableSeed(value: "private"),
                                                   PresentableSeed(value: "digital"),
                                                   PresentableSeed(value: "coin"),
                                                   PresentableSeed(value: "seed"),
                                                   PresentableSeed(value: "key"),
                                                   PresentableSeed(value: "has"),
                                                   PresentableSeed(value: "very"),
                                                   PresentableSeed(value: "long"),
                                                   PresentableSeed(value: "secret"),
                                                   PresentableSeed(value: "pass"),
                                                   PresentableSeed(value: "phrase"),
                                                   PresentableSeed(value: "that"),
                                                   PresentableSeed(value: "will"),
                                                   PresentableSeed(value: "prevent"),
                                                   PresentableSeed(value: "animal"),
                                                   PresentableSeed(value: "weasel"),
                                                   PresentableSeed(value: "brain"),
                                                   PresentableSeed(value: "person"),
                                                   PresentableSeed(value: "like"),
                                                   PresentableSeed(value: "you"),
                                                   PresentableSeed(value: "obtain"),
                                                   PresentableSeed(value: "any"),
                                                   PresentableSeed(value: "large"),
                                                   PresentableSeed(value: "wealth")]))
            
        }
    }
}
