//
//  AnyViewProtocol.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/6/24.
//

import Foundation

protocol AnyViewProtocol {
    associatedtype Data
    var data: Data { get }
    func updateData(_ newData: Data)
}
