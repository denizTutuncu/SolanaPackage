//
//  SeedStorePublisher.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 3/1/23.
//

import SwiftUI
import Combine
import SolanaPackage
import SolanaPackageUI

public final class SeedStorePublisher: ObservableObject {
    public typealias SeedViewModelPublisher = ViewModelPublisher<[String], [PresentableSeed]>
    
    @Published public private(set) var seedViewModelPublisher: SeedViewModelPublisher
    
    private var cancellable: AnyCancellable?

    public init() {
        self.seedViewModelPublisher = SeedViewModelPublisher(mapper: SeedStoreMapper.map)
    }

    public func bind(to publisher: AnyPublisher<[String], Error>) {
        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] seeds in
                guard let self = self else { return }

                DispatchQueue.main.async {
                    self.seedViewModelPublisher = SeedViewModelPublisher(mapper: SeedStoreMapper.map)
                    self.seedViewModelPublisher.bind(to: Just(seeds).setFailureType(to: Error.self).eraseToAnyPublisher())

                    self.objectWillChange.send()
                }
            })
    }
}
