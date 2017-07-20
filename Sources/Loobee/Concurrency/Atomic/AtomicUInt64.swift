// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCAtomic

public struct AtomicUInt64: Atomic, AtomicArithmetic, AtomicBitwise {
    private var val: UInt64

    public init(_ value: UInt64) {
        val = value
    }

    public static func isAlwaysLockFree() -> Bool {
        return LoobeeCAtomicUInt64_isLockFree
    }

    public mutating func store(_ desired: UInt64, order: AtomicOrder = .seqCst) {
        LoobeeCAtomicUInt64_store(&val, desired: desired, order: order)
    }

    public mutating func load(order: AtomicOrder = .seqCst) -> UInt64 {
        return LoobeeCAtomicUInt64_load(&val, order: order)
    }

    public mutating func exchange(_ desired: UInt64, order: AtomicOrder = .seqCst) -> UInt64 {
        return LoobeeCAtomicUInt64_exchange(&val, desired: desired, order: order)
    }

    public mutating func compareExchangeWeak(
            expected: inout UInt64,
            desired: UInt64,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicUInt64_compareExchangeWeak(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    public mutating func compareExchangeWeak(
            expected: inout UInt64,
            desired: UInt64,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeWeak(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    public mutating func compareExchangeStrong(
            expected: inout UInt64,
            desired: UInt64,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicUInt64_compareExchangeStrong(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    public mutating func compareExchangeStrong(
            expected: inout UInt64,
            desired: UInt64,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeStrong(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    public mutating func fetchAndAdd(_ operand: UInt64, order: AtomicOrder = .seqCst) -> UInt64 {
        return LoobeeCAtomicUInt64_fetchAndAdd(&val, op: operand, order: order)
    }

    public mutating func fetchAndSub(_ operand: UInt64, order: AtomicOrder = .seqCst) -> UInt64 {
        return LoobeeCAtomicUInt64_fetchAndSub(&val, op: operand, order: order)
    }

    public mutating func fetchAndAnd(_ operand: UInt64, order: AtomicOrder = .seqCst) -> UInt64 {
        return LoobeeCAtomicUInt64_fetchAndAnd(&val, op: operand, order: order)
    }

    public mutating func fetchAndOr(_ operand: UInt64, order: AtomicOrder = .seqCst) -> UInt64 {
        return LoobeeCAtomicUInt64_fetchAndOr(&val, op: operand, order: order)
    }

    public mutating func fetchAndXor(_ operand: UInt64, order: AtomicOrder = .seqCst) -> UInt64 {
        return LoobeeCAtomicUInt64_fetchAndXor(&val, op: operand, order: order)
    }

    public mutating func addAndFetch(_ operand: UInt64, order: AtomicOrder = .seqCst) -> UInt64 {
        return LoobeeCAtomicUInt64_addAndFetch(&val, op: operand, order: order)
    }

    public mutating func subAndFetch(_ operand: UInt64, order: AtomicOrder = .seqCst) -> UInt64 {
        return LoobeeCAtomicUInt64_subAndFetch(&val, op: operand, order: order)
    }

    public mutating func andAndFetch(_ operand: UInt64, order: AtomicOrder = .seqCst) -> UInt64 {
        return LoobeeCAtomicUInt64_andAndFetch(&val, op: operand, order: order)
    }

    public mutating func orAndFetch(_ operand: UInt64, order: AtomicOrder = .seqCst) -> UInt64 {
        return LoobeeCAtomicUInt64_orAndFetch(&val, op: operand, order: order)
    }

    public mutating func xorAndFetch(_ operand: UInt64, order: AtomicOrder = .seqCst) -> UInt64 {
        return LoobeeCAtomicUInt64_xorAndFetch(&val, op: operand, order: order)
    }

    public static func +=(lhs: inout AtomicUInt64, rhs: UInt64) {
        _ = lhs.addAndFetch(rhs)
    }

    public static func -=(lhs: inout AtomicUInt64, rhs: UInt64) {
        _ = lhs.subAndFetch(rhs)
    }

    public static func &=(lhs: inout AtomicUInt64, rhs: UInt64) {
        _ = lhs.andAndFetch(rhs)
    }

    public static func |=(lhs: inout AtomicUInt64, rhs: UInt64) {
        _ = lhs.orAndFetch(rhs)
    }

    public static func ^=(lhs: inout AtomicUInt64, rhs: UInt64) {
        _ = lhs.xorAndFetch(rhs)
    }
}
