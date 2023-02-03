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
    @State private var progress: CGFloat
    @State private var total: CGFloat
    
    private let onHide: (() -> Void)?
    
    public init(result: Result? = nil,
                title: String,
                currencyName: String,
                progress: CGFloat,
                total: CGFloat,
                onHide: (() -> Void)?)
    {
        self.result = result
        self.title = title
        self.currencyName = currencyName
        self.progress = progress
        self.total = total
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
                LoadingView(title: title, progress: $progress, total: $total)
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
            BalanceContainerView(result: nil, title: "Balance", currencyName: "lamports", progress: 0.7, total: 1.0, onHide: {})
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Loading Container View")
            
            BalanceContainerView(result: .success("100000000"), title: "Balance", currencyName: "lamports", progress: 1.0, total: 1.0, onHide: {})
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Succesful Balance Container View")
            
            BalanceContainerView(result: .failure(MockBalanceError.mockError), title: "Balance", currencyName: "lamports", progress: 1.0, total: 1.0, onHide: {})
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Error Container View")
        }
    }
}
