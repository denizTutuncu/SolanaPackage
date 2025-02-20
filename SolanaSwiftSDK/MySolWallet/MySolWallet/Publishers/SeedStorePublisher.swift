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

public final class SeedStorePublisher {
    
    private init() {}
    public typealias SeedViewModelPublisher = ViewModelPublisher<[String], [PresentableSeed]>
    private static var cancellable: AnyCancellable?
    
    public static func bindToSeedPublisher(_ seedPublisher: AnyPublisher<[String], Error>) -> SeedViewModelPublisher {
        var seedViewModelPublisher = SeedViewModelPublisher(resource: [], mapper: SeedStoreMapper.map)
        
        SeedStorePublisher.cancellable = seedPublisher
            .dispatchOnMainQueue()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { seed in
                seedViewModelPublisher = SeedViewModelPublisher(resource: seed, mapper: SeedStoreMapper.map)
            })
        
        return seedViewModelPublisher
    }
}
