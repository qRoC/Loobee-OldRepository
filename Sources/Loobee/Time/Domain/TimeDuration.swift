// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

public protocol TimeDuration: Comparable, CustomStringConvertible {
    ///
    init(fromDouble: Double)

    ///
    func toDouble() -> Double

    ///
    func difference(other: Self) -> Self

    ///
    func abs() -> Self

    ///
    static func +(lhs: Self, rhs: Self) -> Self

    ///
    static func -(lhs: Self, rhs: Self) -> Self

    ///
    static func *(lhs: Self, factor: Int) -> Self

    ///
    static func /(lhs: Self, quotient: Int) -> Self

    ///
    static prefix func -(duration: Self) -> Self
}
