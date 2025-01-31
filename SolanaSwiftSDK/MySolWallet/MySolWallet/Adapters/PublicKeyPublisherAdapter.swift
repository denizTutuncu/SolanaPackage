//
//  PublicKeyPublisherAdapter.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 3/3/23.
//

import SwiftUI
import Combine
import SolanaPackage
import SolanaPackageUI
 
public final class PublicKeyPublisherAdapter {
    
    private init() {}
    public typealias PublicKeyViewModelPublisher = ViewModelPublisher<[String], [PresentablePublicKey]>
    private static var cancellable: AnyCancellable?

    public static func publicKeyComposedWith(publicKeyPublisher: AnyPublisher<[String], Error>) -> PublicKeyViewModelPublisher {
        var publicKeyStorePublisher = PublicKeyViewModelPublisher(resource: nil, mapper: PublicKeyStoreMapper.map)
        
        PublicKeyPublisherAdapter.cancellable = publicKeyPublisher
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
