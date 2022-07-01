//
//  BalanceLoadingView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI
import SolanaPackage

struct SolBalanceLoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
        }
    }
}

struct BalanceLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        SolBalanceLoadingView()
    }
}
