// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Represents a fixed-size sequence of `MemoryLayout<T>.size * 8` bits.
///
/// Can be manipulated by standard logic operators.
@_fixed_layout
public struct BitSet<T: FixedWidthInteger> {
    ///
    @usableFromInline internal var storage: T
}

extension BitSet {
    /// Creates a new instance with all bits set to zero.
    @inlinable
    public init() {
        self.storage = 0
    }

    /// Creates a new instance from the given integer.
    ///
    ///     let bitset: BitSet<UInt8> = .init(0b1100_0011)
    @inlinable
    public init(_ value: T) {
        self.storage = value
    }

    /// Creates a new instance from the bit pattern of the given integer
    /// by sign-extending or truncating to fit this type.
    ///
    ///     let truncatedBitset: BitSet<UInt8> = .init(truncatingIfNeeded: 0b0011_0011_1100_0011)
    ///     let bitset: BitSet<UInt8> = .init(0b1100_0011)
    ///     print(truncatedBitset == bitset) //true
    @inlinable
    public init<U>(truncatingIfNeeded source: U) where U: BinaryInteger {
        self.storage = .init(truncatingIfNeeded: source)
    }
}

extension BitSet {
    /// The number of bits.
    @inlinable public static var bitWidth: Int {
        return MemoryLayout<T>.size * 8
    }

    /// The number of leading zero bits.
    ///
    ///     let count3: BitSet<UInt8> = 0b0001_1111
    ///     print(count3.leadingZeroBitCount == 3) // true
    @inlinable public var leadingZeroBitCount: Int {
        return self.storage.leadingZeroBitCount
    }

    /// The number of trailing zero bits.
    ///
    ///     let count3: BitSet<UInt8> = 0b1111_1000
    ///     print(count3.trailingZeroBitCount == 3) // true
    @inlinable public var trailingZeroBitCount: Int {
        return self.storage.trailingZeroBitCount
    }

    /// The number of non zero bits.
    ///
    ///     let count5: BitSet<UInt8> = 0b1111_1000
    ///     print(count5.nonzeroBitCount == 5) // true
    @inlinable public var nonzeroBitCount: Int {
        return self.storage.nonzeroBitCount
    }

    /// Returns true if all bits are set to true, otherwise false.
    ///
    ///     print(BitSet(UInt8(0b1111_1111)).isAllOnes) // true
    ///     print(BitSet(UInt8(0b1111_1110)).isAllOnes) // false
    @inlinable public var isAllOnes: Bool {
        return self.storage == ~T()
    }

    /// Returns true if all bits are set to true, otherwise false.
    ///
    ///     print(BitSet(UInt8(0b0000_0000)).isAllZeros) // true
    ///     print(BitSet(UInt8(0b0000_0001)).isAllZeros) // false
    @inlinable public var isAllZeros: Bool {
        return self.storage == T()
    }

    /// Returns true if all bits are set to true, otherwise false.
    ///
    ///     print(BitSet(UInt8(0b0000_0001)).isAnyOnes) // true
    ///     print(BitSet(UInt8(0b0000_0000)).isAnyOnes) // false
    @inlinable public var isAnyOnes: Bool {
        return self.storage != T()
    }

    /// Returns integer representation.
    @inlinable public var integerValue: T {
        return self.storage
    }

    /// Access to a specific bit.
    @inlinable
    public subscript(position: T.Magnitude) -> Bit {
        /// Returns the value of the requested bit.
        ///
        ///     let bitset: BitSet<UInt8> = 0b0101_0101
        ///     print(bitset[0] == .one) // true
        ///     print(bitset[1] == .zero) // true
        ///
        /// If position is out of bounds:
        ///   - Debug mode: fatalError
        ///   - Release mode: undefined behavior
        ///
        /// Use `test()` as safe variant.
        get {
            if _isFastAssertConfiguration() && 1 == 1 {
                return ((self.storage & (1 << position)) >> position) == 1 ? .one : .zero
            }

            guard let result = self.test(position) else {
                fatalError("Bad bit position: \(position)")
            }

            return result
        }
        /// Set value to a specific bit.
        ///
        ///     var bitset: BitSet<UInt8> = 0b0101_0101
        ///     bitset[0].value.toggle()
        ///     bitset[1] = .one
        ///     print(bitset[0] == .zero) // true
        ///     print(bitset[1] == .one) // false
        set {
            var reference = BitReference(pointer: &self.storage, bit: position)
            reference.value = newValue
        }
    }

