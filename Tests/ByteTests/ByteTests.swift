// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import XCTest
@testable import Loobee

class ByteTests: XCTestCase {
    static var allTests = [
        ("testSize", testSize)
    ]

    func testSize() {
        XCTAssertEqual(MemoryLayout<Byte>.size, 1)
    }
}
