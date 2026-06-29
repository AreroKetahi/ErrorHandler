//
//  SwiftUI Extension.swift
//  ErrorHandler
//
//  Created by Akivili Collindort on 2024/10/3
//

import Foundation
import SwiftUI

// MARK: - View Modifier
extension ErrorHandler {
    var modifier: ErrorHandlerModifier {
        ErrorHandlerModifier(handler: self)
    }

    struct ErrorHandlerModifier: ViewModifier {
        @Bindable var handler: ErrorHandler
        func body(content: Content) -> some View {
            if #available(iOS 26.0, macOS 26.0, watchOS 26.0, tvOS 26.0,
            visionOS 26.0, *) {
                content.alert(
                    isPresented: $handler.isPresent,
                    error: handler.error
                ) {
                    Button(role: .confirm) {
                        #if DEBUG
                            print(
                                handler.error as Any,
                                handler.file as Any,
                                handler.line as Any,
                                handler.column as Any,
                                handler.function as Any
                            )
                        #endif
                        if let action = handler.confirmAction {
                            action()
                        }
                        handler.error = nil
                        handler.isPresent = false
                        handler.file = nil
                        handler.line = nil
                        handler.column = nil
                        handler.function = nil
                    }
                }
            } else {
                content.alert(
                    isPresented: $handler.isPresent,
                    error: handler.error
                ) {
                    Button("OK") {
                        #if DEBUG
                            print(
                                handler.error as Any,
                                handler.file as Any,
                                handler.line as Any,
                                handler.column as Any,
                                handler.function as Any
                            )
                        #endif
                        if let action = handler.confirmAction {
                            action()
                        }
                        handler.error = nil
                        handler.isPresent = false
                        handler.file = nil
                        handler.line = nil
                        handler.column = nil
                        handler.function = nil
                    }
                }
            }
        }
    }
}

extension View {
    public func errorAlert(handler: ErrorHandler = .shared) -> some View {
        self.modifier(handler.modifier)
    }
}

extension EnvironmentValues {
    @Entry public var errorHandler = ErrorHandler.shared
}
