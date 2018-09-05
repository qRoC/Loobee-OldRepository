// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Protocol for mark of moveonly structs.
///
public protocol Moveonly {
    /// Called when the object is destroyed.
    func _deinit()
}

/// Box for use Moveonly structs.
///
///    struct Test: Moveonly {
///        func _deinit() {
///            print("_deinit")
///        }
///
///        func hello() {
///            print("Hello")
///        }
///    }
///    let test = MoveonlyBox(init: Test())
///    // let value = test.value // Possible, but not allowed.
///    test.value.hello()
///
public final class MoveonlyBox<T> where T: Moveonly {
    public var value: T!

    @inline(__always)
    public init(init value: T) {
        self.value = value
    }

    @inline(__always)
    public init(move box: MoveonlyBox<T>) {
        self.value = box.value
        box.value = nil
    }

    deinit {
        self.value?._deinit()
    }
}
