// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

@testable import LoobeeCore
import XCTest

internal class BitReferenceTests: XCTestCase {
    func testUInt8InitByPointerAndBit() {
        for var i in UInt8.min...UInt8.max {
            for bit in UInt8.min..<UInt8.max {
                _ = BitReference(pointer: &i, bit: bit)
            }
        }
    }

    func testInt8InitByPointerAndBit() {
        for var i in Int8.min...Int8.max {
            for bit in UInt8.min..<UInt8.max {
                _ = BitReference(pointer: &i, bit: bit)
            }
        }
    }

    func testUInt16InitByPointerAndRangeBit() {
        var value: UInt16 = 0b0101_1010_0101_1010
        for bit in UInt16.min..<16 {
            XCTAssertNotNil(BitReference(pointer: &value, rangeBit: bit))
        }
        for bit in 16..<UInt16.max {
            XCTAssertNil(BitReference(pointer: &value, rangeBit: bit))
        }
    }

    func testInt16InitByPointerAndRangeBit() {
        var value: Int16 = 0b0101_1010_0101_1010
        for bit in 0..<16 {
            XCTAssertNotNil(BitReference(pointer: &value, rangeBit: UInt16(bit)))
        }
        for bit in 16..<Int16.max {
            XCTAssertNil(BitReference(pointer: &value, rangeBit: UInt16(bit)))
        }
    }

    func testUInt8Get0() {
        var value: UInt8 = 0
        for bit in UInt8.min..<UInt8.max {
            XCTAssertEqual(BitReference(pointer: &value, bit: bit).value, .zero)
        }
    }

    func testUInt8Get1() {
        var value: UInt8 = UInt8.max
        for bit in UInt8.min..<UInt8.max {
            XCTAssertEqual(BitReference(pointer: &value, bit: bit).value, .one)
        }
    }

    func testUInt8GetEven() {
        var value: UInt8 = 0b1010_1010
        let result: [Bit] = [.zero, .one, .zero, .one, .zero, .one, .zero, .one]
        for (index, mustValue) in result.enumerated() {
            XCTAssertEqual(BitReference(pointer: &value, bit: UInt8(index)).value, mustValue)
        }
    }

    func testUInt8GetOdd() {
        var value: UInt8 = 0b0101_0101
        let result: [Bit] = [.one, .zero, .one, .zero, .one, .zero, .one, .zero]
        for (index, mustValue) in result.enumerated() {
            XCTAssertEqual(BitReference(pointer: &value, bit: UInt8(index)).value, mustValue)
        }
    }

    func testUInt8Set() {
        var value: UInt8 = 0b0101_0101
        var result: [Bit] = [.one, .zero, .one, .zero, .one, .zero, .one, .zero]
        for changedIndex in 0..<8 {
            var reference = BitReference(pointer: &value, bit: UInt8(changedIndex))

            XCTAssertEqual(reference.value, result[changedIndex])

            result[changedIndex].toggle()

            reference.value = result[changedIndex]
            for (index, mustValue) in result.enumerated() {
                XCTAssertEqual(BitReference(pointer: &value, bit: UInt8(index)).value, mustValue)
            }
        }
    }

    func testInt8Set() {
        var value: Int8 = .init(bitPattern: 0b0101_0101)
        var result: [Bit] = [.one, .zero, .one, .zero, .one, .zero, .one, .zero]
        for changedIndex in 0..<8 {
            var reference = BitReference(pointer: &value, bit: UInt8(changedIndex))

            XCTAssertEqual(reference.value, result[changedIndex])

            result[changedIndex].toggle()

            reference.value = result[changedIndex]
            for (index, mustValue) in result.enumerated() {
                XCTAssertEqual(BitReference(pointer: &value, bit: UInt8(index)).value, mustValue)
            }
        }
    }

    func testValueToggle() {
        var value: UInt8 = 0b0101_0101
        var result: [Bit] = [.one, .zero, .one, .zero, .one, .zero, .one, .zero]
        for changedIndex in 0..<8 {
            var reference = BitReference(pointer: &value, bit: UInt8(changedIndex))

            XCTAssertEqual(reference.value, result[changedIndex])

            result[changedIndex].toggle()
            reference.value.toggle()

            for (index, mustValue) in result.enumerated() {
                XCTAssertEqual(BitReference(pointer: &value, bit: UInt8(index)).value, mustValue)
            }
        }
    }

    func testToggle() {
        var value: UInt8 = 0b0101_0101
        var result: [Bit] = [.one, .zero, .one, .zero, .one, .zero, .one, .zero]
        for changedIndex in 0..<8 {
            var reference = BitReference(pointer: &value, bit: UInt8(changedIndex))

            XCTAssertEqual(reference.value, result[changedIndex])

            result[changedIndex].toggle()
            reference.toggle()

            for (index, mustValue) in result.enumerated() {
                XCTAssertEqual(BitReference(pointer: &value, bit: UInt8(index)).value, mustValue)
            }
        }
    }

    func testSwapT() {
        var value1: UInt8 = 0b0000_0000
        var value2: UInt8 = 0b1111_1111

        var value1Bit = BitReference(pointer: &value1, bit: 3)
        var value2Bit = BitReference(pointer: &value2, bit: 4)

        swap(&value1Bit, &value2Bit)

        XCTAssertEqual(value1Bit.value, .one)
        XCTAssertEqual(value2Bit.value, .zero)

        XCTAssertEqual(value1, 0b0000_1000)
        XCTAssertEqual(value2, 0b1110_1111)
    }

    func testSwapTU() {
        var value1: UInt8 = 0b0000_0000
        var value2: Int16 = .init(bitPattern: 0b1111_1111_1111_1111)

        var value1Bit = BitReference(pointer: &value1, bit: 5)
        var value2Bit = BitReference(pointer: &value2, bit: 10)

        swap(&value1Bit, &value2Bit)

        XCTAssertEqual(value1Bit.value, .one)
        XCTAssertEqual(value2Bit.value, .zero)

        XCTAssertEqual(value1, 0b0010_0000)
        XCTAssertEqual(value2, .init(bitPattern: 0b1111_1011_1111_1111))
    }

    func testSwapBitT() {
        var value: UInt8 = 0b0000_0000

        var valueBit = BitReference(pointer: &value, bit: 5)
        var bit: Bit = .one

        swap(&valueBit, &bit)
        XCTAssertEqual(valueBit.value, .one)
        XCTAssertEqual(bit, .zero)
        XCTAssertEqual(value, 0b0010_0000)

        swap(&bit, &valueBit)
        XCTAssertEqual(valueBit.value, .zero)
        XCTAssertEqual(bit, .one)
        XCTAssertEqual(value, 0b0000_0000)
    }
}
