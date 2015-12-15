From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] lib: fix test_bit_le functions
Date: Tue, 15 Dec 2015 13:19:33 -0800
Message-ID: <1450214374-65696-2-git-send-email-jaegeuk@kernel.org>
References: <1450214374-65696-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a8x0b-0004IU-0s
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 21:19:45 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a8x0a-0003e3-1Y for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 21:19:44 +0000
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

This patch fixes test_bit_le functions for dentry bit operations.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c        | 12 ++++++------
 include/f2fs_fs.h  |  6 +++---
 lib/libf2fs.c      | 26 ++++++++++----------------
 mkfs/f2fs_format.c |  3 ++-
 4 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 58786f2..38391a9 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -955,7 +955,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 
 	/* readahead inode blocks */
 	for (i = 0; i < max; i++) {
-		if (test_bit(i, bitmap) == 0)
+		if (test_bit_le(i, bitmap) == 0)
 			continue;
 
 		ino = le32_to_cpu(dentry[i].ino);
@@ -975,7 +975,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 	}
 
 	for (i = 0; i < max;) {
-		if (test_bit(i, bitmap) == 0) {
+		if (test_bit_le(i, bitmap) == 0) {
 			i++;
 			continue;
 		}
@@ -985,7 +985,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			if (config.fix_on) {
 				FIX_MSG("Clear bad dentry 0x%x with bad ino 0x%x",
 					i, le32_to_cpu(dentry[i].ino));
-				clear_bit(i, bitmap);
+				test_and_clear_bit_le(i, bitmap);
 				fixed = 1;
 			}
 			i++;
@@ -998,7 +998,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			if (config.fix_on) {
 				FIX_MSG("Clear bad dentry 0x%x with bad ftype 0x%x",
 					i, ftype);
-				clear_bit(i, bitmap);
+				test_and_clear_bit_le(i, bitmap);
 				fixed = 1;
 			}
 			i++;
@@ -1011,7 +1011,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			ASSERT_MSG("Bad dentry 0x%x with zero name_len", i);
 			if (config.fix_on) {
 				FIX_MSG("Clear bad dentry 0x%x", i);
-				clear_bit(i, bitmap);
+				test_and_clear_bit_le(i, bitmap);
 				fixed = 1;
 			}
 			i++;
@@ -1053,7 +1053,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			int j;
 
 			for (j = 0; j < slots; j++)
-				clear_bit(i + j, bitmap);
+				test_and_clear_bit_le(i + j, bitmap);
 			FIX_MSG("Unlink [0x%x] - %s len[0x%x], type[0x%x]",
 					le32_to_cpu(dentry[i].ino),
 					name, name_len,
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 4927d24..decc7f4 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -855,9 +855,9 @@ extern int log_base_2(u_int32_t);
 extern unsigned int addrs_per_inode(struct f2fs_inode *);
 
 extern int get_bits_in_byte(unsigned char n);
-extern int set_bit(unsigned int nr,void * addr);
-extern int clear_bit(unsigned int nr, void * addr);
-extern int test_bit(unsigned int nr, const void * addr);
+extern int test_and_set_bit_le(unsigned int, unsigned char *);
+extern int test_and_clear_bit_le(unsigned int, unsigned char*);
+extern int test_bit_le(unsigned int, const unsigned char *);
 extern int f2fs_test_bit(unsigned int, const char *);
 extern int f2fs_set_bit(unsigned int, char *);
 extern int f2fs_clear_bit(unsigned int, char *);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 1802d9c..ab98a11 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -234,37 +234,31 @@ int get_bits_in_byte(unsigned char n)
 	return bits_in_byte[n];
 }
 
-int set_bit(unsigned int nr, void *addr)
+int test_and_set_bit_le(unsigned int nr, unsigned char *addr)
 {
 	int mask, retval;
-	unsigned char *ADDR = (unsigned char *)addr;
 
-	ADDR += nr >> 3;
+	addr += nr >> 3;
 	mask = 1 << ((nr & 0x07));
-	retval = mask & *ADDR;
-	*ADDR |= mask;
+	retval = mask & *addr;
+	*addr |= mask;
 	return retval;
 }
 
-int clear_bit(unsigned int nr, void *addr)
+int test_and_clear_bit_le(unsigned int nr, unsigned char *addr)
 {
 	int mask, retval;
-	unsigned char *ADDR = (unsigned char *)addr;
 
-	ADDR += nr >> 3;
+	addr += nr >> 3;
 	mask = 1 << ((nr & 0x07));
-	retval = mask & *ADDR;
-	*ADDR &= ~mask;
+	retval = mask & *addr;
+	*addr &= ~mask;
 	return retval;
 }
 
-int test_bit(unsigned int nr, const void *addr)
+int test_bit_le(unsigned int nr, const unsigned char *addr)
 {
-	const __u32 *p = (const __u32 *)addr;
-
-	nr = nr ^ 0;
-
-	return ((1 << (nr & 31)) & (p[nr >> 5])) != 0;
+	return ((1 << (nr & 7)) & (addr[nr >> 3]));
 }
 
 int f2fs_test_bit(unsigned int nr, const char *p)
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 98a6bce..cb5379a 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -862,7 +862,8 @@ static int f2fs_add_default_dentry_root(void)
 	memcpy(dent_blk->filename[1], "..", 2);
 
 	/* bitmap for . and .. */
-	dent_blk->dentry_bitmap[0] = (1 << 1) | (1 << 0);
+	test_and_set_bit_le(0, dent_blk->dentry_bitmap);
+	test_and_set_bit_le(1, dent_blk->dentry_bitmap);
 	blk_size_bytes = 1 << get_sb(log_blocksize);
 	data_blk_offset = get_sb(main_blkaddr);
 	data_blk_offset += config.cur_seg[CURSEG_HOT_DATA] *
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
