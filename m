From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: introduce f2fs_find_next(_zero)_bit
Date: Fri, 15 Nov 2013 10:42:51 +0900
Message-ID: <1384479771-11740-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When f2fs_set_bit is used, in a byte MSB and LSB is reversed,
in that case we can use f2fs_find_next_bit or f2fs_find_next_zero_bit.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/segment.c |  143 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fa284d3..b2de887 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -21,6 +21,149 @@
 #include <trace/events/f2fs.h>
 
 /*
+ * f2fs_ffs is copied from include/asm-generic/bitops/__ffs.h because
+ * MSB and LSB is reversed in a byte by f2fs_set_bit.
+ */
+static inline unsigned long f2fs_ffs(unsigned long word)
+{
+	int num = 0;
+
+#if BITS_PER_LONG == 64
+	if ((word & 0xffffffff) == 0) {
+		num += 32;
+		word >>= 32;
+	}
+#endif
+	if ((word & 0xffff) == 0) {
+		num += 16;
+		word >>= 16;
+	}
+	if ((word & 0xff) == 0) {
+		num += 8;
+		word >>= 8;
+	}
+	if ((word & 0xf0) == 0)
+		num += 4;
+	else
+		word >>= 4;
+	if ((word & 0xc) == 0)
+		num += 2;
+	else
+		word >>= 2;
+	if ((word & 0x2) == 0)
+		num += 1;
+	return num;
+}
+
+#define f2fs_ffz(x) f2fs_ffs(~(x))
+
+/*
+ * f2fs_find_next(_zero)_bit is copied from lib/find_next_bit.c becasue
+ * f2fs_set_bit makes MSB and LSB reversed in a byte.
+ * Example:
+ *                             LSB <--> MSB
+ *   f2fs_set_bit(0, bitmap) => 0000 0001
+ *   f2fs_set_bit(7, bitmap) => 1000 0000
+ */
+static unsigned long f2fs_find_next_bit(const unsigned long *addr,
+		unsigned long size, unsigned long offset)
+{
+	const unsigned long *p = addr + BIT_WORD(offset);
+	unsigned long result = offset & ~(BITS_PER_LONG - 1);
+	unsigned long tmp;
+	unsigned long mask, submask;
+	unsigned long quot, rest;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset %= BITS_PER_LONG;
+	if (!offset)
+		goto aligned;
+	tmp = *(p++);
+	quot = (offset >> 3) << 3;
+	rest = offset & 0x7;
+	mask = ~0UL << quot;
+	submask = (unsigned char)(0xff << rest) >> rest;
+	submask <<= quot;
+	mask &= submask;
+	tmp &= mask;
+	if (size < BITS_PER_LONG)
+		goto found_first;
+	if (tmp)
+		goto found_middle;
+	size -= BITS_PER_LONG;
+	result += BITS_PER_LONG;
+aligned:
+	while (size & ~(BITS_PER_LONG-1)) {
+		tmp = *(p++);
+		if (tmp)
+			goto found_middle;
+		result += BITS_PER_LONG;
+		size -= BITS_PER_LONG;
+	}
+	if (!size)
+		return result;
+	tmp = *p;
+
+found_first:
+	tmp &= (~0UL >> (BITS_PER_LONG - size));
+	if (tmp == 0UL)		/* Are any bits set? */
+		return result + size;   /* Nope. */
+found_middle:
+	return result + f2fs_ffs(tmp);
+}
+
+static unsigned long f2fs_find_next_zero_bit(const unsigned long *addr,
+		unsigned long size, unsigned long offset)
+{
+	const unsigned long *p = addr + BIT_WORD(offset);
+	unsigned long result = offset & ~(BITS_PER_LONG - 1);
+	unsigned long tmp;
+	unsigned long mask, submask;
+	unsigned long quot, rest;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset %= BITS_PER_LONG;
+	if (!offset)
+		goto aligned;
+	tmp = *(p++);
+	quot = (offset >> 3) << 3;
+	rest = offset & 0x7;
+	mask = ~(~0UL << quot);
+	submask = (unsigned char)~((unsigned char)(0xff << rest) >> rest);
+	submask <<= quot;
+	mask += submask;
+	tmp |= mask;
+	if (size < BITS_PER_LONG)
+		goto found_first;
+	if (~tmp)
+		goto found_middle;
+	size -= BITS_PER_LONG;
+	result += BITS_PER_LONG;
+aligned:
+	while (size & ~(BITS_PER_LONG - 1)) {
+		tmp = *(p++);
+		if (~tmp)
+			goto found_middle;
+		result += BITS_PER_LONG;
+		size -= BITS_PER_LONG;
+	}
+	if (!size)
+		return result;
+	tmp = *p;
+
+found_first:
+	tmp |= ~0UL << size;
+	if (tmp == ~0UL)        /* Are any bits zero? */
+		return result + size;   /* Nope. */
+found_middle:
+	return result + f2fs_ffz(tmp);
+}
+
+/*
  * This function balances dirty node and dentry pages.
  * In addition, it controls garbage collection.
  */
-- 
1.7.10.4

