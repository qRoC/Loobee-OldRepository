// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

#pragma once

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <assert.h>

#define SWIFT_ENUM(args...) enum { args }

/// enum CLoobeeCoreAtomic
typedef SWIFT_ENUM(
        c_loobee_core_atomic_order_relaxed __attribute((swift_name("relaxed"))) = __ATOMIC_RELAXED,
        c_loobee_core_atomic_order_consume __attribute((swift_name("consume"))) = __ATOMIC_CONSUME,
        c_loobee_core_atomic_order_acquire __attribute((swift_name("acquire"))) = __ATOMIC_ACQUIRE,
        c_loobee_core_atomic_order_release __attribute((swift_name("release"))) = __ATOMIC_RELEASE,
        c_loobee_core_atomic_order_acq_rel __attribute((swift_name("acqRel")))  = __ATOMIC_ACQ_REL,
        c_loobee_core_atomic_order_seq_cst __attribute((swift_name("seqCst")))  = __ATOMIC_SEQ_CST
) c_loobee_core_atomic_order_t __attribute((swift_newtype(enum))) __attribute((swift_name("CLoobeeCoreAtomicOrder")));

/// let CLoobeeCoreAtomic#TYPE#_isLockFree
#define LOOBEE_ATOMIC_IS_LOCK_FREE(id, cType, swiftType) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_isLockFree"))) /*
*/   static const bool c_loobee_core_atomic_##id##_is_lock_free = __atomic_always_lock_free(sizeof(cType), 0);

/// func CLoobeeCoreAtomic#TYPE#_store
#define LOOBEE_ATOMIC_STORE(id, cType, swiftType) /*
*/   static __inline__ __attribute__((__always_inline__)) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_store(_:desired:order:)"))) /*
*/   void c_loobee_core_atomic_##id##_store( /*
*/                                    volatile cType *_Nonnull self, /*
*/                                    cType desired, /*
*/                                    c_loobee_core_atomic_order_t order /*
*/                                    ) { /*
*/       assert(order == c_loobee_core_atomic_order_relaxed || /*
*/              order == c_loobee_core_atomic_order_seq_cst || /*
*/              order == c_loobee_core_atomic_order_release); /*
*/       __atomic_store_n(self, desired, order); /*
*/   }

/// func CLoobeeCoreAtomic#TYPE#_load
#define LOOBEE_ATOMIC_LOAD(id, cType, swiftType, qualifier) /*
*/   static __inline__ __attribute__((__always_inline__)) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_load(_:order:)"))) /*
*/   qualifier cType c_loobee_core_atomic_##id##_load( /*
*/                                    const volatile cType *_Nonnull self, /*
*/                                    c_loobee_core_atomic_order_t order /*
*/                                    ) { /*
*/       assert(order == c_loobee_core_atomic_order_relaxed || /*
*/              order == c_loobee_core_atomic_order_seq_cst || /*
*/              order == c_loobee_core_atomic_order_acquire || /*
*/              order == c_loobee_core_atomic_order_consume); /*
*/       return __atomic_load_n(self, order); /*
*/   }

/// func CLoobeeCoreAtomic#TYPE#_exchange
#define LOOBEE_ATOMIC_EXCHANGE(id, cType, swiftType, qualifier) /*
*/   static __inline__ __attribute__((__always_inline__)) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_exchange(_:desired:order:)"))) /*
*/   qualifier cType c_loobee_core_atomic_##id##_exchange( /*
*/                                     volatile cType *_Nonnull self, /*
*/                                     cType desired, /*
*/                                     c_loobee_core_atomic_order_t order /*
*/                                     ) { /*
*/       assert(order == c_loobee_core_atomic_order_relaxed || /*
*/              order == c_loobee_core_atomic_order_seq_cst || /*
*/              order == c_loobee_core_atomic_order_acquire || /*
*/              order == c_loobee_core_atomic_order_release || /*
*/              order == c_loobee_core_atomic_order_acq_rel); /*
*/       return __atomic_exchange_n(self, desired, order); /*
*/   }

