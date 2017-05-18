// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

#if os(OSX)
import struct Darwin.C.time.timespec
#elseif os(Linux)
import struct SwiftGlibc.C.time.timespec
#endif

public struct SteadyTimeDuration {
    internal var timeSpec: timespec

    public init(sec: Int) {
        self.timeSpec = timespec(tv_sec: sec, tv_nsec: 0)
    }

    public init(sec: Int, usec: Int = 0, nsec: Int = 0) {
        self.timeSpec = timespec(tv_sec: sec, tv_nsec: nsec + usec * 1_000)
    }

    public func toDouble() -> Double {
        return Double(self.timeSpec.tv_nsec) * 1.0E-9 + Double(self.timeSpec.tv_sec)
    }

    public func diff(other: SteadyTimeDuration) -> SteadyTimeDuration {
        if other.timeSpec.tv_nsec < self.timeSpec.tv_nsec {
            return SteadyTimeDuration(
                    sec: other.timeSpec.tv_sec - 1 - self.timeSpec.tv_sec,
                    nsec: Int(1E9) + other.timeSpec.tv_nsec - self.timeSpec.tv_nsec
            )
        }

        return SteadyTimeDuration(
                sec: other.timeSpec.tv_sec - self.timeSpec.tv_sec,
                nsec: other.timeSpec.tv_nsec - self.timeSpec.tv_nsec
        )
    }
}
