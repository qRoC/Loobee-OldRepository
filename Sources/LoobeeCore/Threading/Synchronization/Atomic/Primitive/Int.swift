// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import CLoobeeCore

extension Int: AtomicContract {
    @inlinable
    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return CLoobeeCoreAtomicInt_isLockFree
    }

    @inlinable
    @inline(__always)
    public mutating func atomicStore(_ value: Int, withOrder order: AtomicOrder) {
        CLoobeeCoreAtomicInt_store(&self, desired: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicLoad(withOrder order: AtomicOrder) -> Int {
        return CLoobeeCoreAtomicInt_load(&self, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicExchange(newValue: Int, withOrder order: AtomicOrder) -> Int {
        return CLoobeeCoreAtomicInt_exchange(&self, desired: newValue, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeWeak(
        expected: inout Int,
        desired: Int,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicInt_compareExchangeWeak(
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
        expected: inout Int,
        desired: Int,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicInt_compareExchangeStrong(
            &self,
            expected: &expected,
            desired: desired,
            successOrder: successOrder,
            failureOrder: failureOrder
        )
    }
}

extension Int: AtomicArithmeticContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndAdd(_ value: Int, withOrder order: AtomicOrder) -> Int {
        return CLoobeeCoreAtomicInt_fetchAndAdd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndSub(_ value: Int, withOrder order: AtomicOrder) -> Int {
        return CLoobeeCoreAtomicInt_fetchAndSub(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicAddAndFetch(_ value: Int, withOrder order: AtomicOrder) -> Int {
        return CLoobeeCoreAtomicInt_addAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicSubAndFetch(_ value: Int, withOrder order: AtomicOrder) -> Int {
        return CLoobeeCoreAtomicInt_subAndFetch(&self, op: value, order: order)
    }
}

extension Int: AtomicBitwiseContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitAnd(_ value: Int, withOrder order: AtomicOrder) -> Int {
        return CLoobeeCoreAtomicInt_fetchAndBitAnd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitOr(_ value: Int, withOrder order: AtomicOrder) -> Int {
        return CLoobeeCoreAtomicInt_fetchAndBitOr(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitXor(_ value: Int, withOrder order: AtomicOrder) -> Int {
        return CLoobeeCoreAtomicInt_fetchAndBitXor(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitAndAndFetch(_ value: Int, withOrder order: AtomicOrder) -> Int {
        return CLoobeeCoreAtomicInt_bitAndAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitOrAndFetch(_ value: Int, withOrder order: AtomicOrder) -> Int {
        return CLoobeeCoreAtomicInt_bitOrAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitXorAndFetch(_ value: Int, withOrder order: AtomicOrder) -> Int {
        return CLoobeeCoreAtomicInt_bitXorAndFetch(&self, op: value, order: order)
    }
}
