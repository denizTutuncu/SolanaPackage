//
//  SeedListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import SwiftUI

public struct SeedListView: View {
    let headerTitle: String
    let headerSubtitle: String
    let toogleOFFTitle: String
    let toogleisONTitle: String
    let buttonTitle: String
    let action: () -> Void
    
    @State var viewModel: SeedViewModel
    @State private var isPhraseSafe = false
    
    public init(title: String, subtitle: String, toogleOFFTitle: String, toogleisONTitle: String, buttonTitle: String, action: @escaping () -> Void, viewModel: SeedViewModel) {
        self.headerTitle = title
        self.headerSubtitle = subtitle
        self.toogleOFFTitle = toogleOFFTitle
        self.toogleisONTitle = toogleisONTitle
        self.buttonTitle = buttonTitle
        self.action = action
        self.viewModel = viewModel
    }
  
    public var body: some View {
        VStack {
            HeaderView(title: headerTitle, subtitle: headerSubtitle)
            List {
                ForEach(viewModel.seed.indices, id: \.self) { index in
                    SingleSeedCellView(index: (index + 1), seed: $viewModel.seed[index])
                }
                
                ToogleView(isOFFTitle: toogleOFFTitle, isONTitle: toogleisONTitle, isOn: $isPhraseSafe)
            }
            
            RoundedButton(
                title: buttonTitle,
                isEnabled: isPhraseSafe,
                action: action
            ).padding()
        }.padding(.top)
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
        @State var tapped = false
        
        var body: some View {
            VStack {
                SeedListView(title: "Seed Phrase",
                             subtitle: "The seed phrase is never stored on the device. You will only see it once, and it's only for this time. Please keep it securely.",
                             toogleOFFTitle: "My seed phrase is not safe yet.",
                             toogleisONTitle: "My seed phrase is safe now.",
                             buttonTitle: "Create wallet",
                             action: { tapped.toggle() },
                             viewModel: .init(seed: [
                                SeedUI(value: "private"),
                                SeedUI(value: "digital"),
                                SeedUI(value: "coin"),
                                SeedUI(value: "seed"),
                                SeedUI(value: "key"),
                                SeedUI(value: "has"),
                                SeedUI(value: "very"),
                                SeedUI(value: "long"),
                                SeedUI(value: "secret"),
                                SeedUI(value: "pass"),
                                SeedUI(value: "phrase"),
                                SeedUI(value: "that"),
                                SeedUI(value: "will"),
                                SeedUI(value: "prevent"),
                                SeedUI(value: "animal"),
                                SeedUI(value: "weasel"),
                                SeedUI(value: "brain"),
                                SeedUI(value: "person"),
                                SeedUI(value: "like"),
                                SeedUI(value: "you"),
                                SeedUI(value: "obtain"),
                                SeedUI(value: "any"),
                                SeedUI(value: "large"),
                                SeedUI(value: "wealth")]))
                
                Text("Create wallet tapped: \(tapped.description)")
            }
        }
    }
}
