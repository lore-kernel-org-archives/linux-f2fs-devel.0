From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/5] f2fs: check in-memory block bitmap
Date: Sat, 7 Jan 2017 18:51:01 +0800
Message-ID: <83098918-d882-8743-51bc-1e96038d6ad2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cPodv-0007E5-KY
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jan 2017 10:54:35 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1cPodu-0004BF-4n for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jan 2017 10:54:35 +0000
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

This patch adds a mirror for valid block bitmap, and use it to detect
in-memory bitmap corruption which may be caused by bit-transition of
cache or memory overflow.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 30 ++++++++++++++++++++++++++++--
 fs/f2fs/segment.h |  6 ++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fa8c0ae87d47..ec21ee1c61cd 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1026,14 +1026,32 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)

 	/* Update valid block bitmap */
 	if (del > 0) {
-		if (f2fs_test_and_set_bit(offset, se->cur_valid_map))
+		if (f2fs_test_and_set_bit(offset, se->cur_valid_map)) {
+#ifdef CONFIG_F2FS_CHECK_FS
+			if (f2fs_test_and_set_bit(offset,
+						se->cur_valid_map_mir))
+				f2fs_bug_on(sbi, 1);
+			else
+				WARN_ON(1);
+#else
 			f2fs_bug_on(sbi, 1);
+#endif
+		}
 		if (f2fs_discard_en(sbi) &&
 			!f2fs_test_and_set_bit(offset, se->discard_map))
 			sbi->discard_blks--;
 	} else {
-		if (!f2fs_test_and_clear_bit(offset, se->cur_valid_map))
+		if (!f2fs_test_and_clear_bit(offset, se->cur_valid_map)) {
+#ifdef CONFIG_F2FS_CHECK_FS
+			if (!f2fs_test_and_clear_bit(offset,
+						se->cur_valid_map_mir))
+				f2fs_bug_on(sbi, 1);
+			else
+				WARN_ON(1);
+#else
 			f2fs_bug_on(sbi, 1);
+#endif
+		}
 		if (f2fs_discard_en(sbi) &&
 			f2fs_test_and_clear_bit(offset, se->discard_map))
 			sbi->discard_blks++;
@@ -2357,6 +2375,13 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 				!sit_i->sentries[start].ckpt_valid_map)
 			return -ENOMEM;

+#ifdef CONFIG_F2FS_CHECK_FS
+		sit_i->sentries[start].cur_valid_map_mir
+			= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
+		if (!sit_i->sentries[start].cur_valid_map_mir)
+			return -ENOMEM;
+#endif
+
 		if (f2fs_discard_en(sbi)) {
 			sit_i->sentries[start].discard_map
 				= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
@@ -2786,6 +2811,7 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
 	if (sit_i->sentries) {
 		for (start = 0; start < MAIN_SEGS(sbi); start++) {
 			kfree(sit_i->sentries[start].cur_valid_map);
+			kfree(sit_i->sentries[start].cur_valid_map_mir);
 			kfree(sit_i->sentries[start].ckpt_valid_map);
 			kfree(sit_i->sentries[start].discard_map);
 		}
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 08f1455c812c..9af95194db06 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -164,6 +164,9 @@ struct seg_entry {
 	unsigned int ckpt_valid_blocks:10;	/* # of valid blocks last cp */
 	unsigned int padding:6;		/* padding */
 	unsigned char *cur_valid_map;	/* validity bitmap of blocks */
+#ifdef CONFIG_F2FS_CHECK_FS
+	unsigned char *cur_valid_map_mir;	/* mirror of current valid bitmap */
+#endif
 	/*
 	 * # of valid blocks and the validity bitmap stored in the the last
 	 * checkpoint pack. This information is used by the SSR mode.
@@ -320,6 +323,9 @@ static inline void seg_info_from_raw_sit(struct seg_entry *se,
 	se->ckpt_valid_blocks = GET_SIT_VBLOCKS(rs);
 	memcpy(se->cur_valid_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
 	memcpy(se->ckpt_valid_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
+#ifdef CONFIG_F2FS_CHECK_FS
+	memcpy(se->cur_valid_map_mir, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
+#endif
 	se->type = GET_SIT_TYPE(rs);
 	se->mtime = le64_to_cpu(rs->mtime);
 }
-- 
2.8.2.295.g3f1c1d0



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
