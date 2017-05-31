// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Logger protocol.
///
/// Messages can contain placeholders.
/// Placeholders form: {name}, where "name" is the name of the key in the context dictionary.
public protocol Logger {
    typealias ContextData = [String: String]

    /// System is unusable.
    func emergency(_ message: String, context: ContextData)

    /// Action must be taken immediately.
    func alert(_ message: String, context: ContextData)

    /// Critical conditions.
    func critical(_ message: String, context: ContextData)

    /// An error that does not require immediate action, but must be registered.
    func error(_ message: String, context: ContextData)

    /// Use of undesirable things, misuse, etc.
    func warning(_ message: String, context: ContextData)

    /// Significant notifications that do not indicate errors, but rather simply signal the occurrence of an event.
    func notice(_ message: String, context: ContextData)

    /// Minor notifications.
    func info(_ message: String, context: ContextData)

    /// Detailed debug information.
    func debug(_ message: String, context: ContextData)

    // Logs with an arbitrary level.
    func log(_ level: LogLevel, _ message: String, context: ContextData)
}

extension Logger {
    public func emergency(_ message: String, context: ContextData = [:]) {
        log(.emergency, message, context: context)
    }

    public func alert(_ message: String, context: ContextData = [:]) {
        log(.alert, message, context: context)
    }

    public func critical(_ message: String, context: ContextData = [:]) {
        log(.critical, message, context: context)
    }

    public func error(_ message: String, context: ContextData = [:]) {
        log(.error, message, context: context)
    }

    public func warning(_ message: String, context: ContextData = [:]) {
        log(.warning, message, context: context)
    }

    public func notice(_ message: String, context: ContextData = [:]) {
        log(.notice, message, context: context)
    }

    public func info(_ message: String, context: ContextData = [:]) {
        log(.info, message, context: context)
    }

    public func debug(_ message: String, context: ContextData = [:]) {
        log(.debug, message, context: context)
    }
}
