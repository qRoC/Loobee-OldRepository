// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCore
import XCTest

internal class AtomicUInt16Tests: XCTestCase {
    typealias TestType = UInt16

    static let firstVariant: TestType = 123
    static let secondVariant: TestType = 456

    let atomicContractTest = AtomicContractTests(
        firstVariant: firstVariant,
        secondVariant: secondVariant
    )

    let atomicArithmeticContractTest = AtomicArithmeticContractTests(
        firstVariant: firstVariant,
        secondVariant: secondVariant
    )

    let atomicBitwiseContractTest = AtomicBitwiseContractTests(
        firstVariant: firstVariant,
        secondVariant: secondVariant
    )

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

    func testFetchAndAddRelaxed() {
        self.atomicArithmeticContractTest.testFetchAndAddRelaxed()
    }

    func testFetchAndAddConsume() {
        self.atomicArithmeticContractTest.testFetchAndAddConsume()
    }

    func testFetchAndAddAcquire() {
        self.atomicArithmeticContractTest.testFetchAndAddAcquire()
    }

    func testFetchAndAddRelease() {
        self.atomicArithmeticContractTest.testFetchAndAddRelease()
    }

    func testFetchAndAddAcqRel() {
        self.atomicArithmeticContractTest.testFetchAndAddAcqRel()
    }

    func testFetchAndAddSeqCst() {
        self.atomicArithmeticContractTest.testFetchAndAddSeqCst()
    }

    func testFetchAndAddDefault() {
        self.atomicArithmeticContractTest.testFetchAndAddDefault()
    }

    func testFetchAndSubRelaxed() {
        self.atomicArithmeticContractTest.testFetchAndSubRelaxed()
    }

    func testFetchAndSubConsume() {
        self.atomicArithmeticContractTest.testFetchAndSubConsume()
    }

    func testFetchAndSubAcquire() {
        self.atomicArithmeticContractTest.testFetchAndSubAcquire()
    }

    func testFetchAndSubRelease() {
        self.atomicArithmeticContractTest.testFetchAndSubRelease()
    }

    func testFetchAndSubAcqRel() {
        self.atomicArithmeticContractTest.testFetchAndSubAcqRel()
    }

    func testFetchAndSubSeqCst() {
        self.atomicArithmeticContractTest.testFetchAndSubSeqCst()
    }

    func testFetchAndSubDefault() {
        self.atomicArithmeticContractTest.testFetchAndSubDefault()
    }

    func testAddAndFetchRelaxed() {
        self.atomicArithmeticContractTest.testAddAndFetchRelaxed()
    }

    func testAddAndFetchConsume() {
        self.atomicArithmeticContractTest.testAddAndFetchConsume()
    }

    func testAddAndFetchAcquire() {
        self.atomicArithmeticContractTest.testAddAndFetchAcquire()
    }

    func testAddAndFetchRelease() {
        self.atomicArithmeticContractTest.testAddAndFetchRelease()
    }

    func testAddAndFetchAcqRel() {
        self.atomicArithmeticContractTest.testAddAndFetchAcqRel()
    }

    func testAddAndFetchSeqCst() {
        self.atomicArithmeticContractTest.testAddAndFetchSeqCst()
    }

    func testAddAndFetchDefault() {
        self.atomicArithmeticContractTest.testAddAndFetchDefault()
    }

    func testSubAndFetchRelaxed() {
        self.atomicArithmeticContractTest.testSubAndFetchRelaxed()
    }

    func testSubAndFetchConsume() {
        self.atomicArithmeticContractTest.testSubAndFetchConsume()
    }

    func testSubAndFetchAcquire() {
        self.atomicArithmeticContractTest.testSubAndFetchAcquire()
    }

    func testSubAndFetchRelease() {
        self.atomicArithmeticContractTest.testSubAndFetchRelease()
    }

    func testSubAndFetchAcqRel() {
        self.atomicArithmeticContractTest.testSubAndFetchAcqRel()
    }

    func testSubAndFetchSeqCst() {
        self.atomicArithmeticContractTest.testSubAndFetchSeqCst()
    }

    func testSubAndFetchDefault() {
        self.atomicArithmeticContractTest.testSubAndFetchDefault()
    }

    func testFetchAndBitAndRelaxed() {
        self.atomicBitwiseContractTest.testFetchAndBitAndRelaxed()
    }

    func testFetchAndBitAndConsume() {
        self.atomicBitwiseContractTest.testFetchAndBitAndConsume()
    }

    func testFetchAndBitAndAcquire() {
        self.atomicBitwiseContractTest.testFetchAndBitAndAcquire()
    }

    func testFetchAndBitAndRelease() {
        self.atomicBitwiseContractTest.testFetchAndBitAndRelease()
    }

    func testFetchAndBitAndAcqRel() {
        self.atomicBitwiseContractTest.testFetchAndBitAndAcqRel()
    }

    func testFetchAndBitAndSeqCst() {
        self.atomicBitwiseContractTest.testFetchAndBitAndSeqCst()
    }

