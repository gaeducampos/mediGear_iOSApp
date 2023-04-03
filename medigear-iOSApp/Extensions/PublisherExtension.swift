//
//  PublisherExtension.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 28/3/23.
//

import Foundation
import Combine

extension Publisher where Failure: Error {
    func toResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        map {
            Result.success($0)
        }
        .catch {
            Just(Result.failure($0))
        }
        .eraseToAnyPublisher()
    }
}
