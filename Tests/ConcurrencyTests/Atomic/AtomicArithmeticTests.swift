// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import XCTest
@testable import Loobee

class AtomicArithmeticTests<T: Atomic & AtomicArithmetic> {
    func testFetchAndAdd(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        XCTAssertEqual(obj.fetchAndAdd(opValue, order: .seqCst), baseValue)
        XCTAssertEqual(obj.load(order: .seqCst), baseValue + opValue)
    }

    func testFetchAndSub(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        XCTAssertEqual(obj.fetchAndSub(opValue, order: .seqCst), baseValue)
        XCTAssertEqual(obj.load(order: .seqCst), baseValue - opValue)
    }

    func testAddAndFetch(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        XCTAssertEqual(obj.addAndFetch(opValue, order: .seqCst), baseValue + opValue)
        XCTAssertEqual(obj.load(order: .seqCst), baseValue + opValue)
    }

    func testSubAndFetch(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        XCTAssertEqual(obj.subAndFetch(opValue, order: .seqCst), baseValue - opValue)
        XCTAssertEqual(obj.load(order: .seqCst), baseValue - opValue)
    }

    func testPlusEqual(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        obj += opValue

        XCTAssertEqual(obj.load(order: .seqCst), baseValue + opValue)
    }

    func testMinusEqual(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        obj -= opValue

        XCTAssertEqual(obj.load(order: .seqCst), baseValue - opValue)
    }
}