    func testFetchAndBitAndDefault() {
        self.atomicBitwiseContractTest.testFetchAndBitAndDefault()
    }

    func testFetchAndBitOrRelaxed() {
        self.atomicBitwiseContractTest.testFetchAndBitOrRelaxed()
    }

    func testFetchAndBitOrConsume() {
        self.atomicBitwiseContractTest.testFetchAndBitOrConsume()
    }

    func testFetchAndBitOrAcquire() {
        self.atomicBitwiseContractTest.testFetchAndBitOrAcquire()
    }

    func testFetchAndBitOrRelease() {
        self.atomicBitwiseContractTest.testFetchAndBitOrRelease()
    }

    func testFetchAndBitOrAcqRel() {
        self.atomicBitwiseContractTest.testFetchAndBitOrAcqRel()
    }

    func testFetchAndBitOrSeqCst() {
        self.atomicBitwiseContractTest.testFetchAndBitOrSeqCst()
    }

    func testFetchAndBitOrDefault() {
        self.atomicBitwiseContractTest.testFetchAndBitOrDefault()
    }

    func testFetchAndBitXorRelaxed() {
        self.atomicBitwiseContractTest.testFetchAndBitXorRelaxed()
    }

    func testFetchAndBitXorConsume() {
        self.atomicBitwiseContractTest.testFetchAndBitXorConsume()
    }

    func testFetchAndBitXorAcquire() {
        self.atomicBitwiseContractTest.testFetchAndBitXorAcquire()
    }

    func testFetchAndBitXorRelease() {
        self.atomicBitwiseContractTest.testFetchAndBitXorRelease()
    }

    func testFetchAndBitXorAcqRel() {
        self.atomicBitwiseContractTest.testFetchAndBitXorAcqRel()
    }

    func testFetchAndBitXorSeqCst() {
        self.atomicBitwiseContractTest.testFetchAndBitXorSeqCst()
    }

    func testFetchAndBitXorDefault() {
        self.atomicBitwiseContractTest.testFetchAndBitXorDefault()
    }

    func testBitAndAndFetchRelaxed() {
        self.atomicBitwiseContractTest.testBitAndAndFetchRelaxed()
    }

    func testBitAndAndFetchConsume() {
        self.atomicBitwiseContractTest.testBitAndAndFetchConsume()
    }

    func testBitAndAndFetchAcquire() {
        self.atomicBitwiseContractTest.testBitAndAndFetchAcquire()
    }

    func testBitAndAndFetchRelease() {
        self.atomicBitwiseContractTest.testBitAndAndFetchRelease()
    }

    func testBitAndAndFetchAcqRel() {
        self.atomicBitwiseContractTest.testBitAndAndFetchAcqRel()
    }

    func testBitAndAndFetchSeqCst() {
        self.atomicBitwiseContractTest.testBitAndAndFetchSeqCst()
    }

    func testBitAndAndFetchDefault() {
        self.atomicBitwiseContractTest.testBitAndAndFetchDefault()
    }

    func testBitOrAndFetchRelaxed() {
        self.atomicBitwiseContractTest.testBitOrAndFetchRelaxed()
    }

    func testBitOrAndFetchConsume() {
        self.atomicBitwiseContractTest.testBitOrAndFetchConsume()
    }

    func testBitOrAndFetchAcquire() {
        self.atomicBitwiseContractTest.testBitOrAndFetchAcquire()
    }

    func testBitOrAndFetchRelease() {
        self.atomicBitwiseContractTest.testBitOrAndFetchRelease()
    }

    func testBitOrAndFetchAcqRel() {
        self.atomicBitwiseContractTest.testBitOrAndFetchAcqRel()
    }

    func testBitOrAndFetchSeqCst() {
        self.atomicBitwiseContractTest.testBitOrAndFetchSeqCst()
    }

    func testBitOrAndFetchDefault() {
        self.atomicBitwiseContractTest.testBitOrAndFetchDefault()
    }

    func testBitXorAndFetchRelaxed() {
        self.atomicBitwiseContractTest.testBitXorAndFetchRelaxed()
    }

    func testBitXorAndFetchConsume() {
        self.atomicBitwiseContractTest.testBitXorAndFetchConsume()
    }

    func testBitXorAndFetchAcquire() {
        self.atomicBitwiseContractTest.testBitXorAndFetchAcquire()
    }

    func testBitXorAndFetchRelease() {
        self.atomicBitwiseContractTest.testBitXorAndFetchRelease()
    }

    func testBitXorAndFetchAcqRel() {
        self.atomicBitwiseContractTest.testBitXorAndFetchAcqRel()
    }

    func testBitXorAndFetchSeqCst() {
        self.atomicBitwiseContractTest.testBitXorAndFetchSeqCst()
    }

    func testBitXorAndFetchDefault() {
        self.atomicBitwiseContractTest.testBitXorAndFetchDefault()
    }
}
