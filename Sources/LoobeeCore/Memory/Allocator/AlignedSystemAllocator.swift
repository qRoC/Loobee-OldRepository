// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

#if os(OSX)
import func Darwin.C.stdlib.posix_memalign
import func Darwin.C.stdlib.free
#elseif os(Linux)
import func Glibc.posix_memalign
import func Glibc.free
#endif

/// Uses `posix_memalign` and `free`.
public struct AlignedSystemAllocator<T> {
    public func allocate(count: Count, alignment: Alignment) -> UnsafeMutablePointer<T> {
        var pointer: UnsafeMutableRawPointer?
        let resultCode = posix_memalign(&pointer, alignment.size, MemoryLayout<T>.stride * count)
        if _slowPath(resultCode != 0) {
            fatalError("AlignedSystemAllocator: Cannot allocate memory. Code: \(resultCode)")
        }

        return pointer!.bindMemory(to: T.self, capacity: count)
    }

    public func deallocate(_ pointer: UnsafeMutablePointer<T>) {
        free(pointer)
    }
}
