From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: clean up with
 clear_radix_tree_dirty_tag
Date: Sat, 26 May 2018 18:03:35 +0800
Message-ID: <20180526100335.63001-2-yuchao0@huawei.com>
References: <20180526100335.63001-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fMW3X-000213-FE
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 26 May 2018 10:04:11 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fMW3V-004RUU-H9
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 26 May 2018 10:04:11 +0000
In-Reply-To: <20180526100335.63001-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Introduce clear_radix_tree_dirty_tag to include common codes for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c   | 11 +++++++++++
 fs/f2fs/dir.c    |  8 +-------
 fs/f2fs/f2fs.h   |  1 +
 fs/f2fs/inline.c |  7 +------
 fs/f2fs/node.c   | 12 ++----------
 5 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 98a12526e3d0..9d3e2e1c1e33 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2594,6 +2594,17 @@ const struct address_space_operations f2fs_dblock_aops = {
 #endif
 };
 
+void clear_radix_tree_dirty_tag(struct page *page)
+{
+	struct address_space *mapping = page_mapping(page);
+	unsigned long flags;
+
+	xa_lock_irqsave(&mapping->i_pages, flags);
+	radix_tree_tag_clear(&mapping->i_pages, page_index(page),
+						PAGECACHE_TAG_DIRTY);
+	xa_unlock_irqrestore(&mapping->i_pages, flags);
+}
+
 int __init f2fs_init_post_read_processing(void)
 {
 	bio_post_read_ctx_cache = KMEM_CACHE(bio_post_read_ctx, 0);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8c9c2f31b253..e20539ba0554 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -698,8 +698,6 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	struct	f2fs_dentry_block *dentry_blk;
 	unsigned int bit_pos;
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
-	struct address_space *mapping = page_mapping(page);
-	unsigned long flags;
 	int i;
 
 	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
@@ -732,11 +730,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 
 	if (bit_pos == NR_DENTRY_IN_BLOCK &&
 			!truncate_hole(dir, page->index, page->index + 1)) {
-		xa_lock_irqsave(&mapping->i_pages, flags);
-		radix_tree_tag_clear(&mapping->i_pages, page_index(page),
-				     PAGECACHE_TAG_DIRTY);
-		xa_unlock_irqrestore(&mapping->i_pages, flags);
-
+		clear_radix_tree_dirty_tag(page);
 		clear_page_dirty_for_io(page);
 		ClearPagePrivate(page);
 		ClearPageUptodate(page);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 659c63dae81c..da43959b725a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2966,6 +2966,7 @@ int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
 			struct page *page, enum migrate_mode mode);
 #endif
 bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len);
+void clear_radix_tree_dirty_tag(struct page *page);
 
 /*
  * gc.c
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 1eaa2049eafa..83e6881fd21e 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -204,8 +204,6 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 {
 	void *src_addr, *dst_addr;
 	struct dnode_of_data dn;
-	struct address_space *mapping = page_mapping(page);
-	unsigned long flags;
 	int err;
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
@@ -227,10 +225,7 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	kunmap_atomic(src_addr);
 	set_page_dirty(dn.inode_page);
 
-	xa_lock_irqsave(&mapping->i_pages, flags);
-	radix_tree_tag_clear(&mapping->i_pages, page_index(page),
-			     PAGECACHE_TAG_DIRTY);
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
+	clear_radix_tree_dirty_tag(page);
 
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	set_inode_flag(inode, FI_DATA_EXIST);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 67b3e89975af..59041acbf7ac 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -102,18 +102,10 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 
 static void clear_node_page_dirty(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
-	unsigned int long flags;
-
 	if (PageDirty(page)) {
-		xa_lock_irqsave(&mapping->i_pages, flags);
-		radix_tree_tag_clear(&mapping->i_pages,
-				page_index(page),
-				PAGECACHE_TAG_DIRTY);
-		xa_unlock_irqrestore(&mapping->i_pages, flags);
-
+		clear_radix_tree_dirty_tag(page);
 		clear_page_dirty_for_io(page);
-		dec_page_count(F2FS_M_SB(mapping), F2FS_DIRTY_NODES);
+		dec_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
 	}
 	ClearPageUptodate(page);
 }
-- 
2.17.0.391.g1f1cddd558b5


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
