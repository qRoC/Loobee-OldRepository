// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCAtomic

public struct AtomicUInt8: Atomic, AtomicArithmetic, AtomicBitwise {
    @_versioned var val: UInt8

    @inline(__always)
    public init(_ value: UInt8) {
        val = value
    }

    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return LoobeeCAtomicUInt8_isLockFree
    }

    @inline(__always)
    public mutating func store(_ desired: UInt8, order: AtomicOrder = .seqCst) {
        LoobeeCAtomicUInt8_store(&val, desired: desired, order: order)
    }

    @inline(__always)
    public mutating func load(order: AtomicOrder = .seqCst) -> UInt8 {
        return LoobeeCAtomicUInt8_load(&val, order: order)
    }

    @inline(__always)
    public mutating func exchange(_ desired: UInt8, order: AtomicOrder = .seqCst) -> UInt8 {
        return LoobeeCAtomicUInt8_exchange(&val, desired: desired, order: order)
    }

    @inline(__always)
    public mutating func compareExchangeWeak(
            expected: inout UInt8,
            desired: UInt8,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicUInt8_compareExchangeWeak(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    @inline(__always)
    public mutating func compareExchangeWeak(
            expected: inout UInt8,
            desired: UInt8,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeWeak(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    @inline(__always)
    public mutating func compareExchangeStrong(
            expected: inout UInt8,
            desired: UInt8,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicUInt8_compareExchangeStrong(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    @inline(__always)
    public mutating func compareExchangeStrong(
            expected: inout UInt8,
            desired: UInt8,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeStrong(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    @inline(__always)
    public mutating func fetchAndAdd(_ operand: UInt8, order: AtomicOrder = .seqCst) -> UInt8 {
        return LoobeeCAtomicUInt8_fetchAndAdd(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndSub(_ operand: UInt8, order: AtomicOrder = .seqCst) -> UInt8 {
        return LoobeeCAtomicUInt8_fetchAndSub(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndAnd(_ operand: UInt8, order: AtomicOrder = .seqCst) -> UInt8 {
        return LoobeeCAtomicUInt8_fetchAndAnd(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndOr(_ operand: UInt8, order: AtomicOrder = .seqCst) -> UInt8 {
        return LoobeeCAtomicUInt8_fetchAndOr(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndXor(_ operand: UInt8, order: AtomicOrder = .seqCst) -> UInt8 {
        return LoobeeCAtomicUInt8_fetchAndXor(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func addAndFetch(_ operand: UInt8, order: AtomicOrder = .seqCst) -> UInt8 {
        return LoobeeCAtomicUInt8_addAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func subAndFetch(_ operand: UInt8, order: AtomicOrder = .seqCst) -> UInt8 {
        return LoobeeCAtomicUInt8_subAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func andAndFetch(_ operand: UInt8, order: AtomicOrder = .seqCst) -> UInt8 {
        return LoobeeCAtomicUInt8_andAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func orAndFetch(_ operand: UInt8, order: AtomicOrder = .seqCst) -> UInt8 {
        return LoobeeCAtomicUInt8_orAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func xorAndFetch(_ operand: UInt8, order: AtomicOrder = .seqCst) -> UInt8 {
        return LoobeeCAtomicUInt8_xorAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public static func +=(lhs: inout AtomicUInt8, rhs: UInt8) {
        _ = lhs.addAndFetch(rhs)
    }

    @inline(__always)
    public static func -=(lhs: inout AtomicUInt8, rhs: UInt8) {
        _ = lhs.subAndFetch(rhs)
    }

    @inline(__always)
    public static func &=(lhs: inout AtomicUInt8, rhs: UInt8) {
        _ = lhs.andAndFetch(rhs)
    }

    @inline(__always)
    public static func |=(lhs: inout AtomicUInt8, rhs: UInt8) {
        _ = lhs.orAndFetch(rhs)
    }

    @inline(__always)
    public static func ^=(lhs: inout AtomicUInt8, rhs: UInt8) {
        _ = lhs.xorAndFetch(rhs)
    }
}
