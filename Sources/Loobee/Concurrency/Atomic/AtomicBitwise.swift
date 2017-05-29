// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

public protocol AtomicBitwise {
    associatedtype IntegralType

    /// Atomically performs bitwise AND between the integral value and the value in the atomic object
    /// and return the value held previously.
    ///
    /// - Parameters:
    ///     - operand: Value of bitwise AND.
    ///     - order:   Memory order constraints to enforce.
    ///
    /// - Returns: The value of the atomic object before the call this method.
    mutating func fetchAndAnd(_ operand: IntegralType, order: AtomicOrder) -> IntegralType

    /// Atomically performs bitwise OR between the integral value and the value in the atomic object
    /// and return the value held previously.
    ///
    /// - Parameters:
    ///     - operand: Value of bitwise OR.
    ///     - order:   Memory order constraints to enforce.
    ///
    /// - Returns: The value of the atomic object before the call this method.
    mutating func fetchAndOr(_ operand: IntegralType, order: AtomicOrder) -> IntegralType

    /// Atomically performs bitwise XOR between the integral value and the value in the atomic object
    /// and return the value held previously.
    ///
    /// - Parameters:
    ///     - operand: Value of bitwise XOR.
    ///     - order:   Memory order constraints to enforce.
    ///
    /// - Returns: The value of the atomic object before the call this method.
    mutating func fetchAndXor(_ operand: IntegralType, order: AtomicOrder) -> IntegralType

    /// Atomically performs bitwise AND between the integral value and the value in the atomic object
    /// and return the value held later.
    ///
    /// - Parameters:
    ///     - operand: Value of bitwise AND.
    ///     - order:   Memory order constraints to enforce.
    ///
    /// - Returns: The value of the atomic object after bitwise operation of this method.
    mutating func andAndFetch(_ operand: IntegralType, order: AtomicOrder) -> IntegralType

    /// Atomically performs bitwise OR between the integral value and the value in the atomic object
    /// and return the value held later.
    ///
    /// - Parameters:
    ///     - operand: Value of bitwise OR.
    ///     - order:   Memory order constraints to enforce.
    ///
    /// - Returns: The value of the atomic object after bitwise operation of this method.
    mutating func orAndFetch(_ operand: IntegralType, order: AtomicOrder) -> IntegralType

    /// Atomically performs bitwise XOR between the integral value and the value in the atomic object
    /// and return the value held later.
    ///
    /// - Parameters:
    ///     - operand: Value of bitwise XOR.
    ///     - order:   Memory order constraints to enforce.
    ///
    /// - Returns: The value of the atomic object after bitwise operation of this method.
    mutating func xorAndFetch(_ operand: IntegralType, order: AtomicOrder) -> IntegralType

    /// Alias for `andAndFetch`.
    static func &=(lhs: inout Self, rhs: IntegralType)

    /// Alias for `orAndFetch`.
    static func |=(lhs: inout Self, rhs: IntegralType)

    /// Alias for `xorAndFetch`.
    static func ^=(lhs: inout Self, rhs: IntegralType)
}
