// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

#if os(OSX)
import struct Darwin.C.time.timespec
import func Darwin.C.time.clock_gettime
import var Darwin.C.time._CLOCK_UPTIME_RAW
#elseif os(Linux)
import struct SwiftGlibc.C.time.timespec
import func SwiftGlibc.C.time.clock_gettime
import var SwiftGlibc.C.time.CLOCK_MONOTONIC
#endif

public struct SteadyTime {
    /// Продолжительность от начальной эпохи UNIX
    fileprivate let durationFromUnixEpoch: SteadyTimeDuration

    public init(durationFromUnixEpoch: SteadyTimeDuration) {
        self.durationFromUnixEpoch = durationFromUnixEpoch
    }

    /// От текущей временной метки.
    public static func now() -> SteadyTime? {
        var durationFromUnixEpoch = SteadyTimeDuration(sec: 0)

#if os(OSX)
        if 0 != clock_gettime(_CLOCK_UPTIME_RAW, &durationFromUnixEpoch.timeSpec) {
            return nil
        }
#elseif os(Linux)
        if 0 != clock_gettime(CLOCK_MONOTONIC, &durationFromUnixEpoch.timeSpec) {
            return nil
        }
#else
        return nil
#endif

        return SteadyTime(durationFromUnixEpoch: durationFromUnixEpoch)
    }

    public func toDouble() -> Double {
        return self.durationFromUnixEpoch.toDouble()
    }

    public func diff(other: SteadyTime) -> SteadyTimeDuration {
        return durationFromUnixEpoch.diff(other: other.durationFromUnixEpoch)
    }

    public static func +(steadyTime: SteadyTime, duration: SteadyTimeDuration) -> SteadyTime {
        return SteadyTime(durationFromUnixEpoch: steadyTime.durationFromUnixEpoch + duration)
    }

    public static func -(steadyTime: SteadyTime, duration: SteadyTimeDuration) -> SteadyTime {
        return SteadyTime(durationFromUnixEpoch: steadyTime.durationFromUnixEpoch - duration)
    }
}

extension SteadyTime: Equatable {
    public static func ==(lhs: SteadyTime, rhs: SteadyTime) -> Bool {
        return lhs.durationFromUnixEpoch == rhs.durationFromUnixEpoch
    }

    public static func <(lhs: SteadyTime, rhs: SteadyTime) -> Bool {
        return lhs.durationFromUnixEpoch < rhs.durationFromUnixEpoch
    }

    public static func >(lhs: SteadyTime, rhs: SteadyTime) -> Bool {
        return lhs.durationFromUnixEpoch > rhs.durationFromUnixEpoch
    }

    public static func <=(lhs: SteadyTime, rhs: SteadyTime) -> Bool {
        return lhs.durationFromUnixEpoch <= rhs.durationFromUnixEpoch
    }

    public static func >=(lhs: SteadyTime, rhs: SteadyTime) -> Bool {
        return lhs.durationFromUnixEpoch >= rhs.durationFromUnixEpoch
    }
}
