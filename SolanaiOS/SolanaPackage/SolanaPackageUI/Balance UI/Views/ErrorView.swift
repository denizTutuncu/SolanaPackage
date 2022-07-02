//
//  BalanceErrorView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI

public struct ErrorView: View {
    private let error: Error?
    
    public init(error: Error?) {
        self.error = error
    }
    public var body: some View {
        VStack {
            Text(self.error?.localizedDescription ?? "Connection error")
                .foregroundColor(.white)
        }
    }
}

struct BalanceErrorView_Previews: PreviewProvider {
    enum Error: Swift.Error {
        case fakeError
    }
    static var previews: some View {
        ErrorView(error: Error.fakeError)
    }
}
