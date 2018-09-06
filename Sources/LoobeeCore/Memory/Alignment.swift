// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Represents data alignment in memory.
public enum Alignment: Equatable {
    /// Default alignment for system.
    case system

    /// Custom alignment.
    ///
    /// - Precondition: `size` must be greater than 4 on x32 and greater than 8 on x64.
    /// - Precondition: `size` must be power of two.
    case custom(size: Size)

    public var size: Size {
        switch self {
        case .system:
            return MemoryLayout<Size>.size * 2
        case .custom(let size):
            let minSize = MemoryLayout.size(ofValue: size)
            assert(size >= minSize, "Bad alignment: must be greater than \(minSize).")
            assert((size & (size - 1)) == 0, "Bad alignment: must be power of two.")

            return size
        }
    }

    public static func == (lhs: Alignment, rhs: Alignment) -> Bool {
        return lhs.size == rhs.size
    }
}
