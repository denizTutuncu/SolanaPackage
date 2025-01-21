//
//  OnboardingView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/28/23.
//

import SwiftUI

public struct OnboardingView: View {
    
    public init(headerTitle: String,
                headerTitleTextColor: Color,
                headerSubtitle: String,
                headerSubtitleTextColor: Color,
                backgroundImageName: String,
                logoImageName: String,
                bundle: String,
                firstButtonTitle: String,
                firstButtonAction: @escaping () -> Void,
                secondButtonTitle: String,
                secondButtonAction: @escaping () -> Void
    ) {
        self.headerTitle = headerTitle
        self.headerTitleTextColor = headerTitleTextColor
        self.headerSubtitle = headerSubtitle
        self.headerSubtitleTextColor = headerSubtitleTextColor
        self.backgroundImageName = backgroundImageName
        self.logoImageName = logoImageName
        self.bundle = bundle
        self.firstButtonTitle = firstButtonTitle
        self.firstButtonAction = firstButtonAction
        self.secondButtonTitle = secondButtonTitle
        self.secondButtonAction = secondButtonAction
    }
    
    private let headerTitle: String
    private let headerTitleTextColor: Color
    private let headerSubtitle: String
    private let headerSubtitleTextColor: Color
    private let backgroundImageName: String
    private let logoImageName: String
    private let bundle: String
    private let firstButtonTitle: String
    private let firstButtonAction: () -> Void
    private let secondButtonTitle: String
    private let secondButtonAction: () -> Void
    
    public var body: some View {
        ZStack {
            Image(backgroundImageName, bundle: Bundle(identifier: bundle))
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                HeaderView(title: headerTitle,
                           titleTextColor: headerTitleTextColor,
                           subtitle: headerSubtitle,
                           subtitleTextColor: headerSubtitleTextColor)
                CustomImageView(imageName: logoImageName, bundleName: bundle, animationType: .linear(duration: 2.5))
                RoundedButton(title: firstButtonTitle, action: firstButtonAction)
                RoundedButton(title: secondButtonTitle, action: secondButtonAction)
            }
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
                ZStack {
                    OnboardingView(headerTitle: "Welcome to Blue Giant Labs",
                                   headerTitleTextColor: .white,
                                   headerSubtitle: "Create your crypto wallet with top-tier security. This app is protected by industry-standard encryption, ensuring a secure connection with Solana.",
                                   headerSubtitleTextColor: .blue,
                                   backgroundImageName: "OnboardingBackground",
                                   logoImageName: "OnboardingAppLogo",
                                   bundle: "com.deniztutuncu.SolanaPackageUI",
                                   firstButtonTitle: "Create new wallet",
                                   firstButtonAction: { selection = "Create wallet tapped" },
                                   secondButtonTitle: "Import wallet from seed",
                                   secondButtonAction: { selection = "Import wallet tapped" })
                }
                
//                Text("Last selection: " + selection).padding()
            }
        }
    }
}
