// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import XCTest
@testable import Loobee

class AtomicRawPointerTests: XCTestCase {
    static var allTests = [
        ("testIsAlwaysLockFree", testIsAlwaysLockFree),
        ("testLoad", testLoad),
        ("testStore", testStore),
        ("testExchange", testExchange),
        ("testCompareExchangeWeak", testCompareExchangeWeak),
        ("testCompareExchangeStrong", testCompareExchangeStrong),
        ("testFetchAndAdd", testFetchAndAdd),
        ("testFetchAndSub", testFetchAndSub),
        ("testAddAndFetch", testAddAndFetch),
        ("testSubAndFetch", testSubAndFetch),
        ("testPlusEqual", testPlusEqual),
        ("testMinusEqual", testMinusEqual)
    ]

    func testIsAlwaysLockFree() {
        _ = AtomicRawPointer.isAlwaysLockFree()
    }

    func testLoad() {
        var a = 1

        var obj = AtomicRawPointer(&a)

        XCTAssertEqual(obj.load(order: .relaxed), UnsafeMutableRawPointer(&a))
        XCTAssertEqual(obj.load(order: .consume), UnsafeMutableRawPointer(&a))
        XCTAssertEqual(obj.load(order: .acquire), UnsafeMutableRawPointer(&a))
        XCTAssertEqual(obj.load(order: .seqCst), UnsafeMutableRawPointer(&a))

        XCTAssertEqual(obj.load(order: .relaxed)?.load(as: Int.self), a)
        XCTAssertEqual(obj.load(order: .consume)?.load(as: Int.self), a)
        XCTAssertEqual(obj.load(order: .acquire)?.load(as: Int.self), a)
        XCTAssertEqual(obj.load(order: .seqCst)?.load(as: Int.self), a)
    }

    func testStore() {
        var a = 1
        var b = 2

        var pointer = AtomicRawPointer(&a)
        pointer.store(&b, order: .relaxed)
        XCTAssertEqual(pointer.load(order: .acquire), UnsafeMutableRawPointer(&b))

        pointer = AtomicRawPointer(&a)
        pointer.store(&b, order: .seqCst)
        XCTAssertEqual(pointer.load(order: .acquire), UnsafeMutableRawPointer(&b))

        pointer = AtomicRawPointer(&a)
        pointer.store(&b, order: .release)
        XCTAssertEqual(pointer.load(order: .acquire), UnsafeMutableRawPointer(&b))
    }

    func testExchange() {
        var a = 1
        var b = 2

        var pointer = AtomicRawPointer(&a)

        XCTAssertEqual(pointer.exchange(&b, order: .relaxed), UnsafeMutableRawPointer(&a))
        XCTAssertEqual(pointer.load(order: .acquire), UnsafeMutableRawPointer(&b))

        XCTAssertEqual(pointer.exchange(&a, order: .seqCst), UnsafeMutableRawPointer(&b))
        XCTAssertEqual(pointer.load(order: .acquire), UnsafeMutableRawPointer(&a))

        XCTAssertEqual(pointer.exchange(&b, order: .acquire), UnsafeMutableRawPointer(&a))
        XCTAssertEqual(pointer.load(order: .acquire), UnsafeMutableRawPointer(&b))

        XCTAssertEqual(pointer.exchange(&a, order: .release), UnsafeMutableRawPointer(&b))
        XCTAssertEqual(pointer.load(order: .acquire), UnsafeMutableRawPointer(&a))

        XCTAssertEqual(pointer.exchange(&b, order: .acqRel), UnsafeMutableRawPointer(&a))
        XCTAssertEqual(pointer.load(order: .acquire), UnsafeMutableRawPointer(&b))
    }

    func testCompareExchangeWeak() {
        var a = 1
        var b = 2

        var pointerA = UnsafeMutableRawPointer?(&a)
        var atomicPointerB = AtomicRawPointer(UnsafeMutableRawPointer?(&b))

        XCTAssertEqual(atomicPointerB.compareExchangeWeak(
                expected: &pointerA,
                desired: UnsafeMutableRawPointer?(&a),
                order: .seqCst
        ), false)
        XCTAssertEqual(atomicPointerB.load(order: .seqCst), UnsafeMutableRawPointer?(&b))
        XCTAssertEqual(pointerA, UnsafeMutableRawPointer?(&b))

        pointerA = UnsafeMutableRawPointer?(&a)
        atomicPointerB.store(pointerA, order: .seqCst)

        XCTAssertEqual(atomicPointerB.compareExchangeWeak(
                expected: &pointerA,
                desired: UnsafeMutableRawPointer?(&b),
                order: .seqCst
        ), true)
        XCTAssertEqual(atomicPointerB.load(order: .seqCst), UnsafeMutableRawPointer?(&b))
        XCTAssertEqual(pointerA, UnsafeMutableRawPointer?(&a))
    }

