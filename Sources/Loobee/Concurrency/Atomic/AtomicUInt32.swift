// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCAtomic

public struct AtomicUInt32: Atomic, AtomicArithmetic, AtomicBitwise {
    private var val: UInt32

    public init(_ value: UInt32) {
        val = value
    }

    public static func isLockFree() -> Bool {
        return LoobeeCAtomicUInt32_isLockFree
    }

    public mutating func store(_ desired: UInt32, order: AtomicOrder = .seqCst) {
        LoobeeCAtomicUInt32_store(&val, desired: desired, order: order)
    }

    public mutating func load(order: AtomicOrder = .seqCst) -> UInt32 {
        return LoobeeCAtomicUInt32_load(&val, order: order)
    }

    public mutating func exchange(_ desired: UInt32, order: AtomicOrder = .seqCst) -> UInt32 {
        return LoobeeCAtomicUInt32_exchange(&val, desired: desired, order: order)
    }

    public mutating func compareExchangeWeak(
            expected: inout UInt32,
            desired: UInt32,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicUInt32_compareExchangeWeak(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    public mutating func compareExchangeWeak(
            expected: inout UInt32,
            desired: UInt32,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeWeak(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    public mutating func compareExchangeStrong(
            expected: inout UInt32,
            desired: UInt32,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicUInt32_compareExchangeStrong(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    public mutating func compareExchangeStrong(
            expected: inout UInt32,
            desired: UInt32,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeStrong(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    public mutating func fetchAndAdd(_ operand: UInt32, order: AtomicOrder = .seqCst) -> UInt32 {
        return LoobeeCAtomicUInt32_fetchAndAdd(&val, op: operand, order: order)
    }

    public mutating func fetchAndSub(_ operand: UInt32, order: AtomicOrder = .seqCst) -> UInt32 {
        return LoobeeCAtomicUInt32_fetchAndSub(&val, op: operand, order: order)
    }

    public mutating func fetchAndAnd(_ operand: UInt32, order: AtomicOrder = .seqCst) -> UInt32 {
        return LoobeeCAtomicUInt32_fetchAndAnd(&val, op: operand, order: order)
    }

    public mutating func fetchAndOr(_ operand: UInt32, order: AtomicOrder = .seqCst) -> UInt32 {
        return LoobeeCAtomicUInt32_fetchAndOr(&val, op: operand, order: order)
    }

    public mutating func fetchAndXor(_ operand: UInt32, order: AtomicOrder = .seqCst) -> UInt32 {
        return LoobeeCAtomicUInt32_fetchAndXor(&val, op: operand, order: order)
    }

    public mutating func addAndFetch(_ operand: UInt32, order: AtomicOrder = .seqCst) -> UInt32 {
        return LoobeeCAtomicUInt32_addAndFetch(&val, op: operand, order: order)
    }

    public mutating func subAndFetch(_ operand: UInt32, order: AtomicOrder = .seqCst) -> UInt32 {
        return LoobeeCAtomicUInt32_subAndFetch(&val, op: operand, order: order)
    }

    public mutating func andAndFetch(_ operand: UInt32, order: AtomicOrder = .seqCst) -> UInt32 {
        return LoobeeCAtomicUInt32_andAndFetch(&val, op: operand, order: order)
    }

    public mutating func orAndFetch(_ operand: UInt32, order: AtomicOrder = .seqCst) -> UInt32 {
        return LoobeeCAtomicUInt32_orAndFetch(&val, op: operand, order: order)
    }

    public mutating func xorAndFetch(_ operand: UInt32, order: AtomicOrder = .seqCst) -> UInt32 {
        return LoobeeCAtomicUInt32_xorAndFetch(&val, op: operand, order: order)
    }

    public static func +=(lhs: inout AtomicUInt32, rhs: UInt32) {
        _ = lhs.addAndFetch(rhs)
    }

    public static func -=(lhs: inout AtomicUInt32, rhs: UInt32) {
        _ = lhs.subAndFetch(rhs)
    }

    public static func &=(lhs: inout AtomicUInt32, rhs: UInt32) {
        _ = lhs.andAndFetch(rhs)
    }

    public static func |=(lhs: inout AtomicUInt32, rhs: UInt32) {
        _ = lhs.orAndFetch(rhs)
    }

    public static func ^=(lhs: inout AtomicUInt32, rhs: UInt32) {
        _ = lhs.xorAndFetch(rhs)
    }
}
