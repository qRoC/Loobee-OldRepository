// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

public protocol Time: Comparable, CustomStringConvertible {
    associatedtype Duration

    ///
    func difference(other: Self) -> Duration

    ///
    static func +(lhs: Self, duration: Duration) -> Self

    ///
    static func -(lhs: Self, duration: Duration) -> Self
}
