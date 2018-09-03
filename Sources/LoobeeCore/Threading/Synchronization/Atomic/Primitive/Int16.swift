// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import CLoobeeCore

extension Int16: AtomicContract {
    @inlinable
    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return CLoobeeCoreAtomicInt16_isLockFree
    }

    @inlinable
    @inline(__always)
    public mutating func atomicStore(_ value: Int16, withOrder order: AtomicOrder) {
        CLoobeeCoreAtomicInt16_store(&self, desired: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicLoad(withOrder order: AtomicOrder) -> Int16 {
        return CLoobeeCoreAtomicInt16_load(&self, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicExchange(newValue: Int16, withOrder order: AtomicOrder) -> Int16 {
        return CLoobeeCoreAtomicInt16_exchange(&self, desired: newValue, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeWeak(
        expected: inout Int16,
        desired: Int16,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicInt16_compareExchangeWeak(
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
        expected: inout Int16,
        desired: Int16,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicInt16_compareExchangeStrong(
            &self,
            expected: &expected,
            desired: desired,
            successOrder: successOrder,
            failureOrder: failureOrder
        )
    }
}

extension Int16: AtomicArithmeticContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndAdd(_ value: Int16, withOrder order: AtomicOrder) -> Int16 {
        return CLoobeeCoreAtomicInt16_fetchAndAdd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndSub(_ value: Int16, withOrder order: AtomicOrder) -> Int16 {
        return CLoobeeCoreAtomicInt16_fetchAndSub(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicAddAndFetch(_ value: Int16, withOrder order: AtomicOrder) -> Int16 {
        return CLoobeeCoreAtomicInt16_addAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicSubAndFetch(_ value: Int16, withOrder order: AtomicOrder) -> Int16 {
        return CLoobeeCoreAtomicInt16_subAndFetch(&self, op: value, order: order)
    }
}

extension Int16: AtomicBitwiseContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitAnd(_ value: Int16, withOrder order: AtomicOrder) -> Int16 {
        return CLoobeeCoreAtomicInt16_fetchAndBitAnd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitOr(_ value: Int16, withOrder order: AtomicOrder) -> Int16 {
        return CLoobeeCoreAtomicInt16_fetchAndBitOr(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitXor(_ value: Int16, withOrder order: AtomicOrder) -> Int16 {
        return CLoobeeCoreAtomicInt16_fetchAndBitXor(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitAndAndFetch(_ value: Int16, withOrder order: AtomicOrder) -> Int16 {
        return CLoobeeCoreAtomicInt16_bitAndAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitOrAndFetch(_ value: Int16, withOrder order: AtomicOrder) -> Int16 {
        return CLoobeeCoreAtomicInt16_bitOrAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitXorAndFetch(_ value: Int16, withOrder order: AtomicOrder) -> Int16 {
        return CLoobeeCoreAtomicInt16_bitXorAndFetch(&self, op: value, order: order)
    }
}
