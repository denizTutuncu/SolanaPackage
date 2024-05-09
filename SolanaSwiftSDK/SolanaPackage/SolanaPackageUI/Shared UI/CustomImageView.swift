//
//  CustomImageView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/21/24.
//

import SwiftUI

import SwiftUI

struct CustomImageView: View {
    init(imageName: String, bundleName: String) {
        self.imageName = imageName
        self.bundleName = bundleName
    }
    private let imageName: String
    private let bundleName: String
    var body: some View {
        VStack {
            Image(imageName,
                  bundle: Bundle(identifier: bundleName))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
        }
    }
}

#Preview {
    CustomImageView(imageName:"CreationOptionsBackground",
                    bundleName: "com.deniztutuncu.SolanaPackageUI")
}
