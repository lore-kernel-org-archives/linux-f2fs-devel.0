From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 1/2] f2fs: add help function META_MAPPING
Date: Mon, 20 Jan 2014 18:37:04 +0800
Message-ID: <52DCFC50.5060807@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Kim <jaegeuk.kim@samsung.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Introduce help function META_MAPPING() to get the cache meta blocks'
address space.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/checkpoint.c |    8 ++++----
 fs/f2fs/debug.c      |    4 ++--
 fs/f2fs/f2fs.h       |    5 +++++
 fs/f2fs/node.c       |    2 +-
 fs/f2fs/segment.c    |    2 +-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4de0345..f9d4f7d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -30,7 +30,7 @@ static struct kmem_cache *inode_entry_slab;
  */
 struct page *grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 {
-	struct address_space *mapping = sbi->meta_inode->i_mapping;
+	struct address_space *mapping = META_MAPPING(sbi);
 	struct page *page = NULL;
 repeat:
 	page = grab_cache_page(mapping, index);
@@ -50,7 +50,7 @@ repeat:
  */
 struct page *get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 {
-	struct address_space *mapping = sbi->meta_inode->i_mapping;
+	struct address_space *mapping = META_MAPPING(sbi);
 	struct page *page;
 repeat:
 	page = grab_cache_page(mapping, index);
@@ -128,7 +128,7 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 						long nr_to_write)
 {
-	struct address_space *mapping = sbi->meta_inode->i_mapping;
+	struct address_space *mapping = META_MAPPING(sbi);
 	pgoff_t index = 0, end = LONG_MAX;
 	struct pagevec pvec;
 	long nwritten = 0;
@@ -771,7 +771,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	wait_on_all_pages_writeback(sbi);
 
 	filemap_fdatawait_range(sbi->node_inode->i_mapping, 0, LONG_MAX);
-	filemap_fdatawait_range(sbi->meta_inode->i_mapping, 0, LONG_MAX);
+	filemap_fdatawait_range(META_MAPPING(sbi), 0, LONG_MAX);
 
 	/* update user_block_counts */
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 63cb7e2..8bdc365 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -53,7 +53,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->prefree_count = prefree_segments(sbi);
 	si->dirty_count = dirty_segments(sbi);
 	si->node_pages = sbi->node_inode->i_mapping->nrpages;
-	si->meta_pages = sbi->meta_inode->i_mapping->nrpages;
+	si->meta_pages = META_MAPPING(sbi)->nrpages;
 	si->nats = NM_I(sbi)->nat_cnt;
 	si->sits = SIT_I(sbi)->dirty_sentries;
 	si->fnids = NM_I(sbi)->fcnt;
@@ -168,7 +168,7 @@ get_cache:
 	si->cache_mem += NM_I(sbi)->nat_cnt;
 	npages = sbi->node_inode->i_mapping->nrpages;
 	si->cache_mem += npages << PAGE_CACHE_SHIFT;
-	npages = sbi->meta_inode->i_mapping->nrpages;
+	npages = META_MAPPING(sbi)->nrpages;
 	si->cache_mem += npages << PAGE_CACHE_SHIFT;
 	si->cache_mem += sbi->n_orphans * sizeof(struct orphan_inode_entry);
 	si->cache_mem += sbi->n_dirty_dirs * sizeof(struct dir_inode_entry);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5ab3981..117e30f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -533,6 +533,11 @@ static inline struct dirty_seglist_info *DIRTY_I(struct f2fs_sb_info *sbi)
 	return (struct dirty_seglist_info *)(SM_I(sbi)->dirty_info);
 }
 
+static inline struct address_space *META_MAPPING(struct f2fs_sb_info *sbi)
+{
+	return sbi->meta_inode->i_mapping;
+}
+
 static inline void F2FS_SET_SB_DIRT(struct f2fs_sb_info *sbi)
 {
 	sbi->s_dirty = 1;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 226a05a..527bd12 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -87,7 +87,7 @@ static struct page *get_next_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
  */
 static void ra_nat_pages(struct f2fs_sb_info *sbi, int nid)
 {
-	struct address_space *mapping = sbi->meta_inode->i_mapping;
+	struct address_space *mapping = META_MAPPING(sbi);
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct page *page;
 	pgoff_t index;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e82423fb..7caac5f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1585,7 +1585,7 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 
 static int ra_sit_pages(struct f2fs_sb_info *sbi, int start, int nrpages)
 {
-	struct address_space *mapping = sbi->meta_inode->i_mapping;
+	struct address_space *mapping = META_MAPPING(sbi);
 	struct page *page;
 	block_t blk_addr, prev_blk_addr = 0;
 	int sit_blk_cnt = SIT_BLK_CNT(sbi);
-- 
1.7.7

