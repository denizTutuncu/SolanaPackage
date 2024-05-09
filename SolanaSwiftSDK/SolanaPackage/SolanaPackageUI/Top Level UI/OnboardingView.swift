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
                imageBundle: String,
                bundle: String,
                firstButtonTitle: String,
                firstButtonAction: @escaping () -> Void,
                secondButtonTitle: String,
                secondButtonAction: @escaping () -> Void
    ) {
        self.headerTitle = headerTitle
        self.headerSubtitle = headerSubtitle
        self.imageBundle = imageBundle
        self.bundle = bundle
        self.firstButtonTitle = firstButtonTitle
        self.firstButtonAction = firstButtonAction
        self.secondButtonTitle = secondButtonTitle
        self.secondButtonAction = secondButtonAction
    }
    
    
    private let headerTitle: String
    private let headerSubtitle: String
    
    private let imageBundle: String
    private let bundle: String
    
    private let firstButtonTitle: String
    private let firstButtonAction: () -> Void
    
    private let secondButtonTitle: String
    private let secondButtonAction: () -> Void
    
    public var body: some View {
        VStack {
            HeaderView(title: headerTitle, subtitle: headerSubtitle)
            CustomImageView(imageName: imageBundle, bundleName: bundle)
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
                .previewDisplayName("Onboarding Test View")
        }
    }
    
    struct OnboardingTestView: View {
        @State var selection: String = "none"
        
        var body: some View {
            VStack {
                OnboardingView(headerTitle: "Welcome to Trea",
                               headerSubtitle: "Create your crypto wallet with top-tier security. This app is protected by industry-standard encryption, ensuring a secure connection with Solana.", 
                               imageBundle: "CreationOptionsBackground",
                               bundle: "com.deniztutuncu.SolanaPackageUI",
                               firstButtonTitle: "Create new wallet",
                               firstButtonAction: { selection = "Create wallet tapped" },
                               secondButtonTitle: "Import wallet from seed",
                               secondButtonAction: { selection = "Import wallet tapped" })
                
                Text("Last selection: " + selection).padding()
            }
        }
    }
}
