// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import CLoobeeCore

extension UInt: AtomicContract {
    @inlinable
    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return CLoobeeCoreAtomicUInt_isLockFree
    }

    @inlinable
    @inline(__always)
    public mutating func atomicStore(_ value: UInt, withOrder order: AtomicOrder) {
        CLoobeeCoreAtomicUInt_store(&self, desired: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicLoad(withOrder order: AtomicOrder) -> UInt {
        return CLoobeeCoreAtomicUInt_load(&self, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicExchange(newValue: UInt, withOrder order: AtomicOrder) -> UInt {
        return CLoobeeCoreAtomicUInt_exchange(&self, desired: newValue, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicCompareAndExchangeWeak(
        expected: inout UInt,
        desired: UInt,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
    ) -> Bool {
        return CLoobeeCoreAtomicUInt_compareExchangeWeak(
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
        expected: inout UInt,
        desired: UInt,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
    ) -> Bool {
        return CLoobeeCoreAtomicUInt_compareExchangeStrong(
            &self,
            expected: &expected,
            desired: desired,
            successOrder: successOrder,
            failureOrder: failureOrder
        )
    }
}

extension UInt: AtomicArithmeticContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndAdd(_ value: UInt, withOrder order: AtomicOrder) -> UInt {
        return CLoobeeCoreAtomicUInt_fetchAndAdd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndSub(_ value: UInt, withOrder order: AtomicOrder) -> UInt {
        return CLoobeeCoreAtomicUInt_fetchAndSub(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicAddAndFetch(_ value: UInt, withOrder order: AtomicOrder) -> UInt {
        return CLoobeeCoreAtomicUInt_addAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicSubAndFetch(_ value: UInt, withOrder order: AtomicOrder) -> UInt {
        return CLoobeeCoreAtomicUInt_subAndFetch(&self, op: value, order: order)
    }
}

extension UInt: AtomicBitwiseContract {
    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitAnd(_ value: UInt, withOrder order: AtomicOrder) -> UInt {
        return CLoobeeCoreAtomicUInt_fetchAndBitAnd(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitOr(_ value: UInt, withOrder order: AtomicOrder) -> UInt {
        return CLoobeeCoreAtomicUInt_fetchAndBitOr(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicFetchAndBitXor(_ value: UInt, withOrder order: AtomicOrder) -> UInt {
        return CLoobeeCoreAtomicUInt_fetchAndBitXor(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitAndAndFetch(_ value: UInt, withOrder order: AtomicOrder) -> UInt {
        return CLoobeeCoreAtomicUInt_bitAndAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitOrAndFetch(_ value: UInt, withOrder order: AtomicOrder) -> UInt {
        return CLoobeeCoreAtomicUInt_bitOrAndFetch(&self, op: value, order: order)
    }

    @inlinable
    @inline(__always)
    public mutating func atomicBitXorAndFetch(_ value: UInt, withOrder order: AtomicOrder) -> UInt {
        return CLoobeeCoreAtomicUInt_bitXorAndFetch(&self, op: value, order: order)
    }
}
