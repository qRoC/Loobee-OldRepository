// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

fileprivate final class IndirectWrapper<T> {
    var value: T

    init(_ value: T) {
        self.value = value
    }
}

// Враппер вокруг объекта для реализации механизма copy on write.
public struct IndirectBox<T> {
    fileprivate var wrapper: IndirectWrapper<T>

    init(_ value: T) {
        wrapper = IndirectWrapper(value)
    }

    var value: T {
        get {
            return wrapper.value
        }

        set {
            if !isKnownUniquelyReferenced(&wrapper) {
                wrapper = IndirectWrapper(newValue)
                return
            }

            wrapper.value = newValue
        }
    }
}
