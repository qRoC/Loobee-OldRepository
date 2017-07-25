// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import XCTest
@testable import ByteTests
@testable import ConcurrencyTests

XCTMain([
    /// ByteTests
    testCase(ByteTests.allTests),

    /// ConcurrencyTests
    testCase(AtomicInt8Tests.allTests),
    testCase(AtomicInt16Tests.allTests),
    testCase(AtomicInt32Tests.allTests),
    testCase(AtomicInt64Tests.allTests),
    testCase(AtomicUInt8Tests.allTests),
    testCase(AtomicUInt16Tests.allTests),
    testCase(AtomicUInt32Tests.allTests),
    testCase(AtomicUInt64Tests.allTests),
    testCase(AtomicBoolTests.allTests),
    testCase(AtomicRawPointerTests.allTests)
])
