//
//  ErrorViewProtocol.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/13/23.
//

import SwiftUI

public protocol ErrorViewProtocol: View {
    var message: String? { get }
    var onHide: (() -> Void)? { get }
}
