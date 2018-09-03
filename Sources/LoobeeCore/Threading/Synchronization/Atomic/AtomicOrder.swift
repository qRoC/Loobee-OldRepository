// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import CLoobeeCore

/// Specifies how regular, non-atomic memory accesses are to be ordered
/// around an atomic operation.
///
/// [Details](https://en.cppreference.com/w/cpp/atomic/memory_order)
///
/// - `relaxed`: No barriers or synchronization.
/// - `consume`: Data dependency only for both barrier and synchronization
///              with another thread.
/// - `acquire`: Barrier to hoisting of code and synchronizes with release
///              (or stronger) semantic stores from another thread.
/// - `release`: Barrier to sinking of code and synchronizes with acquire
///              (or stronger) semantic loads from another thread.
/// - `acqRel`:  Full barrier in both directions and synchronizes with acquire
///              loads and release stores in another thread.
/// - `seqCst`:  Full barrier in both directions and synchronizes with acquire
///              loads and release stores in all threads.
public typealias AtomicOrder = CLoobeeCoreAtomicOrder
