From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/6] libf2fs: enhance the bit operations
Date: Fri, 11 Dec 2015 16:00:09 -0800
Message-ID: <1449878414-41254-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a7Xbt-0005g5-Lw
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 00:00:25 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a7Xbs-000740-At for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 00:00:25 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch modifies the existing bit operations.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       |  12 +++----
 include/f2fs_fs.h |  23 ++++++++++--
 lib/libf2fs.c     | 104 ++++++++++++++++++++++++------------------------------
 3 files changed, 73 insertions(+), 66 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index c71f225..c81dde9 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -820,7 +820,7 @@ static void convert_encrypted_name(unsigned char *name, int len,
 }
 
 static void print_dentry(__u32 depth, __u8 *name,
-		unsigned long *bitmap,
+		unsigned char *bitmap,
 		struct f2fs_dir_entry *dentry,
 		int max, int idx, int last_blk, int encrypted)
 {
@@ -837,7 +837,7 @@ static void print_dentry(__u32 depth, __u8 *name,
 	name_len = le16_to_cpu(dentry[idx].name_len);
 	next_idx = idx + (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN;
 
-	bit_offset = find_next_bit(bitmap, max, next_idx);
+	bit_offset = find_next_bit_le(bitmap, max, next_idx);
 	if (bit_offset >= max && last_blk)
 		last_de = 1;
 
@@ -889,7 +889,7 @@ static int f2fs_check_hash_code(struct f2fs_dir_entry *dentry,
 }
 
 static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
-			unsigned long *bitmap,
+			unsigned char *bitmap,
 			struct f2fs_dir_entry *dentry,
 			__u8 (*filenames)[F2FS_SLOT_LEN],
 			int max, int last_blk, int encrypted)
@@ -946,7 +946,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 
 		ftype = dentry[i].file_type;
 		if ((ftype <= F2FS_FT_UNKNOWN || ftype > F2FS_FT_LAST_FILE_TYPE)) {
-			ASSERT_MSG("Bad dentry 0x%x with unexpected ftype 0x%x", i, ftype);
+			ASSERT_MSG("Bad dentry 0x%x with unexpected ftype 0x%x", ino, ftype);
 			if (config.fix_on) {
 				FIX_MSG("Clear bad dentry 0x%x with bad ftype 0x%x",
 					i, ftype);
@@ -1036,7 +1036,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
 
 	fsck->dentry_depth++;
 	dentries = __chk_dentries(sbi, child,
-			(unsigned long *)de_blk->dentry_bitmap,
+			de_blk->dentry_bitmap,
 			de_blk->dentry, de_blk->filename,
 			NR_INLINE_DENTRY, 1,
 			file_is_encrypt(node_blk->i.i_advise));
@@ -1068,7 +1068,7 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 
 	fsck->dentry_depth++;
 	dentries = __chk_dentries(sbi, child,
-			(unsigned long *)de_blk->dentry_bitmap,
+			de_blk->dentry_bitmap,
 			de_blk->dentry, de_blk->filename,
 			NR_DENTRY_IN_BLOCK, last_blk, encrypted);
 
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index a448d61..6fd4c80 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -320,6 +320,23 @@ struct f2fs_configuration {
 			})
 
 /*
+ * Copied from include/linux/kernel.h
+ */
+#define __round_mask(x, y)	((__typeof__(x))((y)-1))
+#define round_down(x, y)	((x) & ~__round_mask(x, y))
+#define min(x, y) ({				\
+	typeof(x) _min1 = (x);			\
+	typeof(y) _min2 = (y);			\
+	(void) (&_min1 == &_min2);		\
+	_min1 < _min2 ? _min1 : _min2; })
+
+#define max(x, y) ({				\
+	typeof(x) _max1 = (x);			\
+	typeof(y) _max2 = (y);			\
+	(void) (&_max1 == &_max2);		\
+	_max1 > _max2 ? _max1 : _max2; })
+
+/*
  * Copied from fs/f2fs/f2fs.h
  */
 #define	NR_CURSEG_DATA_TYPE	(3)
@@ -834,8 +851,10 @@ extern int test_bit(unsigned int nr, const void * addr);
 extern int f2fs_test_bit(unsigned int, const char *);
 extern int f2fs_set_bit(unsigned int, char *);
 extern int f2fs_clear_bit(unsigned int, char *);
-extern unsigned long find_next_bit(const unsigned long *,
-				unsigned long, unsigned long);
+extern unsigned long find_next_bit_le(const unsigned char *, unsigned long,
+		unsigned long);
+extern unsigned long find_next_zero_bit_le(const unsigned char *, unsigned long,
+		unsigned long);
 
 extern u_int32_t f2fs_cal_crc32(u_int32_t, void *, int);
 extern int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 0ac9994..307ad56 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -75,10 +75,10 @@ int get_bits_in_byte(unsigned char n)
 	return bits_in_byte[n];
 }
 
