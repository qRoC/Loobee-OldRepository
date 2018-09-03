// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import CLoobeeCore

extension Int64: AtomicContract {
    @inlinable
    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return CLoobeeCoreAtomicInt64_isLockFree
    }

    @inlinable
    @inline(__always)
    public mutating func atomicStore(_ value: Int64, withOrder order: AtomicOrder) {
        CLoobeeCoreAtomicInt64_store(&self, desired: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicLoad(withOrder order: AtomicOrder) -> Int64 {
        return CLoobeeCoreAtomicInt64_load(&self, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicExchange(newValue: Int64, withOrder order: AtomicOrder) -> Int64 {
        return CLoobeeCoreAtomicInt64_exchange(&self, desired: newValue, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeWeak(
        expected: inout Int64,
        desired: Int64,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicInt64_compareExchangeWeak(
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
        expected: inout Int64,
        desired: Int64,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicInt64_compareExchangeStrong(
            &self,
            expected: &expected,
            desired: desired,
            successOrder: successOrder,
            failureOrder: failureOrder
        )
    }
}

extension Int64: AtomicArithmeticContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndAdd(_ value: Int64, withOrder order: AtomicOrder) -> Int64 {
        return CLoobeeCoreAtomicInt64_fetchAndAdd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndSub(_ value: Int64, withOrder order: AtomicOrder) -> Int64 {
        return CLoobeeCoreAtomicInt64_fetchAndSub(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicAddAndFetch(_ value: Int64, withOrder order: AtomicOrder) -> Int64 {
        return CLoobeeCoreAtomicInt64_addAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicSubAndFetch(_ value: Int64, withOrder order: AtomicOrder) -> Int64 {
        return CLoobeeCoreAtomicInt64_subAndFetch(&self, op: value, order: order)
    }
}

extension Int64: AtomicBitwiseContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitAnd(_ value: Int64, withOrder order: AtomicOrder) -> Int64 {
        return CLoobeeCoreAtomicInt64_fetchAndBitAnd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitOr(_ value: Int64, withOrder order: AtomicOrder) -> Int64 {
        return CLoobeeCoreAtomicInt64_fetchAndBitOr(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitXor(_ value: Int64, withOrder order: AtomicOrder) -> Int64 {
        return CLoobeeCoreAtomicInt64_fetchAndBitXor(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitAndAndFetch(_ value: Int64, withOrder order: AtomicOrder) -> Int64 {
        return CLoobeeCoreAtomicInt64_bitAndAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitOrAndFetch(_ value: Int64, withOrder order: AtomicOrder) -> Int64 {
        return CLoobeeCoreAtomicInt64_bitOrAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitXorAndFetch(_ value: Int64, withOrder order: AtomicOrder) -> Int64 {
        return CLoobeeCoreAtomicInt64_bitXorAndFetch(&self, op: value, order: order)
    }
}
