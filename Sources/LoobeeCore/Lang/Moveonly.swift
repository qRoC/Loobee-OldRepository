// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Protocol for mark of movable types.
public protocol Moveonly {
}

/// Protocol for mark of movable points.
@inline(__always)
public func move<T>(_ obj: T) -> T where T: Moveonly {
    return obj
}