/// func CLoobeeCoreAtomic#TYPE#_compareExchangeWeak
/// func CLoobeeCoreAtomic#TYPE#_compareExchangeStrong
#define LOOBEE_ATOMIC_COMPARE_EXCHANGE(id, cType, swiftType, qualifier) /*
*/   static __inline__ __attribute__((__always_inline__)) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_compareExchangeWeak(_:expected:desired:successOrder:failureOrder:)"))) /*
*/   bool c_loobee_core_atomic_##id##_compare_exchange_weak( /*
*/                                     volatile cType *_Nonnull self, /*
*/                                     qualifier cType *_Nonnull expected, /*
*/                                     cType desired, /*
*/                                     c_loobee_core_atomic_order_t successOrder, /*
*/                                     c_loobee_core_atomic_order_t failureOrder /*
*/                                     ) { /*
*/       assert(failureOrder == c_loobee_core_atomic_order_relaxed || /*
*/              failureOrder == c_loobee_core_atomic_order_consume || /*
*/              failureOrder == c_loobee_core_atomic_order_acquire || /*
*/              failureOrder == c_loobee_core_atomic_order_seq_cst || /*
*/              failureOrder <= successOrder); /*
*/       return __atomic_compare_exchange_n(self, expected, desired, true, successOrder, failureOrder); /*
*/   } /*
*/   static __inline__ __attribute__((__always_inline__)) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_compareExchangeStrong(_:expected:desired:successOrder:failureOrder:)"))) /*
*/   bool c_loobee_core_atomic_##id##_compare_exchange_strong( /*
*/                                     volatile cType *_Nonnull self, /*
*/                                     qualifier cType *_Nonnull expected, /*
*/                                     cType desired, /*
*/                                     c_loobee_core_atomic_order_t successOrder, /*
*/                                     c_loobee_core_atomic_order_t failureOrder /*
*/                                     ) { /*
*/       assert(failureOrder == c_loobee_core_atomic_order_relaxed || /*
*/              failureOrder == c_loobee_core_atomic_order_consume || /*
*/              failureOrder == c_loobee_core_atomic_order_acquire || /*
*/              failureOrder == c_loobee_core_atomic_order_seq_cst); /*
*/       return __atomic_compare_exchange_n(self, expected, desired, false, successOrder, failureOrder); /*
*/   }

/// func CLoobeeCoreAtomic#TYPE#_fetchAndAdd
/// func CLoobeeCoreAtomic#TYPE#_fetchAndSub
/// func CLoobeeCoreAtomic#TYPE#_addAndFetch
/// func CLoobeeCoreAtomic#TYPE#_subAndFetch
#define LOOBEE_ATOMIC_MATH(id, cType, cTypeOp, swiftType, qualifier) /*
*/   static __inline__ __attribute__((__always_inline__)) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_fetchAndAdd(_:op:order:)"))) /*
*/   qualifier cType c_loobee_core_atomic_##id##_fetch_and_add( /*
*/                                    volatile cType *_Nonnull self, /*
*/                                    cTypeOp op, /*
*/                                    c_loobee_core_atomic_order_t order /*
*/                                    ) { /*
*/       return __atomic_fetch_add(self, op, order); /*
*/   } /*
*/   static __inline__ __attribute__((__always_inline__)) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_fetchAndSub(_:op:order:)"))) /*
*/   qualifier cType c_loobee_core_atomic_##id##_fetch_and_sub( /*
*/                                    volatile cType *_Nonnull self, /*
*/                                    cTypeOp op, /*
*/                                    c_loobee_core_atomic_order_t order /*
*/                                    ) { /*
*/       return __atomic_fetch_sub(self, op, order); /*
*/   } /*
*/   static __inline__ __attribute__((__always_inline__)) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_addAndFetch(_:op:order:)"))) /*
*/   qualifier cType c_loobee_core_atomic_##id##_add_and_fetch( /*
*/                                    volatile cType *_Nonnull self, /*
*/                                    cTypeOp op, /*
*/                                    c_loobee_core_atomic_order_t order /*
*/                                    ) { /*
*/       return __atomic_add_fetch(self, op, order); /*
*/   } /*
*/   static __inline__ __attribute__((__always_inline__)) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_subAndFetch(_:op:order:)"))) /*
*/   qualifier cType c_loobee_core_atomic_##id##_sub_and_fetch( /*
*/                                    volatile cType *_Nonnull self, /*
*/                                    cTypeOp op, /*
*/                                    c_loobee_core_atomic_order_t order /*
*/                                    ) { /*
*/       return __atomic_sub_fetch(self, op, order); /*
*/   }

