// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

#if os(OSX)
import func Darwin.C.stdlib.malloc
import func Darwin.C.stdlib.posix_memalign
import func Darwin.C.stdlib.free
import func Darwin.C.string.memset
import func Darwin.C.string.memcpy
import func Darwin.malloc.malloc_size
#elseif os(Linux)
import func SwiftGlibc.C.stdlib.malloc
import func SwiftGlibc.C.stdlib.posix_memalign
import func SwiftGlibc.C.stdlib.free
import func SwiftGlibc.C.string.memset
import func SwiftGlibc.C.string.memcpy
import func LoobeeCLinux.malloc.malloc_usable_size
#endif

final class StandardMallocAllocator: Allocator {
    let debugName: StaticString = "StandardMallocAllocator"

    fileprivate(set) var stats: AllocatorStats

    init() {
        self.stats = AllocatorStats(allocatesCount: 0, totalAllocatedSize: 0, reservedSize: 0, largestRelease: 0)
    }

    func allocate(_ size: Int, alignment: Int) -> UnsafeMutableRawPointer? {
        var pointer: UnsafeMutableRawPointer?

        if alignment == 16 {
            pointer = malloc(size)
        } else {
            if posix_memalign(&pointer, alignment, size) != 0 {
                pointer = nil
            }
        }

        if pointer != nil {
            self.stats.allocatesCount += 1
            self.stats.totalAllocatedSize += getAllocationSize(pointer!)
        }

        return pointer
    }

    func release(_ pointer: UnsafeRawPointer) {
        let size = getAllocationSize(pointer)

        self.stats.allocatesCount -= 1
        self.stats.totalAllocatedSize -= size

        if size > self.stats.largestRelease {
            self.stats.largestRelease = size
        }

        free(UnsafeMutableRawPointer(mutating: pointer))
    }

    func getAllocationSize(_ pointer: UnsafeRawPointer) -> Int {
#if os(OSX)
        return malloc_size(pointer)
#elseif os(Linux)
        return malloc_usable_size(UnsafeMutableRawPointer(mutating: pointer))
#endif
    }

    func fill(destPointer: UnsafeMutableRawPointer, data: Int32, length: Int) {
        memset(destPointer, data, length)
    }

    func fill(destPointer: UnsafeMutableRawPointer, srcPointer: UnsafeRawPointer, length: Int) {
        memcpy(destPointer, srcPointer, length)
    }
}
