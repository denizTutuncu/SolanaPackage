//
//  Portfolio.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/24/25.
//

import Foundation

public struct Portfolio: Identifiable {
    public init(id: UUID =  UUID(), date: Date, value: Double) {
        self.id = id
        self.date = date
        self.value = value
    }
    public let id: UUID
    public let date: Date
    public let value: Double
}
