//
//  Globle Functions.swift
//  ErrorHandler
//
//  Created by Akivili Collindort on 2024/10/3
//

import Foundation
import SwiftUI

@inlinable
public func withErrorHandler(
    _ handler: ErrorHandler,
    operation: () throws -> Void,
    handlerAction: (() -> Void)? = nil
) {
    do {
        try operation()
    } catch let error as LocalizedError {
        handler.raise(error, action: handlerAction)
    } catch {
        handler.raise(error, action: handlerAction)
    }
}

@inlinable @MainActor
func withErrorHandler(
    _ handler: ErrorHandler,
    operation: () async throws -> Void,
    handlerAction: (() -> Void)? = nil
) async {
    do {
        try await operation()
    } catch let error as LocalizedError {
        handler.raise(error, action: handlerAction)
    } catch {
        handler.raise(error, action: handlerAction)
    }
}

// MARK: - Error handler with result type

@inlinable
public func withErrorHandler<Value>(
    _ handler: ErrorHandler,
    operation: () throws -> Value,
    handlerAction: (() -> Void)? = nil
) -> Result<Value, any Error> {
    do {
        let result = try operation()
        return .success(result)
    } catch let error as LocalizedError {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    } catch {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    }
}

@inlinable @MainActor
func withErrorHandler<Value>(
    _ handler: ErrorHandler,
    operation: () async throws -> Value,
    handlerAction: (() -> Void)? = nil
) async -> Result<Value, any Error> where Value: Sendable {
    do {
        let result = try await operation()
        return .success(result)
    } catch let error as LocalizedError {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    } catch {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    }
}
