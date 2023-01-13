//
//  BalanceLoadingView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI

public struct LoadingView: View {
    private let title: String?
    public init(title: String?) { self.title = title }
    public var body: some View {
        VStack {
            ProgressView(self.title ?? "Loading...")
        }
        .foregroundColor(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
    }
}

struct BalanceLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(title: "Loading Balance...")
    }
}
