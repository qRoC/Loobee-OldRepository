// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCore
import XCTest

internal class ByteTests: XCTestCase {
    func testEquatable() {
        XCTAssertEqual(Bit.zero, Bit.zero)
        XCTAssertEqual(Bit.one, Bit.one)

        XCTAssertNotEqual(Bit.zero, Bit.one)
        XCTAssertNotEqual(Bit.one, Bit.zero)
    }

    func testLogicalNOT() {
        XCTAssertEqual(!Bit.zero, Bit.one)
        XCTAssertEqual(!Bit.one, Bit.zero)
    }

    func testToggle() {
        var bit: Bit = .zero

        bit.toggle()
        XCTAssertEqual(bit, Bit.one)

        bit.toggle()
        XCTAssertEqual(bit, Bit.zero)
    }

    func testCustomStringConvertible() {
        XCTAssertNotEqual(Bit.zero.description, "")
        XCTAssertNotEqual(Bit.zero.description, Bit.one.description)
    }

    func testCustomDebugStringConvertible() {
        XCTAssertNotEqual(Bit.zero.debugDescription, "")
        XCTAssertNotEqual(Bit.zero.debugDescription, Bit.one.debugDescription)
    }

    func testLosslessStringConvertible() {
        XCTAssertEqual(Bit(Bit.zero.description), Bit.zero)
        XCTAssertEqual(Bit(Bit.one.description), Bit.one)
    }
}
