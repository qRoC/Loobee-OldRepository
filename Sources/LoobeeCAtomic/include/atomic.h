// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

#include <stdbool.h>
#include <stdint.h>
#include <assert.h>

#define SWIFT_ENUM(args...) enum { args }

// =====================================================================================================================
typedef SWIFT_ENUM(
        loobee_atomic_order_relaxed __attribute((swift_name("relaxed"))) = __ATOMIC_RELAXED,
        loobee_atomic_order_consume __attribute((swift_name("consume"))) = __ATOMIC_CONSUME,
        loobee_atomic_order_acquire __attribute((swift_name("acquire"))) = __ATOMIC_ACQUIRE,
        loobee_atomic_order_release __attribute((swift_name("release"))) = __ATOMIC_RELEASE,
        loobee_atomic_order_acq_rel __attribute((swift_name("acqRel")))  = __ATOMIC_ACQ_REL,
        loobee_atomic_order_seq_cst __attribute((swift_name("seqCst")))  = __ATOMIC_SEQ_CST
) loobee_atomic_order_t __attribute((swift_newtype(enum))) __attribute((swift_name("LoobeeCAtomicOrder")));

// =====================================================================================================================

#define LOOBEE_ATOMIC_IS_LOCK_FREE(id, cType, swiftType) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_isLockFree"))) \
    static const bool loobee_atomic_##id##_is_lock_free = __atomic_always_lock_free(sizeof(cType), 0);

#define LOOBEE_ATOMIC_STORE(id, cType, swiftType) \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_store(_:desired:order:)"))) \
    void loobee_atomic_##id##_store( \
                                               volatile cType *_Nonnull self, \
                                               cType desired, \
                                               loobee_atomic_order_t order \
                                               ) { \
        assert(order == loobee_atomic_order_relaxed || \
               order == loobee_atomic_order_seq_cst || \
               order == loobee_atomic_order_release); \
        __atomic_store_n(self, desired, order); \
    }

#define LOOBEE_ATOMIC_LOAD(id, cType, swiftType) \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_load(_:order:)"))) \
    cType loobee_atomic_##id##_load( \
                                                volatile cType *_Nonnull self, \
                                                loobee_atomic_order_t order \
                                                ) { \
        assert(order == loobee_atomic_order_relaxed || \
               order == loobee_atomic_order_seq_cst || \
               order == loobee_atomic_order_acquire || \
               order == loobee_atomic_order_consume); \
        return __atomic_load_n(self, order); \
    }

#define LOOBEE_ATOMIC_EXCHANGE(id, cType, swiftType) \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_exchange(_:desired:order:)"))) \
    cType loobee_atomic_##id##_exchange( \
                                                 volatile cType *_Nonnull self, \
                                                 cType desired, \
                                                 loobee_atomic_order_t order \
                                                 ) { \
        assert(order == loobee_atomic_order_relaxed || \
               order == loobee_atomic_order_seq_cst || \
               order == loobee_atomic_order_acquire || \
               order == loobee_atomic_order_release || \
               order == loobee_atomic_order_acq_rel); \
        return __atomic_exchange_n(self, desired, order); \
    }

#define LOOBEE_ATOMIC_COMPARE_EXCHANGE(id, cType, swiftType) \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_compareExchangeWeak(_:expected:desired:successOrder:failureOrder:)"))) \
    bool loobee_atomic_##id##_compare_exchange_weak( \
                                                 volatile cType *_Nonnull self, \
                                                 cType *_Nonnull expected, \
                                                 cType desired, \
                                                 loobee_atomic_order_t successOrder, \
                                                 loobee_atomic_order_t failureOrder \
                                                 ) { \
        assert(failureOrder == loobee_atomic_order_relaxed || \
               failureOrder == loobee_atomic_order_consume || \
               failureOrder == loobee_atomic_order_acquire || \
               failureOrder == loobee_atomic_order_seq_cst); \
        return __atomic_compare_exchange_n(self, expected, desired, true, successOrder, failureOrder); \
    } \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_compareExchangeStrong(_:expected:desired:successOrder:failureOrder:)"))) \
    bool loobee_atomic_##id##_compare_exchange_strong( \
                                                 volatile cType *_Nonnull self, \
                                                 cType *_Nonnull expected, \
                                                 cType desired, \
                                                 loobee_atomic_order_t successOrder, \
                                                 loobee_atomic_order_t failureOrder \
                                                 ) { \
        assert(failureOrder == loobee_atomic_order_relaxed || \
               failureOrder == loobee_atomic_order_consume || \
               failureOrder == loobee_atomic_order_acquire || \
               failureOrder == loobee_atomic_order_seq_cst); \
        return __atomic_compare_exchange_n(self, expected, desired, false, successOrder, failureOrder); \
    }

