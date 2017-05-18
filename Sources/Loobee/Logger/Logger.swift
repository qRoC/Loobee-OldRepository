// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Сообщения могут содержать плейсхолдеры в формате: {name}, где "name" имя ключа в словаре context.
public protocol Logger {

    typealias ContextData = [String: String]

    /// Система непригодна для использования.
    func emergency(_ message: String, context: ContextData)

    /// Необходимо принять меры немедленно.
    func alert(_ message: String, context: ContextData)

    /// Критическая ошибка.
    func critical(_ message: String, context: ContextData)

    /// Ошибка, которая не требует немедленных действий, но должна быть зарегистрирована.
    func error(_ message: String, context: ContextData)

    /// Использование нежелательных вещей, неверное использование, т.п.
    func warning(_ message: String, context: ContextData)

    /// Значимые уведомления, которые не свидетельствуют о ошибках, а скорей просто сигнализируют о наступлении события.
    func notice(_ message: String, context: ContextData)

    /// Незначимые уведомления.
    func info(_ message: String, context: ContextData)

    /// Уведомления которые полезны при отладке.
    func debug(_ message: String, context: ContextData)

    // Запись с произвольным уровнем.
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
