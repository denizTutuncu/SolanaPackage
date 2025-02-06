//
//  AssetDailyData.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/5/25.
//

import Foundation

public struct AssetDailyData: Hashable {
    public init(id: UUID = UUID(), date: Date, open: Double, high: Double, low: Double, close: Double) {
        self.id = id
        self.date = date
        self.open = open
        self.high = high
        self.low = low
        self.close = close
    }
    
    public let id: UUID
    public let date: Date
    public let open: Double
    public let high: Double
    public let low: Double
    public let close: Double
}