    func testCompareExchangeStrong() {
        var a = 1
        var b = 2

        var pointerA = UnsafeMutableRawPointer?(&a)
        var atomicPointerB = AtomicRawPointer(UnsafeMutableRawPointer?(&b))

        XCTAssertEqual(atomicPointerB.compareExchangeStrong(
                expected: &pointerA,
                desired: UnsafeMutableRawPointer?(&a),
                order: .seqCst
        ), false)
        XCTAssertEqual(atomicPointerB.load(order: .seqCst), UnsafeMutableRawPointer?(&b))
        XCTAssertEqual(pointerA, UnsafeMutableRawPointer?(&b))

        pointerA = UnsafeMutableRawPointer?(&a)
        atomicPointerB.store(pointerA, order: .seqCst)

        XCTAssertEqual(atomicPointerB.compareExchangeStrong(
                expected: &pointerA,
                desired: UnsafeMutableRawPointer?(&b),
                order: .seqCst
        ), true)
        XCTAssertEqual(atomicPointerB.load(order: .seqCst), UnsafeMutableRawPointer?(&b))
        XCTAssertEqual(pointerA, UnsafeMutableRawPointer?(&a))
    }

    func testFetchAndAdd() {
        var arr = [1, 2, 3, 4, 5, 6, 7, 8]
        let pointer = UnsafeMutableRawPointer?(&arr)
        var atomicPointer = AtomicRawPointer(pointer)

        XCTAssertEqual(atomicPointer.fetchAndAdd(MemoryLayout<Int>.size * 3, order: .seqCst), pointer)
        XCTAssertEqual(atomicPointer.load(order: .seqCst), UnsafeMutableRawPointer?(&arr[3]))
    }

    func testFetchAndSub() {
        var arr = [1, 2, 3, 4, 5, 6, 7, 8]
        let pointer = UnsafeMutableRawPointer?(&arr[5])
        var atomicPointer = AtomicRawPointer(pointer)

        XCTAssertEqual(atomicPointer.fetchAndSub(MemoryLayout<Int>.size * 5, order: .seqCst), pointer)
        XCTAssertEqual(atomicPointer.load(order: .seqCst), UnsafeMutableRawPointer?(&arr))
    }

    func testAddAndFetch() {
        var arr = [1, 2, 3, 4, 5, 6, 7, 8]
        let pointer = UnsafeMutableRawPointer?(&arr)
        var atomicPointer = AtomicRawPointer(pointer)

        XCTAssertEqual(
                atomicPointer.addAndFetch(MemoryLayout<Int>.size * 3, order: .seqCst),
                UnsafeMutableRawPointer?(&arr[3])
        )
        XCTAssertEqual(atomicPointer.load(order: .seqCst), UnsafeMutableRawPointer?(&arr[3]))
    }

    func testSubAndFetch() {
        var arr = [1, 2, 3, 4, 5, 6, 7, 8]
        let pointer = UnsafeMutableRawPointer?(&arr[5])
        var atomicPointer = AtomicRawPointer(pointer)

        XCTAssertEqual(
                atomicPointer.subAndFetch(MemoryLayout<Int>.size * 5, order: .seqCst),
                UnsafeMutableRawPointer?(&arr)
        )
        XCTAssertEqual(atomicPointer.load(order: .seqCst), UnsafeMutableRawPointer?(&arr))
    }

    func testPlusEqual() {
        var arr = [1, 2, 3, 4, 5, 6, 7, 8]
        let pointer = UnsafeMutableRawPointer?(&arr)
        var atomicPointer = AtomicRawPointer(pointer)

        atomicPointer += MemoryLayout<Int>.size * 3

        XCTAssertEqual(atomicPointer.load(order: .seqCst), UnsafeMutableRawPointer?(&arr[3]))
    }

    func testMinusEqual() {
        var arr = [1, 2, 3, 4, 5, 6, 7, 8]
        let pointer = UnsafeMutableRawPointer?(&arr[5])
        var atomicPointer = AtomicRawPointer(pointer)

        atomicPointer -= MemoryLayout<Int>.size * 5

        XCTAssertEqual(atomicPointer.load(order: .seqCst), UnsafeMutableRawPointer?(&arr))
    }
}
