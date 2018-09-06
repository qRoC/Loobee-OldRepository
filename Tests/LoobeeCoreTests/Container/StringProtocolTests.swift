// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

@testable import LoobeeCore
import XCTest

internal class StringProtocolTests: XCTestCase {
    func testCaseInsensitiveASCIICompareString() {
        /// test case insensitive.
        XCTAssertTrue("Test".caseInsensitiveASCIICompare("tEST"))
        XCTAssertTrue("T1$41hfqFHQWG15h(1".caseInsensitiveASCIICompare("t1$41HFQfhqwg15H(1"))

        /// Test on full scan.
        XCTAssertFalse("xx".caseInsensitiveASCIICompare("xxX"))
        XCTAssertFalse("XX".caseInsensitiveASCIICompare("xxX"))
        XCTAssertFalse("xxX".caseInsensitiveASCIICompare("xx"))
        XCTAssertFalse("xxX".caseInsensitiveASCIICompare("XX"))

        /// Test on infinity loop.
        XCTAssertTrue("a1".caseInsensitiveASCIICompare("a1"))
    }
}
