// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// A box that provides atomic access to an object, maintaining the correct retain counts.
public final class AtomicBox<T> where T: AnyObject {
    @usableFromInline
    internal var address: UInt

    @inlinable
    public init(object: T) {
        self.address = .init(bitPattern: Unmanaged<T>.passRetained(object).toOpaque())
    }

    @inlinable
    deinit {
        let address = self.address.atomicLoad(withOrder: .seqCst)
        Unmanaged<T>.fromOpaque(UnsafeRawPointer(bitPattern: address)!).release()
    }

    /// Return true if the type is always lock-free.
    @inlinable
    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return UInt.isAlwaysLockFree()
    }

    /// Atomically assign the object.
    ///
    /// - Parameter object: The object to store.
    /// - Parameter order:  Memory order constraints to enforce.
    @inlinable
    public func store(_ object: T, withOrder order: AtomicOrder) {
        let newAddress = UInt(bitPattern: Unmanaged<T>.passRetained(object).toOpaque())
        let oldAddress = self.address.atomicExchange(newValue: newAddress, withOrder: order)

        Unmanaged<T>.fromOpaque(UnsafeRawPointer(bitPattern: oldAddress)!).release()
    }

    /// Atomically assign the object with the `.seqCst` memory order.
    ///
    /// - Parameter object: The object to store.
    @inlinable
    @inline(__always)
    public func store(_ object: T) {
        self.store(object, withOrder: .seqCst)
    }

    /// Atomically obtains the object.
    ///
    /// - Parameter order: Memory order constraints to enforce.
    ///
    /// - Precondition: `order` must be one of `.relaxed`, `.consume`, `.acquire` or `.seqCst`.
    ///
    /// - Returns: The current object.
    @inlinable
    public func load(withOrder order: AtomicOrder) -> T {
        let address = self.address.atomicLoad(withOrder: order)

        return Unmanaged<T>.fromOpaque(
            UnsafeRawPointer(bitPattern: address)!
            ).takeUnretainedValue()
    }

    /// Atomically obtains the object with the `.seqCst` memory order.
    ///
    /// - Returns: The current object.
    @inlinable
    @inline(__always)
    public func load() -> T {
        return self.load(withOrder: .seqCst)
    }

    /// Atomically assign the object of `newObject` and obtains the object held previously.
    ///
    /// - Parameter newObject: The object to assign.
    /// - Parameter order:     Memory order constraints to enforce.
    ///
    /// - Precondition: `order` cannot be `.consume`.
    ///
    /// - Returns: The object before the call this method.
    @inlinable
    public func exchange(newObject: T, withOrder order: AtomicOrder) -> T {
        let oldPointer = self.address.atomicExchange(
            newValue: UInt(bitPattern: Unmanaged<T>.passRetained(newObject).toOpaque()),
            withOrder: order
        )
        return Unmanaged<T>.fromOpaque(UnsafeRawPointer(bitPattern: oldPointer)!).takeRetainedValue()
    }

    /// Atomically assign the object of `newObject` and obtains the object held previously.
    /// The operation with `.seqCst` memory order.
    ///
    /// - Parameter newObject: The object to assign.
    ///
    /// - Returns: The object before the call this method.
    @inlinable
    @inline(__always)
    public func exchange(newObject: T) -> T {
        return self.exchange(newObject: newObject, withOrder: .seqCst)
    }

    /// Atomically compares the object of `self` with that of `expected` and performs `exchange`
    /// if objects are equals or atomic load if not.
    ///
    /// - Parameter expected:     In-out parameter to the object expected to be found.
    /// - Parameter desired:      The object to store if it is as expected.
    /// - Parameter successOrder: The memory synchronization ordering for the read-modify-write
    ///                           operation if the comparison succeeds.
    /// - Parameter failureOrder: The memory synchronization ordering for the load operation if
    ///                           the comparison fails.
    ///
    /// - Precondition: `failureOrder` cannot be `.release`, `.acqRel` or stronger than `successOrder`.
    ///
    /// - Returns: `true` if the object was successfully changed, `false` otherwise.
    @inlinable
    public func compareAndExchangeWeak(
        expected: inout T,
        desired: T,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return withExtendedLifetime(desired) {
            let expectedPointer = Unmanaged<T>.passUnretained(expected)
            let desiredPointer = Unmanaged<T>.passUnretained(desired)

            var expectedAddress = UInt(bitPattern: expectedPointer.toOpaque())
            let desiredAddress = UInt(bitPattern: desiredPointer.toOpaque())

            let result = self.address.atomicCompareAndExchangeWeak(
                expected: &expectedAddress,
                desired: desiredAddress,
                successOrder: successOrder,
                failureOrder: failureOrder
            )

            expected = Unmanaged<T>.fromOpaque(UnsafeRawPointer(bitPattern: expectedAddress)!).takeUnretainedValue()

            if result {
                _ = desiredPointer.retain()
                expectedPointer.release()
            }

            return result
        }
    }

    /// Atomically compares the object of `self` with that of `expected` and performs `exchange`
    /// if objects are equals or atomic load if not.
    ///
    /// - Note: This method replace value of `order` from `.release` to `.relaxed`
    ///         and `.acqRel` to `.acquire` for load operations.
    ///
    /// - Parameter expected:     In-out parameter to the object expected to be found.
    /// - Parameter desired:      The object to store if it is as expected.
    /// - Parameter order:        The memory synchronization ordering for the read-modify-write
    ///                           and load operations.
    ///
    /// - Returns: `true` if the object was successfully changed, `false` otherwise.
    @inlinable
    @inline(__always)
    public func compareAndExchangeWeak(
        expected: inout T,
        desired: T,
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

        return self.compareAndExchangeWeak(
            expected: &expected,
            desired: desired,
            successOrder: order,
            failureOrder: failureOrder
        )
    }

    /// Atomically compares the object of `self` with that of `expected` and performs `exchange`
    /// if objects are equals or atomic load if not. All operations with the `.seqCst` memory order.
    ///
    /// - Parameter expected:     In-out parameter to the object expected to be found.
    /// - Parameter desired:      The object to store if it is as expected.
    ///
    /// - Returns: `true` if the object was successfully changed, `false` otherwise.
    @inlinable
    @inline(__always)
    public func compareAndExchangeWeak(
        expected: inout T,
        desired: T
        ) -> Bool {
        return self.compareAndExchangeWeak(
            expected: &expected,
            desired: desired,
            withOrder: .seqCst
        )
    }

    /// Atomically compares the object of `self` with that of `expected` and performs `exchange`
    /// if objects are equals or atomic load if not.
    ///
    /// - Parameter expected:     In-out parameter to the object expected to be found.
    /// - Parameter desired:      The object to store if it is as expected.
    /// - Parameter successOrder: The memory synchronization ordering for the read-modify-write
    ///                           operation if the comparison succeeds.
    /// - Parameter failureOrder: The memory synchronization ordering for the load operation if
    ///                           the comparison fails.
    ///
    /// - Precondition: `failureOrder` cannot be `.release`, `.acqRel` or stronger than `successOrder`.
    ///
    /// - Returns: `true` if the object was successfully changed, `false` otherwise.
    @inlinable
    public func compareAndExchangeStrong(
        expected: inout T,
        desired: T,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
    ) -> Bool {
        return withExtendedLifetime(desired) {
            let expectedPointer = Unmanaged<T>.passUnretained(expected)
            let desiredPointer = Unmanaged<T>.passUnretained(desired)

            var expectedAddress = UInt(bitPattern: expectedPointer.toOpaque())
            let desiredAddress = UInt(bitPattern: desiredPointer.toOpaque())

            let result = self.address.atomicCompareAndExchangeStrong(
                expected: &expectedAddress,
                desired: desiredAddress,
                successOrder: successOrder,
                failureOrder: failureOrder
            )

            expected = Unmanaged<T>.fromOpaque(UnsafeRawPointer(bitPattern: expectedAddress)!).takeUnretainedValue()

            if result {
                _ = desiredPointer.retain()
                expectedPointer.release()
            }

            return result
        }
    }

    /// Atomically compares the object of `self` with that of `expected` and performs `exchange`
    /// if objects are equals or atomic load if not.
    ///
    /// - Note: This method replace value of `order` from `.release` to `.relaxed`
    ///         and `.acqRel` to `.acquire` for load operations.
    ///
    /// - Parameter expected:     In-out parameter to the object expected to be found.
    /// - Parameter desired:      The object to store if it is as expected.
    /// - Parameter order:        The memory synchronization ordering for the read-modify-write
    ///                           and load operations.
    ///
    /// - Returns: `true` if the object was successfully changed, `false` otherwise.
    @inlinable
    @inline(__always)
    public func compareAndExchangeStrong(
        expected: inout T,
        desired: T,
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

        return self.compareAndExchangeStrong(
            expected: &expected,
            desired: desired,
            successOrder: order,
            failureOrder: failureOrder
        )
    }

    /// Atomically compares the object of `self` with that of `expected` and performs `exchange`
    /// if objects are equals or atomic load if not. All operations with the `.seqCst` memory order.
    ///
    /// - Parameter expected:     In-out parameter to the object expected to be found.
    /// - Parameter desired:      The object to store if it is as expected.
    ///
    /// - Returns: `true` if the object was successfully changed, `false` otherwise.
    @inlinable
    @inline(__always)
    public func compareAndExchangeStrong(
        expected: inout T,
        desired: T
        ) -> Bool {
        return self.compareAndExchangeStrong(
            expected: &expected,
            desired: desired,
            withOrder: .seqCst
        )
    }
}
