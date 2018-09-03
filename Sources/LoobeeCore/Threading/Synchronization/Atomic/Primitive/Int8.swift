// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import CLoobeeCore

extension Int8: AtomicContract {
    @inlinable
    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return CLoobeeCoreAtomicInt8_isLockFree
    }

    @inlinable
    @inline(__always)
    public mutating func atomicStore(_ value: Int8, withOrder order: AtomicOrder) {
        CLoobeeCoreAtomicInt8_store(&self, desired: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicLoad(withOrder order: AtomicOrder) -> Int8 {
        return CLoobeeCoreAtomicInt8_load(&self, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicExchange(newValue: Int8, withOrder order: AtomicOrder) -> Int8 {
        return CLoobeeCoreAtomicInt8_exchange(&self, desired: newValue, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeWeak(
        expected: inout Int8,
        desired: Int8,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicInt8_compareExchangeWeak(
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
        expected: inout Int8,
        desired: Int8,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicInt8_compareExchangeStrong(
            &self,
            expected: &expected,
            desired: desired,
            successOrder: successOrder,
            failureOrder: failureOrder
        )
    }
}

extension Int8: AtomicArithmeticContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndAdd(_ value: Int8, withOrder order: AtomicOrder) -> Int8 {
        return CLoobeeCoreAtomicInt8_fetchAndAdd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndSub(_ value: Int8, withOrder order: AtomicOrder) -> Int8 {
        return CLoobeeCoreAtomicInt8_fetchAndSub(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicAddAndFetch(_ value: Int8, withOrder order: AtomicOrder) -> Int8 {
        return CLoobeeCoreAtomicInt8_addAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicSubAndFetch(_ value: Int8, withOrder order: AtomicOrder) -> Int8 {
        return CLoobeeCoreAtomicInt8_subAndFetch(&self, op: value, order: order)
    }
}

extension Int8: AtomicBitwiseContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitAnd(_ value: Int8, withOrder order: AtomicOrder) -> Int8 {
        return CLoobeeCoreAtomicInt8_fetchAndBitAnd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitOr(_ value: Int8, withOrder order: AtomicOrder) -> Int8 {
        return CLoobeeCoreAtomicInt8_fetchAndBitOr(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitXor(_ value: Int8, withOrder order: AtomicOrder) -> Int8 {
        return CLoobeeCoreAtomicInt8_fetchAndBitXor(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitAndAndFetch(_ value: Int8, withOrder order: AtomicOrder) -> Int8 {
        return CLoobeeCoreAtomicInt8_bitAndAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitOrAndFetch(_ value: Int8, withOrder order: AtomicOrder) -> Int8 {
        return CLoobeeCoreAtomicInt8_bitOrAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitXorAndFetch(_ value: Int8, withOrder order: AtomicOrder) -> Int8 {
        return CLoobeeCoreAtomicInt8_bitXorAndFetch(&self, op: value, order: order)
    }
}
