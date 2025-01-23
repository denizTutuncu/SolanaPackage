//
//  ImportSeedViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/22/25.
//

import Foundation

public final class ImportSeedViewModel: SeedViewModel {
    public override var canSubmit: Bool {
        model.allSatisfy { !$0.value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }

    public func updateModel(_ seeds: [String]) {
        self.model = seeds.map { PresentableSeed(value: $0, isSafe: !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) }
        self.isLoading = false
    }
}
