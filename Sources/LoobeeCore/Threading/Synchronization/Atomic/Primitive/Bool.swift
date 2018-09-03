// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import CLoobeeCore

extension Bool: AtomicContract {
    @inlinable
    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return CLoobeeCoreAtomicBool_isLockFree
    }

    @inlinable
    @inline(__always)
    public mutating func atomicStore(_ value: Bool, withOrder order: AtomicOrder) {
        return CLoobeeCoreAtomicBool_store(&self, desired: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicLoad(withOrder order: AtomicOrder) -> Bool {
        return CLoobeeCoreAtomicBool_load(&self, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicExchange(newValue: Bool, withOrder order: AtomicOrder) -> Bool {
        return CLoobeeCoreAtomicBool_exchange(&self, desired: newValue, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeWeak(
        expected: inout Bool,
        desired: Bool,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
    ) -> Bool {
        return CLoobeeCoreAtomicBool_compareExchangeWeak(
            &self,
            expected: &expected,
            desired: desired,
            successOrder: successOrder,
            failureOrder: failureOrder
        )
    }

    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeStrong(
        expected: inout Bool,
        desired: Bool,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
    ) -> Bool {
        return CLoobeeCoreAtomicBool_compareExchangeStrong(
            &self,
            expected: &expected,
            desired: desired,
            successOrder: successOrder,
            failureOrder: failureOrder
        )
    }
}
