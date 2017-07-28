// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

#if os(OSX)
import struct Darwin.C.time.timespec
import typealias Darwin.C.time.time_t
#elseif os(Linux)
import struct SwiftGlibc.C.time.timespec
import typealias SwiftGlibc.C.time.time_t
#endif

public struct SteadyTimeDuration: TimeDuration {
    fileprivate static var isSignedSec = !(time_t(0) < time_t(-1))

    fileprivate static var minSec = time_t.min

    fileprivate static var maxSec = time_t.max

    fileprivate static var minNanoSec = 0

    fileprivate static var maxNanoSec = Int(1E9) - 1

    public static var max: SteadyTimeDuration {
        return SteadyTimeDuration(sec: maxSec, nsec: maxNanoSec)
    }

    public static var min: SteadyTimeDuration {
        return SteadyTimeDuration(sec: minSec, nsec: minNanoSec)
    }

    @_versioned var timeSpec: timespec

    ///
    public init(duration: SteadyTimeDuration) {
        self.init(sec: duration.timeSpec.tv_sec, nsec: duration.timeSpec.tv_nsec)
    }

    ///
    public init(sec: Int, msec: Int = 0, usec: Int = 0, nsec: Int = 0) {
        assert(sec >= SteadyTimeDuration.minSec)
        assert(sec <= SteadyTimeDuration.maxSec)
        assert(msec >= 0)
        assert(usec >= 0)
        assert(nsec >= 0)

        let nsecTotal = msec * Int(1E6) + usec * Int(1E3) + nsec

        assert(nsecTotal <= SteadyTimeDuration.maxNanoSec)

        self.timeSpec = timespec(tv_sec: sec, tv_nsec: nsecTotal)
    }

    ///
    public init(fromSafeDouble doubleSec: Double) {
        var sec = Int(doubleSec)
        let frac = 1E9 * (doubleSec + 0.5E-9 - Double(sec))
        var nsec = Int(frac)

        sec += Int(nsec / Int(1E9))
        nsec %= Int(1E9)

        if nsec < 0 {
            sec -= 1
            nsec += Int(1E9)
        }

        self.init(sec: sec, nsec: nsec)
    }

    ///
    public init(fromDouble doubleSec: Double) {
        if Double(SteadyTimeDuration.minSec) > doubleSec {
            self.init(duration: SteadyTimeDuration.min)
            return
        }

        if Double(SteadyTimeDuration.maxSec) < doubleSec {
            self.init(duration: SteadyTimeDuration.max)
            return
        }

        self.init(fromSafeDouble: doubleSec)
    }

    ///
    public func toDouble() -> Double {
        return Double(self.timeSpec.tv_sec) + Double(self.timeSpec.tv_nsec) / 1E9
    }

