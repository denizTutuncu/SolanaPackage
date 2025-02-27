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

    @Published public private(set) var isLoading: Bool = true
    @Published public private(set) var resourceViewModel: ResourceViewModel?

    private var cancellables = Set<AnyCancellable>()
    
    private let mapper: Mapper

    public init(mapper: @escaping Mapper) {
        self.mapper = mapper
    }

    public func bind(to publisher: AnyPublisher<Resource, Error>) {
        isLoading = true
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            }, receiveValue: { resource in
                self.resourceViewModel = try? self.mapper(resource)
                self.isLoading = false
            })
            .store(in: &cancellables)
    }
}
