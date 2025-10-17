//
//  Globle Functions.swift
//  ErrorHandler
//
//  Created by Akivili Collindort on 2024/10/3
//

import Foundation
import SwiftUI

@inlinable
public func withErrorHandler<E>(
    _ handler: ErrorHandler,
    operation: () throws(E) -> Void,
    handlerAction: (() -> Void)? = nil
) where E: Error {
    do {
        try operation()
    } catch let error as LocalizedError {
        handler.raise(error, action: handlerAction)
    } catch {
        handler.raise(error, action: handlerAction)
    }
}

@inlinable @MainActor
public func withErrorHandler<E>(
    _ handler: ErrorHandler,
    operation: () async throws(E) -> Void,
    handlerAction: (() -> Void)? = nil
) async where E: Error {
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
public func withErrorHandler<Value, E>(
    _ handler: ErrorHandler,
    operation: () throws(E) -> Value,
    handlerAction: (() -> Void)? = nil
) -> Result<Value, E> where E: Error {
    do {
        let result = try operation()
        return .success(result)
    } catch {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    }
}

@inlinable @MainActor
public func withErrorHandler<Value, E>(
    _ handler: ErrorHandler,
    operation: () async throws(E) -> Value,
    handlerAction: (() -> Void)? = nil
) async -> Result<Value, E> where Value: Sendable, E: Error {
    do {
        let result = try await operation()
        return .success(result)
    } catch {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    }
}

@inlinable
public func withErrorHandler<Value, E>(
    _ handler: ErrorHandler,
    operation: () throws(E) -> Value,
    handlerAction: (() -> Void)? = nil
) -> Result<Value, E> where E: LocalizedError {
    do {
        let result = try operation()
        return .success(result)
    } catch {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    }
}

@inlinable @MainActor
public func withErrorHandler<Value, E>(
    _ handler: ErrorHandler,
    operation: () async throws(E) -> Value,
    handlerAction: (() -> Void)? = nil
) async -> Result<Value, E> where Value: Sendable, E: LocalizedError {
    do {
        let result = try await operation()
        return .success(result)
    } catch {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    }
}
