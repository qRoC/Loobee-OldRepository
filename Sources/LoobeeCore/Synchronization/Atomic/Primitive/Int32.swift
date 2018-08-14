// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import CLoobeeCore

extension Int32: AtomicContract {
    @inlinable
    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return CLoobeeCoreAtomicInt32_isLockFree
    }

    @inlinable
    @inline(__always)
    public mutating func atomicStore(_ value: Int32, withOrder order: AtomicOrder) {
        CLoobeeCoreAtomicInt32_store(&self, desired: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicLoad(withOrder order: AtomicOrder) -> Int32 {
        return CLoobeeCoreAtomicInt32_load(&self, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicExchange(newValue: Int32, withOrder order: AtomicOrder) -> Int32 {
        return CLoobeeCoreAtomicInt32_exchange(&self, desired: newValue, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeWeak(
        expected: inout Int32,
        desired: Int32,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicInt32_compareExchangeWeak(
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
        expected: inout Int32,
        desired: Int32,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicInt32_compareExchangeStrong(
            &self,
            expected: &expected,
            desired: desired,
            successOrder: successOrder,
            failureOrder: failureOrder
        )
    }
}

extension Int32: AtomicArithmeticContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndAdd(_ value: Int32, withOrder order: AtomicOrder) -> Int32 {
        return CLoobeeCoreAtomicInt32_fetchAndAdd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndSub(_ value: Int32, withOrder order: AtomicOrder) -> Int32 {
        return CLoobeeCoreAtomicInt32_fetchAndSub(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicAddAndFetch(_ value: Int32, withOrder order: AtomicOrder) -> Int32 {
        return CLoobeeCoreAtomicInt32_addAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicSubAndFetch(_ value: Int32, withOrder order: AtomicOrder) -> Int32 {
        return CLoobeeCoreAtomicInt32_subAndFetch(&self, op: value, order: order)
    }
}

extension Int32: AtomicBitwiseContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitAnd(_ value: Int32, withOrder order: AtomicOrder) -> Int32 {
        return CLoobeeCoreAtomicInt32_fetchAndBitAnd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitOr(_ value: Int32, withOrder order: AtomicOrder) -> Int32 {
        return CLoobeeCoreAtomicInt32_fetchAndBitOr(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitXor(_ value: Int32, withOrder order: AtomicOrder) -> Int32 {
        return CLoobeeCoreAtomicInt32_fetchAndBitXor(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitAndAndFetch(_ value: Int32, withOrder order: AtomicOrder) -> Int32 {
        return CLoobeeCoreAtomicInt32_bitAndAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitOrAndFetch(_ value: Int32, withOrder order: AtomicOrder) -> Int32 {
        return CLoobeeCoreAtomicInt32_bitOrAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitXorAndFetch(_ value: Int32, withOrder order: AtomicOrder) -> Int32 {
        return CLoobeeCoreAtomicInt32_bitXorAndFetch(&self, op: value, order: order)
    }
}
