//
//  AnyPresentableError.swift
//  ErrorHandler
//
//  Created by Akivili Collindort on 2024/10/3
//

import Foundation

public struct AnyPresentableError: LocalizedError {
    @usableFromInline
    var error: any Error
    
    public var errorDescription: String? {
        error.localizedDescription
    }
    
    public init<E>(_ error: E) where E: Error {
        self.error = error
    }
}
