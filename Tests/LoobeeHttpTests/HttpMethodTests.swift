// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

@testable import LoobeeHttp
import XCTest

internal class HttpMethodTests: XCTestCase {
    func testCreateFromValidString() {
        XCTAssertEqual(HttpMethod("GET"), HttpMethod.get)
        XCTAssertEqual(HttpMethod("POST"), HttpMethod.post)
        XCTAssertEqual(HttpMethod("OPTIONS"), HttpMethod.options)
        XCTAssertEqual(HttpMethod("DELETE"), HttpMethod.delete)
        XCTAssertEqual(HttpMethod("HEAD"), HttpMethod.head)
        XCTAssertEqual(HttpMethod("CONNECT"), HttpMethod.connect)
        XCTAssertEqual(HttpMethod("PUT"), HttpMethod.put)
        XCTAssertEqual(HttpMethod("TRACE"), HttpMethod.trace)
        XCTAssertEqual(HttpMethod("PATCH"), HttpMethod.patch)
    }

    func testInsensitive() {
        XCTAssertEqual(HttpMethod("get"), HttpMethod.get)
        XCTAssertEqual(HttpMethod("PoSt"), HttpMethod.post)
        XCTAssertEqual(HttpMethod("oPTIONS"), HttpMethod.options)
        XCTAssertEqual(HttpMethod("DELETe"), HttpMethod.delete)
        XCTAssertEqual(HttpMethod("head"), HttpMethod.head)
        XCTAssertEqual(HttpMethod("COnnECT"), HttpMethod.connect)
        XCTAssertEqual(HttpMethod("put"), HttpMethod.put)
        XCTAssertEqual(HttpMethod("trace"), HttpMethod.trace)
        XCTAssertEqual(HttpMethod("PaTcH"), HttpMethod.patch)
    }

    func testCreateFromNotValidString() {
        XCTAssertNil(HttpMethod("GETT"))
        XCTAssertNil(HttpMethod("PPOST"))
        XCTAssertNil(HttpMethod("OPGTIONS"))
        XCTAssertNil(HttpMethod("DALETE"))
        XCTAssertNil(HttpMethod("HEAT"))
    }

    func testTextOutputStream() {
        var result = ""

        HttpMethod.get.write(to: &result)
        HttpMethod.post.write(to: &result)

        XCTAssertEqual(result, "GETPOST")
    }
}
