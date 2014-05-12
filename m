From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: large volume support
Date: Mon, 12 May 2014 15:59:36 +0900
Message-ID: <1399877976-2643-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1WjkEe-0005Nd-09
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 May 2014 07:01:16 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WjkEb-0005El-Ny
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 May 2014 07:01:15 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N5G000MJ8TU9900@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 May 2014 16:01:06 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org

f2fs's cp has one page which consists of struct f2fs_checkpoint and
version bitmap of sit and nat. To support lots of segments, we need more
blocks for sit bitmap. So let's arrange sit bitmap as following:
+-----------------+------------+
| f2fs_checkpoint | sit bitmap |
| + nat bitmap    |            |
+-----------------+------------+
0                 4k        N blocks

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/checkpoint.c    |   47 ++++++++++++++++++++++++++++++++++++++++++++---
 fs/f2fs/f2fs.h          |   13 +++++++++++--
 include/linux/f2fs_fs.h |    2 ++
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index fe968c7..f418243 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -544,6 +544,32 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	cp_block = (struct f2fs_checkpoint *)page_address(cur_page);
 	memcpy(sbi->ckpt, cp_block, blk_size);
 
+	if (is_set_ckpt_flags(sbi->ckpt, CP_LARGE_VOL_FLAG)) {
+		int i, cp_blks;
+		block_t cp_blk_no;
+
+		cp_blk_no = le32_to_cpu(fsb->cp_blkaddr);
+		if (cur_page == cp2)
+			cp_blk_no += 1 << le32_to_cpu(fsb->log_blocks_per_seg);
+
+		cp_blks = 1 + F2FS_BLK_ALIGN(cp_block->sit_ver_bitmap_bytesize);
+
+		kfree(sbi->ckpt);
+		sbi->ckpt = kzalloc(cp_blks * blk_size, GFP_KERNEL);
+
+		memcpy(sbi->ckpt, cp_block, blk_size);
+
+		for (i = 1; i < cp_blks; i++) {
+			void *sit_bitmap_ptr;
+			unsigned char *ckpt = (unsigned char *)sbi->ckpt;
+
+			cur_page = get_meta_page(sbi, cp_blk_no + i);
+			sit_bitmap_ptr = page_address(cur_page);
+			memcpy(ckpt + i * blk_size, sit_bitmap_ptr, blk_size);
+			f2fs_put_page(cur_page, 1);
+		}
+	}
+
 	f2fs_put_page(cp1, 1);
 	f2fs_put_page(cp2, 1);
 	return 0;
@@ -736,6 +762,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	__u32 crc32 = 0;
 	void *kaddr;
 	int i;
+	int sit_bitmap_blks = 0;
 
 	/*
 	 * This avoids to conduct wrong roll-forward operations and uses
@@ -786,16 +813,21 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 
 	orphan_blocks = (sbi->n_orphans + F2FS_ORPHANS_PER_BLOCK - 1)
 					/ F2FS_ORPHANS_PER_BLOCK;
-	ckpt->cp_pack_start_sum = cpu_to_le32(1 + orphan_blocks);
+	if (is_set_ckpt_flags(ckpt, CP_LARGE_VOL_FLAG))
+		sit_bitmap_blks = F2FS_BLK_ALIGN(ckpt->sit_ver_bitmap_bytesize);
+	ckpt->cp_pack_start_sum = cpu_to_le32(1 + sit_bitmap_blks +
+			orphan_blocks);
 
 	if (is_umount) {
 		set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
 		ckpt->cp_pack_total_block_count = cpu_to_le32(2 +
-			data_sum_blocks + orphan_blocks + NR_CURSEG_NODE_TYPE);
+				sit_bitmap_blks + data_sum_blocks +
+				orphan_blocks + NR_CURSEG_NODE_TYPE);
 	} else {
 		clear_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
 		ckpt->cp_pack_total_block_count = cpu_to_le32(2 +
-			data_sum_blocks + orphan_blocks);
+				sit_bitmap_blks + data_sum_blocks +
+				orphan_blocks);
 	}
 
 	if (sbi->n_orphans)
@@ -821,6 +853,15 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	set_page_dirty(cp_page);
 	f2fs_put_page(cp_page, 1);
 
+	for (i = 1; i < 1 + sit_bitmap_blks; i++) {
+		cp_page = grab_meta_page(sbi, start_blk++);
+		kaddr = page_address(cp_page);
+		memcpy(kaddr, (char *)ckpt + i * F2FS_BLKSIZE,
+				(1 << sbi->log_blocksize));
+		set_page_dirty(cp_page);
+		f2fs_put_page(cp_page, 1);
+	}
+
 	if (sbi->n_orphans) {
 		write_orphan_inodes(sbi, start_blk);
 		start_blk += orphan_blocks;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 676a2c6..9e147ae 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -764,9 +764,18 @@ static inline unsigned long __bitmap_size(struct f2fs_sb_info *sbi, int flag)
 static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-	int offset = (flag == NAT_BITMAP) ?
+	int offset;
+
+	if (ckpt->ckpt_flags & CP_LARGE_VOL_FLAG) {
+		if (flag == NAT_BITMAP)
+			return &ckpt->sit_nat_version_bitmap;
+		else
+			return ((unsigned char *)ckpt + F2FS_BLKSIZE);
+	} else {
+		offset = (flag == NAT_BITMAP) ?
 			le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
-	return &ckpt->sit_nat_version_bitmap + offset;
+		return &ckpt->sit_nat_version_bitmap + offset;
+	}
 }
 
 static inline block_t __start_cp_addr(struct f2fs_sb_info *sbi)
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 8c03f71..0f0b788 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -19,6 +19,7 @@
 #define F2FS_LOG_SECTORS_PER_BLOCK	3	/* 4KB: F2FS_BLKSIZE */
 #define F2FS_BLKSIZE			4096	/* support only 4KB block */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
+#define F2FS_BLK_ALIGN(x)	(((x) + F2FS_BLKSIZE - 1) / F2FS_BLKSIZE)
 
 #define NULL_ADDR		((block_t)0)	/* used as block_t addresses */
 #define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
@@ -80,6 +81,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_LARGE_VOL_FLAG	0x00000010
 #define CP_ERROR_FLAG		0x00000008
 #define CP_COMPACT_SUM_FLAG	0x00000004
 #define CP_ORPHAN_PRESENT_FLAG	0x00000002
-- 
1.7.9.5


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
