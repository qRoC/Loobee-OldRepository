// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import CLoobeeCore

extension UInt8: AtomicContract {
    @inlinable
    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return CLoobeeCoreAtomicUInt8_isLockFree
    }

    @inlinable
    @inline(__always)
    public mutating func atomicStore(_ value: UInt8, withOrder order: AtomicOrder) {
        CLoobeeCoreAtomicUInt8_store(&self, desired: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicLoad(withOrder order: AtomicOrder) -> UInt8 {
        return CLoobeeCoreAtomicUInt8_load(&self, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicExchange(newValue: UInt8, withOrder order: AtomicOrder) -> UInt8 {
        return CLoobeeCoreAtomicUInt8_exchange(&self, desired: newValue, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeWeak(
        expected: inout UInt8,
        desired: UInt8,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicUInt8_compareExchangeWeak(
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
        expected: inout UInt8,
        desired: UInt8,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return CLoobeeCoreAtomicUInt8_compareExchangeStrong(
            &self,
            expected: &expected,
            desired: desired,
            successOrder: successOrder,
            failureOrder: failureOrder
        )
    }
}

extension UInt8: AtomicArithmeticContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndAdd(_ value: UInt8, withOrder order: AtomicOrder) -> UInt8 {
        return CLoobeeCoreAtomicUInt8_fetchAndAdd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndSub(_ value: UInt8, withOrder order: AtomicOrder) -> UInt8 {
        return CLoobeeCoreAtomicUInt8_fetchAndSub(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicAddAndFetch(_ value: UInt8, withOrder order: AtomicOrder) -> UInt8 {
        return CLoobeeCoreAtomicUInt8_addAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicSubAndFetch(_ value: UInt8, withOrder order: AtomicOrder) -> UInt8 {
        return CLoobeeCoreAtomicUInt8_subAndFetch(&self, op: value, order: order)
    }
}

extension UInt8: AtomicBitwiseContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitAnd(_ value: UInt8, withOrder order: AtomicOrder) -> UInt8 {
        return CLoobeeCoreAtomicUInt8_fetchAndBitAnd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitOr(_ value: UInt8, withOrder order: AtomicOrder) -> UInt8 {
        return CLoobeeCoreAtomicUInt8_fetchAndBitOr(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitXor(_ value: UInt8, withOrder order: AtomicOrder) -> UInt8 {
        return CLoobeeCoreAtomicUInt8_fetchAndBitXor(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitAndAndFetch(_ value: UInt8, withOrder order: AtomicOrder) -> UInt8 {
        return CLoobeeCoreAtomicUInt8_bitAndAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitOrAndFetch(_ value: UInt8, withOrder order: AtomicOrder) -> UInt8 {
        return CLoobeeCoreAtomicUInt8_bitOrAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitXorAndFetch(_ value: UInt8, withOrder order: AtomicOrder) -> UInt8 {
        return CLoobeeCoreAtomicUInt8_bitXorAndFetch(&self, op: value, order: order)
    }
}
