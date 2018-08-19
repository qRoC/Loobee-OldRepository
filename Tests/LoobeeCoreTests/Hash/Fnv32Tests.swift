// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

@testable import LoobeeCore
import XCTest

internal class Fnv32Tests: XCTestCase {
    func testEmptyString() {
        XCTAssertEqual(fnv32(""), 0x811c9dc5)
    }

    func testHello() {
        XCTAssertEqual(fnv32("Hello, world!"), 0xe84ead66)
    }

    func testBigString() {
        let string = "aDd12*!$&sdjlhf ASF, !=2141oirgh2lufFY!*@fhq2fwafj asfasfas fsafhqwhfqwj"
        XCTAssertEqual(fnv32(string), 0xdae8000a)
    }

    func testEmptyByteBuffer() {
        XCTAssertEqual(fnv32([]), fnv32(""))
    }

    func testSampleByteBuffer() {
        XCTAssertEqual(fnv32([0x61, 0x62, 0x7a]), fnv32("abz"))
    }

    func testByteBuffer() {
        XCTAssertEqual(fnv32([0xff, 0xff, 0xff]), 0xb18eda72)
    }

    func testEmptyDataPointer() {
        var data: UInt64 = 0
        XCTAssertEqual(fnv32(UnsafeRawBufferPointer(start: &data, count: 0)), fnv32(""))
    }

    func testSampleDataPointer() {
        var data: UInt32 = 0x7a6261
        XCTAssertEqual(fnv32(UnsafeRawBufferPointer(start: &data, count: 3)), fnv32("abz"))
    }

    func testDataPointer() {
        var data: UInt32 = 0xffffff
        XCTAssertEqual(fnv32(UnsafeRawBufferPointer(start: &data, count: 3)), 0xb18eda72)
    }
}
