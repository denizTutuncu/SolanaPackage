//
//  CreateWallet.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/16/23.
//

import SwiftUI

public struct CreateWalletButton: View {
    @State private var title: String?
    private let onTap: (() -> Void)?
    
    public init(title: String?, onTap: (() -> Void)?) {
        self.title = title
        self.onTap = onTap
    }
    
    public var body: some View {
        VStack(alignment: .center) {
            if title != nil {
                Button(action: tapped) {
                    Text(title!)
                        .font(.body)
                        .foregroundColor(.primary)
                }
                .padding(8)
                .background(Color.secondary)
            }
        }.padding()
    }
    
    private func tapped() {
        title = nil
        onTap?()
    }
}

struct CreateWallet_Previews: PreviewProvider {
    static var previews: some View {
        CreateWalletButton(title: "Create Wallet", onTap: { })
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Create Wallet View")
    }
}
