// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCore
import XCTest

internal class AtomicContractTests<T: AtomicContract & Equatable> {
    let firstVariant: T
    let secondVariant: T

    init(firstVariant: T, secondVariant: T) {
        self.firstVariant = firstVariant
        self.secondVariant = secondVariant
    }

    func testIsAlwaysLockFree() {
        _ = T.isAlwaysLockFree()
    }

    private func testLoad(withOrder order: AtomicOrder?) {
        func callTestFn(value: inout T) -> T {
            if let order = order {
                return value.atomicLoad(withOrder: order)
            }

            return value.atomicLoad()
        }

        var value = self.firstVariant
        XCTAssertEqual(callTestFn(value: &value), self.firstVariant)
    }

    func testLoadRelaxed() {
        testLoad(withOrder: .relaxed)
    }

    func testLoadConsume() {
        testLoad(withOrder: .consume)
    }

    func testLoadAcquire() {
        testLoad(withOrder: .acquire)
    }

    func testLoadSeqCst() {
        testLoad(withOrder: .seqCst)
    }

    func testLoadDefault() {
        testLoad(withOrder: nil)
    }

    private func testStore(withOrder order: AtomicOrder?) {
        func callTestFn(value: inout T) {
            if let order = order {
                return value.atomicStore(self.secondVariant, withOrder: order)
            }

            value.atomicStore(self.secondVariant)
        }

        var value = self.firstVariant
        callTestFn(value: &value)

        XCTAssertEqual(value.atomicLoad(), self.secondVariant)
    }

    func testStoreRelaxed() {
        self.testStore(withOrder: .relaxed)
    }

    func testStoreRelease() {
        self.testStore(withOrder: .release)
    }

    func testStoreSeqCst() {
        self.testStore(withOrder: .seqCst)
    }

    func testStoreDefault() {
        self.testStore(withOrder: nil)
    }

    private func testExchange(withOrder order: AtomicOrder?) {
        func callTestFn(value: inout T, newValue: T) -> T {
            if let order = order {
                return value.atomicExchange(newValue: newValue, withOrder: order)
            }

            return value.atomicExchange(newValue: newValue)
        }

        var value = self.firstVariant

        XCTAssertEqual(callTestFn(value: &value, newValue: self.secondVariant), self.firstVariant)
        XCTAssertEqual(value.atomicLoad(), self.secondVariant)

        XCTAssertEqual(callTestFn(value: &value, newValue: self.firstVariant), self.secondVariant)
        XCTAssertEqual(value.atomicLoad(), self.firstVariant)
    }

    func testExchangeRelaxed() {
        self.testExchange(withOrder: .relaxed)
    }

    func testExchangeAcquire() {
        self.testExchange(withOrder: .acquire)
    }

    func testExchangeRelease() {
        self.testExchange(withOrder: .release)
    }

    func testExchangeAcqRel() {
        self.testExchange(withOrder: .acqRel)
    }

    func testExchangeSeqCst() {
        self.testExchange(withOrder: .seqCst)
    }

    func testExchangeDefault() {
        self.testExchange(withOrder: nil)
    }

    private enum CompareAndExchange {
        case weak
        case strong
    }

    private func testCompareAndExchange(mode: CompareAndExchange, withOrder order: AtomicOrder?) {
        func callTestFn(value: inout T, expected: inout T, desired: T) -> Bool {
            switch mode {
            case .weak:
                if let order = order {
                    return value.atomicCompareAndExchangeWeak(
                        expected: &expected,
                        desired: desired,
                        withOrder: order
                    )
                }

                return value.atomicCompareAndExchangeWeak(expected: &expected, desired: desired)
            case .strong:
                if let order = order {
                    return value.atomicCompareAndExchangeStrong(
                        expected: &expected,
                        desired: desired,
                        withOrder: order
                    )
                }

                return value.atomicCompareAndExchangeStrong(expected: &expected, desired: desired)
            }
        }

        var value1 = self.firstVariant
        var value2 = self.secondVariant

        XCTAssertEqual(callTestFn(value: &value2, expected: &value1, desired: self.firstVariant), false)
        XCTAssertEqual(value2.atomicLoad(), self.secondVariant)
        XCTAssertEqual(value1, self.secondVariant)

        XCTAssertEqual(callTestFn(value: &value2, expected: &value1, desired: self.secondVariant), true)
        XCTAssertEqual(value2.atomicLoad(), self.secondVariant)
        XCTAssertEqual(value1, self.secondVariant)
    }

    func testCompareAndExchangeWeakRelaxed() {
        self.testCompareAndExchange(mode: .weak, withOrder: .relaxed)
    }

    func testCompareAndExchangeWeakConsume() {
        self.testCompareAndExchange(mode: .weak, withOrder: .consume)
    }

    func testCompareAndExchangeWeakAcquire() {
        self.testCompareAndExchange(mode: .weak, withOrder: .acquire)
    }

    func testCompareAndExchangeWeakRelease() {
        self.testCompareAndExchange(mode: .weak, withOrder: .release)
    }

    func testCompareAndExchangeWeakAcqRel() {
        self.testCompareAndExchange(mode: .weak, withOrder: .acqRel)
    }

    func testCompareAndExchangeWeakSeqCst() {
        self.testCompareAndExchange(mode: .weak, withOrder: .seqCst)
    }

    func testCompareAndExchangeWeakDefault() {
        self.testCompareAndExchange(mode: .weak, withOrder: nil)
    }

    func testCompareAndExchangeStrongRelaxed() {
        self.testCompareAndExchange(mode: .strong, withOrder: .relaxed)
    }

    func testCompareAndExchangeStrongConsume() {
        self.testCompareAndExchange(mode: .strong, withOrder: .consume)
    }

    func testCompareAndExchangeStrongAcquire() {
        self.testCompareAndExchange(mode: .strong, withOrder: .acquire)
    }

    func testCompareAndExchangeStrongRelease() {
        self.testCompareAndExchange(mode: .weak, withOrder: .release)
    }

    func testCompareAndExchangeStrongAcqRel() {
        self.testCompareAndExchange(mode: .strong, withOrder: .acqRel)
    }

    func testCompareAndExchangeStrongSeqCst() {
        self.testCompareAndExchange(mode: .strong, withOrder: .seqCst)
    }

    func testCompareAndExchangeStrongDefault() {
        self.testCompareAndExchange(mode: .strong, withOrder: nil)
    }
}
