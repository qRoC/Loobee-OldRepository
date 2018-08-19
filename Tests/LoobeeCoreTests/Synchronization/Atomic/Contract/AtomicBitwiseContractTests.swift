// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCore
import XCTest

class AtomicBitwiseContractTests<T: AtomicContract & AtomicBitwiseContract & FixedWidthInteger> {
    let firstVariant: T
    let secondVariant: T

    init(firstVariant: T, secondVariant: T) {
        self.firstVariant = firstVariant
        self.secondVariant = secondVariant
    }

    fileprivate func testFetchAndBitAnd(withOrder order: AtomicOrder?) {
        func callTestFn(value: inout T, applyValue: T) -> T {
            if let order = order {
                return value.atomicFetchAndBitAnd(applyValue, withOrder: order)
            }

            return value.atomicFetchAndBitAnd(applyValue)
        }

        var value = self.firstVariant

        XCTAssertEqual(callTestFn(value: &value, applyValue: self.secondVariant), self.firstVariant)
        XCTAssertEqual(value.atomicLoad(), self.firstVariant & self.secondVariant)
    }

    func testFetchAndBitAndRelaxed() {
        self.testFetchAndBitAnd(withOrder: .relaxed)
    }

    func testFetchAndBitAndConsume() {
        self.testFetchAndBitAnd(withOrder: .consume)
    }

    func testFetchAndBitAndAcquire() {
        self.testFetchAndBitAnd(withOrder: .acquire)
    }

    func testFetchAndBitAndRelease() {
        self.testFetchAndBitAnd(withOrder: .release)
    }

    func testFetchAndBitAndAcqRel() {
        self.testFetchAndBitAnd(withOrder: .acqRel)
    }

    func testFetchAndBitAndSeqCst() {
        self.testFetchAndBitAnd(withOrder: .seqCst)
    }

    func testFetchAndBitAndDefault() {
        self.testFetchAndBitAnd(withOrder: nil)
    }

    fileprivate func testFetchAndBitOr(withOrder order: AtomicOrder?) {
        func callTestFn(value: inout T, applyValue: T) -> T {
            if let order = order {
                return value.atomicFetchAndBitOr(applyValue, withOrder: order)
            }

            return value.atomicFetchAndBitOr(applyValue)
        }

        var value = self.firstVariant

        XCTAssertEqual(callTestFn(value: &value, applyValue: self.secondVariant), self.firstVariant)
        XCTAssertEqual(value.atomicLoad(), self.firstVariant | self.secondVariant)
    }

    func testFetchAndBitOrRelaxed() {
        self.testFetchAndBitOr(withOrder: .relaxed)
    }

    func testFetchAndBitOrConsume() {
        self.testFetchAndBitOr(withOrder: .consume)
    }

    func testFetchAndBitOrAcquire() {
        self.testFetchAndBitOr(withOrder: .acquire)
    }

    func testFetchAndBitOrRelease() {
        self.testFetchAndBitOr(withOrder: .release)
    }

    func testFetchAndBitOrAcqRel() {
        self.testFetchAndBitOr(withOrder: .acqRel)
    }

    func testFetchAndBitOrSeqCst() {
        self.testFetchAndBitOr(withOrder: .seqCst)
    }

    func testFetchAndBitOrDefault() {
        self.testFetchAndBitOr(withOrder: nil)
    }

    fileprivate func testFetchAndBitXor(withOrder order: AtomicOrder?) {
        func callTestFn(value: inout T, applyValue: T) -> T {
            if let order = order {
                return value.atomicFetchAndBitXor(applyValue, withOrder: order)
            }

            return value.atomicFetchAndBitXor(applyValue)
        }

        var value = self.firstVariant

        XCTAssertEqual(callTestFn(value: &value, applyValue: self.secondVariant), self.firstVariant)
        XCTAssertEqual(value.atomicLoad(), self.firstVariant ^ self.secondVariant)
    }

    func testFetchAndBitXorRelaxed() {
        self.testFetchAndBitXor(withOrder: .relaxed)
    }

    func testFetchAndBitXorConsume() {
        self.testFetchAndBitXor(withOrder: .consume)
    }

    func testFetchAndBitXorAcquire() {
        self.testFetchAndBitXor(withOrder: .acquire)
    }

    func testFetchAndBitXorRelease() {
        self.testFetchAndBitXor(withOrder: .release)
    }

    func testFetchAndBitXorAcqRel() {
        self.testFetchAndBitXor(withOrder: .acqRel)
    }

