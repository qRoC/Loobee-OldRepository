// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

public protocol AtomicArithmetic {
    associatedtype IntegralType: Numeric

    /// Atomically add the integral value to the value in the atomic object and return the value held previously.
    ///
    /// - Parameters:
    ///     - operand: Value for arithmetic addition.
    ///     - order:   Memory order constraints to enforce.
    ///
    /// - Returns: The value of the atomic object before the call this method.
    mutating func fetchAndAdd(_ operand: IntegralType, order: AtomicOrder) -> IntegralType

    /// Atomically subtract the integral value from the value in the atomic
    /// object and return the value held previously.
    ///
    /// - Parameters:
    ///     - operand: Value for arithmetic subtraction.
    ///     - order:   Memory order constraints to enforce.
    ///
    /// - Returns: The value of the atomic object before the call this method.
    mutating func fetchAndSub(_ operand: IntegralType, order: AtomicOrder) -> IntegralType

    /// Atomically add the integral value to the value in the atomic object and return the value held later.
    ///
    /// - Parameters:
    ///     - operand: Value for arithmetic addition.
    ///     - order:   Memory order constraints to enforce.
    ///
    /// - Returns: The value of the atomic object after adds in this method.
    mutating func addAndFetch(_ operand: IntegralType, order: AtomicOrder) -> IntegralType

    /// Atomically subtract the integral value to the value in the atomic object and return the value held later.
    ///
    /// - Parameters:
    ///     - operand: Value for arithmetic subtraction.
    ///     - order:   Memory order constraints to enforce.
    ///
    /// - Returns: The value of the atomic object after subtracts in this method.
    mutating func subAndFetch(_ operand: IntegralType, order: AtomicOrder) -> IntegralType

    /// Alias for `addAndFetch`.
    static func +=(lhs: inout Self, rhs: IntegralType)

    /// Alias for `subAndFetch`.
    static func -=(lhs: inout Self, rhs: IntegralType)
}
