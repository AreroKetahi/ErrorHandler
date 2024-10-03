# Error Handler

A very tiny repackage of SwiftUI's `alert(isPresent:error:actions:)` modifier.

**This library dose not have enough localization strings for all the languanges, feel free for fork & submit PR!**

### Setup

To use error handler in you SwiftUI app, there have serval steps to initialize it. Before we start, don't forget to `import ErrorHandler`.

#### 1. Setup environment.

Go to `<Your Project Name>App.swift`, add `@Environment(\.errorHandler) private var handler` inside the brace of your app.

```swift
@main
struct SampleApp: App {
    @Environment(\.errorHandler) private var handler
  
    // body: some Scene { ...
}
```

#### 2. Setup alert

Then, add `errorAlert(handler:)` modifier to your `ContentView`.

```swift
@main
struct SampleApp: App {
    @Environment(\.errorHandler) private var handler
  
    var body: some Scene {
        WindowGroup {
            ContentView()
                .errorAlert(handler: handler)
        }
    }
}
```

#### 3. Use it!

Once you setup error handler, you can use it anywhere. Here is a example 

```swift
// You have you get handler from environment first.
//
// use 
// @Environment(\.errorHandler) private var handler
// to get it

withErrorHandler(handler) {
    // do something may occur error
}

```

### Dive deeper

This library provide 2 major ways to handle errors.

1. The most easy one, directly handle the error

   ```swift
   withErrorHandler(handler) {
       // actions may occur error
   }
   ```

2. You can also execute custom action after user click "confirm" button.

  ```swift
  withErrorHandler(handler) {
      // actions may occur error
  } handlerAction: {
      // actions that will execute after user click "confirm" button
  }
  ```

Library also provide asynchronous version functions to support concurrency, both of the are marked by `@MainActor`. 
Those function are support the throw-actions which need to run in asynchronous environment.

```swift
await withErrorHandler(handler) {
    // actions may occur error in asynchronous environment.
}

await withErrorHandler(handler) {
    // actions may occur error in asynchronous environment.
} handlerAction: {
    // actions that will execute after user click "confirm" button
    // handler action DOSE NOT SUPPORT concurrency
}
```

