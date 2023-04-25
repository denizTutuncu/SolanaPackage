//
//  LoadResourceViewModelAdapter.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 3/6/23.
//

import Foundation
import Combine
import SolanaPackage

final class LoadResourcePresentationAdapter<Resource, ResourceViewModel> {
    public typealias Mapper = (Resource) throws -> ResourceViewModel
    
    private let loader: () -> AnyPublisher<Resource, Error>
    private let mapper: Mapper
    private var cancellable: Cancellable?
    private var isLoading = false
    
    var publisher: ViewModelPublisher<Resource, ResourceViewModel>?
    
    init(loader: @escaping () -> AnyPublisher<Resource, Error>,
         mapper: @escaping Mapper) {
        self.loader = loader
        self.mapper = mapper
    }
    
    func loadResource() {
        guard !isLoading else { return }
        
        publisher?.load()
        isLoading = true
        
        cancellable = loader()
            .dispatchOnMainQueue()
            .handleEvents(receiveCancel: { [weak self] in
                self?.isLoading = false
            })
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished: break
                        
                    case .failure:
                        self?.publisher?.onResourceLoad = nil
                    }
                    
                    self?.isLoading = false
                }, receiveValue: { [weak self] resource in
                    do {
                        let resourceViewModel = try self?.mapper(resource)
                        self?.publisher?.onResourceLoad = resourceViewModel
                    } catch {
                        self?.publisher?.onResourceLoad = nil
                    }
                })
    }
}
