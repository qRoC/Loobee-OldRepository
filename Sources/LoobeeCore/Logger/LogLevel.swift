// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

public enum LogLevel: Int {
    case emergency, alert, critical, error, warning, notice, info, debug
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
