// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCAtomic

public struct AtomicInt64: Atomic, AtomicArithmetic, AtomicBitwise {
    private var val: Int64

    public init(_ value: Int64) {
        val = value
    }

    public static func isLockFree() -> Bool {
        return LoobeeCAtomicInt64_isLockFree
    }

    public mutating func store(_ desired: Int64, order: AtomicOrder = .seqCst) {
        LoobeeCAtomicInt64_store(&val, desired: desired, order: order)
    }

    public mutating func load(order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_load(&val, order: order)
    }

    public mutating func exchange(_ desired: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_exchange(&val, desired: desired, order: order)
    }

    public mutating func compareExchangeWeak(
            expected: inout Int64,
            desired: Int64,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicInt64_compareExchangeWeak(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    public mutating func compareExchangeWeak(
            expected: inout Int64,
            desired: Int64,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeWeak(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    public mutating func compareExchangeStrong(
            expected: inout Int64,
            desired: Int64,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicInt64_compareExchangeStrong(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    public mutating func compareExchangeStrong(
            expected: inout Int64,
            desired: Int64,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeStrong(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    public mutating func fetchAndAdd(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_fetchAndAdd(&val, op: operand, order: order)
    }

    public mutating func fetchAndSub(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_fetchAndSub(&val, op: operand, order: order)
    }

    public mutating func fetchAndAnd(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_fetchAndAnd(&val, op: operand, order: order)
    }

    public mutating func fetchAndOr(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_fetchAndOr(&val, op: operand, order: order)
    }

    public mutating func fetchAndXor(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_fetchAndXor(&val, op: operand, order: order)
    }

    public mutating func addAndFetch(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_addAndFetch(&val, op: operand, order: order)
    }

    public mutating func subAndFetch(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_subAndFetch(&val, op: operand, order: order)
    }

    public mutating func andAndFetch(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_andAndFetch(&val, op: operand, order: order)
    }

    public mutating func orAndFetch(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_orAndFetch(&val, op: operand, order: order)
    }

    public mutating func xorAndFetch(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_xorAndFetch(&val, op: operand, order: order)
    }

    public static func +=(lhs: inout AtomicInt64, rhs: Int64) {
        _ = lhs.addAndFetch(rhs)
    }

    public static func -=(lhs: inout AtomicInt64, rhs: Int64) {
        _ = lhs.subAndFetch(rhs)
    }

    public static func &=(lhs: inout AtomicInt64, rhs: Int64) {
        _ = lhs.andAndFetch(rhs)
    }

    public static func |=(lhs: inout AtomicInt64, rhs: Int64) {
        _ = lhs.orAndFetch(rhs)
    }

    public static func ^=(lhs: inout AtomicInt64, rhs: Int64) {
        _ = lhs.xorAndFetch(rhs)
    }
}
