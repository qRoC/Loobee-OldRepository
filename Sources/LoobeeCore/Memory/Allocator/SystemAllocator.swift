// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

#if os(OSX)
import func Darwin.C.stdlib.malloc
import func Darwin.C.stdlib.free
#elseif os(Linux)
import func Glibc.C.stdlib.malloc
import func Glibc.C.stdlib.free
#endif

/// Uses default `malloc` and `free`.
public struct SystemAllocator<T> {
    public func allocate(count: Count) -> UnsafeMutablePointer<T> {
        let pointer = malloc(MemoryLayout<T>.stride * count)
        if _slowPath(pointer == nil) {
            fatalError("SystemAllocator: Cannot allocate memory.")
        }

        return pointer!.bindMemory(to: T.self, capacity: count)
    }

    public func deallocate(_ pointer: UnsafeMutablePointer<T>) {
        free(pointer)
    }
}
