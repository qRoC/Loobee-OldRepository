// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCAtomic

public struct AtomicInt8: Atomic, AtomicArithmetic, AtomicBitwise {
    private var val: Int8

    public init(_ value: Int8) {
        val = value
    }

    public static func isAlwaysLockFree() -> Bool {
        return LoobeeCAtomicInt8_isLockFree
    }

    public mutating func store(_ desired: Int8, order: AtomicOrder = .seqCst) {
        LoobeeCAtomicInt8_store(&val, desired: desired, order: order)
    }

    public mutating func load(order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_load(&val, order: order)
    }

    public mutating func exchange(_ desired: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_exchange(&val, desired: desired, order: order)
    }

    public mutating func compareExchangeWeak(
            expected: inout Int8,
            desired: Int8,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicInt8_compareExchangeWeak(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    public mutating func compareExchangeWeak(
            expected: inout Int8,
            desired: Int8,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeWeak(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    public mutating func compareExchangeStrong(
            expected: inout Int8,
            desired: Int8,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicInt8_compareExchangeStrong(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    public mutating func compareExchangeStrong(
            expected: inout Int8,
            desired: Int8,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeStrong(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    public mutating func fetchAndAdd(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_fetchAndAdd(&val, op: operand, order: order)
    }

    public mutating func fetchAndSub(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_fetchAndSub(&val, op: operand, order: order)
    }

    public mutating func fetchAndAnd(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_fetchAndAnd(&val, op: operand, order: order)
    }

    public mutating func fetchAndOr(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_fetchAndOr(&val, op: operand, order: order)
    }

    public mutating func fetchAndXor(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_fetchAndXor(&val, op: operand, order: order)
    }

    public mutating func addAndFetch(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_addAndFetch(&val, op: operand, order: order)
    }

    public mutating func subAndFetch(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_subAndFetch(&val, op: operand, order: order)
    }

    public mutating func andAndFetch(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_andAndFetch(&val, op: operand, order: order)
    }

    public mutating func orAndFetch(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_orAndFetch(&val, op: operand, order: order)
    }

    public mutating func xorAndFetch(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_xorAndFetch(&val, op: operand, order: order)
    }

    public static func +=(lhs: inout AtomicInt8, rhs: Int8) {
        _ = lhs.addAndFetch(rhs)
    }

    public static func -=(lhs: inout AtomicInt8, rhs: Int8) {
        _ = lhs.subAndFetch(rhs)
    }

    public static func &=(lhs: inout AtomicInt8, rhs: Int8) {
        _ = lhs.andAndFetch(rhs)
    }

    public static func |=(lhs: inout AtomicInt8, rhs: Int8) {
        _ = lhs.orAndFetch(rhs)
    }

    public static func ^=(lhs: inout AtomicInt8, rhs: Int8) {
        _ = lhs.xorAndFetch(rhs)
    }
}
