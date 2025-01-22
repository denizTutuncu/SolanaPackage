//
//  ImportSeedViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/22/25.
//

import Foundation

public final class ImportSeedViewModel: SeedViewModel {
    public func updateModel(_ seeds: [String]) {
        self.model = seeds.map { PresentableSeed(value: $0) }
        self.isLoading = false
    }
}
