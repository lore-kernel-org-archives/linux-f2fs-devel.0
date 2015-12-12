From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/6] fsck.f2fs: LFS alloc_type must have free
	segment after blkoff
Date: Fri, 11 Dec 2015 16:00:13 -0800
Message-ID: <1449878414-41254-5-git-send-email-jaegeuk@kernel.org>
References: <1449878414-41254-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a7Xc0-0004GR-BR
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 00:00:32 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a7Xbz-00074A-8g for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 00:00:32 +0000
In-Reply-To: <1449878414-41254-1-git-send-email-jaegeuk@kernel.org>
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

This patch checks alloc_type of current segment type.
If it is LFS, the last of segment should have no valid block.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/f2fs.h  | 16 ++++++++++
 fsck/fsck.c  | 15 +++++++++-
 fsck/fsck.h  |  4 +++
 fsck/mount.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 100854e..03a0646 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -354,6 +354,22 @@ static inline bool IS_VALID_BLK_ADDR(struct f2fs_sb_info *sbi, u32 addr)
 	return 1;
 }
 
+static inline int IS_CUR_SEGNO(struct f2fs_sb_info *sbi, u32 segno, int type)
+{
+	int i;
+
+	for (i = 0; i < NO_CHECK_TYPE; i++) {
+		struct curseg_info *curseg = CURSEG_I(sbi, i);
+
+		if (type == i)
+			continue;
+
+		if (segno == curseg->segno)
+			return 1;
+	}
+	return 0;
+}
+
 static inline u64 BLKOFF_FROM_MAIN(struct f2fs_sb_info *sbi, u64 blk_addr)
 {
 	ASSERT(blk_addr >= SM_I(sbi)->main_blkaddr);
diff --git a/fsck/fsck.c b/fsck/fsck.c
index adc61d2..1b55c30 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1368,13 +1368,24 @@ int check_curseg_offset(struct f2fs_sb_info *sbi)
 	for (i = 0; i < NO_CHECK_TYPE; i++) {
 		struct curseg_info *curseg = CURSEG_I(sbi, i);
 		struct seg_entry *se;
+		int j, nblocks;
 
 		se = get_seg_entry(sbi, curseg->segno);
 		if (f2fs_test_bit(curseg->next_blkoff,
-				(const char *)se->cur_valid_map) == 1) {
+					(const char *)se->cur_valid_map)) {
 			ASSERT_MSG("Next block offset is not free, type:%d", i);
 			return -EINVAL;
 		}
+		if (curseg->alloc_type == SSR)
+			return 0;
+
+		nblocks = sbi->blocks_per_seg;
+		for (j = curseg->next_blkoff + 1; j < nblocks; j++) {
+			if (f2fs_test_bit(j, (const char *)se->cur_valid_map)) {
+				ASSERT_MSG("LFS must have free section:%d", i);
+				return -EINVAL;
+			}
+		}
 	}
 	return 0;
 }
@@ -1528,6 +1539,8 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	if (force || (config.bug_on && config.fix_on && !config.ro)) {
 		fix_hard_links(sbi);
 		fix_nat_entries(sbi);
+		move_curseg_info(sbi, SM_I(sbi)->main_blkaddr);
+		write_curseg_info(sbi);
 		rewrite_sit_area_bitmap(sbi);
 		fix_checkpoint(sbi);
 	}
diff --git a/fsck/fsck.h b/fsck/fsck.h
index f6b8c53..4876914 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -132,6 +132,10 @@ extern void fsck_free(struct f2fs_sb_info *);
 extern int f2fs_do_mount(struct f2fs_sb_info *);
 extern void f2fs_do_umount(struct f2fs_sb_info *);
 
+extern void move_curseg_info(struct f2fs_sb_info *, u64);
+extern void write_curseg_info(struct f2fs_sb_info *);
+extern int find_next_free_block(struct f2fs_sb_info *, u64 *, int, int);
+
 extern void print_raw_sb_info(struct f2fs_super_block *);
 
 /* dump.c */
