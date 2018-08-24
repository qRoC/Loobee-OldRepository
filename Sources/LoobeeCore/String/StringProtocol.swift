// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

extension StringProtocol {
    /// Compares ASCII strings, while ignoring differences in case.
    public func caseInsensitiveASCIICompare(_ other: Self) -> Bool {
        if self.count != other.count {
            return false
        }

        return self.withCString { lhs in
            other.withCString { rhs in
                var lhs = lhs
                var rhs = rhs
                while lhs.pointee != 0 {
                    defer {
                        lhs = lhs.successor()
                        rhs = rhs.successor()
                    }

                    if lhs.pointee == rhs.pointee {
                        continue
                    }

                    if (lhs.pointee ^ rhs.pointee) != 0b100000 {
                        return false
                    }

                    let charCode = lhs.pointee | rhs.pointee

                    if charCode < 97 || charCode > 122 {
                        return false
                    }
                }

                return true
            }
        }
    }
}
