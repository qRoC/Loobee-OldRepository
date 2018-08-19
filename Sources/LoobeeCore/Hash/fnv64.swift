// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Fowler/Noll/Vo hash
/// - Link http://www.isthe.com/chongo/tech/comp/fnv/
@inlinable
public func fnv64(_ buffer: String, hash: UInt64 = 14_695_981_039_346_656_037) -> UInt64 {
    var hash = hash

    for byte: UInt8 in buffer.utf8 {
        let toAdd1 = (hash << 1) &+ (hash << 4) &+ (hash << 5)
        let toAdd2 = (hash << 7) &+ (hash << 8) &+ (hash << 40)
        hash = hash &+ toAdd1 &+ toAdd2
        hash = hash ^ UInt64(byte)
    }

    return hash
}

@inlinable
public func fnv64(_ buffer: [Byte], hash: UInt64 = 14_695_981_039_346_656_037) -> UInt64 {
    var hash = hash

    for byte in buffer {
        let toAdd1 = (hash << 1) &+ (hash << 4) &+ (hash << 5)
        let toAdd2 = (hash << 7) &+ (hash << 8) &+ (hash << 40)
        hash = hash &+ toAdd1 &+ toAdd2
        hash = hash ^ UInt64(byte.integerValue)
    }

    return hash
}

@inlinable
public func fnv64(_ buffer: UnsafeRawBufferPointer, hash: UInt64 = 14_695_981_039_346_656_037) -> UInt64 {
    var hash = hash

    for byte in buffer.bindMemory(to: Byte.self) {
        let toAdd1 = (hash << 1) &+ (hash << 4) &+ (hash << 5)
        let toAdd2 = (hash << 7) &+ (hash << 8) &+ (hash << 40)
        hash = hash &+ toAdd1 &+ toAdd2
        hash = hash ^ UInt64(byte.integerValue)
    }

    return hash
}
