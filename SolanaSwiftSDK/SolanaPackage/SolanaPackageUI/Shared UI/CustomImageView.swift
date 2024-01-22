//
//  CustomImageView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/21/24.
//

import SwiftUI

import SwiftUI

struct CustomImageView: View {
    init(imageName: String, bundle: String) {
        self.imageName = imageName
        self.bundle = bundle
    }
    private let imageName: String
    private let bundle: String
    var body: some View {
        VStack {
            // Replace "your_image_name" with the name of your image file in the bundle
            Image(imageName,
                  bundle: Bundle(identifier: bundle))
                .resizable() // Makes the image resizable
                .aspectRatio(contentMode: .fit) // Keeps the aspect ratio and fits the content in the available space
                .padding() // Adds some padding around the image
        }
    }
}

#Preview {
    CustomImageView(imageName:"CreationOptionsBackground",
                    bundle: "com.deniztutuncu.SolanaPackageUI")
}
