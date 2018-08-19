// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCore
import XCTest

class AtomicTests: XCTestCase {
    func testIsAlwaysLockFree() {
        XCTAssertEqual(Atomic<Int>.isAlwaysLockFree(), Int.isAlwaysLockFree())
    }

    func testStore() {
        let obj1 = Atomic(1)
        var obj2 = 1

        for order: AtomicOrder in [.relaxed, .release, .seqCst] {
            obj1.store(1, withOrder: order)
            obj2.atomicStore(1, withOrder: order)
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        obj1.store(1)
        obj2.atomicStore(1)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testLoad() {
        let obj1 = Atomic(1)
        var obj2 = 1

        for order: AtomicOrder in [.relaxed, .consume, .acquire, .seqCst] {
            XCTAssertEqual(obj1.load(withOrder: order), obj2.atomicLoad(withOrder: order))
        }

        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testExchange() {
        let obj1 = Atomic(1)
        var obj2 = 1

        for order: AtomicOrder in [.relaxed, .acquire, .release, .acqRel, .seqCst] {
            let result1 = obj1.exchange(newValue: 1, withOrder: order)
            let result2 = obj2.atomicExchange(newValue: 1, withOrder: order)
            XCTAssertEqual(result1, result2)
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        let result1 = obj1.exchange(newValue: 1)
        let result2 = obj2.atomicExchange(newValue: 1)
        XCTAssertEqual(result1, result2)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testCompareAndExchangeWeak() {
        let obj1 = Atomic(1)
        var obj2 = 1

        do {
            var expected1 = 0
            var expected2 = 0
            for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
                let result1 = obj1.compareAndExchangeWeak(
                    expected: &expected1,
                    desired: 1,
                    successOrder: order,
                    failureOrder: .relaxed
                )
                let result2 = obj2.atomicCompareAndExchangeWeak(
                    expected: &expected2,
                    desired: 1,
                    successOrder: order,
                    failureOrder: .relaxed
                )
                XCTAssertEqual(result1, result2)
                XCTAssertEqual(obj1.load(), obj2.atomicLoad())
            }
        }

        do {
            var expected1 = 0
            var expected2 = 0
            for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
                let result1 = obj1.compareAndExchangeWeak(
                    expected: &expected1,
                    desired: 1,
                    withOrder: order
                )
                let result2 = obj2.atomicCompareAndExchangeWeak(
                    expected: &expected2,
                    desired: 1,
                    withOrder: order
                )
                XCTAssertEqual(result1, result2)
                XCTAssertEqual(obj1.load(), obj2.atomicLoad())
            }
        }

        var expected1 = 0
        var expected2 = 0
        let result1 = obj1.compareAndExchangeWeak(
            expected: &expected1,
            desired: 1
        )
        let result2 = obj2.atomicCompareAndExchangeWeak(
            expected: &expected2,
            desired: 1
        )
        XCTAssertEqual(result1, result2)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testCompareAndExchangeStrong() {
        let obj1 = Atomic(1)
        var obj2 = 1

        do {
            var expected1 = 0
            var expected2 = 0
            for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
                let result1 = obj1.compareAndExchangeStrong(
                    expected: &expected1,
                    desired: 1,
                    successOrder: order,
                    failureOrder: .relaxed
                )
                let result2 = obj2.atomicCompareAndExchangeStrong(
                    expected: &expected2,
                    desired: 1,
                    successOrder: order,
                    failureOrder: .relaxed
                )
                XCTAssertEqual(result1, result2)
                XCTAssertEqual(obj1.load(), obj2.atomicLoad())
            }
        }

        do {
            var expected1 = 0
            var expected2 = 0
            for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
                let result1 = obj1.compareAndExchangeStrong(
                    expected: &expected1,
                    desired: 1,
                    withOrder: order
                )
                let result2 = obj2.atomicCompareAndExchangeStrong(
                    expected: &expected2,
                    desired: 1,
                    withOrder: order
                )
                XCTAssertEqual(result1, result2)
                XCTAssertEqual(obj1.load(), obj2.atomicLoad())
            }
        }

        var expected1 = 0
        var expected2 = 0
        let result1 = obj1.compareAndExchangeStrong(
            expected: &expected1,
            desired: 1
        )
        let result2 = obj2.atomicCompareAndExchangeStrong(
            expected: &expected2,
            desired: 1
        )
        XCTAssertEqual(result1, result2)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testFetchAndAdd() {
        let obj1 = Atomic(1)
        var obj2 = 1

        for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
            XCTAssertEqual(
                obj1.fetchAndAdd(1, withOrder: order),
                obj2.atomicFetchAndAdd(1, withOrder: order)
            )
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        XCTAssertEqual(
            obj1.fetchAndAdd(1),
            obj2.atomicFetchAndAdd(1)
        )
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testFetchAndSub() {
        let obj1 = Atomic(1)
        var obj2 = 1

        for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
            XCTAssertEqual(
                obj1.fetchAndSub(1, withOrder: order),
                obj2.atomicFetchAndSub(1, withOrder: order)
            )
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        XCTAssertEqual(
            obj1.fetchAndSub(1),
            obj2.atomicFetchAndSub(1)
        )
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testAddAndFetch() {
        let obj1 = Atomic(1)
        var obj2 = 1

        for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
            XCTAssertEqual(
                obj1.addAndFetch(1, withOrder: order),
                obj2.atomicAddAndFetch(1, withOrder: order)
            )
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        XCTAssertEqual(
            obj1.addAndFetch(1),
            obj2.atomicAddAndFetch(1)
        )
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testSubAndFetch() {
        let obj1 = Atomic(1)
        var obj2 = 1

        for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
            XCTAssertEqual(
                obj1.subAndFetch(1, withOrder: order),
                obj2.atomicSubAndFetch(1, withOrder: order)
            )
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        XCTAssertEqual(
            obj1.subAndFetch(1),
            obj2.atomicSubAndFetch(1)
        )
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testAddOperator() {
        let obj1 = Atomic(1)
        var obj2 = 1

        obj1 += 1
        _ = obj2.atomicFetchAndAdd(1)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())

        obj1 += Atomic(1)
        _ = obj2.atomicFetchAndAdd(1)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testSubOperator() {
        let obj1 = Atomic(1)
        var obj2 = 1

        obj1 -= 1
        _ = obj2.atomicFetchAndSub(1)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())

        obj1 -= Atomic(1)
        _ = obj2.atomicFetchAndSub(1)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testFetchAndBitAnd() {
        let obj1 = Atomic(11_241)
        var obj2 = 11_241

        for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
            XCTAssertEqual(
                obj1.fetchAndBitAnd(1123, withOrder: order),
                obj2.atomicFetchAndBitAnd(1123, withOrder: order)
            )
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        XCTAssertEqual(
            obj1.fetchAndBitAnd(21_551),
            obj2.atomicFetchAndBitAnd(21_551)
        )
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testFetchAndBitOr() {
        let obj1 = Atomic(11_241)
        var obj2 = 11_241

        for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
            XCTAssertEqual(
                obj1.fetchAndBitOr(1123, withOrder: order),
                obj2.atomicFetchAndBitOr(1123, withOrder: order)
            )
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        XCTAssertEqual(
            obj1.fetchAndBitOr(21_551),
            obj2.atomicFetchAndBitOr(21_551)
        )
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testFetchAndBitXor() {
        let obj1 = Atomic(11_241)
        var obj2 = 11_241

        for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
            XCTAssertEqual(
                obj1.fetchAndBitXor(1123, withOrder: order),
                obj2.atomicFetchAndBitXor(1123, withOrder: order)
            )
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        XCTAssertEqual(
            obj1.fetchAndBitXor(21_551),
            obj2.atomicFetchAndBitXor(21_551)
        )
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testBitAndAndFetch() {
        let obj1 = Atomic(11_241)
        var obj2 = 11_241

        for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
            XCTAssertEqual(
                obj1.bitAndAndFetch(1123, withOrder: order),
                obj2.atomicBitAndAndFetch(1123, withOrder: order)
            )
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        XCTAssertEqual(
            obj1.bitAndAndFetch(21_551),
            obj2.atomicBitAndAndFetch(21_551)
        )
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testBitOrAndFetch() {
        let obj1 = Atomic(11_241)
        var obj2 = 11_241

        for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
            XCTAssertEqual(
                obj1.bitOrAndFetch(1123, withOrder: order),
                obj2.atomicBitOrAndFetch(1123, withOrder: order)
            )
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        XCTAssertEqual(
            obj1.bitOrAndFetch(21_551),
            obj2.atomicBitOrAndFetch(21_551)
        )
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testBitXOrAndFetch() {
        let obj1 = Atomic(11_241)
        var obj2 = 11_241

        for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
            XCTAssertEqual(
                obj1.bitXorAndFetch(1123, withOrder: order),
                obj2.atomicBitXorAndFetch(1123, withOrder: order)
            )
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        XCTAssertEqual(
            obj1.bitXorAndFetch(21_551),
            obj2.atomicBitXorAndFetch(21_551)
        )
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testOperatorAnd() {
        let obj1 = Atomic(11_241)
        var obj2 = 11_241

        obj1 &= 21_551
        _ = obj2.atomicBitAndAndFetch(21_551)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())

        obj1 &= Atomic(21_551)
        _ = obj2.atomicBitAndAndFetch(21_551)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testOperatorOr() {
        let obj1 = Atomic(11_241)
        var obj2 = 11_241

        obj1 |= 21_551
        _ = obj2.atomicBitOrAndFetch(21_551)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())

        obj1 |= Atomic(21_551)
        _ = obj2.atomicBitOrAndFetch(21_551)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testOperatorXor() {
        let obj1 = Atomic(11_241)
        var obj2 = 11_241

        obj1 ^= 21_551
        _ = obj2.atomicBitXorAndFetch(21_551)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())

        obj1 ^= Atomic(21_551)
        _ = obj2.atomicBitXorAndFetch(21_551)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }
}
