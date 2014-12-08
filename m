From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH] f2fs: use atomic for counting inode with
 inline_{dir,inode} flag
Date: Mon, 08 Dec 2014 19:08:20 +0800
Message-ID: <002201d012d7$63ac9df0$2b05d9d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

As inline_{dir,inode} stat is increased/decreased concurrently by multi threads,
so the value is not so accurate, let's use atomic type for counting accurately.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/debug.c |  7 +++++--
 fs/f2fs/f2fs.h  | 12 ++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 4e2e39c..91e8f69 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -46,8 +46,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->valid_count = valid_user_blocks(sbi);
 	si->valid_node_count = valid_node_count(sbi);
 	si->valid_inode_count = valid_inode_count(sbi);
-	si->inline_inode = sbi->inline_inode;
-	si->inline_dir = sbi->inline_dir;
+	si->inline_inode = atomic_read(&sbi->inline_inode);
+	si->inline_dir = atomic_read(&sbi->inline_dir);
 	si->utilization = utilization(sbi);
 
 	si->free_segs = free_segments(sbi);
@@ -329,6 +329,9 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	si->sbi = sbi;
 	sbi->stat_info = si;
 
+	atomic_set(&sbi->inline_inode, 0);
+	atomic_set(&sbi->inline_dir, 0);
+
 	mutex_lock(&f2fs_stat_mutex);
 	list_add_tail(&si->stat_list, &f2fs_stat_list);
 	mutex_unlock(&f2fs_stat_mutex);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f60b817..2695d78 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -590,8 +590,8 @@ struct f2fs_sb_info {
 	unsigned int segment_count[2];		/* # of allocated segments */
 	unsigned int block_count[2];		/* # of allocated blocks */
 	int total_hit_ext, read_hit_ext;	/* extent cache hit ratio */
-	int inline_inode;			/* # of inline_data inodes */
-	int inline_dir;				/* # of inline_dentry inodes */
+	atomic_t inline_inode;			/* # of inline_data inodes */
+	atomic_t inline_dir;			/* # of inline_dentry inodes */
 	int bg_gc;				/* background gc calls */
 	unsigned int n_dirty_dirs;		/* # of dir inodes */
 #endif
@@ -1532,22 +1532,22 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_inc_inline_inode(inode)					\
 	do {								\
 		if (f2fs_has_inline_data(inode))			\
-			((F2FS_I_SB(inode))->inline_inode++);		\
+			(atomic_inc(&F2FS_I_SB(inode)->inline_inode));	\
 	} while (0)
 #define stat_dec_inline_inode(inode)					\
 	do {								\
 		if (f2fs_has_inline_data(inode))			\
-			((F2FS_I_SB(inode))->inline_inode--);		\
+			(atomic_dec(&F2FS_I_SB(inode)->inline_inode));	\
 	} while (0)
 #define stat_inc_inline_dir(inode)					\
 	do {								\
 		if (f2fs_has_inline_dentry(inode))			\
-			((F2FS_I_SB(inode))->inline_dir++);		\
+			(atomic_inc(&F2FS_I_SB(inode)->inline_dir));	\
 	} while (0)
 #define stat_dec_inline_dir(inode)					\
 	do {								\
 		if (f2fs_has_inline_dentry(inode))			\
-			((F2FS_I_SB(inode))->inline_dir--);		\
+			(atomic_dec(&F2FS_I_SB(inode)->inline_dir));	\
 	} while (0)
 #define stat_inc_seg_type(sbi, curseg)					\
 		((sbi)->segment_count[(curseg)->alloc_type]++)
-- 
2.1.2
