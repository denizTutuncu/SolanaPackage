//
//  ExportSeedViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/22/25.
//

import Foundation

public final class ExportSeedViewModel: SeedViewModel {
    public func updateSeed(at index: Int, with seed: PresentableSeed) {
        guard model.indices.contains(index) else { return }
        model[index] = seed
    }
}
