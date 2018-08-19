// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

///
public enum ExecutorPriority {
    case low // -127
    case medium // 0
    case high  // 127
    case custom(value: Int8)
}

/// An Executor accepts units of work with add(), which should be threadsafe.
public protocol Executor: class {
    var numPriorities: UInt8 { get }

    /// Enqueue a function to executed by this executor. This and all
    /// variants must be threadsafe.
    func add(_: () -> Void)

    /// Enqueue a function with a given priority, where 0 is the medium priority
    /// This is up to the implementation to enforce
    func add(_: () -> Void, withPriority: ExecutorPriority)
}

extension Executor {
    internal var numPriorities: UInt8 {
        return 1
    }
}

extension Executor {

}
