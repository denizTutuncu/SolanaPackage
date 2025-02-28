//
//  PublicKeyStorePublisher.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 3/3/23.
//

import SwiftUI
import Combine
import SolanaPackage
import SolanaPackageUI

public final class PublicKeyStorePublisher: ObservableObject {
    public typealias PublicKeyViewModelPublisher = ViewModelPublisher<[String], [PresentablePublicKey]>
    
    @Published public private(set) var publicKeyViewModelPublisher = PublicKeyViewModelPublisher(mapper: PublicKeyStoreMapper.map)
    
    private var cancellable: AnyCancellable?
    
    public func bind(to publisher: AnyPublisher<[String], Error>) {
        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] publicKeys in
                self?.publicKeyViewModelPublisher = PublicKeyViewModelPublisher(mapper: PublicKeyStoreMapper.map)
                self?.publicKeyViewModelPublisher.bind(to: Just(publicKeys).setFailureType(to: Error.self).eraseToAnyPublisher())
            })
    }
}

