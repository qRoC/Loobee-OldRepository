import XCTest

extension HttpMethodTests {
    static let __allTests = [
        ("testCreateFromNotValidString", testCreateFromNotValidString),
        ("testCreateFromValidString", testCreateFromValidString),
        ("testInsensitive", testInsensitive),
        ("testTextOutputStream", testTextOutputStream),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(HttpMethodTests.__allTests),
    ]
}
#endif