    ///
    public func difference(other: SteadyTimeDuration) -> SteadyTimeDuration {
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

    ///
    public func isNegative() -> Bool {
        return self.timeSpec.tv_sec < 0
    }

    ///
    public func absolute() -> SteadyTimeDuration {
        if self.isPositive() {
            return self
        }

        return SteadyTimeDuration(sec: self.timeSpec.tv_sec * -1, nsec: self.timeSpec.tv_nsec)
    }

    ///
    public static prefix func -(duration: SteadyTimeDuration) -> SteadyTimeDuration {
        if duration.timeSpec.tv_sec <= 0 {
            return duration
        }

        return SteadyTimeDuration(sec: duration.timeSpec.tv_sec * -1, nsec: duration.timeSpec.tv_nsec)
    }

    ///
    public static func addUnsafe(_ lhs: SteadyTimeDuration, _ rhs: SteadyTimeDuration) -> SteadyTimeDuration {
        var sec = lhs.timeSpec.tv_sec + rhs.timeSpec.tv_sec
        var nsec = lhs.timeSpec.tv_nsec + rhs.timeSpec.tv_nsec

        if nsec >= Int(1E9) {
            sec += 1
            nsec -= Int(1E9)
        }

        return SteadyTimeDuration(
                sec: sec,
                nsec: nsec
        )
    }

    ///
    public static func add(_ lhs: SteadyTimeDuration, _ rhs: SteadyTimeDuration) -> SteadyTimeDuration {
        var lSec = lhs.timeSpec.tv_sec
        var rSec = rhs.timeSpec.tv_sec

        let nsec = lhs.timeSpec.tv_nsec + rhs.timeSpec.tv_nsec

        let nsecd = nsec - Int(1E9)
        var rnsec = nsec

        repeat {
            if 0 <= nsecd {
                rnsec = nsecd

                if rSec < SteadyTimeDuration.maxSec {
                    rSec += 1
                } else if lSec < 0 {
                    lSec += 1
                } else {
                    break
                }
            }

            let (addResult, didOverflow) = Int.addWithOverflow(lSec, rSec)
            if didOverflow {
                if lSec < 0 {
                    lSec = SteadyTimeDuration.minSec
                    rnsec = 0
                } else {
                    break
                }
            } else {
                lSec = addResult
            }

            return SteadyTimeDuration(sec: lSec, nsec: rnsec)
        } while false

        /// overflow
        return SteadyTimeDuration(sec: SteadyTimeDuration.maxSec, nsec: SteadyTimeDuration.maxNanoSec)
    }

    ///
    public static func +(lhs: SteadyTimeDuration, rhs: SteadyTimeDuration) -> SteadyTimeDuration {
        return SteadyTimeDuration.add(lhs, rhs)
    }

    ///
    public static func subtractUnsafe(_ lhs: SteadyTimeDuration, _ rhs: SteadyTimeDuration) -> SteadyTimeDuration {
        var sec = lhs.timeSpec.tv_sec - rhs.timeSpec.tv_sec
        var nsec = lhs.timeSpec.tv_nsec - rhs.timeSpec.tv_nsec

        if nsec < 0 {
            sec -= 1
            nsec += Int(1E9)
        }

        return SteadyTimeDuration(
                sec: sec,
                nsec: nsec
        )
    }

    ///
    public static func subtract(_ lhs: SteadyTimeDuration, _ rhs: SteadyTimeDuration) -> SteadyTimeDuration {
        var lSec = lhs.timeSpec.tv_sec
        var rSec = rhs.timeSpec.tv_sec

        let nsec = lhs.timeSpec.tv_nsec - rhs.timeSpec.tv_nsec

        var rnsec = nsec

        repeat {
            if nsec < 0 {
                rnsec = nsec + Int(1E9)

                if rSec < SteadyTimeDuration.maxSec {
                    rSec += 1
                } else if -(isSignedSec ? 1 : 0) < lSec {
                    lSec -= 1
                } else {
                    break
                }
            }

            let (subtractResult, didOverflow) = Int.subtractWithOverflow(lSec, rSec)
            if didOverflow {
                if lSec >= 0 {
                    lSec = SteadyTimeDuration.maxSec
                    rnsec = SteadyTimeDuration.maxNanoSec
                } else {
                    break
                }
            } else {
                lSec = subtractResult
            }

            return SteadyTimeDuration(sec: lSec, nsec: rnsec)
        } while false

        /// overflow
        return SteadyTimeDuration(sec: SteadyTimeDuration.minSec, nsec: SteadyTimeDuration.minNanoSec)
    }

    ///
    public static func -(lhs: SteadyTimeDuration, rhs: SteadyTimeDuration) -> SteadyTimeDuration {
        return SteadyTimeDuration.subtract(lhs, rhs)
    }

    ///
    public static func multiplyUnsafe(_ lhs: SteadyTimeDuration, factor: Int) -> SteadyTimeDuration {
        var sec = lhs.timeSpec.tv_sec * factor
        var nsec = lhs.timeSpec.tv_nsec * abs(factor)

        if nsec >= Int(1E9) {
            sec += 1
            nsec -= Int(1E9)
        }

        return SteadyTimeDuration(
                sec: sec,
                nsec: nsec
        )
    }

    ///
    public static func *(lhs: SteadyTimeDuration, factor: Int) -> SteadyTimeDuration {
        return SteadyTimeDuration.multiplyUnsafe(lhs, factor: factor)
    }

    ///
    public static func divideUnsafe(_ lhs: SteadyTimeDuration, divisor: Int) -> SteadyTimeDuration {
        // wait Swift 4 for DoubleWidth
        // overflow
        let ns: IntMax = (IntMax(lhs.timeSpec.tv_sec) * IntMax(1E9) + IntMax(lhs.timeSpec.tv_nsec)) / IntMax(divisor)

        return SteadyTimeDuration(
                sec: Int(ns / IntMax(1E9)),
                nsec: Int(ns % IntMax(1E9))
        )
    }

    ///
    public static func /(lhs: SteadyTimeDuration, divisor: Int) -> SteadyTimeDuration {
        return SteadyTimeDuration.divideUnsafe(lhs, divisor: divisor)
    }

    ///
    public static func <(lhs: SteadyTimeDuration, rhs: SteadyTimeDuration) -> Bool {
        if lhs.timeSpec.tv_sec < rhs.timeSpec.tv_sec {
            return true
        }

        if lhs.timeSpec.tv_sec > rhs.timeSpec.tv_sec {
            return false
        }

        return lhs.timeSpec.tv_nsec < rhs.timeSpec.tv_nsec
    }

    ///
    public static func <=(lhs: SteadyTimeDuration, rhs: SteadyTimeDuration) -> Bool {
        return !(lhs > rhs)
    }

    ///
    public static func >=(lhs: SteadyTimeDuration, rhs: SteadyTimeDuration) -> Bool {
        return !(lhs < rhs)
    }

    ///
    public static func >(lhs: SteadyTimeDuration, rhs: SteadyTimeDuration) -> Bool {
        if lhs.timeSpec.tv_sec > rhs.timeSpec.tv_sec {
            return true
        }

        if lhs.timeSpec.tv_sec < rhs.timeSpec.tv_sec {
            return false
        }

        return lhs.timeSpec.tv_nsec > rhs.timeSpec.tv_nsec
    }

    ///
    public static func ==(lhs: SteadyTimeDuration, rhs: SteadyTimeDuration) -> Bool {
        if lhs.timeSpec.tv_sec != rhs.timeSpec.tv_sec {
            return false
        }

        if !lhs.isNegative() {
            return lhs.timeSpec.tv_nsec == rhs.timeSpec.tv_nsec
        }

        return rhs.timeSpec.tv_nsec >= lhs.timeSpec.tv_nsec - 1 && rhs.timeSpec.tv_nsec <= lhs.timeSpec.tv_nsec + 1
    }

    ///
    public var description: String {
        return String(self.timeSpec.tv_sec) + "." + String(self.timeSpec.tv_nsec)
    }
}
