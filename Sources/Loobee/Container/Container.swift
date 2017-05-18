// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

public protocol Container {
    func has<Service>(implementationFor interface: Service.Type) -> Bool

    func get<Service>(implementationFor interface: Service.Type) -> Service?
}