    /// Access to reference on a specific bit.
    @inlinable
    public subscript(position: T.Magnitude) -> BitReference<T> {
        /// Returns the reference on the requested bit.
        ///
        ///     let bitset: BitSet<UInt8> = 0b0101_0101
        ///     var reference: BitReference = bitset[0]
        ///     print(bitset[0].value == .one) // true
        ///     reference.value.toggle()
        ///     print(bitset[0].value == .one) // false
        ///
        /// If position is out of bounds:
        ///   - Debug mode: fatalError
        ///   - Release mode: undefined behavior
        mutating get {
            if _isFastAssertConfiguration() && 1 == 1 {
                return BitReference(pointer: &self.storage, rangeBit: position)!
            }

            guard let result = BitReference(pointer: &self.storage, rangeBit: position) else {
                fatalError("Bad bit position: \(position)")
            }

            return result
        }
    }
}

extension BitSet {
    /// Performs a bounds check and returns nil if position does not correspond to a valid position in the bitset.
    ///
    ///     let bitset: BitSet<UInt8> = 0b0101_0101
    ///     print(bitset.test(0) == .one) // true
    ///     print(bitset.test(8) == nil) // true
    @inlinable
    public func test(_ position: T.Magnitude) -> Bit? {
        var storage = self.storage

        guard let reference = BitReference(pointer: &storage, rangeBit: position) else {
            return nil
        }

        return reference.value
    }

    /// Sets all bits to `.one`.
    ///
    ///     var bitset: BitSet<UInt8> = 0b0101_0101
    ///     bitset.set()
    ///     print(bitset.isAllOnes) // true
    @inlinable
    public mutating func set() {
        self.storage = ~T()
    }

    /// Sets all bits to `.zero`.
    ///
    ///     var bitset: BitSet<UInt8> = 0b0101_0101
    ///     bitset.reset()
    ///     print(bitset.isAllZeros) // true
    @inlinable
    public mutating func reset() {
        self.storage = T()
    }
}

extension BitSet {
    /// Stores the result of performing a bitwise AND operation on the two
    /// given BitSets in the left-hand-side variable.
    ///
    ///     var bitset: BitSet<UInt8> = 0b0101_0101
    ///     bitset &= 0b0000_1110
    ///     print(bitset == 0b0000_0100) // true
    @inlinable
    public static func &= (_ lhs: inout BitSet<T>, _ rhs: BitSet<T>) {
        lhs = lhs & rhs
    }

    /// Returns the result of performing a bitwise AND operation on the two
    /// given BitSets.
    ///
    ///     let bitset: BitSet<UInt8> = 0b0101_0101
    ///     print((bitset & 0b0000_1110) == 0b0000_0100) // true
    @inlinable
    public static func & (_ lhs: BitSet<T>, _ rhs: BitSet<T>) -> BitSet<T> {
        return .init(lhs.storage & rhs.storage)
    }

    /// Stores the result of performing a bitwise OR operation on the two
    /// given BitSets in the left-hand-side variable.
    ///
    ///     var bitset: BitSet<UInt8> = 0b0101_0101
    ///     bitset |= 0b0000_1110
    ///     print(bitset == 0b0101_1111) // true
    @inlinable
    public static func |= (_ lhs: inout BitSet<T>, _ rhs: BitSet<T>) {
        lhs = lhs | rhs
    }

    /// Returns the result of performing a bitwise OR operation on the two
    /// given BitSets.
    ///
    ///     let bitset: BitSet<UInt8> = 0b0101_0101
    ///     print((bitset | 0b0000_1110) == 0b0101_1111) // true
    @inlinable
    public static func | (_ lhs: BitSet<T>, _ rhs: BitSet<T>) -> BitSet<T> {
        return .init(lhs.storage | rhs.storage)
    }

