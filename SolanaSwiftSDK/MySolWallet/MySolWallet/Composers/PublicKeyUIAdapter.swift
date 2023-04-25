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
    public typealias PublicKeyStorePublisher = ViewModelPublisher<[String], [PresentablePublicKey]>
    private static var cancellable: AnyCancellable?
    
    private init() {}
    
    deinit {
        PublicKeyUIAdapter.cancellable?.cancel()
    }
    
    public static func publicKeyComposedWith(publicKeyPublisher: AnyPublisher<[String], Error>) -> PublicKeyStorePublisher {
        var publicKeyStorePublisher = PublicKeyStorePublisher(resource: [], mapper: PublicKeyStoreMapper.map)
        
        PublicKeyUIAdapter.cancellable = publicKeyPublisher
            .sink(receiveCompletion: { completion in
                publicKeyStorePublisher = PublicKeyStorePublisher(resource: [], mapper: PublicKeyStoreMapper.map)
            },
                  receiveValue: { publicKeys in
                publicKeyStorePublisher = PublicKeyStorePublisher(resource: publicKeys, mapper: PublicKeyStoreMapper.map)
            })
        
        return publicKeyStorePublisher
    }
}
