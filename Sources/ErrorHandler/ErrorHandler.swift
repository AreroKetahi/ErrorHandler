//
//  ErrorHandler.swift
//  ErrorHanler
//
//  Created by Akivili Collindort on 2024/10/3
//

import Foundation
import Observation

@Observable
public final class ErrorHandler: @unchecked Sendable {
    public var isPresent = false
    
    public var error: AnyLocalizedError?
    
    public var confirmAction: (() -> Void)? = nil
}

// MARK: - methods

extension ErrorHandler {
    @inlinable
    public func raise<E>(_ error: E, action: (() -> Void)? = nil) where E: LocalizedError {
        self.error = .init(error)
        self.confirmAction = action
        self.isPresent = true
    }
    
    @inlinable
    public func raise<E>(_ error: E, action: (() -> Void)? = nil) where E: Error {
        let localizedError = AnyPresentableError(error)
        self.raise(localizedError, action: action)
    }
}
