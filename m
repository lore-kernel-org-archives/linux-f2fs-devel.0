From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/5] f2fs: check in-memory sit version bitmap
Date: Sat, 7 Jan 2017 18:52:34 +0800
Message-ID: <90c86a9f-64fa-5301-633d-d9bdfb811196@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cPocG-00079k-OS
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jan 2017 10:52:52 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cPoc8-0003yq-Th
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jan 2017 10:52:52 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds a mirror for sit version bitmap, and use it to detect
in-memory bitmap corruption which may be caused by bit-transition of
cache or memory overflow.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 16 ++++++++++++----
 fs/f2fs/segment.h | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ec21ee1c61cd..bdb82b7ebb31 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2346,7 +2346,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct sit_info *sit_i;
 	unsigned int sit_segs, start;
-	char *src_bitmap, *dst_bitmap;
+	char *src_bitmap;
 	unsigned int bitmap_size;

 	/* allocate memory for SIT information */
@@ -2408,17 +2408,22 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	bitmap_size = __bitmap_size(sbi, SIT_BITMAP);
 	src_bitmap = __bitmap_ptr(sbi, SIT_BITMAP);

-	dst_bitmap = kmemdup(src_bitmap, bitmap_size, GFP_KERNEL);
-	if (!dst_bitmap)
+	sit_i->sit_bitmap = kmemdup(src_bitmap, bitmap_size, GFP_KERNEL);
+	if (!sit_i->sit_bitmap)
 		return -ENOMEM;

+#ifdef CONFIG_F2FS_CHECK_FS
+	sit_i->sit_bitmap_mir = kmemdup(src_bitmap, bitmap_size, GFP_KERNEL);
+	if (!sit_i->sit_bitmap_mir)
+		return -ENOMEM;
+#endif
+
 	/* init SIT information */
 	sit_i->s_ops = &default_salloc_ops;

 	sit_i->sit_base_addr = le32_to_cpu(raw_super->sit_blkaddr);
 	sit_i->sit_blocks = sit_segs << sbi->log_blocks_per_seg;
 	sit_i->written_valid_blocks = 0;
-	sit_i->sit_bitmap = dst_bitmap;
 	sit_i->bitmap_size = bitmap_size;
 	sit_i->dirty_sentries = 0;
 	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK;
@@ -2824,6 +2829,9 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)

 	SM_I(sbi)->sit_info = NULL;
 	kfree(sit_i->sit_bitmap);
+#ifdef CONFIG_F2FS_CHECK_FS
+	kfree(sit_i->sit_bitmap_mir);
+#endif
 	kfree(sit_i);
 }

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 9af95194db06..5cb5755c75d9 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -209,6 +209,9 @@ struct sit_info {
 	block_t sit_blocks;		/* # of blocks used by SIT area */
 	block_t written_valid_blocks;	/* # of valid blocks in main area */
 	char *sit_bitmap;		/* SIT bitmap pointer */
+#ifdef CONFIG_F2FS_CHECK_FS
+	char *sit_bitmap_mir;		/* SIT bitmap mirror */
+#endif
 	unsigned int bitmap_size;	/* SIT bitmap size */

 	unsigned long *tmp_map;			/* bitmap for temporal use */
@@ -423,6 +426,12 @@ static inline void get_sit_bitmap(struct f2fs_sb_info *sbi,
 		void *dst_addr)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
+
+#ifdef CONFIG_F2FS_CHECK_FS
+	if (memcmp(sit_i->sit_bitmap, sit_i->sit_bitmap_mir,
+						sit_i->bitmap_size))
+		f2fs_bug_on(sbi, 1);
+#endif
 	memcpy(dst_addr, sit_i->sit_bitmap, sit_i->bitmap_size);
 }

@@ -643,6 +652,12 @@ static inline pgoff_t current_sit_addr(struct f2fs_sb_info *sbi,

 	check_seg_range(sbi, start);

+#ifdef CONFIG_F2FS_CHECK_FS
+	if (f2fs_test_bit(offset, sit_i->sit_bitmap) !=
+			f2fs_test_bit(offset, sit_i->sit_bitmap_mir))
+		f2fs_bug_on(sbi, 1);
+#endif
+
 	/* calculate sit block address */
 	if (f2fs_test_bit(offset, sit_i->sit_bitmap))
 		blk_addr += sit_i->sit_blocks;
@@ -668,6 +683,9 @@ static inline void set_to_next_sit(struct sit_info *sit_i, unsigned int start)
 	unsigned int block_off = SIT_BLOCK_OFFSET(start);

 	f2fs_change_bit(block_off, sit_i->sit_bitmap);
+#ifdef CONFIG_F2FS_CHECK_FS
+	f2fs_change_bit(block_off, sit_i->sit_bitmap_mir);
+#endif
 }

 static inline unsigned long long get_mtime(struct f2fs_sb_info *sbi)
-- 
2.8.2.295.g3f1c1d0



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
