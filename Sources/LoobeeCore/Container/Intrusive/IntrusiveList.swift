// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

///
public protocol IntrusiveListNode: class {
    var nextNode : Self? { get set }
    var prevNode : Self? { get set }
}

/// Intrusive doubly-linked list.
public struct IntrusiveList<T>: Moveonly where T: IntrusiveListNode {
    public func _deinit() {

    }
}
