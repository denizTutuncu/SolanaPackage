//
//  SeedUIComposerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/18/23.
//

import SwiftUI

struct SeedUIComposerView: View {
    let errorMessage: String
    let downloadingTitle: String
    let tryAgain: () -> Void
    let selection: ([PresentableSeed]) -> Void
    @Binding var seed: [PresentableSeed]
    
    var body: some View {
        if !seed.isEmpty {
            SeedErrorComposerView(errorMessage: errorMessage,
                                  onTryAgain: tryAgain,
                                  selection: selection,
                                  seed: $seed)
        } else {
            LoadingView(title: downloadingTitle).padding()
        }
    }
}



struct SeedUIComposerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SeedUIComposerTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Seed UI Composer Test View")
        }
    }
}

struct SeedUIComposerTestView: View {
    
    var body: some View {
        VStack {
            SeedUIComposerView(errorMessage: "",
                               downloadingTitle: "Downloading seed phrase",
                               tryAgain: { },
                               selection: { _ in },
                               seed: .constant([]))
            
            SeedUIComposerView(errorMessage: "",
                               downloadingTitle: "",
                               tryAgain: { },
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


