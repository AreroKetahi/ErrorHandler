//
//  Expectable Handler with Solution.swift
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
    solution: (E) -> Void,
    handlerAction: (() -> Void)? = nil
) where E: LocalizedError {
    do {
        try operation()
    } catch let error as E {
        solution(error)
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
    solution: (E) -> Void,
    handlerAction: (() -> Void)? = nil
) async where E: LocalizedError {
    do {
        try await operation()
    } catch let error as E {
        solution(error)
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
    solution: (E) -> (),
    handlerAction: (() -> Void)? = nil
) throws(E) -> Result<Value, any Error> where E: LocalizedError {
    do {
        let result = try operation()
        return .success(result)
    } catch let error as E {
        solution(error)
        return .failure(error)
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
    solution: (E) -> (),
    handlerAction: (() -> Void)? = nil
) async throws(E) -> Result<Value, any Error> where Value: Sendable, E: LocalizedError {
    do {
        let result = try await operation()
        return .success(result)
    } catch let error as E {
        solution(error)
        return .failure(error)
    } catch let error as LocalizedError {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    } catch {
        handler.raise(error, action: handlerAction)
        return .failure(error)
    }
}
