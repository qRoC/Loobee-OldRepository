// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCore

/// The Method token indicates the method to be performed on the resource identified by the Request-URI.
///
/// That includes methods from [RFC2616 5.1.1](https://tools.ietf.org/html/rfc2616#section-5.1.1)
/// and [RFC5789](https://tools.ietf.org/html/rfc5789).
public enum HttpMethod: LosslessStringConvertible, TextOutputStreamable {
    case get
    case post
    case options
    case delete
    case head
    case connect
    case put
    case trace
    case patch

    public var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .options:
            return "OPTIONS"
        case .delete:
            return "DELETE"
        case .head:
            return "HEAD"
        case .connect:
            return "CONNECT"
        case .put:
            return "PUT"
        case .trace:
            return "TRACE"
        case .patch:
            return "PATCH"
        }
    }

    /// - Note: Rule of "The method is case-sensitive." from RFC2616 5.1.1 is ignored.
    public init?<T>(_ description: T) where T: StringProtocol {
        switch true {
        case description.caseInsensitiveASCIICompare("GET"):
            self = .get
        case description.caseInsensitiveASCIICompare("POST"):
            self = .post
        case description.caseInsensitiveASCIICompare("OPTIONS"):
            self = .options
        case description.caseInsensitiveASCIICompare("DELETE"):
            self = .delete
        case description.caseInsensitiveASCIICompare("HEAD"):
            self = .head
        case description.caseInsensitiveASCIICompare("CONNECT"):
            self = .connect
        case description.caseInsensitiveASCIICompare("PUT"):
            self = .put
        case description.caseInsensitiveASCIICompare("TRACE"):
            self = .trace
        case description.caseInsensitiveASCIICompare("PATCH"):
            self = .patch
        default:
            return nil
        }
    }

    public func write<Target>(to target: inout Target) where Target: TextOutputStream {
        target.write(self.description)
    }
}
