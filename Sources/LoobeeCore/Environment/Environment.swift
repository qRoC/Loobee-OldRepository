// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Provides information about the current environment.
public class Environment {
    ///
    public static let current = Environment()

    private init() {
    }

    /// Returns discover details of the processor.
    public let cpuId = CpuId.current()
}
