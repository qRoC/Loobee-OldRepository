// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

@testable import LoobeeCore
import XCTest

internal class Fnva64Tests: XCTestCase {
    func testEmptyString() {
        XCTAssertEqual(fnva64(""), 0xcbf29ce484222325)
    }

    func testHello() {
        XCTAssertEqual(fnva64("Hello, world!"), 0x38d1334144987bf4)
    }

    func testBigString() {
        let string = "aDd12*!$&sdjlhf ASF, !=2141oirgh2lufFY!*@fhq2fwafj asfasfas fsafhqwhfqwj"
        XCTAssertEqual(fnva64(string), 0x52174823484fbcbc)
    }

    func testEmptyByteBuffer() {
        XCTAssertEqual(fnva64([]), fnva64(""))
    }

    func testSampleByteBuffer() {
        XCTAssertEqual(fnva64([0x61, 0x62, 0x7a]), fnva64("abz"))
    }

    func testByteBuffer() {
        XCTAssertEqual(fnva64([0xff, 0xff, 0xff]), 0xf998341Be47bae14)
    }

    func testEmptyDataPointer() {
        var data: UInt64 = 0
        XCTAssertEqual(fnva64(UnsafeRawBufferPointer(start: &data, count: 0)), fnva64(""))
    }

    func testSampleDataPointer() {
        var data: UInt32 = 0x7a6261
        XCTAssertEqual(fnva64(UnsafeRawBufferPointer(start: &data, count: 3)), fnva64("abz"))
    }

    func testDataPointer() {
        var data: UInt32 = 0xffffff
        XCTAssertEqual(fnva64(UnsafeRawBufferPointer(start: &data, count: 3)), 0xf998341Be47bae14)
    }
}
