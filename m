From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH] f2fs: clean up the needless end 'return' of void function
Date: Fri, 09 Aug 2013 18:21:24 +0800
Message-ID: <5204C2A4.5060601@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Kim <jaegeuk.kim@samsung.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net


Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/data.c    |    1 -
 fs/f2fs/node.c    |    1 -
 fs/f2fs/segment.c |    4 ----
 fs/f2fs/super.c   |    1 -
 4 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a7eb529..ea3cb29 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -176,7 +176,6 @@ void update_extent_cache(block_t blk_addr, struct dnode_of_data *dn)
 end_update:
 	write_unlock(&fi->ext.ext_lock);
 	sync_inode_page(dn);
-	return;
 }
 
 struct page *find_data_page(struct inode *inode, pgoff_t index, bool sync)
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f5172e2..bb8fbda 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -916,7 +916,6 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 		f2fs_put_page(apage, 0);
 	else if (err == LOCKED_PAGE)
 		f2fs_put_page(apage, 1);
-	return;
 }
 
 struct page *get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 68e344f..9c45b8e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -117,7 +117,6 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 	}
 
 	mutex_unlock(&dirty_i->seglist_lock);
-	return;
 }
 
 /*
@@ -261,7 +260,6 @@ static void __add_sum_entry(struct f2fs_sb_info *sbi, int type,
 	void *addr = curseg->sum_blk;
 	addr += curseg->next_blkoff * sizeof(struct f2fs_summary);
 	memcpy(addr, sum, sizeof(struct f2fs_summary));
-	return;
 }
 
 /*
@@ -559,7 +557,6 @@ out:
 #ifdef CONFIG_F2FS_STAT_FS
 	sbi->segment_count[curseg->alloc_type]++;
 #endif
-	return;
 }
 
 void allocate_new_segments(struct f2fs_sb_info *sbi)
@@ -1192,7 +1189,6 @@ void write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
 {
 	if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_UMOUNT_FLAG))
 		write_normal_summaries(sbi, start_blk, CURSEG_HOT_NODE);
-	return;
 }
 
 int lookup_journal_in_cursum(struct f2fs_summary_block *sum, int type,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 94c0e20..9e494d4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -318,7 +318,6 @@ static int f2fs_drop_inode(struct inode *inode)
 static void f2fs_dirty_inode(struct inode *inode, int flags)
 {
 	set_inode_flag(F2FS_I(inode), FI_DIRTY_INODE);
-	return;
 }
 
 static void f2fs_i_callback(struct rcu_head *head)
-- 
1.7.7

