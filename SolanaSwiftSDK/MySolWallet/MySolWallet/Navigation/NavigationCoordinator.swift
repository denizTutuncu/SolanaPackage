//
//  NavigationCoordinator.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 1/22/25.
//

import SwiftUI

final class NavigationCoordinator: ObservableObject {
    enum Route {
        case onboarding
        case walletList
        case exportSeed
        case importSeed
        case walletDetail
    }
    
    @Published var currentRoute: Route = .onboarding
    
    func navigate(to route: Route) {
        withAnimation {
            currentRoute = route
        }
    }
}
