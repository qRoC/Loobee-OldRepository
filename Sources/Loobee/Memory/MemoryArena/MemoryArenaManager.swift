// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

public class MemoryArenaManager {
    let memoryArena: MemoryArena

    init(memoryArena: MemoryArena) {
        self.memoryArena = memoryArena
    }

    /// Выделяет область памяти размером `size`, выравнивая её по `alignment`.
    func allocate(_ size: Int, alignment: Int, saveSizeInfo: Bool) -> UnsafeMutableRawPointer? {
        precondition(alignment >= 4)
        precondition(alignment <= 128)
        precondition(alignment & ~(alignment - 1) == alignment)

        if self.memoryArena.noRelease || self.memoryArena.sizeStored || !saveSizeInfo {
            return self.memoryArena.allocate(size, alignment: alignment)
        }

        var alignmentSize = alignment + (~(alignment - 1) & (alignment + size - 1))

        guard let pointer = self.memoryArena.allocate(alignmentSize, alignment: alignment) else {
            return nil
        }

        if alignment != 4 {
            alignmentSize |= 1
            pointer.advanced(by: alignment - 8).storeBytes(of: alignment, as: Int.self)
        }

        pointer.advanced(by: alignment - 4).storeBytes(of: alignmentSize, as: Int.self)

        return pointer.advanced(by: alignment)
    }

    /// Очищает область памяти.
    /// Аргумент `size` игнорируется при `MemoryArena.sizeStored=true`,
    /// или если метод `allocate` был вызван  с `saveSizeInfo=true`.
    func release(_ pointer: UnsafeRawPointer, size: Int) {
        if self.memoryArena.noRelease {
            return
        }

        if self.memoryArena.sizeStored {
            self.memoryArena.release(pointer, size: 0)
            return
        }

        let basePointer: UnsafeRawPointer

        let alignmentSize = pointer.advanced(by: -4).load(as: Int.self)

        if alignmentSize & 1 == 1 {
            let alignment = pointer.advanced(by: -8).load(as: Int.self)
            basePointer = pointer.advanced(by: -alignment)
        } else {
            basePointer = pointer.advanced(by: -4)
        }

        self.memoryArena.release(basePointer, size: alignmentSize)
    }
}