-int set_bit(unsigned int nr,void * addr)
+int set_bit(unsigned int nr, void *addr)
 {
-	int             mask, retval;
-	unsigned char   *ADDR = (unsigned char *) addr;
+	int mask, retval;
+	unsigned char *ADDR = (unsigned char *)addr;
 
 	ADDR += nr >> 3;
 	mask = 1 << ((nr & 0x07));
@@ -87,10 +87,10 @@ int set_bit(unsigned int nr,void * addr)
 	return retval;
 }
 
-int clear_bit(unsigned int nr, void * addr)
+int clear_bit(unsigned int nr, void *addr)
 {
-	int             mask, retval;
-	unsigned char   *ADDR = (unsigned char *) addr;
+	int mask, retval;
+	unsigned char *ADDR = (unsigned char *)addr;
 
 	ADDR += nr >> 3;
 	mask = 1 << ((nr & 0x07));
@@ -99,7 +99,7 @@ int clear_bit(unsigned int nr, void * addr)
 	return retval;
 }
 
-int test_bit(unsigned int nr, const void * addr)
+int test_bit(unsigned int nr, const void *addr)
 {
 	const __u32 *p = (const __u32 *)addr;
 
@@ -142,24 +142,10 @@ int f2fs_clear_bit(unsigned int nr, char *addr)
 	return ret;
 }
 
-static inline unsigned long __ffs(unsigned long word)
+static inline unsigned long __ffs(unsigned char word)
 {
 	int num = 0;
 
-#if BITS_PER_LONG == 64
-	if ((word & 0xffffffff) == 0) {
-		num += 32;
-		word >>= 32;
-	}
-#endif
-	if ((word & 0xffff) == 0) {
-		num += 16;
-		word >>= 16;
-	}
-	if ((word & 0xff) == 0) {
-		num += 8;
-		word >>= 8;
-	}
 	if ((word & 0xf) == 0) {
 		num += 4;
 		word >>= 4;
@@ -173,43 +159,45 @@ static inline unsigned long __ffs(unsigned long word)
 	return num;
 }
 
-unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
-                unsigned long offset)
+/* Copied from linux/lib/find_bit.c */
+#define BITMAP_FIRST_BYTE_MASK(start) (0xff << ((start) & (BITS_PER_BYTE - 1)))
+
+static unsigned long _find_next_bit_le(const unsigned char *addr,
+		unsigned long nbits, unsigned long start, char invert)
+{
+	unsigned char tmp;
+
+	if (!nbits || start >= nbits)
+		return nbits;
+
+	tmp = addr[start / BITS_PER_BYTE] ^ invert;
+
+	/* Handle 1st word. */
+	tmp &= BITMAP_FIRST_BYTE_MASK(start);
+	start = round_down(start, BITS_PER_BYTE);
+
+	while (!tmp) {
+		start += BITS_PER_BYTE;
+		if (start >= nbits)
+			return nbits;
+
+		tmp = addr[start / BITS_PER_BYTE] ^ invert;
+	}
+
+	return min(start + __ffs(tmp), nbits);
+}
+
+unsigned long find_next_bit_le(const unsigned char *addr, unsigned long size,
+		unsigned long offset)
+{
+	return _find_next_bit_le(addr, size, offset, 0);
+}
+
+
+unsigned long find_next_zero_bit_le(const unsigned char *addr,
+		unsigned long size, unsigned long offset)
 {
-        const unsigned long *p = addr + BIT_WORD(offset);
-        unsigned long result = offset & ~(BITS_PER_LONG-1);
-        unsigned long tmp;
-
-        if (offset >= size)
-                return size;
-        size -= result;
-        offset %= BITS_PER_LONG;
-        if (offset) {
-                tmp = *(p++);
-                tmp &= (~0UL << offset);
-                if (size < BITS_PER_LONG)
-                        goto found_first;
-                if (tmp)
-                        goto found_middle;
-                size -= BITS_PER_LONG;
-                result += BITS_PER_LONG;
-        }
-        while (size & ~(BITS_PER_LONG-1)) {
-                if ((tmp = *(p++)))
-                        goto found_middle;
-                result += BITS_PER_LONG;
-                size -= BITS_PER_LONG;
-        }
-        if (!size)
-                return result;
-        tmp = *p;
-
-found_first:
-        tmp &= (~0UL >> (BITS_PER_LONG - size));
-        if (tmp == 0UL)		/* Are any bits set? */
-                return result + size;   /* Nope. */
-found_middle:
-        return result + __ffs(tmp);
+	return _find_next_bit_le(addr, size, offset, 0xff);
 }
 
 /*
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
