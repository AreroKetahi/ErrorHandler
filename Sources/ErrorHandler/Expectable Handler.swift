//
//  Expectable Handler.swift
//  ErrorHandler
//
//  Created by Akivili Collindort on 2024/10/4
//

import Foundation

@inlinable
public func withErrorHandler<E>(
    _ handler: ErrorHandler = .shared,
    expectedError: E.Type,
    operation: () throws(E) -> Void,
    handlerAction: (() -> Void)? = nil
) throws(E) where E: Error {
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
    _ handler: ErrorHandler = .shared,
    expectedError: E.Type,
    operation: () async throws(E) -> Void,
    handlerAction: (() -> Void)? = nil
) async throws(E) where E: Error {
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
    _ handler: ErrorHandler = .shared,
    expectedError: E.Type,
    operation: () throws(E) -> Value,
    handlerAction: (() -> Void)? = nil
) throws(E) -> Result<Value, E> where E: Error {
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
    _ handler: ErrorHandler = .shared,
    expectedError: E.Type,
    operation: () async throws(E) -> Value,
    handlerAction: (() -> Void)? = nil
) async throws(E) -> Result<Value, E> where Value: Sendable, E: Error {
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
    _ handler: ErrorHandler = .shared,
    expectedError: E.Type,
    operation: () throws(E) -> Value,
    handlerAction: (() -> Void)? = nil
) throws(E) -> Result<Value, E> where E: LocalizedError {
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
    _ handler: ErrorHandler = .shared,
    expectedError: E.Type,
    operation: () async throws(E) -> Value,
    handlerAction: (() -> Void)? = nil
) async throws(E) -> Result<Value, E> where Value: Sendable, E: LocalizedError {
    do {
        let result = try await operation()
        return .success(result)
    } catch {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    }
}
