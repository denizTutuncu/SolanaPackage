//
//  BalanceErrorView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI

public struct BalanceUIErrorView: View {
    private let error: Error?
    public init(error: Error?) {
        self.error = error
    }
    public var body: some View {
        Text(self.error?.localizedDescription ?? "Connection error")
    }
}

struct BalanceErrorView_Previews: PreviewProvider {
     enum Error: Swift.Error {
        case fakeError
    }
    static var previews: some View {
        BalanceUIErrorView(error: Error.fakeError)
    }
}
