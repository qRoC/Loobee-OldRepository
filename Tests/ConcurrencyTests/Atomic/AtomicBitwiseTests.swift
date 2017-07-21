// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import XCTest
@testable import Loobee

class AtomicBitwiseTests<T: Atomic & AtomicBitwise> {
    func testFetchAndAnd(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        XCTAssertEqual(obj.fetchAndAnd(opValue, order: .seqCst), baseValue)
        XCTAssertEqual(obj.load(order: .seqCst), baseValue & opValue)
    }

    func testFetchAndOr(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        XCTAssertEqual(obj.fetchAndOr(opValue, order: .seqCst), baseValue)
        XCTAssertEqual(obj.load(order: .seqCst), baseValue | opValue)
    }

    func testFetchAndXor(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        XCTAssertEqual(obj.fetchAndXor(opValue, order: .seqCst), baseValue)
        XCTAssertEqual(obj.load(order: .seqCst), baseValue ^ opValue)
    }

    func testAndAndFetch(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        XCTAssertEqual(obj.andAndFetch(opValue, order: .seqCst), baseValue & opValue)
    }

    func testOrAndFetch(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        XCTAssertEqual(obj.orAndFetch(opValue, order: .seqCst), baseValue | opValue)
    }

    func testXorAndFetch(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        XCTAssertEqual(obj.xorAndFetch(opValue, order: .seqCst), baseValue ^ opValue)
    }

    func testOperatorAnd(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        obj &= opValue

        XCTAssertEqual(obj.load(order: .seqCst), baseValue & opValue)
    }

    func testOperatorOr(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        obj |= opValue

        XCTAssertEqual(obj.load(order: .seqCst), baseValue | opValue)
    }

    func testOperatorXor(baseValue: T.IntegralType, opValue: T.IntegralType) {
        var obj = T(baseValue)

        obj ^= opValue

        XCTAssertEqual(obj.load(order: .seqCst), baseValue ^ opValue)
    }
}
