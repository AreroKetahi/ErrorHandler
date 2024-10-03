//
//  AnyLocalizedError.swift
//  ErrorHandler
//
//  Created by Akivili Collindort on 2024/10/3
//

import Foundation

public struct AnyLocalizedError: LocalizedError {
    @usableFromInline
    var backing: any LocalizedError
    
    public var errorDescription: String? { backing.errorDescription }
    
    public var failureReason: String? { backing.failureReason }
    
    public var helpAnchor: String? { backing.helpAnchor }
    
    public var recoverySuggestion: String? { backing.recoverySuggestion }
    
    @inlinable
    public init<L>(_ backing: L) where L: LocalizedError {
        self.backing = backing
    }
}

extension NSError: @retroactive LocalizedError {
    public var errorDescription: String? {
        self.localizedDescription
    }
    
    public var failureReason: String? {
        self.localizedFailureReason
    }
    
    public var recoverySuggestion: String? {
        self.localizedRecoverySuggestion
    }
}
