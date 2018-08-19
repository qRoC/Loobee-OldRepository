// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCore
import XCTest

class BitSetTests: XCTestCase {
    func testBitWidth() {
        XCTAssertEqual(BitSet<UInt8>.bitWidth, UInt8.bitWidth)
        XCTAssertEqual(BitSet<Int8>.bitWidth, Int8.bitWidth)

        XCTAssertEqual(BitSet<UInt16>.bitWidth, UInt16.bitWidth)
        XCTAssertEqual(BitSet<Int16>.bitWidth, Int16.bitWidth)

        XCTAssertEqual(BitSet<UInt32>.bitWidth, UInt32.bitWidth)
        XCTAssertEqual(BitSet<Int32>.bitWidth, Int32.bitWidth)

        XCTAssertEqual(BitSet<UInt64>.bitWidth, UInt64.bitWidth)
        XCTAssertEqual(BitSet<Int64>.bitWidth, Int64.bitWidth)
    }

    func testLeadingZeroBitCount() {
        let count0: BitSet<UInt8> = 0b1111_1111
        XCTAssertEqual(count0.leadingZeroBitCount, 0)

        let count3: BitSet<UInt8> = 0b0001_1111
        XCTAssertEqual(count3.leadingZeroBitCount, 3)

        let countAll: BitSet<UInt8> = 0b0000_0000
        XCTAssertEqual(countAll.leadingZeroBitCount, type(of: countAll).bitWidth)
    }

    func testTrailingZeroBitCount() {
        let count0: BitSet<UInt8> = 0b1111_1111
        XCTAssertEqual(count0.trailingZeroBitCount, 0)

        let count3: BitSet<UInt8> = 0b1111_1000
        XCTAssertEqual(count3.trailingZeroBitCount, 3)

        let countAll: BitSet<UInt8> = 0b0000_0000
        XCTAssertEqual(countAll.trailingZeroBitCount, type(of: countAll).bitWidth)
    }

    func testNonzeroBitCount() {
        let count0: BitSet<UInt8> = 0b0000_0000
        XCTAssertEqual(count0.nonzeroBitCount, 0)

        let count4: BitSet<UInt8> = 0b0101_1010
        XCTAssertEqual(count4.nonzeroBitCount, 4)

        let count6: BitSet<UInt8> = 0b1101_1011
        XCTAssertEqual(count6.nonzeroBitCount, 6)

        let countAll: BitSet<UInt8> = 0b1111_1111
        XCTAssertEqual(countAll.nonzeroBitCount, type(of: countAll).bitWidth)
    }

    func testInit() {
        let bitset: BitSet<UInt8> = .init()
        XCTAssertEqual(bitset.nonzeroBitCount, 0)
    }

    func testInitByValue() {
        let count0: BitSet<UInt8> = .init(0b0000_0000)
        XCTAssertEqual(count0.nonzeroBitCount, 0)

        let count4: BitSet<UInt8> = .init(0b0101_1010)
        XCTAssertEqual(count4.nonzeroBitCount, 4)

        let count6: BitSet<UInt8> = .init(0b1101_1011)
        XCTAssertEqual(count6.nonzeroBitCount, 6)

        let countAll: BitSet<UInt8> = .init(0b1111_1111)
        XCTAssertEqual(countAll.nonzeroBitCount, type(of: countAll).bitWidth)
    }

    func testInitTruncatingIfNeeded() {
        let count0: BitSet<UInt8> = .init(truncatingIfNeeded: 0b10101010_00000000)
        XCTAssertEqual(count0.nonzeroBitCount, 0)

        let count4: BitSet<UInt8> = .init(truncatingIfNeeded: 0b10101010_0101_1010)
        XCTAssertEqual(count4.nonzeroBitCount, 4)

        let count6: BitSet<UInt8> = .init(truncatingIfNeeded: 0b10101010_1101_1011)
        XCTAssertEqual(count6.nonzeroBitCount, 6)

        let countAll: BitSet<UInt8> = .init(truncatingIfNeeded: 0b10101010_1111_1111)
        XCTAssertEqual(countAll.nonzeroBitCount, type(of: countAll).bitWidth)
    }

    func testSubscriptWithBitReturnsGet() {
        let bitset: BitSet<UInt8> = 0b0101_0101

        XCTAssertEqual(bitset[0], .one)
        XCTAssertEqual(bitset[1], .zero)
        XCTAssertEqual(bitset[2], .one)
        XCTAssertEqual(bitset[3], .zero)

        XCTAssertEqual(bitset[4], .one)
        XCTAssertEqual(bitset[5], .zero)
        XCTAssertEqual(bitset[6], .one)
        XCTAssertEqual(bitset[7], .zero)
    }

    func testSubscriptWithBitReturnsSet() {
        var bitset: BitSet<UInt8> = 0b0101_0101

        bitset[0].toggle()
        bitset[1] = .one
        bitset[2] = .zero

        XCTAssertEqual(bitset[0], .zero)
        XCTAssertEqual(bitset[1], .one)
        XCTAssertEqual(bitset[2], .zero)
        XCTAssertEqual(bitset[3], .zero)

        XCTAssertEqual(bitset[4], .one)
        XCTAssertEqual(bitset[5], .zero)
        XCTAssertEqual(bitset[6], .one)
        XCTAssertEqual(bitset[7], .zero)
    }

