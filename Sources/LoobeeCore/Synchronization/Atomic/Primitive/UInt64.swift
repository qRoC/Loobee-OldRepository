// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import CLoobeeCore

extension UInt64: AtomicContract {
    @inlinable
    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return CLoobeeCoreAtomicUInt64_isLockFree
    }

    @inlinable
    @inline(__always)
    public mutating func atomicStore(_ value: UInt64, withOrder order: AtomicOrder) {
        CLoobeeCoreAtomicUInt64_store(&self, desired: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicLoad(withOrder order: AtomicOrder) -> UInt64 {
        return CLoobeeCoreAtomicUInt64_load(&self, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicExchange(newValue: UInt64, withOrder order: AtomicOrder) -> UInt64 {
        return CLoobeeCoreAtomicUInt64_exchange(&self, desired: newValue, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeWeak(
        expected: inout UInt64,
        desired: UInt64,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicUInt64_compareExchangeWeak(
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
        expected: inout UInt64,
        desired: UInt64,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicUInt64_compareExchangeStrong(
            &self,
            expected: &expected,
            desired: desired,
            successOrder: successOrder,
            failureOrder: failureOrder
        )
    }
}

extension UInt64: AtomicArithmeticContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndAdd(_ value: UInt64, withOrder order: AtomicOrder) -> UInt64 {
        return CLoobeeCoreAtomicUInt64_fetchAndAdd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndSub(_ value: UInt64, withOrder order: AtomicOrder) -> UInt64 {
        return CLoobeeCoreAtomicUInt64_fetchAndSub(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicAddAndFetch(_ value: UInt64, withOrder order: AtomicOrder) -> UInt64 {
        return CLoobeeCoreAtomicUInt64_addAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicSubAndFetch(_ value: UInt64, withOrder order: AtomicOrder) -> UInt64 {
        return CLoobeeCoreAtomicUInt64_subAndFetch(&self, op: value, order: order)
    }
}

extension UInt64: AtomicBitwiseContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitAnd(_ value: UInt64, withOrder order: AtomicOrder) -> UInt64 {
        return CLoobeeCoreAtomicUInt64_fetchAndBitAnd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitOr(_ value: UInt64, withOrder order: AtomicOrder) -> UInt64 {
        return CLoobeeCoreAtomicUInt64_fetchAndBitOr(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitXor(_ value: UInt64, withOrder order: AtomicOrder) -> UInt64 {
        return CLoobeeCoreAtomicUInt64_fetchAndBitXor(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitAndAndFetch(_ value: UInt64, withOrder order: AtomicOrder) -> UInt64 {
        return CLoobeeCoreAtomicUInt64_bitAndAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitOrAndFetch(_ value: UInt64, withOrder order: AtomicOrder) -> UInt64 {
        return CLoobeeCoreAtomicUInt64_bitOrAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitXorAndFetch(_ value: UInt64, withOrder order: AtomicOrder) -> UInt64 {
        return CLoobeeCoreAtomicUInt64_bitXorAndFetch(&self, op: value, order: order)
    }
}