    func testFetchAndBitXorSeqCst() {
        self.testFetchAndBitXor(withOrder: .seqCst)
    }

    func testFetchAndBitXorDefault() {
        self.testFetchAndBitXor(withOrder: nil)
    }

    fileprivate func testBitAndAndFetch(withOrder order: AtomicOrder?) {
        func callTestFn(value: inout T, applyValue: T) -> T {
            if let order = order {
                return value.atomicBitAndAndFetch(applyValue, withOrder: order)
            }

            return value.atomicBitAndAndFetch(applyValue)
        }

        var value = self.firstVariant
        let result = self.firstVariant & self.secondVariant

        XCTAssertEqual(callTestFn(value: &value, applyValue: self.secondVariant), result)
        XCTAssertEqual(value.atomicLoad(), result)
    }

    func testBitAndAndFetchRelaxed() {
        self.testBitAndAndFetch(withOrder: .relaxed)
    }

    func testBitAndAndFetchConsume() {
        self.testBitAndAndFetch(withOrder: .consume)
    }

    func testBitAndAndFetchAcquire() {
        self.testBitAndAndFetch(withOrder: .acquire)
    }

    func testBitAndAndFetchRelease() {
        self.testBitAndAndFetch(withOrder: .release)
    }

    func testBitAndAndFetchAcqRel() {
        self.testBitAndAndFetch(withOrder: .acqRel)
    }

    func testBitAndAndFetchSeqCst() {
        self.testBitAndAndFetch(withOrder: .seqCst)
    }

    func testBitAndAndFetchDefault() {
        self.testBitAndAndFetch(withOrder: nil)
    }

    fileprivate func testBitOrAndFetch(withOrder order: AtomicOrder?) {
        func callTestFn(value: inout T, applyValue: T) -> T {
            if let order = order {
                return value.atomicBitOrAndFetch(applyValue, withOrder: order)
            }

            return value.atomicBitOrAndFetch(applyValue)
        }

        var value = self.firstVariant
        let result = self.firstVariant | self.secondVariant

        XCTAssertEqual(callTestFn(value: &value, applyValue: self.secondVariant), result)
        XCTAssertEqual(value.atomicLoad(), result)
    }

    func testBitOrAndFetchRelaxed() {
        self.testBitOrAndFetch(withOrder: .relaxed)
    }

    func testBitOrAndFetchConsume() {
        self.testBitOrAndFetch(withOrder: .consume)
    }

    func testBitOrAndFetchAcquire() {
        self.testBitOrAndFetch(withOrder: .acquire)
    }

    func testBitOrAndFetchRelease() {
        self.testBitOrAndFetch(withOrder: .release)
    }

    func testBitOrAndFetchAcqRel() {
        self.testBitOrAndFetch(withOrder: .acqRel)
    }

    func testBitOrAndFetchSeqCst() {
        self.testBitOrAndFetch(withOrder: .seqCst)
    }

    func testBitOrAndFetchDefault() {
        self.testBitOrAndFetch(withOrder: nil)
    }

    fileprivate func testBitXorAndFetch(withOrder order: AtomicOrder?) {
        func callTestFn(value: inout T, applyValue: T) -> T {
            if let order = order {
                return value.atomicBitXorAndFetch(applyValue, withOrder: order)
            }

            return value.atomicBitXorAndFetch(applyValue)
        }

        var value = self.firstVariant
        let result = self.firstVariant ^ self.secondVariant

        XCTAssertEqual(callTestFn(value: &value, applyValue: self.secondVariant), result)
        XCTAssertEqual(value.atomicLoad(), result)
    }

    func testBitXorAndFetchRelaxed() {
        self.testBitXorAndFetch(withOrder: .relaxed)
    }

    func testBitXorAndFetchConsume() {
        self.testBitXorAndFetch(withOrder: .consume)
    }

    func testBitXorAndFetchAcquire() {
        self.testBitXorAndFetch(withOrder: .acquire)
    }

    func testBitXorAndFetchRelease() {
        self.testBitXorAndFetch(withOrder: .release)
    }

    func testBitXorAndFetchAcqRel() {
        self.testBitXorAndFetch(withOrder: .acqRel)
    }

    func testBitXorAndFetchSeqCst() {
        self.testBitXorAndFetch(withOrder: .seqCst)
    }

    func testBitXorAndFetchDefault() {
        self.testBitXorAndFetch(withOrder: nil)
    }
}
