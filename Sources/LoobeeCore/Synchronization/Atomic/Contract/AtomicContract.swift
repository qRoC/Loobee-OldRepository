// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Each realization defines an atomic primitive type.
///
/// - Note: Primitive types are copied unsafe.
public protocol AtomicContract {
    /// Return true if the type is always lock-free.
    static func isAlwaysLockFree() -> Bool

    /// Atomically assign the value.
    ///
    /// - Parameter value: The value to store.
    /// - Parameter order: Memory order constraints to enforce.
    ///
    /// - Precondition: `order` must be one of `.relaxed`, `.release` or `.seqCst`.
    mutating func atomicStore(_ value: Self, withOrder order: AtomicOrder)

    /// Atomically obtains the value.
    ///
    /// - Parameter order: Memory order constraints to enforce.
    ///
    /// - Precondition: `order` must be one of `.relaxed`, `.consume`, `.acquire` or `.seqCst`.
    ///
    /// - Returns: The current value.
    mutating func atomicLoad(withOrder order: AtomicOrder) -> Self

    /// Atomically assign the value of `newValue` and obtains the value held previously.
    ///
    /// - Parameter newValue: The value to assign.
    /// - Parameter order:    Memory order constraints to enforce.
    ///
    /// - Precondition: `order` cannot be `.consume`.
    ///
    /// - Returns: The value before the call this method.
    mutating func atomicExchange(newValue: Self, withOrder order: AtomicOrder) -> Self

    /// Atomically compares the value of `self` with that of `expected` and performs `exchange`
    /// if values are equals or atomic load if not.
    ///
    /// - Parameter expected:     In-out parameter to the value expected to be found.
    /// - Parameter desired:      The value to store if it is as expected.
    /// - Parameter successOrder: The memory synchronization ordering for the read-modify-write
    ///                           operation if the comparison succeeds.
    /// - Parameter failureOrder: The memory synchronization ordering for the load operation if
    ///                           the comparison fails.
    ///
    /// - Precondition: `failureOrder` cannot be `.release`, `.acqRel` or stronger than `successOrder`.
    ///
    /// - Returns: `true` if the value was successfully changed, `false` otherwise.
    mutating func atomicCompareAndExchangeWeak(
        expected: inout Self,
        desired: Self,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
    ) -> Bool

    /// Atomically compares the value of `self` with that of `expected` and performs `exchange`
    /// if values are equals or atomic load if not.
    ///
    /// - Parameter expected:     In-out parameter to the value expected to be found.
    /// - Parameter desired:      The value to store if it is as expected.
    /// - Parameter successOrder: The memory synchronization ordering for the read-modify-write
    ///                           operation if the comparison succeeds.
    /// - Parameter failureOrder: The memory synchronization ordering for the load operation if
    ///                           the comparison fails.
    ///
    /// - Precondition: `failureOrder` cannot be `.release`, `.acqRel` or stronger than `successOrder`.
    ///
    /// - Returns: `true` if the value was successfully changed, `false` otherwise.
    mutating func atomicCompareAndExchangeStrong(
        expected: inout Self,
        desired: Self,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
    ) -> Bool
}

extension AtomicContract {
    /// Atomically assign the value with the `.seqCst` memory order.
    ///
    /// - Parameter value: The value to store.
    @inlinable
    @inline(__always)
    public mutating func atomicStore(_ value: Self) {
        self.atomicStore(value, withOrder: .seqCst)
    }

    /// Atomically obtains the value with the `.seqCst` memory order.
    ///
    /// - Returns: The current value.
    @inlinable
    @inline(__always)
    public mutating func atomicLoad() -> Self {
        return self.atomicLoad(withOrder: .seqCst)
    }

    /// Atomically assign the value of `newValue` and obtains the value held previously.
    /// The operation with `.seqCst` memory order.
    ///
    /// - Parameter newValue: The value to assign.
    ///
    /// - Returns: The value before the call this method.
    @inlinable
    @inline(__always)
    public mutating func atomicExchange(newValue: Self) -> Self {
        return self.atomicExchange(newValue: newValue, withOrder: .seqCst)
    }

    /// Atomically compares the value of `self` with that of `expected` and performs `exchange`
    /// if values are equals or atomic load if not.
    ///
    /// - Note: This method replace value of `order` from `.release` to `.relaxed`
    ///         and `.acqRel` to `.acquire` for load operations.
    ///
    /// - Parameter expected:     In-out parameter to the value expected to be found.
    /// - Parameter desired:      The value to store if it is as expected.
    /// - Parameter order:        The memory synchronization ordering for the read-modify-write
    ///                           and load operations.
    ///
    /// - Returns: `true` if the value was successfully changed, `false` otherwise.
    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeWeak(
        expected: inout Self,
        desired: Self,
        withOrder order: AtomicOrder
        ) -> Bool {
        let failureOrder: AtomicOrder = {
            switch order {
            case .release:
                return .relaxed
            case .acqRel:
                return .acquire
            default:
                return order
            }
        }()

        return self.atomicCompareAndExchangeWeak(
            expected: &expected,
            desired: desired,
            successOrder: order,
            failureOrder: failureOrder
        )
    }

    /// Atomically compares the value of `self` with that of `expected` and performs `exchange`
    /// if values are equals or atomic load if not. All operations with the `.seqCst` memory order.
    ///
    /// - Parameter expected:     In-out parameter to the value expected to be found.
    /// - Parameter desired:      The value to store if it is as expected.
    ///
    /// - Returns: `true` if the value was successfully changed, `false` otherwise.
    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeWeak(expected: inout Self, desired: Self) -> Bool {
        return self.atomicCompareAndExchangeWeak(
            expected: &expected,
            desired: desired,
            successOrder: .seqCst,
            failureOrder: .seqCst
        )
    }

    /// Atomically compares the value of `self` with that of `expected` and performs `exchange`
    /// if values are equals or atomic load if not.
    ///
    /// - Note: This method replace value of `order` from `.release` to `.relaxed`
    ///         and `.acqRel` to `.acquire` for load operations.
    ///
    /// - Parameter expected:     In-out parameter to the value expected to be found.
    /// - Parameter desired:      The value to store if it is as expected.
    /// - Parameter order:        The memory synchronization ordering for the read-modify-write
    ///                           and load operations.
    ///
    /// - Returns: `true` if the value was successfully changed, `false` otherwise.
    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeStrong(
        expected: inout Self,
        desired: Self,
        withOrder order: AtomicOrder
        ) -> Bool {
        let failureOrder: AtomicOrder = {
            switch order {
            case .release:
                return .relaxed
            case .acqRel:
                return .acquire
            default:
                return order
            }
        }()

        return self.atomicCompareAndExchangeStrong(
            expected: &expected,
            desired: desired,
            successOrder: order,
            failureOrder: failureOrder
        )
    }

    /// Atomically compares the value of `self` with that of `expected` and performs `exchange`
    /// if values are equals or atomic load if not. All operations with the `.seqCst` memory order.
    ///
    /// - Parameter expected:     In-out parameter to the value expected to be found.
    /// - Parameter desired:      The value to store if it is as expected.
    ///
    /// - Returns: `true` if the value was successfully changed, `false` otherwise.
    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeStrong(expected: inout Self, desired: Self) -> Bool {
        return self.atomicCompareAndExchangeStrong(
            expected: &expected,
            desired: desired,
            successOrder: .seqCst,
            failureOrder: .seqCst
        )
    }
}
