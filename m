From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/5] f2fs: add a slab cache entry for small discards
Date: Fri, 15 Nov 2013 14:20:20 +0900
Message-ID: <1384492824-32483-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds a slab cache entry for small discards.

Each entry consists of:

struct discard_entry {
	struct list_head list;	/* list head */
	block_t blkaddr;	/* block address to be discarded */
	int len;		/* # of consecutive blocks of the discard */
};

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h    | 14 ++++++++++++++
 fs/f2fs/segment.c | 20 ++++++++++++++++++++
 fs/f2fs/super.c   |  7 ++++++-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 89dc750..c73e3df 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -97,6 +97,13 @@ struct dir_inode_entry {
 	struct inode *inode;	/* vfs inode pointer */
 };
 
+/* for the list of blockaddresses to be discarded */
+struct discard_entry {
+	struct list_head list;	/* list head */
+	block_t blkaddr;	/* block address to be discarded */
+	int len;		/* # of consecutive blocks of the discard */
+};
+
 /* for the list of fsync inodes, used only during recovery */
 struct fsync_inode_entry {
 	struct list_head list;	/* list head */
@@ -308,6 +315,11 @@ struct f2fs_sm_info {
 
 	/* a threshold to reclaim prefree segments */
 	unsigned int rec_prefree_segments;
+
+	/* for small discard management */
+	struct list_head discard_list;		/* 4KB discard list */
+	int nr_discards;			/* # of discards in the list */
+	int max_discards;			/* max. discards to be issued */
 };
 
 /*
@@ -1079,6 +1091,8 @@ int lookup_journal_in_cursum(struct f2fs_summary_block *,
 void flush_sit_entries(struct f2fs_sb_info *);
 int build_segment_manager(struct f2fs_sb_info *);
 void destroy_segment_manager(struct f2fs_sb_info *);
+int __init create_segment_manager_caches(void);
+void destroy_segment_manager_caches(void);
 
 /*
  * checkpoint.c
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 67f1e5b..823526e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -22,6 +22,8 @@
 
 #define __reverse_ffz(x) __reverse_ffs(~(x))
 
+static struct kmem_cache *discard_entry_slab;
+
 /*
  * __reverse_ffs is copied from include/asm-generic/bitops/__ffs.h since
  * MSB and LSB are reversed in a byte by f2fs_set_bit.
@@ -1798,6 +1800,10 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->ssa_blkaddr = le32_to_cpu(raw_super->ssa_blkaddr);
 	sm_info->rec_prefree_segments = DEF_RECLAIM_PREFREE_SEGMENTS;
 
+	INIT_LIST_HEAD(&sm_info->discard_list);
+	sm_info->nr_discards = 0;
+	sm_info->max_discards = 0;
+
 	err = build_sit_info(sbi);
 	if (err)
 		return err;
@@ -1913,3 +1919,17 @@ void destroy_segment_manager(struct f2fs_sb_info *sbi)
 	sbi->sm_info = NULL;
 	kfree(sm_info);
 }
+
+int __init create_segment_manager_caches(void)
+{
+	discard_entry_slab = f2fs_kmem_cache_create("discard_entry",
+			sizeof(struct discard_entry), NULL);
+	if (!discard_entry_slab)
+		return -ENOMEM;
+	return 0;
+}
+
+void destroy_segment_manager_caches(void)
+{
+	kmem_cache_destroy(discard_entry_slab);
+}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bafff72..e9aa3f7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1078,9 +1078,12 @@ static int __init init_f2fs_fs(void)
 	err = create_node_manager_caches();
 	if (err)
 		goto free_inodecache;
-	err = create_gc_caches();
+	err = create_segment_manager_caches();
 	if (err)
 		goto free_node_manager_caches;
+	err = create_gc_caches();
+	if (err)
+		goto free_segment_manager_caches;
 	err = create_checkpoint_caches();
 	if (err)
 		goto free_gc_caches;
@@ -1102,6 +1105,8 @@ free_checkpoint_caches:
 	destroy_checkpoint_caches();
 free_gc_caches:
 	destroy_gc_caches();
+free_segment_manager_caches:
+	destroy_segment_manager_caches();
 free_node_manager_caches:
 	destroy_node_manager_caches();
 free_inodecache:
-- 
1.8.4.474.g128a96c

