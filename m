From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: use __set_page_dirty_nobuffers directly
Date: Thu, 20 Oct 2016 19:28:46 -0700
Message-ID: <20161021022847.55629-2-jaegeuk@kernel.org>
References: <20161021022847.55629-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bxPZs-00004z-7F
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Oct 2016 02:29:00 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bxPZr-0004t4-Hu
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Oct 2016 02:29:00 +0000
In-Reply-To: <20161021022847.55629-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch replaces the copied code with original generic function.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 29 -----------------------------
 fs/f2fs/f2fs.h |  6 +++++-
 2 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 68edb47..3954315 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1801,35 +1801,6 @@ int f2fs_release_page(struct page *page, gfp_t wait)
 	return 1;
 }
 
-/*
- * This was copied from __set_page_dirty_buffers which gives higher performance
- * in very high speed storages. (e.g., pmem)
- */
-void f2fs_set_page_dirty_nobuffers(struct page *page)
-{
-	struct address_space *mapping = page->mapping;
-	unsigned long flags;
-
-	if (unlikely(!mapping))
-		return;
-
-	spin_lock(&mapping->private_lock);
-	lock_page_memcg(page);
-	SetPageDirty(page);
-	spin_unlock(&mapping->private_lock);
-
-	spin_lock_irqsave(&mapping->tree_lock, flags);
-	WARN_ON_ONCE(!PageUptodate(page));
-	account_page_dirtied(page, mapping);
-	radix_tree_tag_set(&mapping->page_tree,
-			page_index(page), PAGECACHE_TAG_DIRTY);
-	spin_unlock_irqrestore(&mapping->tree_lock, flags);
-	unlock_page_memcg(page);
-
-	__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
-	return;
-}
-
 static int f2fs_set_data_page_dirty(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 168f939..b66a04c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1960,6 +1960,11 @@ static inline unsigned long f2fs_find_next_bit(const void *addr,
 	return find_next_bit(addr, size, offset + 2);
 }
 
+static inline void f2fs_set_page_dirty_nobuffers(struct page *page)
+{
+	__set_page_dirty_nobuffers(page);
+}
+
 #define get_inode_mode(i) \
 	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
@@ -2200,7 +2205,6 @@ struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
 int do_write_data_page(struct f2fs_io_info *);
 int f2fs_map_blocks(struct inode *, struct f2fs_map_blocks *, int, int);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
-void f2fs_set_page_dirty_nobuffers(struct page *);
 void f2fs_invalidate_page(struct page *, unsigned int, unsigned int);
 int f2fs_release_page(struct page *, gfp_t);
 #ifdef CONFIG_MIGRATION
-- 
2.8.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
