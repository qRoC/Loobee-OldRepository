import XCTest

import LoobeeCoreTests
import LoobeeHttpTests

var tests = [XCTestCaseEntry]()
tests += LoobeeCoreTests.__allTests()
tests += LoobeeHttpTests.__allTests()

XCTMain(tests)
