// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

public enum LogLevel: UInt8 {
    case emergency = 0
    case alert = 1
    case critical = 2
    case error = 3
    case warning = 4
    case notice = 5
    case info = 6
    case debug = 7
}

extension LogLevel: CustomStringConvertible {
    public var description: String {
        switch self {
        case .emergency:
            return "EMERGENCY"
        case .alert:
            return "ALERT"
        case .critical:
            return "CRITICAL"
        case .error:
            return "ERROR"
        case .warning:
            return "WARNING"
        case .notice:
            return "NOTICE"
        case .info:
            return "INFO"
        case .debug:
            return "DEBUG"
        }
    }
}
