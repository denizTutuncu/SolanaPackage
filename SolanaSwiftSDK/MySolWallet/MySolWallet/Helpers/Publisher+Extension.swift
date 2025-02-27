//
//  Publisher+Extension.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/26/25.
//

import Foundation
import Combine
//
//extension Publisher {
//    func asyncFirstValue() async throws -> Output {
//        try await withCheckedThrowingContinuation { continuation in
//            var cancellable: AnyCancellable?
//            cancellable = first()
//                .sink(receiveCompletion: { completion in
//                    if case let .failure(error) = completion {
//                        continuation.resume(throwing: error)
//                    }
//                }, receiveValue: { value in
//                    continuation.resume(returning: value)
//                    cancellable?.cancel()
//                })
//        }
//    }
//}
