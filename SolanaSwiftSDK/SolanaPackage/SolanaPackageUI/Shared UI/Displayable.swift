//
//  ResultDisplayable.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/3/23.
//

import SwiftUI

public protocol Displayable: View {
    associatedtype ViewModel
    var viewModel: ViewModel? { get }
}