diff --git a/fsck/mount.c b/fsck/mount.c
index 99e2439..970b159 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1133,6 +1133,103 @@ void rewrite_sit_area_bitmap(struct f2fs_sb_info *sbi)
 	}
 }
 
+int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
+{
+	struct seg_entry *se;
+	u32 segno;
+	u64 offset;
+
+	while (*to >= SM_I(sbi)->main_blkaddr &&
+			*to < F2FS_RAW_SUPER(sbi)->block_count) {
+		segno = GET_SEGNO(sbi, *to);
+		offset = OFFSET_IN_SEG(sbi, *to);
+
+		se = get_seg_entry(sbi, segno);
+
+		if (se->valid_blocks == sbi->blocks_per_seg)
+			goto next;
+
+		if (se->valid_blocks == 0 && !(segno % sbi->segs_per_sec) &&
+					!IS_CUR_SEGNO(sbi, segno, type)) {
+			struct seg_entry *se2;
+			int i;
+
+			for (i = 0; i < sbi->segs_per_sec; i++) {
+				se2 = get_seg_entry(sbi, segno + i);
+				if (se2->valid_blocks)
+					break;
+			}
+			if (i == sbi->segs_per_sec)
+				return 0;
+		}
+
+		if (se->type == type &&
+			!f2fs_test_bit(offset, (const char *)se->cur_valid_map))
+			return 0;
+next:
+		*to = left ? *to - 1: *to + 1;
+	}
+	return -1;
+}
+
+void move_curseg_info(struct f2fs_sb_info *sbi, u64 from)
+{
+	int i, ret;
+
+	/* update summary blocks having nullified journal entries */
+	for (i = 0; i < NO_CHECK_TYPE; i++) {
+		struct curseg_info *curseg = CURSEG_I(sbi, i);
+		u32 old_segno;
+		u64 ssa_blk, to;
+
+		/* update original SSA too */
+		ssa_blk = GET_SUM_BLKADDR(sbi, curseg->segno);
+		ret = dev_write_block(curseg->sum_blk, ssa_blk);
+		ASSERT(ret >= 0);
+
+		to = from;
+		ret = find_next_free_block(sbi, &to, 0, i);
+		ASSERT(ret == 0);
+
+		old_segno = curseg->segno;
+		curseg->segno = GET_SEGNO(sbi, to);
+		curseg->next_blkoff = OFFSET_IN_SEG(sbi, to);
+		curseg->alloc_type = SSR;
+
+		/* update new segno */
+		ssa_blk = GET_SUM_BLKADDR(sbi, curseg->segno);
+		ret = dev_read_block(curseg->sum_blk, ssa_blk);
+		ASSERT(ret >= 0);
+
+		/* update se->types */
+		reset_curseg(sbi, i);
+
+		DBG(0, "Move curseg[%d] %x -> %x after %"PRIx64"\n",
+				i, old_segno, curseg->segno, from);
+	}
+}
+
+void write_curseg_info(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+	int i;
+
+	for (i = 0; i < NO_CHECK_TYPE; i++) {
+		cp->alloc_type[i] = CURSEG_I(sbi, i)->alloc_type;
+		if (i < CURSEG_HOT_NODE) {
+			set_cp(cur_data_segno[i], CURSEG_I(sbi, i)->segno);
+			set_cp(cur_data_blkoff[i],
+					CURSEG_I(sbi, i)->next_blkoff);
+		} else {
+			int n = i - CURSEG_HOT_NODE;
+
+			set_cp(cur_node_segno[n], CURSEG_I(sbi, i)->segno);
+			set_cp(cur_node_blkoff[n],
+					CURSEG_I(sbi, i)->next_blkoff);
+		}
+	}
+}
+
 int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid,
 					struct f2fs_nat_entry *raw_nat)
 {
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
