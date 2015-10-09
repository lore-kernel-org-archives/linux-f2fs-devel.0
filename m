From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] Revert "f2fs: do not skip dentry block writes"
Date: Thu,  8 Oct 2015 17:29:26 -0700
Message-ID: <1444350566-37795-2-git-send-email-jaegeuk@kernel.org>
References: <1444350566-37795-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444350566-37795-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The periodic checkpoint can resolve the previous issue.
So, now we can use this again to improve the reported performance regression:

https://lkml.org/lkml/2015/10/8/20

This reverts commit 15bec0ff5a9ba6d203178fa8772259df6207942a.
---
 fs/f2fs/data.c    | 5 +++++
 fs/f2fs/node.c    | 5 +++++
 fs/f2fs/node.h    | 1 +
 fs/f2fs/segment.h | 4 +++-
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a903423..bc04e92 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1340,6 +1340,11 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	if (!get_dirty_pages(inode) && wbc->sync_mode == WB_SYNC_NONE)
 		return 0;
 
+	if (S_ISDIR(inode->i_mode) && wbc->sync_mode == WB_SYNC_NONE &&
+			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
+			available_free_memory(sbi, DIRTY_DENTS))
+		goto skip_write;
+
 	/* during POR, we don't need to trigger writepage at all. */
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto skip_write;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1fe49ca..4d9bedf 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -52,6 +52,11 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 		mem_size = (nm_i->nat_cnt * sizeof(struct nat_entry)) >>
 							PAGE_CACHE_SHIFT;
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
+	} else if (type == DIRTY_DENTS) {
+		if (sbi->sb->s_bdi->wb.dirty_exceeded)
+			return false;
+		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
+		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
 	} else if (type == INO_ENTRIES) {
 		int i;
 
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 51c62ed..7427e95 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -118,6 +118,7 @@ static inline void raw_nat_from_node_info(struct f2fs_nat_entry *raw_ne,
 enum mem_type {
 	FREE_NIDS,	/* indicates the free nid list */
 	NAT_ENTRIES,	/* indicates the cached nat entry */
+	DIRTY_DENTS,	/* indicates dirty dentry pages */
 	INO_ENTRIES,	/* indicates inode entries */
 	EXTENT_CACHE,	/* indicates extent cache */
 	BASE_CHECK,	/* check kernel status */
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index e9afb58..ee44d34 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -699,7 +699,9 @@ static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 	if (sbi->sb->s_bdi->wb.dirty_exceeded)
 		return 0;
 
-	if (type == NODE)
+	if (type == DATA)
+		return sbi->blocks_per_seg;
+	else if (type == NODE)
 		return 3 * sbi->blocks_per_seg;
 	else if (type == META)
 		return MAX_BIO_BLOCKS(sbi);
-- 
2.1.1
