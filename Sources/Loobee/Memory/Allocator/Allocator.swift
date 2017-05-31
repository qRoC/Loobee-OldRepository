// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

public struct AllocatorStats {
    public var allocatesCount: Int
    public var totalAllocatedSize: Int
    public var reservedSize: Int
    public var largestRelease: Int
}

public protocol Allocator {
    /// Allocator debug name.
    var debugName: StaticString { get }

    /// Allocator stats.
    var stats: AllocatorStats { get }

    /// Allocates a memory area size `size` bytes aligned on a boundary specified by `alignment`.
    func allocate(_ size: Int, alignment: Int) -> UnsafeMutableRawPointer?

    /// Release memory area.
    func release(_ pointer: UnsafeRawPointer)

    /// Returns information about size of memory arena.
    func getAllocationSize(_ pointer: UnsafeRawPointer) -> Int

    /// Fills `length` bytes of the memory area pointed by `destPtr` by value `data`.
    func fill(destPointer: UnsafeMutableRawPointer, data: Int32, length: Int)

    /// Fills `length` bytes of the memory area pointed by `destPtr` by value from `srcPtr`.
    func fill(destPointer: UnsafeMutableRawPointer, srcPointer: UnsafeRawPointer, length: Int)
}
