//
//  WalletSetupView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/28/23.
//

import SwiftUI

public struct WalletSetupView: View {
    
    public init(headerTitle: String,
                headerTitleTextColor: Color,
                headerSubtitle: String,
                headerSubtitleTextColor: Color,
                backgroundImageName: String,
                logoImageName: String,
                bundle: String,
                firstButtonTitle: String,
                firstButtonAction: @escaping () -> Void,
                firstButtonBackgroundColor: Color,
                secondButtonTitle: String,
                secondButtonAction: @escaping () -> Void,
                secondButtonBackgroundColor: Color
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
        self.firstButtonBackgroundColor = firstButtonBackgroundColor
        self.secondButtonTitle = secondButtonTitle
        self.secondButtonAction = secondButtonAction
        self.secondButtonBackgroundColor = secondButtonBackgroundColor
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
    private let firstButtonBackgroundColor: Color
    private let secondButtonTitle: String
    private let secondButtonAction: () -> Void
    private let secondButtonBackgroundColor: Color

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
                Spacer()
                CustomImageView(imageName: logoImageName, bundleName: bundle, animationType: .linear(duration: 2.5))
                Spacer()
                RoundedButton(title: firstButtonTitle, action: firstButtonAction, backgroundColor: firstButtonBackgroundColor)
                RoundedButton(title: secondButtonTitle, action: secondButtonAction, backgroundColor: secondButtonBackgroundColor)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Wallet Setup Test View")
        }
    }
    
    struct OnboardingTestView: View {
        @State var selection: String = "none"
        
        var body: some View {
            VStack {
                ZStack {
                    WalletSetupView(headerTitle: "Welcome to Blue Giant Labs",
                                   headerTitleTextColor: .white,
                                   headerSubtitle: "Providing head-to-head Solana asset comparisons to help users make informed choices in the volatile crypto market.",
                                   headerSubtitleTextColor: .blue,
                                   backgroundImageName: "OnboardingBackground",
                                   logoImageName: "OnboardingAppLogo",
                                   bundle: "com.deniztutuncu.SolanaPackageUI",
                                   firstButtonTitle: "Create new wallet",
                                   firstButtonAction: { selection = "Create wallet tapped" },
                                   firstButtonBackgroundColor: .blue,
                                   secondButtonTitle: "Import wallet from seed",
                                   secondButtonAction: { selection = "Import wallet tapped" },
                                    secondButtonBackgroundColor: .blue)
                }
                
//                Text("Last selection: " + selection).padding()
            }
        }
    }
}
