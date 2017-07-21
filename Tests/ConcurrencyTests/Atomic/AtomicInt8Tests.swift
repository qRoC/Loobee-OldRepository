// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import XCTest
@testable import Loobee

class AtomicInt8Tests: XCTestCase {
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
        ("testMinusEqual", testMinusEqual),
        ("testFetchAndAnd", testFetchAndAnd),
        ("testFetchAndOr", testFetchAndOr),
        ("testFetchAndXor", testFetchAndXor),
        ("testAndAndFetch", testAndAndFetch),
        ("testOrAndFetch", testOrAndFetch),
        ("testXorAndFetch", testXorAndFetch),
        ("testOperatorAnd", testOperatorAnd),
        ("testOperatorOr", testOperatorOr),
        ("testOperatorXor", testOperatorXor)
    ]

    var atomicTests = AtomicTests<AtomicInt8>()

    var atomicArithmeticTests = AtomicArithmeticTests<AtomicInt8>()

    var atomicBitwiseTests = AtomicBitwiseTests<AtomicInt8>()

    func testIsAlwaysLockFree() {
        atomicTests.testIsAlwaysLockFree()
    }

    func testLoad() {
        atomicTests.testLoad(value: 1, valueOpposite: 0)
        atomicTests.testLoad(value: -1, valueOpposite: 0)
        atomicTests.testLoad(value: 1, valueOpposite: -1)
    }

    func testStore() {
        atomicTests.testStore(value: 1, valueOpposite: 0)
        atomicTests.testStore(value: -1, valueOpposite: 0)
        atomicTests.testStore(value: 1, valueOpposite: -1)
    }

    func testExchange() {
        atomicTests.testExchange(value: 1, valueOpposite: 0)
        atomicTests.testExchange(value: -1, valueOpposite: 0)
        atomicTests.testExchange(value: 1, valueOpposite: -1)
    }

    func testCompareExchangeWeak() {
        atomicTests.testCompareExchangeWeak(value: 1, valueOpposite: 0)
        atomicTests.testCompareExchangeWeak(value: -1, valueOpposite: 0)
        atomicTests.testCompareExchangeWeak(value: 1, valueOpposite: -1)
    }

    func testCompareExchangeStrong() {
        atomicTests.testCompareExchangeStrong(value: 1, valueOpposite: 0)
        atomicTests.testCompareExchangeStrong(value: -1, valueOpposite: 0)
        atomicTests.testCompareExchangeStrong(value: 1, valueOpposite: -1)
    }

    func testFetchAndAdd() {
        atomicArithmeticTests.testFetchAndAdd(baseValue: 1, opValue: 0)
        atomicArithmeticTests.testFetchAndAdd(baseValue: -1, opValue: 0)
        atomicArithmeticTests.testFetchAndAdd(baseValue: 1, opValue: -1)
    }

    func testFetchAndSub() {
        atomicArithmeticTests.testFetchAndSub(baseValue: 1, opValue: 0)
        atomicArithmeticTests.testFetchAndSub(baseValue: -1, opValue: 0)
        atomicArithmeticTests.testFetchAndSub(baseValue: 1, opValue: -1)
        atomicArithmeticTests.testFetchAndSub(baseValue: -1, opValue: 1)
    }

    func testAddAndFetch() {
        atomicArithmeticTests.testAddAndFetch(baseValue: 1, opValue: 0)
        atomicArithmeticTests.testAddAndFetch(baseValue: -1, opValue: 0)
        atomicArithmeticTests.testAddAndFetch(baseValue: 1, opValue: -1)
    }

    func testSubAndFetch() {
        atomicArithmeticTests.testSubAndFetch(baseValue: 1, opValue: 0)
        atomicArithmeticTests.testSubAndFetch(baseValue: -1, opValue: 0)
        atomicArithmeticTests.testSubAndFetch(baseValue: 1, opValue: -1)
        atomicArithmeticTests.testSubAndFetch(baseValue: -1, opValue: 1)
    }

    func testPlusEqual() {
        atomicArithmeticTests.testPlusEqual(baseValue: 1, opValue: 0)
        atomicArithmeticTests.testPlusEqual(baseValue: -1, opValue: 0)
        atomicArithmeticTests.testPlusEqual(baseValue: 1, opValue: -1)
    }

    func testMinusEqual() {
        atomicArithmeticTests.testMinusEqual(baseValue: 1, opValue: 0)
        atomicArithmeticTests.testMinusEqual(baseValue: -1, opValue: 0)
        atomicArithmeticTests.testMinusEqual(baseValue: 1, opValue: -1)
        atomicArithmeticTests.testMinusEqual(baseValue: -1, opValue: 1)
    }

    func testFetchAndAnd() {
        atomicBitwiseTests.testFetchAndAnd(baseValue: 0, opValue: 0)
        atomicBitwiseTests.testFetchAndAnd(baseValue: 1, opValue: 0)
        atomicBitwiseTests.testFetchAndAnd(baseValue: 0, opValue: 1)
        atomicBitwiseTests.testFetchAndAnd(baseValue: 1, opValue: 1)
        atomicBitwiseTests.testFetchAndAnd(baseValue: -1, opValue: 0)
        atomicBitwiseTests.testFetchAndAnd(baseValue: 0, opValue: -1)
        atomicBitwiseTests.testFetchAndAnd(baseValue: -1, opValue: -1)
        atomicBitwiseTests.testFetchAndAnd(baseValue: 1, opValue: -1)
        atomicBitwiseTests.testFetchAndAnd(baseValue: -1, opValue: 1)
    }

    func testFetchAndOr() {
        atomicBitwiseTests.testFetchAndOr(baseValue: 0, opValue: 0)
        atomicBitwiseTests.testFetchAndOr(baseValue: 1, opValue: 0)
        atomicBitwiseTests.testFetchAndOr(baseValue: 0, opValue: 1)
        atomicBitwiseTests.testFetchAndOr(baseValue: 1, opValue: 1)
        atomicBitwiseTests.testFetchAndOr(baseValue: -1, opValue: 0)
        atomicBitwiseTests.testFetchAndOr(baseValue: 0, opValue: -1)
        atomicBitwiseTests.testFetchAndOr(baseValue: -1, opValue: -1)
        atomicBitwiseTests.testFetchAndOr(baseValue: 1, opValue: -1)
        atomicBitwiseTests.testFetchAndOr(baseValue: -1, opValue: 1)
    }

    func testFetchAndXor() {
        atomicBitwiseTests.testFetchAndXor(baseValue: 0, opValue: 0)
        atomicBitwiseTests.testFetchAndXor(baseValue: 1, opValue: 0)
        atomicBitwiseTests.testFetchAndXor(baseValue: 0, opValue: 1)
        atomicBitwiseTests.testFetchAndXor(baseValue: 1, opValue: 1)
        atomicBitwiseTests.testFetchAndXor(baseValue: -1, opValue: 0)
        atomicBitwiseTests.testFetchAndXor(baseValue: 0, opValue: -1)
        atomicBitwiseTests.testFetchAndXor(baseValue: -1, opValue: -1)
        atomicBitwiseTests.testFetchAndXor(baseValue: 1, opValue: -1)
        atomicBitwiseTests.testFetchAndXor(baseValue: -1, opValue: 1)
    }

    func testAndAndFetch() {
        atomicBitwiseTests.testAndAndFetch(baseValue: 0, opValue: 0)
        atomicBitwiseTests.testAndAndFetch(baseValue: 1, opValue: 0)
        atomicBitwiseTests.testAndAndFetch(baseValue: 0, opValue: 1)
        atomicBitwiseTests.testAndAndFetch(baseValue: 1, opValue: 1)
        atomicBitwiseTests.testAndAndFetch(baseValue: -1, opValue: 0)
        atomicBitwiseTests.testAndAndFetch(baseValue: 0, opValue: -1)
        atomicBitwiseTests.testAndAndFetch(baseValue: -1, opValue: -1)
        atomicBitwiseTests.testAndAndFetch(baseValue: 1, opValue: -1)
        atomicBitwiseTests.testAndAndFetch(baseValue: -1, opValue: 1)
    }

    func testOrAndFetch() {
        atomicBitwiseTests.testOrAndFetch(baseValue: 0, opValue: 0)
        atomicBitwiseTests.testOrAndFetch(baseValue: 1, opValue: 0)
        atomicBitwiseTests.testOrAndFetch(baseValue: 0, opValue: 1)
        atomicBitwiseTests.testOrAndFetch(baseValue: 1, opValue: 1)
        atomicBitwiseTests.testOrAndFetch(baseValue: -1, opValue: 0)
        atomicBitwiseTests.testOrAndFetch(baseValue: 0, opValue: -1)
        atomicBitwiseTests.testOrAndFetch(baseValue: -1, opValue: -1)
        atomicBitwiseTests.testOrAndFetch(baseValue: 1, opValue: -1)
        atomicBitwiseTests.testOrAndFetch(baseValue: -1, opValue: 1)
    }

    func testXorAndFetch() {
        atomicBitwiseTests.testXorAndFetch(baseValue: 0, opValue: 0)
        atomicBitwiseTests.testXorAndFetch(baseValue: 1, opValue: 0)
        atomicBitwiseTests.testXorAndFetch(baseValue: 0, opValue: 1)
        atomicBitwiseTests.testXorAndFetch(baseValue: 1, opValue: 1)
        atomicBitwiseTests.testXorAndFetch(baseValue: -1, opValue: 0)
        atomicBitwiseTests.testXorAndFetch(baseValue: 0, opValue: -1)
        atomicBitwiseTests.testXorAndFetch(baseValue: -1, opValue: -1)
        atomicBitwiseTests.testXorAndFetch(baseValue: 1, opValue: -1)
        atomicBitwiseTests.testXorAndFetch(baseValue: -1, opValue: 1)
    }

    func testOperatorAnd() {
        atomicBitwiseTests.testOperatorAnd(baseValue: 0, opValue: 0)
        atomicBitwiseTests.testOperatorAnd(baseValue: 1, opValue: 0)
        atomicBitwiseTests.testOperatorAnd(baseValue: 0, opValue: 1)
        atomicBitwiseTests.testOperatorAnd(baseValue: 1, opValue: 1)
        atomicBitwiseTests.testOperatorAnd(baseValue: -1, opValue: 0)
        atomicBitwiseTests.testOperatorAnd(baseValue: 0, opValue: -1)
        atomicBitwiseTests.testOperatorAnd(baseValue: -1, opValue: -1)
        atomicBitwiseTests.testOperatorAnd(baseValue: 1, opValue: -1)
        atomicBitwiseTests.testOperatorAnd(baseValue: -1, opValue: 1)
    }

    func testOperatorOr() {
        atomicBitwiseTests.testOperatorOr(baseValue: 0, opValue: 0)
        atomicBitwiseTests.testOperatorOr(baseValue: 1, opValue: 0)
        atomicBitwiseTests.testOperatorOr(baseValue: 0, opValue: 1)
        atomicBitwiseTests.testOperatorOr(baseValue: 1, opValue: 1)
        atomicBitwiseTests.testOperatorOr(baseValue: -1, opValue: 0)
        atomicBitwiseTests.testOperatorOr(baseValue: 0, opValue: -1)
        atomicBitwiseTests.testOperatorOr(baseValue: -1, opValue: -1)
        atomicBitwiseTests.testOperatorOr(baseValue: 1, opValue: -1)
        atomicBitwiseTests.testOperatorOr(baseValue: -1, opValue: 1)
    }

    func testOperatorXor() {
        atomicBitwiseTests.testOperatorXor(baseValue: 0, opValue: 0)
        atomicBitwiseTests.testOperatorXor(baseValue: 1, opValue: 0)
        atomicBitwiseTests.testOperatorXor(baseValue: 0, opValue: 1)
        atomicBitwiseTests.testOperatorXor(baseValue: 1, opValue: 1)
        atomicBitwiseTests.testOperatorXor(baseValue: -1, opValue: 0)
        atomicBitwiseTests.testOperatorXor(baseValue: 0, opValue: -1)
        atomicBitwiseTests.testOperatorXor(baseValue: -1, opValue: -1)
        atomicBitwiseTests.testOperatorXor(baseValue: 1, opValue: -1)
        atomicBitwiseTests.testOperatorXor(baseValue: -1, opValue: 1)
    }
}
