// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCAtomic

public struct AtomicInt8: Atomic, AtomicArithmetic, AtomicBitwise {
    @_versioned var val: Int8

    @inline(__always)
    public init(_ value: Int8) {
        val = value
    }

    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return LoobeeCAtomicInt8_isLockFree
    }

    @inline(__always)
    public mutating func store(_ desired: Int8, order: AtomicOrder = .seqCst) {
        LoobeeCAtomicInt8_store(&val, desired: desired, order: order)
    }

    @inline(__always)
    public mutating func load(order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_load(&val, order: order)
    }

    @inline(__always)
    public mutating func exchange(_ desired: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_exchange(&val, desired: desired, order: order)
    }

    @inline(__always)
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

    @inline(__always)
    public mutating func compareExchangeWeak(
            expected: inout Int8,
            desired: Int8,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeWeak(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    @inline(__always)
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

    @inline(__always)
    public mutating func compareExchangeStrong(
            expected: inout Int8,
            desired: Int8,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeStrong(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    @inline(__always)
    public mutating func fetchAndAdd(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_fetchAndAdd(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndSub(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_fetchAndSub(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndAnd(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_fetchAndAnd(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndOr(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_fetchAndOr(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndXor(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_fetchAndXor(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func addAndFetch(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_addAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func subAndFetch(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_subAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func andAndFetch(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_andAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func orAndFetch(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_orAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func xorAndFetch(_ operand: Int8, order: AtomicOrder = .seqCst) -> Int8 {
        return LoobeeCAtomicInt8_xorAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public static func +=(lhs: inout AtomicInt8, rhs: Int8) {
        _ = lhs.addAndFetch(rhs)
    }

    @inline(__always)
    public static func -=(lhs: inout AtomicInt8, rhs: Int8) {
        _ = lhs.subAndFetch(rhs)
    }

    @inline(__always)
    public static func &=(lhs: inout AtomicInt8, rhs: Int8) {
        _ = lhs.andAndFetch(rhs)
    }

    @inline(__always)
    public static func |=(lhs: inout AtomicInt8, rhs: Int8) {
        _ = lhs.orAndFetch(rhs)
    }

    @inline(__always)
    public static func ^=(lhs: inout AtomicInt8, rhs: Int8) {
        _ = lhs.xorAndFetch(rhs)
    }
}
