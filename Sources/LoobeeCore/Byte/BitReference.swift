// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Represents a reference on a bit.
///
/// This structure allows manipulation with individual bits.
@_fixed_layout
public struct BitReference<T: FixedWidthInteger> {
    ///
    @usableFromInline internal let storagePointer: UnsafeMutablePointer<T>

    ///
    @usableFromInline internal let mask: T
}

extension BitReference {
    @inlinable public var value: Bit {
        /// Returns the referenced bit.
        get {
            return (self.storagePointer.pointee & self.mask) != 0 ? .one : .zero
        }
        /// Assigns a `Bit` to the referenced bit.
        set {
            switch newValue {
            case .one:
                self.storagePointer.pointee |= self.mask
            case .zero:
                self.storagePointer.pointee &= ~self.mask
            }
        }
    }
}

extension BitReference {
    @usableFromInline
    internal init(pointer: UnsafeMutablePointer<T>, bit: T.Magnitude) {
        self.storagePointer = pointer
        self.mask = 1 << (bit % T.Magnitude(MemoryLayout<T>.size * 8))
    }

    @usableFromInline
    internal init?(pointer: UnsafeMutablePointer<T>, rangeBit: T.Magnitude) {
        guard rangeBit < T(MemoryLayout<T>.size * 8) else {
            return nil
        }

        self.storagePointer = pointer
        self.mask = 1 << rangeBit
    }
}

extension BitReference {
    /// Flips the referenced bit.
    ///
    /// Analog of this function is:
    ///
    ///     bitReference.value.toggle() // call getter, do changes, call setter (if compiler can't optimize).
    ///
    /// But this function just do changes.
    @inlinable
    public mutating func toggle() {
        self.storagePointer.pointee ^= self.mask
    }
}

@inlinable
public func swap<T>(_ lhs: inout BitReference<T>, _ rhs: inout BitReference<T>) {
    let tmp = lhs.value
    lhs.value = rhs.value
    rhs.value = tmp
}

@inlinable
public func swap<T, U>(_ lhs: inout BitReference<T>, _ rhs: inout BitReference<U>) {
    let tmp = lhs.value
    lhs.value = rhs.value
    rhs.value = tmp
}

@inlinable
public func swap<T>(_ lhs: inout BitReference<T>, _ rhs: inout Bit) {
    let tmp = lhs.value
    lhs.value = rhs
    rhs = tmp
}

@inlinable
public func swap<T>(_ lhs: inout Bit, _ rhs: inout BitReference<T>) {
    let tmp = lhs
    lhs = rhs.value
    rhs.value = tmp
}
