// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCAtomic

public struct AtomicUInt16: Atomic, AtomicArithmetic, AtomicBitwise {
    private var val: UInt16

    public init(_ value: UInt16) {
        val = value
    }

    public static func isLockFree() -> Bool {
        return LoobeeCAtomicUInt16_isLockFree
    }

    public mutating func store(_ desired: UInt16, order: AtomicOrder = .seqCst) {
        LoobeeCAtomicUInt16_store(&val, desired: desired, order: order)
    }

    public mutating func load(order: AtomicOrder = .seqCst) -> UInt16 {
        return LoobeeCAtomicUInt16_load(&val, order: order)
    }

    public mutating func exchange(_ desired: UInt16, order: AtomicOrder = .seqCst) -> UInt16 {
        return LoobeeCAtomicUInt16_exchange(&val, desired: desired, order: order)
    }

    public mutating func compareExchangeWeak(
            expected: inout UInt16,
            desired: UInt16,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicUInt16_compareExchangeWeak(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    public mutating func compareExchangeWeak(
            expected: inout UInt16,
            desired: UInt16,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeWeak(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    public mutating func compareExchangeStrong(
            expected: inout UInt16,
            desired: UInt16,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicUInt16_compareExchangeStrong(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    public mutating func compareExchangeStrong(
            expected: inout UInt16,
            desired: UInt16,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeStrong(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    public mutating func fetchAndAdd(_ operand: UInt16, order: AtomicOrder = .seqCst) -> UInt16 {
        return LoobeeCAtomicUInt16_fetchAndAdd(&val, op: operand, order: order)
    }

    public mutating func fetchAndSub(_ operand: UInt16, order: AtomicOrder = .seqCst) -> UInt16 {
        return LoobeeCAtomicUInt16_fetchAndSub(&val, op: operand, order: order)
    }

    public mutating func fetchAndAnd(_ operand: UInt16, order: AtomicOrder = .seqCst) -> UInt16 {
        return LoobeeCAtomicUInt16_fetchAndAnd(&val, op: operand, order: order)
    }

    public mutating func fetchAndOr(_ operand: UInt16, order: AtomicOrder = .seqCst) -> UInt16 {
        return LoobeeCAtomicUInt16_fetchAndOr(&val, op: operand, order: order)
    }

    public mutating func fetchAndXor(_ operand: UInt16, order: AtomicOrder = .seqCst) -> UInt16 {
        return LoobeeCAtomicUInt16_fetchAndXor(&val, op: operand, order: order)
    }

    public mutating func addAndFetch(_ operand: UInt16, order: AtomicOrder = .seqCst) -> UInt16 {
        return LoobeeCAtomicUInt16_addAndFetch(&val, op: operand, order: order)
    }

    public mutating func subAndFetch(_ operand: UInt16, order: AtomicOrder = .seqCst) -> UInt16 {
        return LoobeeCAtomicUInt16_subAndFetch(&val, op: operand, order: order)
    }

    public mutating func andAndFetch(_ operand: UInt16, order: AtomicOrder = .seqCst) -> UInt16 {
        return LoobeeCAtomicUInt16_andAndFetch(&val, op: operand, order: order)
    }

    public mutating func orAndFetch(_ operand: UInt16, order: AtomicOrder = .seqCst) -> UInt16 {
        return LoobeeCAtomicUInt16_orAndFetch(&val, op: operand, order: order)
    }

    public mutating func xorAndFetch(_ operand: UInt16, order: AtomicOrder = .seqCst) -> UInt16 {
        return LoobeeCAtomicUInt16_xorAndFetch(&val, op: operand, order: order)
    }

    public static func +=(lhs: inout AtomicUInt16, rhs: UInt16) {
        _ = lhs.addAndFetch(rhs)
    }

    public static func -=(lhs: inout AtomicUInt16, rhs: UInt16) {
        _ = lhs.subAndFetch(rhs)
    }

    public static func &=(lhs: inout AtomicUInt16, rhs: UInt16) {
        _ = lhs.andAndFetch(rhs)
    }

    public static func |=(lhs: inout AtomicUInt16, rhs: UInt16) {
        _ = lhs.orAndFetch(rhs)
    }

    public static func ^=(lhs: inout AtomicUInt16, rhs: UInt16) {
        _ = lhs.xorAndFetch(rhs)
    }
}
