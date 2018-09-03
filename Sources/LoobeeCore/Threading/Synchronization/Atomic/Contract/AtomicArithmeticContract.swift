// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

public protocol AtomicArithmeticContract {
    /// Atomically add the integral value and return the value held previously.
    ///
    /// - Parameter value: Value for arithmetic addition.
    /// - Parameter order: Memory order constraints to enforce.
    ///
    /// - Returns: The value before the call this method.
    mutating func atomicFetchAndAdd(_ value: Self, withOrder order: AtomicOrder) -> Self

    /// Atomically subtract the integral value and return the value held previously.
    ///
    /// - Parameter value: Value for arithmetic subtraction.
    /// - Parameter order: Memory order constraints to enforce.
    ///
    /// - Returns: The value before the call this method.
    mutating func atomicFetchAndSub(_ value: Self, withOrder order: AtomicOrder) -> Self

    /// Atomically add the integral value and return the value held later.
    ///
    /// - Parameter value: Value for arithmetic addition.
    /// - Parameter order: Memory order constraints to enforce.
    ///
    /// - Returns: The value after adds in this method.
    mutating func atomicAddAndFetch(_ value: Self, withOrder order: AtomicOrder) -> Self

    /// Atomically subtract the integral value and return the value held later.
    ///
    /// - Parameter value: Value for arithmetic subtraction.
    /// - Parameter order: Memory order constraints to enforce.
    ///
    /// - Returns: The value after subtracts in this method.
    mutating func atomicSubAndFetch(_ value: Self, withOrder order: AtomicOrder) -> Self
}

extension AtomicArithmeticContract {
    /// Atomically add the integral value and return the value held previously.
    /// The operation with `.seqCst` memory order.
    ///
    /// - Parameter value: Value for arithmetic addition.
    ///
    /// - Returns: The value before the call this method.
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndAdd(_ value: Self) -> Self {
        return self.atomicFetchAndAdd(value, withOrder: .seqCst)
    }

    /// Atomically subtract the integral value and return the value held previously.
    /// The operation with `.seqCst` memory order.
    ///
    /// - Parameter value: Value for arithmetic subtraction.
    ///
    /// - Returns: The value before the call this method.
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndSub(_ value: Self) -> Self {
        return self.atomicFetchAndSub(value, withOrder: .seqCst)
    }

    /// Atomically add the integral value and return the value held later.
    /// The operation with `.seqCst` memory order.
    ///
    /// - Parameter value: Value for arithmetic addition.
    ///
    /// - Returns: The value after adds in this method.
    @inlinable
    @inline(__always)
    public mutating func atomicAddAndFetch(_ value: Self) -> Self {
        return self.atomicAddAndFetch(value, withOrder: .seqCst)
    }

    /// Atomically subtract the integral value and return the value held later.
    ///
    /// - Parameter value: Value for arithmetic subtraction.
    ///
    /// - Returns: The value after subtracts in this method.
    @inlinable
    @inline(__always)
    public mutating func atomicSubAndFetch(_ value: Self) -> Self {
        return self.atomicSubAndFetch(value, withOrder: .seqCst)
    }
}
