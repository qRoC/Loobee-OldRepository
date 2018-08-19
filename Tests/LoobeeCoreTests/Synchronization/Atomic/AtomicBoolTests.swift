// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCore
import XCTest

internal class AtomicBoolTests: XCTestCase {
    let atomicContractTest = AtomicContractTests(firstVariant: true, secondVariant: false)

    func testIsAlwaysLockFree() {
        self.atomicContractTest.testIsAlwaysLockFree()
    }

    func testLoadRelaxed() {
        self.atomicContractTest.testLoadRelaxed()
    }

    func testLoadConsume() {
        self.atomicContractTest.testLoadConsume()
    }

    func testLoadAcquire() {
        self.atomicContractTest.testLoadAcquire()
    }

    func testLoadSeqCst() {
        self.atomicContractTest.testLoadSeqCst()
    }

    func testLoadDefault() {
        self.atomicContractTest.testLoadDefault()
    }

    func testStoreRelaxed() {
        self.atomicContractTest.testStoreRelaxed()
    }

    func testStoreRelease() {
        self.atomicContractTest.testStoreRelease()
    }

    func testStoreSeqCst() {
        self.atomicContractTest.testStoreSeqCst()
    }

    func testStoreDefault() {
        self.atomicContractTest.testStoreDefault()
    }

    func testExchangeRelaxed() {
        self.atomicContractTest.testExchangeRelaxed()
    }

    func testExchangeAcquire() {
        self.atomicContractTest.testExchangeAcquire()
    }

    func testExchangeRelease() {
        self.atomicContractTest.testExchangeRelease()
    }

    func testExchangeAcqRel() {
        self.atomicContractTest.testExchangeAcqRel()
    }

    func testExchangeSeqCst() {
        self.atomicContractTest.testExchangeSeqCst()
    }

    func testExchangeDefault() {
        self.atomicContractTest.testExchangeDefault()
    }

    func testCompareAndExchangeWeakRelaxed() {
        self.atomicContractTest.testCompareAndExchangeWeakRelaxed()
    }

    func testCompareAndExchangeWeakConsume() {
        self.atomicContractTest.testCompareAndExchangeWeakConsume()
    }

    func testCompareAndExchangeWeakAcquire() {
        self.atomicContractTest.testCompareAndExchangeWeakAcquire()
    }

    func testCompareAndExchangeWeakRelease() {
        self.atomicContractTest.testCompareAndExchangeWeakRelease()
    }

    func testCompareAndExchangeWeakAcqRel() {
        self.atomicContractTest.testCompareAndExchangeWeakAcqRel()
    }

    func testCompareAndExchangeWeakSeqCst() {
        self.atomicContractTest.testCompareAndExchangeWeakSeqCst()
    }

    func testCompareAndExchangeWeakDefault() {
        self.atomicContractTest.testCompareAndExchangeWeakDefault()
    }

    func testCompareAndExchangeStrongRelaxed() {
        self.atomicContractTest.testCompareAndExchangeStrongRelaxed()
    }

    func testCompareAndExchangeStrongConsume() {
        self.atomicContractTest.testCompareAndExchangeStrongConsume()
    }

    func testCompareAndExchangeStrongAcquire() {
        self.atomicContractTest.testCompareAndExchangeStrongAcquire()
    }

    func testCompareAndExchangeStrongRelease() {
        self.atomicContractTest.testCompareAndExchangeStrongRelease()
    }

    func testCompareAndExchangeStrongAcqRel() {
        self.atomicContractTest.testCompareAndExchangeStrongAcqRel()
    }

    func testCompareAndExchangeStrongSeqCst() {
        self.atomicContractTest.testCompareAndExchangeStrongSeqCst()
    }

    func testCompareAndExchangeStrongDefault() {
        self.atomicContractTest.testCompareAndExchangeStrongDefault()
    }
}
