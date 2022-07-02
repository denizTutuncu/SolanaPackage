//
//  BalanceLoadingView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI
import SolanaPackage

public struct LoadingView: View {
    private let title: String?
    public init(title: String?) { self.title = title }
    public var body: some View {
        VStack {
            ProgressView(self.title ?? "Loading...")
        }
        .foregroundColor(.white)
    }
}

struct BalanceLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(title: "Loading Balance...")
    }
}
