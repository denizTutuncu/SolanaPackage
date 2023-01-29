//
//  UIModel.swift
//  SolPrototype
//
//  Created by Deniz Tutuncu on 3/28/22.
//

import Foundation

struct UIModel {
    let publicKey: String
    let balance: String
}

struct Transaction {
    let id: UUID
    let from: String
    let to: String
    let amount: String
    let date: String
}
