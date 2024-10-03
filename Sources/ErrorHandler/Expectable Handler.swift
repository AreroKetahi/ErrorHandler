//
//  Expectable Handler.swift
//  ErrorHandler
//
//  Created by Akivili Collindort on 2024/10/4
//

import Foundation

@inlinable
public func withErrorHandler<E>(
    _ handler: ErrorHandler,
    expectedError: E.Type,
    operation: () throws -> Void,
    handlerAction: (() -> Void)? = nil
) throws(E) where E: LocalizedError {
    do {
        try operation()
    } catch let error as E {
        throw error
    } catch let error as LocalizedError {
        handler.raise(error, action: handlerAction)
    } catch {
        handler.raise(error, action: handlerAction)
    }
}

@inlinable @MainActor
func withErrorHandler<E>(
    _ handler: ErrorHandler,
    expectedError: E.Type,
    operation: () async throws -> Void,
    handlerAction: (() -> Void)? = nil
) async throws(E) where E: LocalizedError {
    do {
        try await operation()
    } catch let error as E {
        throw error
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
    expectedError: E.Type,
    operation: () throws -> Value,
    handlerAction: (() -> Void)? = nil
) throws(E) -> Result<Value, any Error> where E: LocalizedError {
    do {
        let result = try operation()
        return .success(result)
    } catch let error as E {
        throw error
    } catch let error as LocalizedError {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    } catch {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    }
}

@inlinable @MainActor
func withErrorHandler<Value, E>(
    _ handler: ErrorHandler,
    expectedError: E.Type,
    operation: () async throws -> Value,
    handlerAction: (() -> Void)? = nil
) async throws(E) -> Result<Value, any Error> where Value: Sendable, E: LocalizedError {
    do {
        let result = try await operation()
        return .success(result)
    } catch let error as E {
        throw error
    } catch let error as LocalizedError {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    } catch {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    }
}
