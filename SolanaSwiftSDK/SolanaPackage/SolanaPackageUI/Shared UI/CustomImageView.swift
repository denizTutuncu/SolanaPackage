//
//  CustomImageView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/21/24.
//

import SwiftUI

struct CustomImageView: View {
    private let imageName: String
    private let bundleName: String
    private let animationType: Animation?
    
    @State private var rotationAngle: Double = 0

    init(imageName: String, bundleName: String, animationType: Animation? = nil) {
        self.imageName = imageName
        self.bundleName = bundleName
        self.animationType = animationType
    }

    var body: some View {
        VStack {
            Image(imageName,
                  bundle: Bundle(identifier: bundleName))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .rotationEffect(Angle(degrees: rotationAngle))
                .onAppear {
                    if let animation = animationType {
                        withAnimation(animation.repeatForever(autoreverses: false)) {
                            rotationAngle = -360
                        }
                    }
                }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        // Instance with animation
        CustomImageView(
            imageName: "CreationOptionsBackground",
            bundleName: "com.deniztutuncu.SolanaPackageUI",
            animationType: .linear(duration: 2.0)
        )
        .frame(width: 200, height: 200)
        
        // Instance without animation
        CustomImageView(
            imageName: "CreationOptionsBackground",
            bundleName: "com.deniztutuncu.SolanaPackageUI"
        )
        .frame(width: 200, height: 200)
    }
}
