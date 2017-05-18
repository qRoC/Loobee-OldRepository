import Foundation
import PackageDescription

let mainTarget = "Loobee"
let cTargets = try! FileManager.default.contentsOfDirectory(atPath: "./Sources").filter { $0.hasPrefix("LoobeeC") }
let testTargets = try! FileManager.default.contentsOfDirectory(atPath: "./Tests").filter { $0.hasSuffix("Tests") }

let package = Package(name: mainTarget)

for targetName in cTargets {
    package.targets.append(Target(name: targetName))
}

let cTargetsAsDependencies: [Target.Dependency] = cTargets.map { .Target(name: $0) }

package.targets.append(Target(name: mainTarget, dependencies: cTargetsAsDependencies))

let testDependencies = cTargetsAsDependencies + [.Target(name: mainTarget)]
for targetName in testTargets {
    package.targets.append(Target(name: targetName, dependencies: testDependencies))
}