    func testSubscriptWithBitReferenceReturns() {
        var bitset: BitSet<UInt8> = 0b0101_0101
        var reference: BitReference = bitset[0]
        reference.value.toggle()

        XCTAssertEqual(bitset[0], .zero)
        XCTAssertEqual(bitset[1], .zero)
        XCTAssertEqual(bitset[2], .one)
        XCTAssertEqual(bitset[3], .zero)

        XCTAssertEqual(bitset[4], .one)
        XCTAssertEqual(bitset[5], .zero)
        XCTAssertEqual(bitset[6], .one)
        XCTAssertEqual(bitset[7], .zero)
    }

    func testTest() {
        let bitset: BitSet<UInt8> = 0b0101_0101

        XCTAssertEqual(bitset.test(0), .one)
        XCTAssertEqual(bitset.test(1), .zero)
        XCTAssertEqual(bitset.test(2), .one)
        XCTAssertEqual(bitset.test(3), .zero)

        XCTAssertEqual(bitset.test(4), .one)
        XCTAssertEqual(bitset.test(5), .zero)
        XCTAssertEqual(bitset.test(6), .one)
        XCTAssertEqual(bitset.test(7), .zero)

        XCTAssertNil(bitset.test(8))
    }

    func testIsAllOnes() {
        XCTAssertTrue(BitSet(UInt8(0b1111_1111)).isAllOnes)
        XCTAssertFalse(BitSet(UInt8(0b1111_1110)).isAllOnes)
        XCTAssertFalse(BitSet(UInt8(0b0111_1111)).isAllOnes)
    }

    func testIsAllZeros() {
        XCTAssertTrue(BitSet(UInt8(0b0000_0000)).isAllZeros)
        XCTAssertFalse(BitSet(UInt8(0b0000_0001)).isAllZeros)
    }

    func testIsAnyOnes() {
        XCTAssertTrue(BitSet(UInt8(0b0000_0001)).isAnyOnes)
        XCTAssertTrue(BitSet(UInt8(0b1000_0000)).isAnyOnes)
        XCTAssertFalse(BitSet(UInt8(0b0000_0000)).isAnyOnes)
    }

    func testIntegerValue() {
        XCTAssertEqual(BitSet(UInt8(255)).integerValue, 255)
        XCTAssertEqual(BitSet(UInt8(0)).integerValue, 0)
        XCTAssertEqual(BitSet(UInt8(128)).integerValue, 128)
    }

    func testSet() {
        var bitset: BitSet<UInt8> = 0b0101_0101
        bitset.set()
        XCTAssertTrue(bitset.isAllOnes)
    }

    func testReset() {
        var bitset: BitSet<UInt8> = 0b0101_0101
        bitset.reset()
        XCTAssertTrue(bitset.isAllZeros)
    }

    func testBitwiseAndToLeft() {
        var bitset: BitSet<UInt8> = 0b0101_0101

        bitset &= 0b0000_1110

        XCTAssertEqual(bitset, 0b0000_0100)
    }

    func testBitwiseAnd() {
        let bitset: BitSet<UInt8> = 0b0101_0101

        XCTAssertEqual(bitset & 0b0000_1110, 0b0000_0100)
    }

    func testBitwiseOrToLeft() {
        var bitset: BitSet<UInt8> = 0b0101_0101

        bitset |= 0b0000_1110

        XCTAssertEqual(bitset, 0b0101_1111)
    }

    func testBitwiseOr() {
        let bitset: BitSet<UInt8> = 0b0101_0101

        XCTAssertEqual(bitset | 0b0000_1110, 0b0101_1111)
    }

    func testBitwiseXOrToLeft() {
        var bitset: BitSet<UInt8> = 0b0101_0101

        bitset ^= 0b0000_1110

        XCTAssertEqual(bitset, 0b0101_1011)
    }

    func testBitwiseXOr() {
        let bitset: BitSet<UInt8> = 0b0101_0101

        XCTAssertEqual(bitset ^ 0b0000_1110, 0b0101_1011)
    }

    func testInverse() {
        let bitset: BitSet<UInt8> = 0b0101_0101

        XCTAssertEqual(~bitset, 0b1010_1010)
    }

    func testShiftRightCurrent() {
        var bitset: BitSet<UInt8> = 0b0001_1110
        bitset &>>= 2
        XCTAssertEqual(bitset, 0b0000_0111)
    }

    func testShiftRight() {
        let bitset: BitSet<UInt8> = 0b0001_1110
        let result = bitset &>> 2
        XCTAssertEqual(result, 0b0000_0111)
        XCTAssertEqual(bitset, 0b0001_1110)
    }

    func testShiftLeftCurrent() {
        var bitset: BitSet<UInt8> = 0b0001_1110
        bitset &<<= 2
        XCTAssertEqual(bitset, 0b0111_1000)
    }

    func testShiftLeft() {
        let bitset: BitSet<UInt8> = 0b0001_1110
        let result = bitset &<< 2
        XCTAssertEqual(result, 0b0111_1000)
        XCTAssertEqual(bitset, 0b0001_1110)
    }
}
