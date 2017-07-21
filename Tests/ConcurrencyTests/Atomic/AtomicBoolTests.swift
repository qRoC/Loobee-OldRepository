// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import XCTest
@testable import Loobee

class AtomicBoolTests: XCTestCase {
    static var allTests = [
        ("testIsAlwaysLockFree", testIsAlwaysLockFree),
        ("testLoad", testLoad),
        ("testStore", testStore),
        ("testExchange", testExchange),
        ("testCompareExchangeWeak", testCompareExchangeWeak),
        ("testCompareExchangeStrong", testCompareExchangeStrong)
    ]

    var atomicTests = AtomicTests<AtomicBool>()

    func testIsAlwaysLockFree() {
        atomicTests.testIsAlwaysLockFree()
    }

    func testLoad() {
        atomicTests.testLoad(value: true, valueOpposite: false)
    }

    func testStore() {
        atomicTests.testStore(value: true, valueOpposite: false)
    }

    func testExchange() {
        atomicTests.testExchange(value: true, valueOpposite: false)
    }

    func testCompareExchangeWeak() {
        atomicTests.testCompareExchangeWeak(value: true, valueOpposite: false)
    }

    func testCompareExchangeStrong() {
        atomicTests.testCompareExchangeStrong(value: true, valueOpposite: false)
    }
}
