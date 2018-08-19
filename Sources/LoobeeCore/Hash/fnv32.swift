// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Fowler/Noll/Vo hash
/// - Link http://www.isthe.com/chongo/tech/comp/fnv/
@inlinable
public func fnv32(_ buffer: String, hash: UInt32 = 2_166_136_261) -> UInt32 {
    var hash = hash

    for byte: UInt8 in buffer.utf8 {
        let toAdd = (hash << 1) &+ (hash << 4) &+ (hash << 7) &+ (hash << 8) &+ (hash << 24)
        hash = hash &+ toAdd
        hash = hash ^ UInt32(byte)
    }

    return hash
}

@inlinable
public func fnv32(_ buffer: [Byte], hash: UInt32 = 2_166_136_261) -> UInt32 {
    var hash = hash

    for byte in buffer {
        let toAdd = (hash << 1) &+ (hash << 4) &+ (hash << 7) &+ (hash << 8) &+ (hash << 24)
        hash = hash &+ toAdd
        hash = hash ^ UInt32(byte.integerValue)
    }

    return hash
}

@inlinable
public func fnv32(_ buffer: UnsafeRawBufferPointer, hash: UInt32 = 2_166_136_261) -> UInt32 {
    var hash = hash

    for byte in buffer.bindMemory(to: Byte.self) {
        let toAdd = (hash << 1) &+ (hash << 4) &+ (hash << 7) &+ (hash << 8) &+ (hash << 24)
        hash = hash &+ toAdd
        hash = hash ^ UInt32(byte.integerValue)
    }

    return hash
}
