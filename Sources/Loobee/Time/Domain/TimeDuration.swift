// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// A span of time.
///
/// A `TimeDuration` represents a difference from one point in time to another.
/// The duration may be "negative" if the difference is from a later time to an earlier.
public protocol TimeDuration: Comparable, CustomStringConvertible {
    /// Maximum possible span of time.
    static var max: Self { get }

    /// Minimum possible span of time.
    static var min: Self { get }

    /// Create `TimeDuration` from double value.
    init(fromDouble: Double)

    /// Convert to double value.
    func toDouble() -> Double

    /// Returns a new instance with the difference between `self` and `other`.
    func difference(other: Self) -> Self

    ///
    func isNegative() -> Bool

    ///
    func isPositive() -> Bool

    ///
    func absolute() -> Self

    ///
    static prefix func -(duration: Self) -> Self

    ///
    static func +(lhs: Self, rhs: Self) -> Self

    ///
    static func -(lhs: Self, rhs: Self) -> Self

    ///
    static func *(lhs: Self, factor: Int) -> Self

    ///
    static func /(lhs: Self, divisor: Int) -> Self
}

extension TimeDuration {
    public func isPositive() -> Bool {
        return !isNegative()
    }
}
