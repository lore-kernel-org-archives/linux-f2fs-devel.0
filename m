From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] fsck.f2fs: update curseg
 .next_blkoff/.alloc_type preferential
Date: Thu, 16 May 2019 20:40:43 +0800
Message-ID: <20190516124043.90103-2-yuchao0@huawei.com>
References: <20190516124043.90103-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hRFhM-0002Ey-BO
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 May 2019 12:41:24 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hRFhD-000pB9-JU
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 May 2019 12:41:19 +0000
In-Reply-To: <20190516124043.90103-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

If .next_blkoff is inconsistent, we can update curseg .next_blkoff
to first unused block address, and change .alloc_type to SSR
preferential, instead of move curseg to other position.

This can help to repair fuzzed image which has no more free segment.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c  | 23 ++++++++++++++++++-----
 fsck/fsck.h  |  1 +
 fsck/mount.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index b10b201..6075d22 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2172,6 +2172,23 @@ int check_curseg_offsets(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
+static void fix_curseg_info(struct f2fs_sb_info *sbi)
+{
+	int i, need_update = 0;
+
+	for (i = 0; i < NO_CHECK_TYPE; i++) {
+		if (check_curseg_offset(sbi, i)) {
+			update_curseg_info(sbi, i);
+			need_update = 1;
+		}
+	}
+
+	if (need_update) {
+		write_curseg_info(sbi);
+		flush_curseg_sit_entries(sbi);
+	}
+}
+
 int check_sit_types(struct f2fs_sb_info *sbi)
 {
 	unsigned int i;
@@ -2760,11 +2777,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 			fix_hard_links(sbi);
 			fix_nat_entries(sbi);
 			rewrite_sit_area_bitmap(sbi);
-			if (check_curseg_offsets(sbi)) {
-				move_curseg_info(sbi, SM_I(sbi)->main_blkaddr, 0);
-				write_curseg_info(sbi);
-				flush_curseg_sit_entries(sbi);
-			}
+			fix_curseg_info(sbi);
 			fix_checksum(sbi);
 			fix_checkpoint(sbi);
 		} else if (is_set_ckpt_flags(cp, CP_FSCK_FLAG) ||
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 72076eb..270597a 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -184,6 +184,7 @@ extern void f2fs_do_umount(struct f2fs_sb_info *);
 extern int f2fs_sparse_initialize_meta(struct f2fs_sb_info *);
 
 extern void flush_journal_entries(struct f2fs_sb_info *);
+extern void update_curseg_info(struct f2fs_sb_info *, int);
 extern void zero_journal_entries(struct f2fs_sb_info *);
 extern void flush_sit_entries(struct f2fs_sb_info *);
 extern void move_curseg_info(struct f2fs_sb_info *, u64, int);
diff --git a/fsck/mount.c b/fsck/mount.c
index f596722..3dd6711 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2169,6 +2169,30 @@ void flush_sit_entries(struct f2fs_sb_info *sbi)
 	free(sit_blk);
 }
 
+int relocate_curseg_offset(struct f2fs_sb_info *sbi, int type)
+{
+	struct curseg_info *curseg = CURSEG_I(sbi, type);
+	struct seg_entry *se = get_seg_entry(sbi, curseg->segno);
+	unsigned int i;
+
+	for (i = 0; i < sbi->blocks_per_seg; i++) {
+		if (!f2fs_test_bit(i, (const char *)se->cur_valid_map))
+			break;
+	}
+
+	if (i == sbi->blocks_per_seg)
+		return -EINVAL;
+
+	DBG(1, "Update curseg[%d].next_blkoff %u -> %u, alloc_type %s -> SSR\n",
+			type, curseg->next_blkoff, i,
+			curseg->alloc_type == LFS ? "LFS" : "SSR");
+
+	curseg->next_blkoff = i;
+	curseg->alloc_type = SSR;
+
+	return 0;
+}
+
 int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
 {
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
@@ -2265,6 +2289,13 @@ void move_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left)
 	}
 }
 
+void update_curseg_info(struct f2fs_sb_info *sbi, int type)
+{
+	if (!relocate_curseg_offset(sbi, type))
+		return;
+	move_curseg_info(sbi, SM_I(sbi)->main_blkaddr, 0);
+}
+
 void zero_journal_entries(struct f2fs_sb_info *sbi)
 {
 	int i;
-- 
2.18.0.rc1
