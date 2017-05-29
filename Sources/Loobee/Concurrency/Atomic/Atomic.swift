// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Each realization defines an atomic type. This type are thread safe.
public protocol Atomic {
    associatedtype IntegralType

    /// Create atomic object from integral value.
    init(_ value: IntegralType)

    /// Return true if the type is always lock-free.
    static func isLockFree() -> Bool

    /// Atomically assign the value of the atomic object.
    ///
    /// - Parameters:
    ///     - desired: The value to store into the atomic object.
    ///     - order:   Memory order constraints to enforce.
    mutating func store(_ desired: IntegralType, order: AtomicOrder)

    /// Atomically obtains the value of the atomic object.
    ///
    /// - Parameters:
    ///     - order: Memory order constraints to enforce.
    ///
    /// - Returns: The current value of the atomic object.
    mutating func load(order: AtomicOrder) -> IntegralType

    /// Atomically assign the value of the atomic object and obtains the value held previously.
    ///
    /// - Parameters:
    ///     - desired: The value to assign to the atomic object.
    ///     - order:   Memory order constraints to enforce.
    ///
    /// - Returns: The value of the atomic object before the call this method.
    mutating func exchange(_ desired: IntegralType, order: AtomicOrder) -> IntegralType

    /// Atomically compares the value of the atomic object and performs `exchange` if
    /// values are equals or atomic load if not.
    ///
    /// - Parameters:
    ///     - expected:     In-out parameter to the value expected to be found in the atomic object.
    ///     - desired:      The value to store in the atomic object if it is as expected.
    ///     - successOrder: The memory synchronization ordering for the read-modify-write operation if the
    ///                     comparison succeeds. All values are permitted.
    ///     - failureOrder: The memory synchronization ordering for the load operation if the comparison fails.
    ///
    /// - Returns: Value of the atomic object was successfully changed.
    mutating func compareExchangeWeak(
            expected: inout IntegralType,
            desired: IntegralType,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool

    /// Atomically compares the value of the atomic object and performs `exchange` if
    /// values are equals or atomic load if not.
    ///
    /// - Parameters:
    ///     - expected: In-out parameter to the value expected to be found in the atomic object.
    ///     - desired:  The value to store in the atomic object if it is as expected.
    ///     - order:    The memory synchronization ordering for success and failure operations.
    ///
    /// - Returns: Value of the atomic object was successfully changed.
    mutating func compareExchangeWeak(
            expected: inout IntegralType,
            desired: IntegralType,
            order: AtomicOrder
    ) -> Bool

    /// Atomically compares the value of the atomic object and performs `exchange` if
    /// values are equals or atomic load if not.
    ///
    /// - Parameters:
    ///     - expected:     In-out parameter to the value expected to be found in the atomic object.
    ///     - desired:      The value to store in the atomic object if it is as expected.
    ///     - successOrder: The memory synchronization ordering for the read-modify-write operation if the
    ///                     comparison succeeds. All values are permitted.
    ///     - failureOrder: The memory synchronization ordering for the load operation if the comparison fails.
    ///
    /// - Returns: Value of the atomic object was successfully changed.
    mutating func compareExchangeStrong(
            expected: inout IntegralType,
            desired: IntegralType,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool

    /// Atomically compares the value of the atomic object and performs `exchange` if
    /// values are equals or atomic load if not.
    ///
    /// - Parameters:
    ///     - expected: In-out parameter to the value expected to be found in the atomic object.
    ///     - desired:  The value to store in the atomic object if it is as expected.
    ///     - order:    The memory synchronization ordering for success and failure operations.
    ///
    /// - Returns: Value of the atomic object was successfully changed.
    mutating func compareExchangeStrong(
            expected: inout IntegralType,
            desired: IntegralType,
            order: AtomicOrder
    ) -> Bool
}
