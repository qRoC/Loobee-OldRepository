// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

public protocol MemoryArena {
    /// Arena debug name.
    var debugName: StaticString { get }

    /// Implementation Flag: Arena saves information about the size of the allocated area.
    var sizeStored: Bool { get }

    /// Implementation Flag: Arena does not purge the allocated areas with the `release` method.
    var noRelease: Bool { get }

    /// Size of the total allocated bytes of this arena.
    var bytesAllocated: Int { get }

    /// Allocates a memory area size `size` bytes aligned on a boundary specified by `alignment`.
    func allocate(_ size: Int, alignment: Int) -> UnsafeMutableRawPointer?

    /// Release memory area. Argument `size` is ignored when `sizeStored = true`.
    func release(_ pointer: UnsafeRawPointer, size: Int)
}
