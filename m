From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: add block count by in-place-update in stat info
Date: Tue, 23 Dec 2014 08:30:54 +0900
Message-ID: <1419291054-7630-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds block count by in-place-update in stat.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/debug.c   | 3 +++
 fs/f2fs/f2fs.h    | 5 ++++-
 fs/f2fs/segment.c | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 91e8f69..46bef86 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -79,6 +79,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 		si->segment_count[i] = sbi->segment_count[i];
 		si->block_count[i] = sbi->block_count[i];
 	}
+
+	si->inplace_count = sbi->inplace_count;
 }
 
 /*
@@ -277,6 +279,7 @@ static int stat_show(struct seq_file *s, void *v)
 		for (j = 0; j < si->util_free; j++)
 			seq_putc(s, '-');
 		seq_puts(s, "]\n\n");
+		seq_printf(s, "IPU: %u blocks\n", si->inplace_count);
 		seq_printf(s, "SSR: %u blocks in %u segments\n",
 			   si->block_count[SSR], si->segment_count[SSR]);
 		seq_printf(s, "LFS: %u blocks in %u segments\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ec58bb2..ae6dfb6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -589,6 +589,7 @@ struct f2fs_sb_info {
 	struct f2fs_stat_info *stat_info;	/* FS status information */
 	unsigned int segment_count[2];		/* # of allocated segments */
 	unsigned int block_count[2];		/* # of allocated blocks */
+	unsigned int inplace_count;		/* # of inplace update */
 	int total_hit_ext, read_hit_ext;	/* extent cache hit ratio */
 	atomic_t inline_inode;			/* # of inline_data inodes */
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
@@ -1514,6 +1515,7 @@ struct f2fs_stat_info {
 
 	unsigned int segment_count[2];
 	unsigned int block_count[2];
+	unsigned int inplace_count;
 	unsigned base_mem, cache_mem;
 };
 
@@ -1553,7 +1555,8 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		((sbi)->segment_count[(curseg)->alloc_type]++)
 #define stat_inc_block_count(sbi, curseg)				\
 		((sbi)->block_count[(curseg)->alloc_type]++)
-
+#define stat_inc_inplace_blocks(sbi)					\
+		((sbi)->inplace_count++)
 #define stat_inc_seg_count(sbi, type)					\
 	do {								\
 		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 42607a6..fd9bc96 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1235,6 +1235,7 @@ void write_data_page(struct page *page, struct dnode_of_data *dn,
 void rewrite_data_page(struct page *page, block_t old_blkaddr,
 					struct f2fs_io_info *fio)
 {
+	stat_inc_inplace_blocks(F2FS_P_SB(page));
 	f2fs_submit_page_mbio(F2FS_P_SB(page), page, old_blkaddr, fio);
 }
 
-- 
1.9.1

