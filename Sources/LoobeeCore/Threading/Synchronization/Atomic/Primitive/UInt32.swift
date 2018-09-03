// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import CLoobeeCore

extension UInt32: AtomicContract {
    @inlinable
    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return CLoobeeCoreAtomicUInt32_isLockFree
    }

    @inlinable
    @inline(__always)
    public mutating func atomicStore(_ value: UInt32, withOrder order: AtomicOrder) {
        CLoobeeCoreAtomicUInt32_store(&self, desired: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicLoad(withOrder order: AtomicOrder) -> UInt32 {
        return CLoobeeCoreAtomicUInt32_load(&self, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicExchange(newValue: UInt32, withOrder order: AtomicOrder) -> UInt32 {
        return CLoobeeCoreAtomicUInt32_exchange(&self, desired: newValue, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeWeak(
        expected: inout UInt32,
        desired: UInt32,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicUInt32_compareExchangeWeak(
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
        expected: inout UInt32,
        desired: UInt32,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicUInt32_compareExchangeStrong(
            &self,
            expected: &expected,
            desired: desired,
            successOrder: successOrder,
            failureOrder: failureOrder
        )
    }
}

extension UInt32: AtomicArithmeticContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndAdd(_ value: UInt32, withOrder order: AtomicOrder) -> UInt32 {
        return CLoobeeCoreAtomicUInt32_fetchAndAdd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndSub(_ value: UInt32, withOrder order: AtomicOrder) -> UInt32 {
        return CLoobeeCoreAtomicUInt32_fetchAndSub(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicAddAndFetch(_ value: UInt32, withOrder order: AtomicOrder) -> UInt32 {
        return CLoobeeCoreAtomicUInt32_addAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicSubAndFetch(_ value: UInt32, withOrder order: AtomicOrder) -> UInt32 {
        return CLoobeeCoreAtomicUInt32_subAndFetch(&self, op: value, order: order)
    }
}

extension UInt32: AtomicBitwiseContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitAnd(_ value: UInt32, withOrder order: AtomicOrder) -> UInt32 {
        return CLoobeeCoreAtomicUInt32_fetchAndBitAnd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitOr(_ value: UInt32, withOrder order: AtomicOrder) -> UInt32 {
        return CLoobeeCoreAtomicUInt32_fetchAndBitOr(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitXor(_ value: UInt32, withOrder order: AtomicOrder) -> UInt32 {
        return CLoobeeCoreAtomicUInt32_fetchAndBitXor(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitAndAndFetch(_ value: UInt32, withOrder order: AtomicOrder) -> UInt32 {
        return CLoobeeCoreAtomicUInt32_bitAndAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitOrAndFetch(_ value: UInt32, withOrder order: AtomicOrder) -> UInt32 {
        return CLoobeeCoreAtomicUInt32_bitOrAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitXorAndFetch(_ value: UInt32, withOrder order: AtomicOrder) -> UInt32 {
        return CLoobeeCoreAtomicUInt32_bitXorAndFetch(&self, op: value, order: order)
    }
}
