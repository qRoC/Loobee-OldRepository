// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// An instant in time.
public protocol Time: Comparable, CustomStringConvertible {
    associatedtype Duration: TimeDuration

    /// Returns a `Duration` with the difference between `self` and `other`.
    func difference(other: Self) -> Duration

    /// Returns a new `Self` instance with `duration` added to this.
    static func +(lhs: Self, duration: Duration) -> Self

    /// Returns a new `Self` instance with `duration` subtracted from this.
    static func -(lhs: Self, duration: Duration) -> Self
}
