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
