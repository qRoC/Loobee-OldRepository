// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

@testable import LoobeeCore
import XCTest

internal class Fnv64Tests: XCTestCase {
    func testEmptyString() {
        XCTAssertEqual(fnv64(""), 0xcbf29ce484222325)
    }

    func testHello() {
        XCTAssertEqual(fnv64("Hello, world!"), 0x6519bd6389aaa166)
    }

    func testBigString() {
        let string = "aDd12*!$&sdjlhf ASF, !=2141oirgh2lufFY!*@fhq2fwafj asfasfas fsafhqwhfqwj"
        XCTAssertEqual(fnv64(string), 0xa424395a5f88020a)
    }

    func testEmptyByteBuffer() {
        XCTAssertEqual(fnv64([]), fnv64(""))
    }

    func testSampleByteBuffer() {
        XCTAssertEqual(fnv64([0x61, 0x62, 0x7a]), fnv64("abz"))
    }

    func testByteBuffer() {
        XCTAssertEqual(fnv64([0xff, 0xff, 0xff]), 0xd6c4371869e81fd2)
    }

    func testEmptyDataPointer() {
        var data: UInt64 = 0
        XCTAssertEqual(fnv64(UnsafeRawBufferPointer(start: &data, count: 0)), fnv64(""))
    }

    func testSampleDataPointer() {
        var data: UInt32 = 0x7a6261
        XCTAssertEqual(fnv64(UnsafeRawBufferPointer(start: &data, count: 3)), fnv64("abz"))
    }

    func testDataPointer() {
        var data: UInt32 = 0xffffff
        XCTAssertEqual(fnv64(UnsafeRawBufferPointer(start: &data, count: 3)), 0xd6c4371869e81fd2)
    }
}
