// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

public struct AllocatorStats {
    var allocatesCount: Int
    var totalAllocatedSize: Int
    var reservedSize: Int
    var largestRelease: Int
}

public protocol Allocator {
    /// Имя аллокатора для отладки.
    var debugName: StaticString { get }

    /// Статистика аллокатора.
    var stats: AllocatorStats { get }

    /// Выделяет область памяти размером `size`, выравнивая её по `alignment`.
    func allocate(_ size: Int, alignment: Int) -> UnsafeMutableRawPointer?

    /// Очищает область памяти.
    func release(_ pointer: UnsafeRawPointer)

    /// Получить информацию о размере аллокации.
    func getAllocationSize(_ pointer: UnsafeRawPointer) -> Int

    /// Заполнить `length` байт блока памяти на который указывает указатель `destPtr` значением `data`.
    func fill(destPointer: UnsafeMutableRawPointer, data: Int32, length: Int)

    /// Заполнить `length` байт блока памяти на который указывает указатель `destPtr` значением блока на который
    /// указывает `srcPtr`.
    func fill(destPointer: UnsafeMutableRawPointer, srcPointer: UnsafeRawPointer, length: Int)
}
