//
//  SeedUIComposer.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 3/1/23.
//

import SwiftUI
import Combine
import SolanaPackage
import SolanaPackageUI

public final class SeedUIAdapter {
    
    private init() {}
    public typealias SeedStorePublisher = ViewModelPublisher<[String], [PresentableSeed]>
    private static var cancellable: AnyCancellable?
    
    public static func seedComposedWith(seedPublisher: AnyPublisher<[String], Error>) -> SeedStorePublisher {
        var seedStorePublisher = SeedStorePublisher(resource: [], mapper: SeedStoreMapper.map)
        
        SeedUIAdapter.cancellable = seedPublisher
            .dispatchOnMainQueue()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { seed in
                seedStorePublisher = SeedStorePublisher(resource: seed, mapper: SeedStoreMapper.map)
            })
        
        return seedStorePublisher
    }
}
