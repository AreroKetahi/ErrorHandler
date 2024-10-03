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
            content.alert(isPresented: $handler.isPresent, error: handler.error) {
                Button("OK") {
                    print(handler.error as Any)
                    if let action = handler.confirmAction {
                        action()
                    }
                    handler.error = nil
                    handler.isPresent = false
                }
            }
        }
    }
}

extension View {
    public func errorAlert(handler: ErrorHandler) -> some View {
        self.modifier(handler.modifier)
    }
}

extension EnvironmentValues {
    @Entry public var errorHandler = ErrorHandler()
}
