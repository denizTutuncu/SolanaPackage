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

public final class SeedUIComposer {
    private init() {}
    
    private typealias SeedStorePublisher = ViewModelPublisher<[DomainSeed], [SeedUI]>
    
    public static func seedComposedWith(
        listTitle: String,
        listSubtitle: String,
        toogleOFFTitle: String,
        toogleisONTitle: String,
        buttonTitle: String,
        action: @escaping () -> Void = {},
        resource: [DomainSeed]
    ) -> SeedListView {
        let seedPublisher = SeedStorePublisher(resource: resource, mapper: SeedStoreMapper.map)
        
        let seedView = makeSeedListView(listTitle: listTitle,
                                        listSubtitle: listSubtitle,
                                        toogleOFFTitle: toogleOFFTitle,
                                        toogleisONTitle: toogleisONTitle,
                                        buttonTitle: buttonTitle,
                                        action: action,
                                        viewModel: .init(seed: seedPublisher.onResourceLoad))
        return seedView
    }
    
    private static func makeSeedListView(listTitle: String,
                                         listSubtitle: String,
                                         toogleOFFTitle: String,
                                         toogleisONTitle: String,
                                         buttonTitle: String,
                                         action: @escaping () -> Void = {},
                                         viewModel: SeedViewModel
    ) -> SeedListView {
        let seedView = SeedListView(title: listTitle,
                                    subtitle: listSubtitle,
                                    toogleOFFTitle: toogleOFFTitle,
                                    toogleisONTitle: toogleisONTitle,
                                    buttonTitle: buttonTitle,
                                    action: action,
                                    viewModel: viewModel)
        return seedView
    }
}
