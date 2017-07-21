// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import XCTest
@testable import Loobee

class AtomicTests<T: Atomic> {
    func testIsAlwaysLockFree() {
        _ = T.isAlwaysLockFree()
    }

    func testLoad(value: T.IntegralType, valueOpposite: T.IntegralType) {
        var obj = T(value)

        XCTAssertEqual(obj.load(order: .relaxed), value)
        XCTAssertEqual(obj.load(order: .consume), value)
        XCTAssertEqual(obj.load(order: .acquire), value)
        XCTAssertEqual(obj.load(order: .seqCst), value)

        XCTAssertNotEqual(obj.load(order: .relaxed), valueOpposite)
        XCTAssertNotEqual(obj.load(order: .consume), valueOpposite)
        XCTAssertNotEqual(obj.load(order: .acquire), valueOpposite)
        XCTAssertNotEqual(obj.load(order: .seqCst), valueOpposite)
    }

    func testStore(value: T.IntegralType, valueOpposite: T.IntegralType) {
        var obj = T(value)
        obj.store(valueOpposite, order: .relaxed)
        XCTAssertEqual(obj.load(order: .acquire), valueOpposite)

        obj = T(value)
        obj.store(valueOpposite, order: .seqCst)
        XCTAssertEqual(obj.load(order: .acquire), valueOpposite)

        obj = T(value)
        obj.store(valueOpposite, order: .release)
        XCTAssertEqual(obj.load(order: .acquire), valueOpposite)
    }

    func testExchange(value: T.IntegralType, valueOpposite: T.IntegralType) {
        var obj = T(value)

        XCTAssertEqual(obj.exchange(valueOpposite, order: .relaxed), value)
        XCTAssertEqual(obj.load(order: .acquire), valueOpposite)

        XCTAssertEqual(obj.exchange(value, order: .seqCst), valueOpposite)
        XCTAssertEqual(obj.load(order: .acquire), value)

        XCTAssertEqual(obj.exchange(valueOpposite, order: .acquire), value)
        XCTAssertEqual(obj.load(order: .acquire), valueOpposite)

        XCTAssertEqual(obj.exchange(value, order: .release), valueOpposite)
        XCTAssertEqual(obj.load(order: .acquire), value)

        XCTAssertEqual(obj.exchange(valueOpposite, order: .acqRel), value)
        XCTAssertEqual(obj.load(order: .acquire), valueOpposite)
    }

    func testCompareExchangeWeak(value: T.IntegralType, valueOpposite: T.IntegralType) {
        var obj = value
        var objAtomic = T(valueOpposite)

        XCTAssertEqual(objAtomic.compareExchangeWeak(expected: &obj, desired: value, order: .seqCst), false)
        XCTAssertEqual(objAtomic.load(order: .seqCst), valueOpposite)
        XCTAssertEqual(obj, valueOpposite)

        obj = value
        objAtomic.store(obj, order: .seqCst)

        XCTAssertEqual(objAtomic.compareExchangeWeak(expected: &obj, desired: valueOpposite, order: .seqCst), true)
        XCTAssertEqual(objAtomic.load(order: .seqCst), valueOpposite)
        XCTAssertEqual(obj, value)
    }

    func testCompareExchangeStrong(value: T.IntegralType, valueOpposite: T.IntegralType) {
        var obj = value
        var objAtomic = T(valueOpposite)

        XCTAssertEqual(objAtomic.compareExchangeStrong(expected: &obj, desired: value, order: .seqCst), false)
        XCTAssertEqual(objAtomic.load(order: .seqCst), valueOpposite)
        XCTAssertEqual(obj, valueOpposite)

        obj = value
        objAtomic.store(obj, order: .seqCst)

        XCTAssertEqual(objAtomic.compareExchangeStrong(expected: &obj, desired: valueOpposite, order: .seqCst), true)
        XCTAssertEqual(objAtomic.load(order: .seqCst), valueOpposite)
        XCTAssertEqual(obj, value)
    }
}
