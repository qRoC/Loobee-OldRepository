// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

///
public protocol IntrusiveSListNode: class {
    var next : Self? { get set }
}

/// Intrusive singly-linked list.
public struct IntrusiveSList<T>: Moveonly where T: IntrusiveSListNode {
    ///
    public enum Mode {
        case circular
        case linear
    }

    internal let mode: Mode

    public init(mode: Mode) {
        self.mode = mode
    }

    public func _deinit() {

    }
}
