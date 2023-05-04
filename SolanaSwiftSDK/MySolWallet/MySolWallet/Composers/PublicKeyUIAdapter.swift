//
//  WalletUIComposer.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 3/3/23.
//

import SwiftUI
import Combine
import SolanaPackage
import SolanaPackageUI
 
public final class PublicKeyUIAdapter {
    
    private init() {}
    public typealias PublicKeyViewModelPublisher = ViewModelPublisher<[String], [String]>
    private static var cancellable: AnyCancellable?

    public static func publicKeyComposedWith(publicKeyPublisher: AnyPublisher<[String], Error>) -> PublicKeyViewModelPublisher {
        var publicKeyStorePublisher = PublicKeyViewModelPublisher(resource: nil, mapper: PublicKeyStoreMapper.map)
        
        PublicKeyUIAdapter.cancellable = publicKeyPublisher
            .dispatchOnMainQueue()
            .sink(receiveCompletion: { completion in
                publicKeyStorePublisher = PublicKeyViewModelPublisher(resource: [], mapper: PublicKeyStoreMapper.map)
            },
                  receiveValue: { publicKeys in
                publicKeyStorePublisher = PublicKeyViewModelPublisher(resource: publicKeys, mapper: PublicKeyStoreMapper.map)
            })
        
        return publicKeyStorePublisher
    }
}
