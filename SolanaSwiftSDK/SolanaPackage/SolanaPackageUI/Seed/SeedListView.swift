//
//  SeedListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import SwiftUI

struct SeedListView: View {
    let title: String
    let subtitle: String
    let seeds: [String]
    
    var body: some View {
        VStack {
            HeaderView(title: title, subtitle: subtitle)
            List {
                ForEach(seeds.indices, id: \.self) { index in
                    let seed = seeds[index]
                    SingleSeedCellView(index: (index + 1), seed: seed)
                }
            }
        }
    }
}

struct SeedListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SeedListView(title: "The seed phrase is never stored on the device. You will only see it once, and it's only for this time. Please keep it securely.", subtitle: "Seed Phrase", seeds: ["private","digital","coin","seed","key","has","very","long","secret","pass","phrase","that","will","prevent","animal","weasel","brain","person","like","you","obtain","any","large","wealth"])
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Seed List Test View")
        }
        
    }
}
