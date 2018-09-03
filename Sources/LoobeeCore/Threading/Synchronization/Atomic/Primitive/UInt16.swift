// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import CLoobeeCore

extension UInt16: AtomicContract {
    @inlinable
    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return CLoobeeCoreAtomicUInt16_isLockFree
    }

    @inlinable
    @inline(__always)
    public mutating func atomicStore(_ value: UInt16, withOrder order: AtomicOrder) {
        CLoobeeCoreAtomicUInt16_store(&self, desired: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicLoad(withOrder order: AtomicOrder) -> UInt16 {
        return CLoobeeCoreAtomicUInt16_load(&self, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicExchange(newValue: UInt16, withOrder order: AtomicOrder) -> UInt16 {
        return CLoobeeCoreAtomicUInt16_exchange(&self, desired: newValue, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeWeak(
        expected: inout UInt16,
        desired: UInt16,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicUInt16_compareExchangeWeak(
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
        expected: inout UInt16,
        desired: UInt16,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicUInt16_compareExchangeStrong(
            &self,
            expected: &expected,
            desired: desired,
            successOrder: successOrder,
            failureOrder: failureOrder
        )
    }
}

extension UInt16: AtomicArithmeticContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndAdd(_ value: UInt16, withOrder order: AtomicOrder) -> UInt16 {
        return CLoobeeCoreAtomicUInt16_fetchAndAdd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndSub(_ value: UInt16, withOrder order: AtomicOrder) -> UInt16 {
        return CLoobeeCoreAtomicUInt16_fetchAndSub(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicAddAndFetch(_ value: UInt16, withOrder order: AtomicOrder) -> UInt16 {
        return CLoobeeCoreAtomicUInt16_addAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicSubAndFetch(_ value: UInt16, withOrder order: AtomicOrder) -> UInt16 {
        return CLoobeeCoreAtomicUInt16_subAndFetch(&self, op: value, order: order)
    }
}

extension UInt16: AtomicBitwiseContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitAnd(_ value: UInt16, withOrder order: AtomicOrder) -> UInt16 {
        return CLoobeeCoreAtomicUInt16_fetchAndBitAnd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitOr(_ value: UInt16, withOrder order: AtomicOrder) -> UInt16 {
        return CLoobeeCoreAtomicUInt16_fetchAndBitOr(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitXor(_ value: UInt16, withOrder order: AtomicOrder) -> UInt16 {
        return CLoobeeCoreAtomicUInt16_fetchAndBitXor(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitAndAndFetch(_ value: UInt16, withOrder order: AtomicOrder) -> UInt16 {
        return CLoobeeCoreAtomicUInt16_bitAndAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitOrAndFetch(_ value: UInt16, withOrder order: AtomicOrder) -> UInt16 {
        return CLoobeeCoreAtomicUInt16_bitOrAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitXorAndFetch(_ value: UInt16, withOrder order: AtomicOrder) -> UInt16 {
        return CLoobeeCoreAtomicUInt16_bitXorAndFetch(&self, op: value, order: order)
    }
}
