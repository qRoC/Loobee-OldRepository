// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

@testable import LoobeeCore
import XCTest

internal class MoveonlyTestCounter {
    var initCount: Count = 0
    var deinitCount: Count = 0
}

internal struct MoveonlyTest: Moveonly {
    var a: Int

    var counter: MoveonlyTestCounter

    mutating func incA() {
        self.a += 1
    }

    init(counter: MoveonlyTestCounter) {
        self.a = 0
        self.counter = counter

        self.counter.initCount += 1
    }

    func _deinit() {
        self.counter.deinitCount += 1
    }
}

internal class MoveonlyTests: XCTestCase {
    func testNoCopy() {
        let counter = MoveonlyTestCounter()
        do {
            let test1 = MoveonlyBox(init: MoveonlyTest(counter: counter))
            test1.value.incA()
            test1.value.a += 1
            XCTAssertEqual(test1.value.a, 2)
            XCTAssertEqual(counter.initCount, 1)
            XCTAssertEqual(counter.deinitCount, 0)
        }

        XCTAssertEqual(counter.initCount, 1)
        XCTAssertEqual(counter.deinitCount, 1)
    }

    func testMove() {
        let counter = MoveonlyTestCounter()
        do {
            var test2: MoveonlyBox<MoveonlyTest>

            do {
                let test1 = MoveonlyBox(init: MoveonlyTest(counter: counter))
                test1.value.incA()
                test1.value.a += 1
                XCTAssertEqual(test1.value.a, 2)
                XCTAssertEqual(counter.initCount, 1)
                XCTAssertEqual(counter.deinitCount, 0)

                test2 = MoveonlyBox(move: test1)
                test2.value.incA()
                test2.value.a += 1
            }

            XCTAssertEqual(test2.value.a, 4)
            XCTAssertEqual(counter.initCount, 1)
            XCTAssertEqual(counter.deinitCount, 0)
        }

        XCTAssertEqual(counter.initCount, 1)
        XCTAssertEqual(counter.deinitCount, 1)
    }
}
