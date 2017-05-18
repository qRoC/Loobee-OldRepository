// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

public protocol MemoryArena {
    /// Имя арены для отладки.
    var debugName: StaticString { get }

    /// Арена сохраняет информацию о размере выделенной области.
    var sizeStored: Bool { get }

    /// Арена не очищает выделенные ею области с помощью метода `release`.
    var noRelease: Bool { get }

    /// Размер общей выделенной области данной арены.
    var bytesAllocated: Int { get }

    /// Выделяет область памяти размером `size`, выравнивая её по `alignment`.
    func allocate(_ size: Int, alignment: Int) -> UnsafeMutableRawPointer?

    /// Очищает область памяти.
    ///
    /// Аргумент `size` игнорируется при `sizeStored=true`.
    func release(_ pointer: UnsafeRawPointer, size: Int)
}
