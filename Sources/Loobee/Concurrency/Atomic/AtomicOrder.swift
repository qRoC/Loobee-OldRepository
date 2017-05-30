// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCAtomic

/// Specifies how regular, non-atomic memory accesses are to be ordered around an atomic operation.
///
/// See [Wiki](http://en.cppreference.com/w/cpp/atomic/memory_order) for info.
///
/// - relaxed
/// - consume
/// - acquire
/// - release
/// - acqRel
/// - seqCst
public typealias AtomicOrder = LoobeeCAtomicOrder
