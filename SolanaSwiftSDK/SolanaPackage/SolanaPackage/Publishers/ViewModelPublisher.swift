//
//  ViewProtocol.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 1/31/23.
//

import Foundation
import Combine

final public class ViewModelPublisher<Resource, ResourceViewModel>: ObservableObject {
    public typealias Mapper = (Resource) throws -> ResourceViewModel
    
    @Published public var onLoadingState: Bool = true
    @Published public var onResourceLoad: ResourceViewModel?
    
    private let resource: Resource?
    private let mapper: Mapper
    private var cancellables = Set<AnyCancellable>()
    
    public init(resource: Resource?, mapper: @escaping Mapper) {
        self.resource = resource
        self.mapper = mapper
    }
    
    public func load() {
        guard let resource = resource else {
            onLoadingState = false
            return
        }
        guard let resourceViewModel = try? mapper(resource) else {
            onLoadingState = false
            onResourceLoad = nil
            return
        }
        onResourceLoad = resourceViewModel
        onLoadingState = false
    }
    
}

