//
//  Flow.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

public final class MainApp {
    
    private init(flow: Any) {
        self.flow = flow
    }
    
    public typealias PublicKey = String
    public typealias Seed = String

    private let flow: Any
    
    public static func start<Delegate: PublicKeyDelegate>(
        publickeys: [PublicKey],
        seed: [Seed],
        delegate: Delegate
    ) -> MainApp {
        
        let flow = AppStartFlow(publickeys: publickeys,
                                seed: seed,
                                delegate: delegate)
        flow.start()
        return MainApp(flow: flow)
    }
}
