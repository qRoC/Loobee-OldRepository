// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import XCTest
import LoobeeCore

class AtomicBoxTests: XCTestCase {
    class Foo {}

    func testIsAlwaysLockFree() {
        _ = AtomicBox<Foo>.isAlwaysLockFree()
    }

    fileprivate func testLoad(withOrder order: AtomicOrder?) {
        func callTestFn(_ object: AtomicBox<Foo>) -> Foo {
            if let order =  order {
                return object.load(withOrder: order)
            }

            return object.load()
        }

        let object = Foo()
        XCTAssert(callTestFn(AtomicBox(object: object)) === object)
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

    fileprivate func testStore(withOrder order: AtomicOrder?) {
        func callTestFn(_ object: AtomicBox<Foo>, _ newObject: Foo) {
            if let order =  order {
                return object.store(newObject, withOrder: order)
            }

            object.store(newObject)
        }

        let object1 = AtomicBox(object: Foo())
        let object2 = Foo()
        callTestFn(object1, object2)

        XCTAssert(object1.load() === object2)
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

    fileprivate func testExchange(withOrder order: AtomicOrder?) {
        func callTestFn(_ object: AtomicBox<Foo>, newObject: Foo) -> Foo {
            if let order =  order {
                return object.exchange(newObject: newObject, withOrder: order)
            }

            return object.exchange(newObject: newObject)
        }

        let object1 = Foo()
        let object2 = Foo()
        let atomic = AtomicBox(object: object1)

        XCTAssert(callTestFn(atomic, newObject: object2) === object1)
        XCTAssert(atomic.load() === object2)

        XCTAssert(callTestFn(atomic, newObject: object1) === object2)
        XCTAssert(atomic.load() === object1)
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

    fileprivate enum CompareAndExchange {
        case weak
        case strong
    }

    fileprivate func testCompareAndExchange(mode: CompareAndExchange, withOrder order: AtomicOrder?) {
        func callTestFn(_ object: AtomicBox<Foo>, expected: inout Foo, desired: Foo) -> Bool {
            switch mode {
            case .weak:
                if let order =  order {
                    return object.compareAndExchangeWeak(
                        expected: &expected,
                        desired: desired,
                        withOrder: order
                    )
                }

                return object.compareAndExchangeWeak(expected: &expected, desired: desired)
            case .strong:
                if let order =  order {
                    return object.compareAndExchangeStrong(
                        expected: &expected,
                        desired: desired,
                        withOrder: order
                    )
                }

                return object.compareAndExchangeStrong(expected: &expected, desired: desired)
            }
        }

        let originalObject1 = Foo()
        let originalObject2 = Foo()

        var object1 = originalObject1
        let object2 = originalObject2

        let atomicObject2 = AtomicBox(object: object2)

        XCTAssertEqual(callTestFn(atomicObject2, expected: &object1, desired: originalObject1), false)
        XCTAssert(atomicObject2.load() === originalObject2)
        XCTAssert(object1 === originalObject2)

        XCTAssertEqual(callTestFn(atomicObject2, expected: &object1, desired: originalObject2), true)
        XCTAssert(atomicObject2.load() === originalObject2)
        XCTAssert(object1 === originalObject2)
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
