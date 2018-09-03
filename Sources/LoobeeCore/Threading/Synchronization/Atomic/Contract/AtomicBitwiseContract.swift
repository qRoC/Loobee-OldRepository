// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

public protocol AtomicBitwiseContract {
    /// Atomically performs bitwise AND and return the value held previously.
    ///
    /// - Parameter value: Value of bitwise AND.
    /// - Parameter order: Memory order constraints to enforce.
    ///
    /// - Returns: The value before the call this method.
    mutating func atomicFetchAndBitAnd(_ value: Self, withOrder order: AtomicOrder) -> Self

    /// Atomically performs bitwise OR and return the value held previously.
    ///
    /// - Parameter value: Value of bitwise OR.
    /// - Parameter order: Memory order constraints to enforce.
    ///
    /// - Returns: The value before the call this method.
    mutating func atomicFetchAndBitOr(_ value: Self, withOrder order: AtomicOrder) -> Self

    /// Atomically performs bitwise XOR and return the value held previously.
    ///
    /// - Parameter value: Value of bitwise XOR.
    /// - Parameter order: Memory order constraints to enforce.
    ///
    /// - Returns: The value before the call this method.
    mutating func atomicFetchAndBitXor(_ value: Self, withOrder order: AtomicOrder) -> Self

    /// Atomically performs bitwise AND and return the value held later.
    ///
    /// - Parameter value: Value of bitwise AND.
    /// - Parameter order: Memory order constraints to enforce.
    ///
    /// - Returns: The value after bitwise operation of this method.
    mutating func atomicBitAndAndFetch(_ value: Self, withOrder order: AtomicOrder) -> Self

    /// Atomically performs bitwise OR and return the value held later.
    ///
    /// - Parameter value: Value of bitwise OR.
    /// - Parameter order: Memory order constraints to enforce.
    ///
    /// - Returns: The value after bitwise operation of this method.
    mutating func atomicBitOrAndFetch(_ value: Self, withOrder order: AtomicOrder) -> Self

    /// Atomically performs bitwise XOR and return the value held later.
    ///
    /// - Parameter value: Value of bitwise XOR.
    /// - Parameter order: Memory order constraints to enforce.
    ///
    /// - Returns: The value after bitwise operation of this method.
    mutating func atomicBitXorAndFetch(_ value: Self, withOrder order: AtomicOrder) -> Self
}

extension AtomicBitwiseContract {
    /// Atomically performs bitwise AND and return the value held previously.
    /// The operation with `.seqCst` memory order.
    ///
    /// - Parameter value: Value of bitwise AND.
    ///
    /// - Returns: The value before the call this method.
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitAnd(_ value: Self) -> Self {
        return self.atomicFetchAndBitAnd(value, withOrder: .seqCst)
    }

    /// Atomically performs bitwise OR and return the value held previously.
    /// The operation with `.seqCst` memory order.
    ///
    /// - Parameter value: Value of bitwise OR.
    ///
    /// - Returns: The value before the call this method.
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitOr(_ value: Self) -> Self {
        return self.atomicFetchAndBitOr(value, withOrder: .seqCst)
    }

    /// Atomically performs bitwise XOR and return the value held previously.
    /// The operation with `.seqCst` memory order.
    ///
    /// - Parameter value: Value of bitwise XOR.
    ///
    /// - Returns: The value before the call this method.
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitXor(_ value: Self) -> Self {
        return self.atomicFetchAndBitXor(value, withOrder: .seqCst)
    }

    /// Atomically performs bitwise AND and return the value held later.
    /// The operation with `.seqCst` memory order.
    ///
    /// - Parameter value: Value of bitwise AND.
    ///
    /// - Returns: The value after bitwise operation of this method.
    @inlinable
    @inline(__always)
    public mutating func atomicBitAndAndFetch(_ value: Self) -> Self {
        return self.atomicBitAndAndFetch(value, withOrder: .seqCst)
    }

    /// Atomically performs bitwise OR and return the value held later.
    /// The operation with `.seqCst` memory order.
    ///
    /// - Parameter value: Value of bitwise OR.
    ///
    /// - Returns: The value after bitwise operation of this method.
    @inlinable
    @inline(__always)
    public mutating func atomicBitOrAndFetch(_ value: Self) -> Self {
        return self.atomicBitOrAndFetch(value, withOrder: .seqCst)
    }

    /// Atomically performs bitwise XOR and return the value held later.
    /// The operation with `.seqCst` memory order.
    ///
    /// - Parameter value: Value of bitwise XOR.
    ///
    /// - Returns: The value after bitwise operation of this method.
    @inlinable
    @inline(__always)
    public mutating func atomicBitXorAndFetch(_ value: Self) -> Self {
        return self.atomicBitXorAndFetch(value, withOrder: .seqCst)
    }
}
