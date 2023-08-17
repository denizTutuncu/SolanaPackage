//
//  OnboardingView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/28/23.
//

import SwiftUI

public struct OnboardingView: View {
    
    public init(headerTitle: String,
                headerSubtitle: String,
                firstButtonTitle: String,
                firstButtonAction: @escaping () -> Void,
                secondButtonTitle: String,
                secondButtonAction: @escaping () -> Void
    ) {
        self.headerTitle = headerTitle
        self.headerSubtitle = headerSubtitle
        self.firstButtonTitle = firstButtonTitle
        self.firstButtonAction = firstButtonAction
        self.secondButtonTitle = secondButtonTitle
        self.secondButtonAction = secondButtonAction
    }
    
    
    private let headerTitle: String
    private let headerSubtitle: String
    
    private let firstButtonTitle: String
    private let firstButtonAction: () -> Void
    
    private let secondButtonTitle: String
    private let secondButtonAction: () -> Void
    
    public var body: some View {
        VStack {
            HeaderView(title: headerTitle, subtitle: headerSubtitle)
            Spacer()
            RoundedButton(title: firstButtonTitle, action: firstButtonAction)
            RoundedButton(title: secondButtonTitle, action: secondButtonAction)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Creation Option Test View")
        }
    }
    
    struct OnboardingTestView: View {
        @State var selection: String = "none"
        
        var body: some View {
            VStack {
                OnboardingView(headerTitle: "Welcome to Trea",
                                   headerSubtitle: "TREA, Trusted Repository for Electronic Assets, to create your crypto wallet with top-tier security. This app is protected by industry-standard encryption, ensuring a secure connection with Solana.",
                    firstButtonTitle: "Create new wallet",
                                   firstButtonAction: { selection = "Create wallet tapped" },
                                   secondButtonTitle: "Import wallet from seed",
                                   secondButtonAction: { selection = "Import wallet tapped" })
                
                Text("Last selection: " + selection).padding()
            }
        }
    }
}
