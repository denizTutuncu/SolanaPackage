//
//  SeedListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/18/23.
//

import SwiftUI

struct SeedListView: View {
    @Binding var seed: [PresentableSeed]
    
    var body: some View {
        VStack {
            List {
                ForEach(seed.indices, id: \.self) { index in
                    SingleSeedCellView(index: (index + 1),
                                       seed: $seed[index])
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
}

struct SeedListTestView: View {
    @State var selection: [String] = []
    
    var body: some View {
        VStack {
            
            SeedListView(seed: .constant([
                PresentableSeed(value: "private"),
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
