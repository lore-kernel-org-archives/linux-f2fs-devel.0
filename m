From: Liu Xue <liuxueliu.liu@huawei.com>
Subject: [PATCH] fsck.f2fs: flush curseg sit entries
Date: Wed, 23 Nov 2016 20:40:06 +0800
Message-ID: <20161123124006.21516-1-liuxueliu.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuxueliu.liu@huawei.com>) id 1c9Wb6-0001RC-S0
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Nov 2016 12:24:20 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c9Wb4-0002qx-Bo
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Nov 2016 12:24:20 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, zhengjunling@huawei.com, shengyong1@huawei.com, liuxueliu.liu@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Flush curseg sit entries, since type of sit entries may
be changed after move_curseg_info.

Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
---
 fsck/fsck.c  | 25 +++++++++++++++++++++++++
 fsck/fsck.h  |  4 ++++
 fsck/mount.c |  2 +-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 0009ea4..7a536b2 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1729,6 +1729,30 @@ static void fix_nat_entries(struct f2fs_sb_info *sbi)
 			nullify_nat_entry(sbi, i);
 }
 
+static void flush_curseg_sit_entries(struct f2fs_sb_info *sbi)
+{
+	struct sit_info *sit_i = SIT_I(sbi);
+	int i;
+
+	/* update curseg sit entries, since we may change
+	 * a segment type in move_curseg_info
+	 */
+	for (i = 0; i < NO_CHECK_TYPE; i++) {
+		struct curseg_info *curseg = CURSEG_I(sbi, i);
+		struct f2fs_sit_block *sit_blk;
+		struct f2fs_sit_entry *sit;
+		struct seg_entry *se;
+
+		se = get_seg_entry(sbi, curseg->segno);
+		sit_blk = get_current_sit_page(sbi, curseg->segno);
+		sit = &sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, curseg->segno)];
+		sit->vblocks = cpu_to_le16((se->type << SIT_VBLOCKS_SHIFT) |
+							se->valid_blocks);
+		rewrite_current_sit_page(sbi, curseg->segno, sit_blk);
+		free(sit_blk);
+	}
+}
+
 static void fix_checkpoint(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
@@ -1982,6 +2006,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 			rewrite_sit_area_bitmap(sbi);
 			move_curseg_info(sbi, SM_I(sbi)->main_blkaddr);
 			write_curseg_info(sbi);
+			flush_curseg_sit_entries(sbi);
 			fix_checkpoint(sbi);
 		} else if (is_set_ckpt_flags(cp, CP_FSCK_FLAG)) {
 			write_checkpoint(sbi);
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 412e7b7..c106153 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -165,6 +165,10 @@ extern void update_nat_blkaddr(struct f2fs_sb_info *, nid_t, nid_t, block_t);
 extern void print_raw_sb_info(struct f2fs_super_block *);
 
 extern u32 get_free_segments(struct f2fs_sb_info *);
+extern struct f2fs_sit_block *get_current_sit_page(struct f2fs_sb_info *,
+			unsigned int);
+extern void rewrite_current_sit_page(struct f2fs_sb_info *, unsigned int,
+			struct f2fs_sit_block *);
 
 /* dump.c */
 struct dump_option {
diff --git a/fsck/mount.c b/fsck/mount.c
index 9fcb008..e7d5cee 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1018,7 +1018,7 @@ static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
 	ASSERT(segno <= end_segno);
 }
 
-static struct f2fs_sit_block *get_current_sit_page(struct f2fs_sb_info *sbi,
+struct f2fs_sit_block *get_current_sit_page(struct f2fs_sb_info *sbi,
 						unsigned int segno)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-- 
1.8.5.2


------------------------------------------------------------------------------
