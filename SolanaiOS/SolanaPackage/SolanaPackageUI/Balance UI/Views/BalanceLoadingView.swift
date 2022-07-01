//
//  BalanceLoadingView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI
import SolanaPackage

public struct BalanceLoadingView: View {
    private let title: String
    public init(title: String) { self.title = title }
    public var body: some View {
        VStack {
            ProgressView(self.title)
        }
    }
}

struct BalanceLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceLoadingView(title: "Loading...")
    }
}
