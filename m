From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add block count by in-place-update in
 stat	info
Date: Tue, 23 Dec 2014 17:22:30 +0900
Message-ID: <20141223082230.GD3335@lcm>
References: <1419291054-7630-1-git-send-email-cm224.lee@samsung.com>
 <003301d01e7e$ab0d42f0$0127c8d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <003301d01e7e$ab0d42f0$0127c8d0$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change from v1
 o use atomic_t inplace_count for more accurate suggested by Chao

-- >8 --

>From 7a42b27c8df45494e806d625be03830bfa8c30ff Mon Sep 17 00:00:00 2001
From: Changman Lee <cm224.lee@samsung.com>
Date: Wed, 24 Dec 2014 02:16:54 +0900
Subject: [PATCH] f2fs: add block count by in-place-update in stat info

This patch adds block count by in-place-update in stat.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/debug.c   | 4 ++++
 fs/f2fs/f2fs.h    | 5 ++++-
 fs/f2fs/segment.c | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 91e8f69..2b64221 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -79,6 +79,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 		si->segment_count[i] = sbi->segment_count[i];
 		si->block_count[i] = sbi->block_count[i];
 	}
+
+	si->inplace_count = atomic_read(&sbi->inplace_count);
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
@@ -331,6 +334,7 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 
 	atomic_set(&sbi->inline_inode, 0);
 	atomic_set(&sbi->inline_dir, 0);
+	atomic_set(&sbi->inplace_count, 0);
 
 	mutex_lock(&f2fs_stat_mutex);
 	list_add_tail(&si->stat_list, &f2fs_stat_list);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ec58bb2..72d2aab 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -589,6 +589,7 @@ struct f2fs_sb_info {
 	struct f2fs_stat_info *stat_info;	/* FS status information */
 	unsigned int segment_count[2];		/* # of allocated segments */
 	unsigned int block_count[2];		/* # of allocated blocks */
+	atomic_t inplace_count;		/* # of inplace update */
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
+		(atomic_inc(&(sbi)->inplace_count))
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

