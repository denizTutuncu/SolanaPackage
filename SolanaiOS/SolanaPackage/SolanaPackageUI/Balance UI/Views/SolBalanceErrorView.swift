//
//  BalanceErrorView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI

struct SolBalanceErrorView: View {
    private let errorMessage: String
    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    var body: some View {
        Text(self.errorMessage)
    }
}

struct BalanceErrorView_Previews: PreviewProvider {
    static var previews: some View {
        SolBalanceErrorView(errorMessage: "ANY ERROR MESSAGE HERE")
    }
}
