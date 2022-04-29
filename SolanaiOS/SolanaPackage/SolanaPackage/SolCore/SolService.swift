//
//  SolService.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/18/22.
//

import Foundation

public protocol SolServiceRequest {
    var httpBody: [String:Any] { get set }
}
