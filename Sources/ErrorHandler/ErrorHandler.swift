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
    /// Shared instance of error handler
    public static var shared: ErrorHandler {
        if let _shared {
            return _shared
        } else {
            _shared = ErrorHandler()
            return .shared
        }
    }

    nonisolated(unsafe) private static var _shared: ErrorHandler?

    public var isPresent = false

    public var error: AnyLocalizedError?

    public var confirmAction: (() -> Void)? = nil

    public var file: String?
    public var line: Int?
    public var column: Int?
    public var function: String?
}

// MARK: - methods

extension ErrorHandler {
    @inlinable
    public func raise<E>(
        _ error: E,
        action: (() -> Void)? = nil,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) where E: LocalizedError {
        self.error = .init(error)
        self.confirmAction = action
        self.isPresent = true
        self.file = file
        self.line = line
        self.column = column
        self.function = function
        notifyChange()
        #if DEBUG
        print(error)
        #endif
    }

    @inlinable
    public func raise<E>(
        _ error: E,
        action: (() -> Void)? = nil,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) where E: Error {
        let localizedError = AnyPresentableError(error)
        self.raise(
            localizedError,
            action: action,
            file: file,
            line: line,
            column: column,
            function: function
        )
    }
}