/// func CLoobeeCoreAtomic#TYPE#_fetchAndBitAnd
/// func CLoobeeCoreAtomic#TYPE#_fetchAndBitOr
/// func CLoobeeCoreAtomic#TYPE#_fetchAndBitXor
/// func CLoobeeCoreAtomic#TYPE#_bitAndAndFetch
/// func CLoobeeCoreAtomic#TYPE#_bitOrAndFetch
/// func CLoobeeCoreAtomic#TYPE#_bitXorAndFetch
#define LOOBEE_ATOMIC_BIT(id, cType, swiftType) /*
*/   static __inline__ __attribute__((__always_inline__)) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_fetchAndBitAnd(_:op:order:)"))) /*
*/   cType c_loobee_core_atomic_##id##_fetch_and_and( /*
*/                                    volatile cType *_Nonnull self, /*
*/                                    cType op, /*
*/                                    c_loobee_core_atomic_order_t order /*
*/                                    ) { /*
*/       return __atomic_fetch_and(self, op, order); /*
*/   } /*
*/   static __inline__ __attribute__((__always_inline__)) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_fetchAndBitOr(_:op:order:)"))) /*
*/   cType c_loobee_core_atomic_##id##_fetch_and_or( /*
*/                                    volatile cType *_Nonnull self, /*
*/                                    cType op, /*
*/                                    c_loobee_core_atomic_order_t order /*
*/                                    ) { /*
*/       return __atomic_fetch_or(self, op, order); /*
*/   } /*
*/   static __inline__ __attribute__((__always_inline__)) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_fetchAndBitXor(_:op:order:)"))) /*
*/   cType c_loobee_core_atomic_##id##_fetch_and_xor( /*
*/                                    volatile cType *_Nonnull self, /*
*/                                    cType op, /*
*/                                    c_loobee_core_atomic_order_t order /*
*/                                    ) { /*
*/       return __atomic_fetch_xor(self, op, order); /*
*/   } /*
*/   static __inline__ __attribute__((__always_inline__)) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_bitAndAndFetch(_:op:order:)"))) /*
*/   cType c_loobee_core_atomic_##id##_and_and_fetch( /*
*/                                    volatile cType *_Nonnull self, /*
*/                                    cType op, /*
*/                                    c_loobee_core_atomic_order_t order /*
*/                                    ) { /*
*/       return __atomic_and_fetch(self, op, order); /*
*/   } /*
*/   static __inline__ __attribute__((__always_inline__)) /*
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_bitOrAndFetch(_:op:order:)"))) /*
*/   cType c_loobee_core_atomic_##id##_or_and_fetch( /*
*/                                    volatile cType *_Nonnull self, /*
*/                                    cType op, /*
*/                                    c_loobee_core_atomic_order_t order /*
*/                                    ) { /*
*/       return __atomic_or_fetch(self, op, order); /*
*/   } /*
*/   static __inline__ __attribute__((__always_inline__)) /*s
*/   __attribute((swift_name("CLoobeeCoreAtomic"#swiftType"_bitXorAndFetch(_:op:order:)"))) /*
*/   cType c_loobee_core_atomic_##id##_xor_and_fetch( /*
*/                                    volatile cType *_Nonnull self, /*
*/                                    cType op, /*
*/                                    c_loobee_core_atomic_order_t order /*
*/                                    ) { /*
*/       return __atomic_xor_fetch(self, op, order); /*
*/   }
// =====================================================================================================================
LOOBEE_ATOMIC_IS_LOCK_FREE(bool, bool, Bool)
LOOBEE_ATOMIC_STORE(bool, bool, Bool)
LOOBEE_ATOMIC_LOAD(bool, bool, Bool,)
LOOBEE_ATOMIC_EXCHANGE(bool, bool, Bool,)
LOOBEE_ATOMIC_COMPARE_EXCHANGE(bool, bool, Bool,)

#define LOOBEE_ATOMIC_SCALAR(id, cType, swiftType) /*
*/   LOOBEE_ATOMIC_IS_LOCK_FREE(id, cType, swiftType) /*
*/   LOOBEE_ATOMIC_STORE(id, cType, swiftType) /*
*/   LOOBEE_ATOMIC_LOAD(id, cType, swiftType,) /*
*/   LOOBEE_ATOMIC_EXCHANGE(id, cType, swiftType,) /*
*/   LOOBEE_ATOMIC_COMPARE_EXCHANGE(id, cType, swiftType,) /*
*/   LOOBEE_ATOMIC_MATH(id, cType, cType, swiftType,) /*
*/   LOOBEE_ATOMIC_BIT(id, cType, swiftType)

LOOBEE_ATOMIC_SCALAR(uint8, uint8_t, UInt8)
LOOBEE_ATOMIC_SCALAR(int8, int8_t, Int8)
LOOBEE_ATOMIC_SCALAR(uint16, uint16_t, UInt16)
LOOBEE_ATOMIC_SCALAR(int16, int16_t, Int16)
LOOBEE_ATOMIC_SCALAR(uint32, uint32_t, UInt32)
LOOBEE_ATOMIC_SCALAR(int32, int32_t, Int32)
LOOBEE_ATOMIC_SCALAR(uint64, uint64_t, UInt64)
LOOBEE_ATOMIC_SCALAR(int64, int64_t, Int64)
LOOBEE_ATOMIC_SCALAR(uint, unsigned long int, UInt)
LOOBEE_ATOMIC_SCALAR(int, long int, Int)


#undef LOOBEE_ATOMIC_IS_LOCK_FREE
#undef LOOBEE_ATOMIC_STORE
#undef LOOBEE_ATOMIC_LOAD
#undef LOOBEE_ATOMIC_EXCHANGE
#undef LOOBEE_ATOMIC_COMPARE_EXCHANGE
#undef LOOBEE_ATOMIC_MATH
#undef LOOBEE_ATOMIC_BIT
#undef LOOBEE_ATOMIC_SCALAR
