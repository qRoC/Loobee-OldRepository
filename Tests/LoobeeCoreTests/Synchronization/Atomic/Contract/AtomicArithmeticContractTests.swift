// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCore
import XCTest

class AtomicArithmeticContractTests<T: AtomicContract & AtomicArithmeticContract & FixedWidthInteger> {
    let firstVariant: T
    let secondVariant: T

    init(firstVariant: T, secondVariant: T) {
        self.firstVariant = firstVariant
        self.secondVariant = secondVariant
    }

    fileprivate func testFetchAndAdd(withOrder order: AtomicOrder?) {
        func callTestFn(value: inout T, valueToAdd: T) -> T {
            if let order = order {
                return value.atomicFetchAndAdd(valueToAdd, withOrder: order)
            }

            return value.atomicFetchAndAdd(valueToAdd)
        }

        var value = self.firstVariant
        XCTAssertEqual(callTestFn(value: &value, valueToAdd: self.secondVariant), self.firstVariant)
        XCTAssertEqual(value.atomicLoad(), self.firstVariant &+ self.secondVariant)

        var value2 = self.secondVariant
        XCTAssertEqual(callTestFn(value: &value2, valueToAdd: self.firstVariant), self.secondVariant)
        XCTAssertEqual(value2.atomicLoad(), self.secondVariant &+ self.firstVariant)
    }

    func testFetchAndAddRelaxed() {
        self.testFetchAndAdd(withOrder: .relaxed)
    }

    func testFetchAndAddConsume() {
        self.testFetchAndAdd(withOrder: .consume)
    }

    func testFetchAndAddAcquire() {
        self.testFetchAndAdd(withOrder: .acquire)
    }

    func testFetchAndAddRelease() {
        self.testFetchAndAdd(withOrder: .release)
    }

    func testFetchAndAddAcqRel() {
        self.testFetchAndAdd(withOrder: .acqRel)
    }

    func testFetchAndAddSeqCst() {
        self.testFetchAndAdd(withOrder: .seqCst)
    }

    func testFetchAndAddDefault() {
        self.testFetchAndAdd(withOrder: nil)
    }

    fileprivate func testFetchAndSub(withOrder order: AtomicOrder?) {
        func callTestFn(value: inout T, valueToSub: T) -> T {
            if let order = order {
                return value.atomicFetchAndSub(valueToSub, withOrder: order)
            }

            return value.atomicFetchAndSub(valueToSub)
        }

        var value = self.firstVariant
        XCTAssertEqual(callTestFn(value: &value, valueToSub: self.secondVariant), self.firstVariant)
        XCTAssertEqual(value.atomicLoad(), self.firstVariant &- self.secondVariant)

        var value2 = self.secondVariant
        XCTAssertEqual(callTestFn(value: &value2, valueToSub: self.firstVariant), self.secondVariant)
        XCTAssertEqual(value2.atomicLoad(), self.secondVariant &- self.firstVariant)
    }

    func testFetchAndSubRelaxed() {
        self.testFetchAndSub(withOrder: .relaxed)
    }

    func testFetchAndSubConsume() {
        self.testFetchAndSub(withOrder: .consume)
    }

    func testFetchAndSubAcquire() {
        self.testFetchAndSub(withOrder: .acquire)
    }

    func testFetchAndSubRelease() {
        self.testFetchAndSub(withOrder: .release)
    }

    func testFetchAndSubAcqRel() {
        self.testFetchAndSub(withOrder: .acqRel)
    }

    func testFetchAndSubSeqCst() {
        self.testFetchAndSub(withOrder: .seqCst)
    }

    func testFetchAndSubDefault() {
        self.testFetchAndSub(withOrder: nil)
    }

    fileprivate func testAddAndFetch(withOrder order: AtomicOrder?) {
        func callTestFn(value: inout T, valueToAdd: T) -> T {
            if let order = order {
                return value.atomicAddAndFetch(valueToAdd, withOrder: order)
            }

            return value.atomicAddAndFetch(valueToAdd)
        }

        var value = self.firstVariant
        XCTAssertEqual(callTestFn(value: &value, valueToAdd: self.secondVariant), self.firstVariant &+ self.secondVariant)
        XCTAssertEqual(value.atomicLoad(), self.firstVariant &+ self.secondVariant)

        var value2 = self.secondVariant
        XCTAssertEqual(callTestFn(value: &value2, valueToAdd: self.firstVariant), self.secondVariant &+ self.firstVariant)
        XCTAssertEqual(value2.atomicLoad(), self.secondVariant &+ self.firstVariant)
    }

    func testAddAndFetchRelaxed() {
        self.testAddAndFetch(withOrder: .relaxed)
    }

    func testAddAndFetchConsume() {
        self.testAddAndFetch(withOrder: .consume)
    }

    func testAddAndFetchAcquire() {
        self.testAddAndFetch(withOrder: .acquire)
    }

    func testAddAndFetchRelease() {
        self.testAddAndFetch(withOrder: .release)
    }

    func testAddAndFetchAcqRel() {
        self.testAddAndFetch(withOrder: .acqRel)
    }

    func testAddAndFetchSeqCst() {
        self.testAddAndFetch(withOrder: .seqCst)
    }

    func testAddAndFetchDefault() {
        self.testAddAndFetch(withOrder: nil)
    }

    fileprivate func testSubAndFetch(withOrder order: AtomicOrder?) {
        func callTestFn(value: inout T, valueToSub: T) -> T {
            if let order = order {
                return value.atomicSubAndFetch(valueToSub, withOrder: order)
            }

            return value.atomicSubAndFetch(valueToSub)
        }

        var value = self.firstVariant
        XCTAssertEqual(callTestFn(value: &value, valueToSub: self.secondVariant), self.firstVariant &- self.secondVariant)
        XCTAssertEqual(value.atomicLoad(), self.firstVariant &- self.secondVariant)

        var value2 = self.secondVariant
        XCTAssertEqual(callTestFn(value: &value2, valueToSub: self.firstVariant), self.secondVariant &- self.firstVariant)
        XCTAssertEqual(value2.atomicLoad(), self.secondVariant &- self.firstVariant)
    }

    func testSubAndFetchRelaxed() {
        self.testSubAndFetch(withOrder: .relaxed)
    }

    func testSubAndFetchConsume() {
        self.testSubAndFetch(withOrder: .consume)
    }

    func testSubAndFetchAcquire() {
        self.testSubAndFetch(withOrder: .acquire)
    }

    func testSubAndFetchRelease() {
        self.testSubAndFetch(withOrder: .release)
    }

    func testSubAndFetchAcqRel() {
        self.testSubAndFetch(withOrder: .acqRel)
    }

    func testSubAndFetchSeqCst() {
        self.testSubAndFetch(withOrder: .seqCst)
    }

    func testSubAndFetchDefault() {
        self.testSubAndFetch(withOrder: nil)
    }
}
