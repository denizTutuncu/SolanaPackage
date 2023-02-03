//
//  ViewProtocol.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 1/31/23.
//

import Foundation
import Combine

final public class PublisherViewModel<Resource, ResourceViewModel>: ObservableObject {
    public typealias Mapper = (Resource) throws -> ResourceViewModel
    private let mapper: Mapper
    private let resource: Resource
    @Published public var onLoadingState: Bool = true
    @Published public var onResourceLoad: ResourceViewModel?
    
    public init(resource: Resource, mapper: @escaping Mapper) {
        self.resource = resource
        self.mapper = mapper
    }
    
    public func loadResource() {        
        guard let resourceViewModel = try? mapper(resource) else {
            onLoadingState = false
            return
        }
        onResourceLoad = resourceViewModel
        onLoadingState = false
    }
}
