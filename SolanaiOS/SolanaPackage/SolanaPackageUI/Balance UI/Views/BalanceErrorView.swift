//
//  BalanceErrorView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI

public struct BalanceErrorView: View {
    private let errorMessage: String
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    public var body: some View {
        Text(self.errorMessage)
    }
}

struct BalanceErrorView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceErrorView(errorMessage: "ANY ERROR MESSAGE HERE")
    }
}
