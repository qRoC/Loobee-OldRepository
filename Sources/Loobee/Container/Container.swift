// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Protocol of a container that exposes methods to read its entries.
public protocol Container {
    /// Returns true if the container contains an entry that implements the specified protocol.
    func has<EntryProtocol>(implementationFor protocol: EntryProtocol.Type) -> Bool

    /// Returns entry that implements the specified protocol.
    func get<EntryProtocol>(implementationFor protocol: EntryProtocol.Type) -> EntryProtocol?
}
