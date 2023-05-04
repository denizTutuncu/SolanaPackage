//
//  TransactionStore.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import Foundation

public struct TransactionViewModel {
    public init(model: [PresentableTransaction]? = nil) {
        self.model = model
    }
    
    public let model: [PresentableTransaction]?
    
    public var onLoadingState: Bool {
        self.model == nil
    }
    
}
