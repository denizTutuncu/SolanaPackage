//
//  PresentableSeed.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/16/23.
//

import Foundation

public struct PresentableSeed: Identifiable {
    public init(id: UUID = UUID(), value: String, isSafe: Bool = false) {
        self.id = id
        self.value = value
        self.isSafe = isSafe
    }

    public let id: UUID
    public var value: String
    public var isSafe: Bool
}