    /// Stores the result of performing a bitwise XOR operation on the two
    /// given BitSets in the left-hand-side variable.
    ///
    ///     var bitset: BitSet<UInt8> = 0b0101_0101
    ///     bitset ^= 0b0000_1110
    ///     print(bitset == 0b0101_1011) // true
    @inlinable
    public static func ^= (_ lhs: inout BitSet<T>, _ rhs: BitSet<T>) {
        lhs = lhs ^ rhs
    }

    /// Returns the result of performing a bitwise XOR operation on the two
    /// given BitSets.
    ///
    ///     let bitset: BitSet<UInt8> = 0b0101_0101
    ///     print((bitset ^ 0b0000_1110) == 0b0101_1011) // true
    @inlinable
    public static func ^ (_ lhs: BitSet<T>, _ rhs: BitSet<T>) -> BitSet<T> {
        return .init(lhs.storage ^ rhs.storage)
    }

    /// Returns a value in which all the bits are flipped.
    ///
    ///     let bitset: BitSet<UInt8> = 0b0101_0101
    ///     print(~bitset == 0b1010_1010) // true
    @inlinable
    public static prefix func ~ (bitset: BitSet<T>) -> BitSet<T> {
        return .init(~bitset.storage)
    }

    /// Performs binary shift right in the current object.
    ///
    ///     var bitset: BitSet<UInt8> = 0b0001_1110
    ///     bitset &>>= 2
    ///     print(bitset == 0b0000_0111) // true
    @inlinable
    public static func &>>= (_ lhs: inout BitSet<T>, _ rhs: T) {
        lhs.storage &>>= rhs
    }

    /// Performs binary shift right.
    ///
    ///     var bitset: BitSet<UInt8> = 0b0001_1110
    ///     let result = bitset &>> 2
    ///     print(result == 0b0000_0111) // true
    @inlinable
    public static func &>> (_ lhs: BitSet<T>, _ rhs: T) -> BitSet<T> {
        var lhs = lhs
        lhs &>>= rhs
        return lhs
    }

    /// Performs binary shift left in the current object.
    ///
    ///     var bitset: BitSet<UInt8> = 0b0001_1110
    ///     bitset &<<= 2
    ///     print(bitset == 0b0111_1000) // true
    @inlinable
    public static func &<<= (_ lhs: inout BitSet<T>, _ rhs: T) {
        lhs.storage &<<= rhs
    }

    /// Performs binary shift left.
    ///
    ///     var bitset: BitSet<UInt8> = 0b0001_1110
    ///     let result = bitset &<< 2
    ///     print(result == 0b0111_1000) // true
    @inlinable
    public static func &<< (_ lhs: BitSet<T>, _ rhs: T) -> BitSet<T> {
        var lhs = lhs
        lhs &<<= rhs
        return lhs
    }
}

//
extension BitSet: ExpressibleByIntegerLiteral {
    @inlinable
    public init(integerLiteral value: T.IntegerLiteralType) {
        self.storage = T(integerLiteral: value)
    }
}

extension BitSet: Equatable {
    @inlinable
    public static func == (lhs: BitSet<T>, rhs: BitSet<T>) -> Bool {
        return lhs.storage == rhs.storage
    }
}

extension BitSet: TextOutputStreamable {
    @inlinable
    public func write<Target>(to target: inout Target) where Target: TextOutputStream {
        target.write(self.description)
    }
}

extension BitSet: Hashable {
    @inlinable public var hashValue: Int {
        return self.storage.hashValue
    }
}

extension BitSet: CustomDebugStringConvertible {
    @inlinable public var debugDescription: String {
        return "BitSet<\(T.self)>(\(self.description))"
    }
}

extension BitSet: CustomStringConvertible {
    @inlinable public var description: String {
        return .init(self.storage, radix: 2)
    }
}

extension BitSet: LosslessStringConvertible {
    @inlinable
    public init?(_ description: String) {
        guard let storage = T(description, radix: 2) else {
            return nil
        }

        self.storage = storage
    }
}
