//
//  BalanceContainerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/20/23.
//

import SwiftUI

public struct BalanceContainerView: View {
    public typealias Result = Swift.Result<String, Error>
    @State private var result: Result?
    
    @State private var title: String
    @State private var currencyName: String
    
    private let onHide: (() -> Void)?
    
    public init(result: Result? = nil,
                title: String,
                currencyName: String,
                onHide: (() -> Void)?)
    {
        self.result = result
        self.title = title
        self.currencyName = currencyName
        self.onHide = onHide
    }
    
    public var body: some View {
        ZStack {
    
            switch self.result {
            case let .success(balance):
                BalanceView(title: title, amount: balance, currencyName: currencyName)
            case let .failure(error):
                ErrorView(message: error.localizedDescription, onHide: onHide)
            case .none:
                LoadingView(title: title, progress: 0.1)
                
            }
        }
    }
}

struct BalanceContainerView_Previews: PreviewProvider {
    
    enum MockBalanceError: Error {
        case mockError
    }
    
    static var previews: some View {
        Group {
            BalanceContainerView(result: nil, title: "Balance", currencyName: "lamports", onHide: {})
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Loading Container View")
            
            BalanceContainerView(result: .success("100000000"), title: "Balance", currencyName: "lamports", onHide: {})
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Succesful Balance Container View")
            
            BalanceContainerView(result: .failure(MockBalanceError.mockError), title: "Bakiye", currencyName: "lamports", onHide: {})
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Error Container View")
        }
    }
}