#define LOOBEE_ATOMIC_MATH(id, cType, swiftType) \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_fetchAndAdd(_:op:order:)"))) \
    cType loobee_atomic_##id##_fetch_and_add( \
                                                     volatile cType *_Nonnull self, \
                                                     cType op, \
                                                     loobee_atomic_order_t order \
                                                     ) { \
        return __atomic_fetch_add(self, op, order); \
    } \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_fetchAndSub(_:op:order:)"))) \
    cType loobee_atomic_##id##_fetch_and_sub( \
                                                     volatile cType *_Nonnull self, \
                                                     cType op, \
                                                     loobee_atomic_order_t order \
                                                     ) { \
        return __atomic_fetch_sub(self, op, order); \
    } \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_addAndFetch(_:op:order:)"))) \
    cType loobee_atomic_##id##_add_and_fetch( \
                                                     volatile cType *_Nonnull self, \
                                                     cType op, \
                                                     loobee_atomic_order_t order \
                                                     ) { \
        return __atomic_add_fetch(self, op, order); \
    } \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_subAndFetch(_:op:order:)"))) \
    cType loobee_atomic_##id##_sub_and_fetch( \
                                                     volatile cType *_Nonnull self, \
                                                     cType op, \
                                                     loobee_atomic_order_t order \
                                                     ) { \
        return __atomic_sub_fetch(self, op, order); \
    }

#define LOOBEE_ATOMIC_BIT(id, cType, swiftType) \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_fetchAndAnd(_:op:order:)"))) \
    cType loobee_atomic_##id##_fetch_and_and( \
                                                     volatile cType *_Nonnull self, \
                                                     cType op, \
                                                     loobee_atomic_order_t order \
                                                     ) { \
        return __atomic_fetch_and(self, op, order); \
    } \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_fetchAndOr(_:op:order:)"))) \
    cType loobee_atomic_##id##_fetch_and_or( \
                                                    volatile cType *_Nonnull self, \
                                                    cType op, \
                                                    loobee_atomic_order_t order \
                                                    ) { \
        return __atomic_fetch_or(self, op, order); \
    } \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_fetchAndXor(_:op:order:)"))) \
    cType loobee_atomic_##id##_fetch_and_xor( \
                                                     volatile cType *_Nonnull self, \
                                                     cType op, \
                                                     loobee_atomic_order_t order \
                                                     ) { \
        return __atomic_fetch_xor(self, op, order); \
    } \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_andAndFetch(_:op:order:)"))) \
    cType loobee_atomic_##id##_and_and_fetch( \
                                                     volatile cType *_Nonnull self, \
                                                     cType op, \
                                                     loobee_atomic_order_t order \
                                                     ) { \
        return __atomic_and_fetch(self, op, order); \
    } \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_orAndFetch(_:op:order:)"))) \
    cType loobee_atomic_##id##_or_and_fetch( \
                                                    volatile cType *_Nonnull self, \
                                                    cType op, \
                                                    loobee_atomic_order_t order \
                                                    ) { \
        return __atomic_or_fetch(self, op, order); \
    } \
    static __inline__ __attribute__((__always_inline__)) \
    __attribute((swift_name("LoobeeCAtomic"#swiftType"_xorAndFetch(_:op:order:)"))) \
    cType loobee_atomic_##id##_xor_and_fetch( \
                                                     volatile cType *_Nonnull self, \
                                                     cType op, \
                                                     loobee_atomic_order_t order \
                                                     ) { \
        return __atomic_xor_fetch(self, op, order); \
    }
// =====================================================================================================================
LOOBEE_ATOMIC_IS_LOCK_FREE(bool, bool, Bool)
LOOBEE_ATOMIC_STORE(bool, bool, Bool)
LOOBEE_ATOMIC_LOAD(bool, bool, Bool)
LOOBEE_ATOMIC_EXCHANGE(bool, bool, Bool)
LOOBEE_ATOMIC_COMPARE_EXCHANGE(bool, bool, Bool)

#define LOOBEE_ATOMIC_SCALAR(id, cType, swiftType) \
    LOOBEE_ATOMIC_IS_LOCK_FREE(id, cType, swiftType) \
    LOOBEE_ATOMIC_STORE(id, cType, swiftType) \
    LOOBEE_ATOMIC_LOAD(id, cType, swiftType) \
    LOOBEE_ATOMIC_EXCHANGE(id, cType, swiftType) \
    LOOBEE_ATOMIC_COMPARE_EXCHANGE(id, cType, swiftType) \
    LOOBEE_ATOMIC_MATH(id, cType, swiftType) \
    LOOBEE_ATOMIC_BIT(id, cType, swiftType)

LOOBEE_ATOMIC_SCALAR(uint8, uint8_t, UInt8)
LOOBEE_ATOMIC_SCALAR(int8, int8_t, Int8)
LOOBEE_ATOMIC_SCALAR(uint16, uint16_t, UInt16)
LOOBEE_ATOMIC_SCALAR(int16, int16_t, Int16)
LOOBEE_ATOMIC_SCALAR(uint32, uint32_t, UInt32)
LOOBEE_ATOMIC_SCALAR(int32, int32_t, Int32)
LOOBEE_ATOMIC_SCALAR(uint64, uint64_t, UInt64)
LOOBEE_ATOMIC_SCALAR(int64, int64_t, Int64)
