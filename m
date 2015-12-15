From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] lib: use u8/u32/u64 for bit operations
Date: Tue, 15 Dec 2015 13:19:34 -0800
Message-ID: <1450214374-65696-3-git-send-email-jaegeuk@kernel.org>
References: <1450214374-65696-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a8x0b-0001Pn-Ui
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 21:19:45 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a8x0a-0004GO-WC for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 21:19:45 +0000
In-Reply-To: <1450214374-65696-1-git-send-email-jaegeuk@kernel.org>
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

This cleans up the bit operations.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       |  6 ++----
 include/f2fs_fs.h | 12 +++++-------
 lib/libf2fs.c     | 19 ++++++++-----------
 3 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 38391a9..3e67ffc 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -869,8 +869,7 @@ static void convert_encrypted_name(unsigned char *name, int len,
 }
 
 static void print_dentry(__u32 depth, __u8 *name,
-		unsigned char *bitmap,
-		struct f2fs_dir_entry *dentry,
+		u8 *bitmap, struct f2fs_dir_entry *dentry,
 		int max, int idx, int last_blk, int encrypted)
 {
 	int last_de = 0;
@@ -937,8 +936,7 @@ static int f2fs_check_hash_code(struct f2fs_dir_entry *dentry,
 }
 
 static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
-			unsigned char *bitmap,
-			struct f2fs_dir_entry *dentry,
+			u8 *bitmap, struct f2fs_dir_entry *dentry,
 			__u8 (*filenames)[F2FS_SLOT_LEN],
 			int max, int last_blk, int encrypted)
 {
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index decc7f4..f9060f2 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -855,16 +855,14 @@ extern int log_base_2(u_int32_t);
 extern unsigned int addrs_per_inode(struct f2fs_inode *);
 
 extern int get_bits_in_byte(unsigned char n);
-extern int test_and_set_bit_le(unsigned int, unsigned char *);
-extern int test_and_clear_bit_le(unsigned int, unsigned char*);
-extern int test_bit_le(unsigned int, const unsigned char *);
+extern int test_and_set_bit_le(u32, u8 *);
+extern int test_and_clear_bit_le(u32, u8 *);
+extern int test_bit_le(u32, const u8 *);
 extern int f2fs_test_bit(unsigned int, const char *);
 extern int f2fs_set_bit(unsigned int, char *);
 extern int f2fs_clear_bit(unsigned int, char *);
-extern unsigned long find_next_bit_le(const unsigned char *, unsigned long,
-		unsigned long);
-extern unsigned long find_next_zero_bit_le(const unsigned char *, unsigned long,
-		unsigned long);
+extern unsigned long find_next_bit_le(const u8 *, u64, u64);
+extern unsigned long find_next_zero_bit_le(const u8 *, u64, u64);
 
 extern u_int32_t f2fs_cal_crc32(u_int32_t, void *, int);
 extern int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index ab98a11..e9a1606 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -234,7 +234,7 @@ int get_bits_in_byte(unsigned char n)
 	return bits_in_byte[n];
 }
 
-int test_and_set_bit_le(unsigned int nr, unsigned char *addr)
+int test_and_set_bit_le(u32 nr, u8 *addr)
 {
 	int mask, retval;
 
@@ -245,7 +245,7 @@ int test_and_set_bit_le(unsigned int nr, unsigned char *addr)
 	return retval;
 }
 
-int test_and_clear_bit_le(unsigned int nr, unsigned char *addr)
+int test_and_clear_bit_le(u32 nr, u8 *addr)
 {
 	int mask, retval;
 
@@ -256,7 +256,7 @@ int test_and_clear_bit_le(unsigned int nr, unsigned char *addr)
 	return retval;
 }
 
-int test_bit_le(unsigned int nr, const unsigned char *addr)
+int test_bit_le(u32 nr, const u8 *addr)
 {
 	return ((1 << (nr & 7)) & (addr[nr >> 3]));
 }
@@ -295,7 +295,7 @@ int f2fs_clear_bit(unsigned int nr, char *addr)
 	return ret;
 }
 
-static inline unsigned long __ffs(unsigned char word)
+static inline u64 __ffs(u8 word)
 {
 	int num = 0;
 
@@ -315,10 +315,9 @@ static inline unsigned long __ffs(unsigned char word)
 /* Copied from linux/lib/find_bit.c */
 #define BITMAP_FIRST_BYTE_MASK(start) (0xff << ((start) & (BITS_PER_BYTE - 1)))
 
-static unsigned long _find_next_bit_le(const unsigned char *addr,
-		unsigned long nbits, unsigned long start, char invert)
+static u64 _find_next_bit_le(const u8 *addr, u64 nbits, u64 start, char invert)
 {
-	unsigned char tmp;
+	u8 tmp;
 
 	if (!nbits || start >= nbits)
 		return nbits;
@@ -340,15 +339,13 @@ static unsigned long _find_next_bit_le(const unsigned char *addr,
 	return min(start + __ffs(tmp), nbits);
 }
 
-unsigned long find_next_bit_le(const unsigned char *addr, unsigned long size,
-		unsigned long offset)
+u64 find_next_bit_le(const u8 *addr, u64 size, u64 offset)
 {
 	return _find_next_bit_le(addr, size, offset, 0);
 }
 
 
-unsigned long find_next_zero_bit_le(const unsigned char *addr,
-		unsigned long size, unsigned long offset)
+u64 find_next_zero_bit_le(const u8 *addr, u64 size, u64 offset)
 {
 	return _find_next_bit_le(addr, size, offset, 0xff);
 }
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
