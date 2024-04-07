#define _FILE_OFFSET_BITS 64

#define _GNU_SOURCE             /* recvmmsg */

/* For OpenBSD `swap` functions */
#ifdef __OpenBSD__
#define _BSD_SOURCE
#endif

#include <string.h>
#ifndef _MSC_VER
#include <unistd.h>
#else
#include <stdlib.h>
#endif
#include <errno.h>
#include <assert.h>
#include <stdint.h>

#ifdef __APPLE__
#include <libkern/OSByteOrder.h>
#define bswap_16 OSSwapInt16
#define bswap_32 OSSwapInt32
#define bswap_64 OSSwapInt64
#elif __GLIBC__
#include <byteswap.h>
#include <malloc.h>
#elif __OpenBSD__
#include <sys/types.h>
#define bswap_16 swap16
#define bswap_32 swap32
#define bswap_64 swap64
#elif __CYGWIN__
#include <endian.h>
#elif __MINGW32__
#if defined(__GNUC__) && __GNUC__ > 4
#define bswap_16 __builtin_bswap16
#else
static inline uint16_t bswap_16 (uint16_t x)
{
      return (x << 8) | (x >> 8);
}
#endif
#define bswap_32 __builtin_bswap32
#define bswap_64 __builtin_bswap64
#elif _MSC_VER
#define bswap_16 _byteswap_ushort
#define bswap_32 _byteswap_ulong
#define bswap_64 _byteswap_uint64
#else
#include <sys/types.h>
#if defined(__FreeBSD__) || defined(__NetBSD__) || defined(__OpenBSD__)
#include <sys/endian.h>
#else
#include <endian.h>
#endif
#define __BYTE_ORDER    _BYTE_ORDER
#define __LITTLE_ENDIAN _LITTLE_ENDIAN
#define __BIG_ENDIAN    _BIG_ENDIAN
#define bswap_16 bswap16
#define bswap_32 bswap32
#define bswap_64 bswap64
#endif

#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/fail.h>
#include <caml/signals.h>
#include <caml/bigarray.h>
#include "base_bigstring.h"
#include "internalhash.h"

/* Bytes_val is only available from 4.06 */
#ifndef Bytes_val
#define Bytes_val String_val
#endif

static inline char * get_bstr(value v_bstr, value v_pos)
{
  return (char *) Caml_ba_data_val(v_bstr) + Long_val(v_pos);
}

CAMLexport value
bigstring_alloc (value v_gc_max_unused, value v_size)
{
  intnat size = Long_val(v_size);
  void * data = NULL;
  int flags = BASE_BIGSTRING_FLAGS | CAML_BA_MANAGED;
  intnat gc_max_unused = Long_val(v_gc_max_unused);
  intnat dims[1];
  dims[0] = size;

  if (gc_max_unused >= 0) {
    data = (void *) malloc(sizeof(char) * size);
    if (NULL == data) caml_raise_out_of_memory ();
    /* caml_adjust_gc_speed is also called by caml_ba_alloc below, but it will have
    * numerator 0 when data != NULL. Effectively, that call will have no effect if this
    * call is made. */
    caml_adjust_gc_speed(size, gc_max_unused);
  }

  return caml_ba_alloc (flags, 1, data, dims);
}

/* Checking memory-mapping */

CAMLprim value bigstring_is_mmapped_stub(value v_bstr)
{
  return
    Val_bool((Caml_ba_array_val(v_bstr)->flags & CAML_BA_MAPPED_FILE) != 0);
}

/* Blitting */

CAMLprim value bigstring_blit_string_bigstring_stub(
  value v_str, value v_src_pos, value v_bstr, value v_dst_pos, value v_len)
{
  const char *str = String_val(v_str) + Long_val(v_src_pos);
  char *bstr = get_bstr(v_bstr, v_dst_pos);
  memcpy(bstr, str, Long_val(v_len));
  return Val_unit;
}

CAMLprim value bigstring_blit_bytes_bigstring_stub(
  value v_str, value v_src_pos, value v_bstr, value v_dst_pos, value v_len)
{
  unsigned char *str = Bytes_val(v_str) + Long_val(v_src_pos);
  char *bstr = get_bstr(v_bstr, v_dst_pos);
  memcpy(bstr, str, Long_val(v_len));
  return Val_unit;
}

