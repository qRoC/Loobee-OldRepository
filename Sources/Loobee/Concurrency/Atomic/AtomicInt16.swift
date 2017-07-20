// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCAtomic

public struct AtomicInt16: Atomic, AtomicArithmetic, AtomicBitwise {
    private var val: Int16

    public init(_ value: Int16) {
        val = value
    }

    public static func isAlwaysLockFree() -> Bool {
        return LoobeeCAtomicInt16_isLockFree
    }

    public mutating func store(_ desired: Int16, order: AtomicOrder = .seqCst) {
        LoobeeCAtomicInt16_store(&val, desired: desired, order: order)
    }

    public mutating func load(order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_load(&val, order: order)
    }

    public mutating func exchange(_ desired: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_exchange(&val, desired: desired, order: order)
    }

    public mutating func compareExchangeWeak(
            expected: inout Int16,
            desired: Int16,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicInt16_compareExchangeWeak(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    public mutating func compareExchangeWeak(
            expected: inout Int16,
            desired: Int16,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeWeak(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    public mutating func compareExchangeStrong(
            expected: inout Int16,
            desired: Int16,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicInt16_compareExchangeStrong(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    public mutating func compareExchangeStrong(
            expected: inout Int16,
            desired: Int16,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeStrong(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    public mutating func fetchAndAdd(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_fetchAndAdd(&val, op: operand, order: order)
    }

    public mutating func fetchAndSub(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_fetchAndSub(&val, op: operand, order: order)
    }

    public mutating func fetchAndAnd(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_fetchAndAnd(&val, op: operand, order: order)
    }

    public mutating func fetchAndOr(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_fetchAndOr(&val, op: operand, order: order)
    }

    public mutating func fetchAndXor(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_fetchAndXor(&val, op: operand, order: order)
    }

    public mutating func addAndFetch(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_addAndFetch(&val, op: operand, order: order)
    }

    public mutating func subAndFetch(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_subAndFetch(&val, op: operand, order: order)
    }

    public mutating func andAndFetch(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_andAndFetch(&val, op: operand, order: order)
    }

    public mutating func orAndFetch(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_orAndFetch(&val, op: operand, order: order)
    }

    public mutating func xorAndFetch(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_xorAndFetch(&val, op: operand, order: order)
    }

    public static func +=(lhs: inout AtomicInt16, rhs: Int16) {
        _ = lhs.addAndFetch(rhs)
    }

    public static func -=(lhs: inout AtomicInt16, rhs: Int16) {
        _ = lhs.subAndFetch(rhs)
    }

    public static func &=(lhs: inout AtomicInt16, rhs: Int16) {
        _ = lhs.andAndFetch(rhs)
    }

    public static func |=(lhs: inout AtomicInt16, rhs: Int16) {
        _ = lhs.orAndFetch(rhs)
    }

    public static func ^=(lhs: inout AtomicInt16, rhs: Int16) {
        _ = lhs.xorAndFetch(rhs)
    }
}
