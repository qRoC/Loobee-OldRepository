// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Represents a smallest unit of storage. A bit stores just a `zero` or `one`.
public enum Bit {
    case zero
    case one
}

extension Bit {
    /// The logical NOT operator (`!`) flips the value.
    ///
    ///     let bit: Bit = .zero
    ///     let flipped = !bit
    ///     print(flipped == .one) // true
    @inlinable
    public static prefix func ! (bit: Bit) -> Bit {
        return bit == .one ? .zero : .one
    }

    /// Flips the current value.
    ///
    ///     let bit: Bit = .zero
    ///     bit.toggle()
    ///     print(bit == .one) // true
    @inlinable
    public mutating func toggle() {
        self = !self
    }
}

extension Bit: CustomStringConvertible {
    @inlinable public var description: String {
        return self == .one ? "1" : "0"
    }
}

extension Bit: CustomDebugStringConvertible {
    @inlinable public var debugDescription: String {
        return "Bit(\"\(self.description)\")"
    }
}

extension Bit: LosslessStringConvertible {
    @inlinable
    public init?(_ description: String) {
        if _fastPath(description == "1") {
            self = .one
        } else if _fastPath(description == "0") {
            self = .zero
        } else {
            return nil
        }
    }
}