CAMLprim value bigstring_blit_bigstring_bytes_stub(
  value v_bstr, value v_src_pos, value v_str, value v_dst_pos, value v_len)
{
  char *bstr = get_bstr(v_bstr, v_src_pos);
  unsigned char *str = Bytes_val(v_str) + Long_val(v_dst_pos);
  memcpy(str, bstr, Long_val(v_len));
  return Val_unit;
}


CAMLprim value bigstring_blit_stub(
  value v_src, value v_src_pos, value v_dst, value v_dst_pos, value v_len)
{
  struct caml_ba_array *ba_src = Caml_ba_array_val(v_src);
  struct caml_ba_array *ba_dst = Caml_ba_array_val(v_dst);
  char *src = (char *) ba_src->data + Long_val(v_src_pos);
  char *dst = (char *) ba_dst->data + Long_val(v_dst_pos);
  size_t len = Long_val(v_len);
  memmove(dst, src, len);
  return Val_unit;
}

CAMLprim value bigstring_memset_stub(value v_t, value v_pos, value v_len, value v_char)
{
  struct caml_ba_array *ba_t = Caml_ba_array_val(v_t);
  char *buffer = ((char *) ba_t->data) + Long_val(v_pos);
  memset(buffer, Int_val(v_char), Long_val(v_len));

  return Val_unit;
}

/* Comparison */

static inline value caml_memcmp(unsigned char * s1, unsigned char * s2, size_t n)
{
  int res = memcmp(s1, s2, n);
  if (res < 0) return Val_int(-1);
  if (res > 0) return Val_int(1);
  return Val_int(0);
}

CAMLprim value bigstring_memcmp_stub(value v_s1, value v_s1_pos,
                                     value v_s2, value v_s2_pos,
                                     value v_len) /* noalloc */
{
  struct caml_ba_array *ba_s1 = Caml_ba_array_val(v_s1);
  struct caml_ba_array *ba_s2 = Caml_ba_array_val(v_s2);
  return caml_memcmp((unsigned char *) ba_s1->data + Long_val(v_s1_pos),
                     (unsigned char *) ba_s2->data + Long_val(v_s2_pos),
                     Long_val(v_len));
}

CAMLprim value bigstring_memcmp_bytes_stub(value v_bstr, value v_s1_pos,
                                           value v_bytes, value v_s2_pos,
                                           value v_len) /* noalloc */
{
  struct caml_ba_array *ba_s1 = Caml_ba_array_val(v_bstr);
  return caml_memcmp((unsigned char *) ba_s1->data + Long_val(v_s1_pos),
                     Bytes_val(v_bytes) + Long_val(v_s2_pos),
                     Long_val(v_len));
}

/* Hashing */

CAMLprim value internalhash_fold_bigstring(value st, value v_str) /* noalloc */
{
  uint32_t h = Long_val(st);

  struct caml_ba_array *ba = Caml_ba_array_val(v_str);
  uint8_t *s = (uint8_t *) ba->data;

  mlsize_t len = ba->dim[0];

  h = Base_internalhash_fold_blob(h, len, s);

  return Val_long(h);
}

/* Search */

CAMLprim value ptr_to_offset(const char *start, value v_pos, const char *r) {

  if (!r) return Val_long(-1);

  intnat ret = Long_val(v_pos) + r - start;
  return Val_long(ret);
}

CAMLprim value bigstring_find(value v_str, value v_needle,
                              value v_pos, value v_len)
{
  char *start, *r;

  start = get_bstr(v_str, v_pos);
  r = (char*) memchr(start, Int_val(v_needle), Long_val(v_len));

  return ptr_to_offset(start, v_pos, r);
}

CAMLprim value bigstring_memmem(value v_haystack, value v_needle,
                                value v_haystack_pos, value v_haystack_len,
                                value v_needle_pos, value v_needle_len)
{
  const char *haystack = get_bstr(v_haystack, v_haystack_pos);
  const char *needle = get_bstr(v_needle, v_needle_pos);
  const char *result = memmem(haystack, Long_val(v_haystack_len),
                              needle, Long_val(v_needle_len));

  return ptr_to_offset(haystack, v_haystack_pos, result);

}

CAMLprim value bigstring_memmem_bytecode(value *argv, int n) {
  assert(n==6);
  return bigstring_memmem(argv[0],argv[1],argv[2],argv[3],argv[4],argv[5]);
}
