// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

@testable import LoobeeCore
import XCTest

internal struct MoveonlyTestStruct: Moveonly, Equatable {
    var a: Int
    var b: String
}

internal class MoveonlyTestClass: Moveonly {
    var a: Int
    var b: String

    init(a: Int, b: String) {
        self.a = a
        self.b = b
    }
}

internal class MoveonlyTests: XCTestCase {
    func testMoveStruct() {
        let test = MoveonlyTestStruct(a: 412, b: "asdjqw")
        XCTAssertEqual(test, move(test))
    }

    func testMoveClass() {
        let test = MoveonlyTestClass(a: 5125, b: "fasfqwfqwz")
        XCTAssertTrue(test === move(test))
    }
}
