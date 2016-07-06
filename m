From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/6] f2fs: introduce f2fs_set_page_dirty_nobuffer
Date: Wed,  6 Jul 2016 09:06:27 -0700
Message-ID: <20160706160632.78272-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bKpLW-0004rS-L3
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jul 2016 16:06:42 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bKpLV-0007V6-Im
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jul 2016 16:06:42 +0000
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

This patch adds f2fs_set_page_dirty_nobuffer() copied from __set_page_dirty_buffer.
When appending 4KB blocks in f2fs on pmem with multiple cores, this improves the
overall performance.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/data.c       | 33 ++++++++++++++++++++++++++++++++-
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/node.c       |  2 +-
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2b43d40..2755ef7 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -366,7 +366,7 @@ static int f2fs_set_meta_page_dirty(struct page *page)
 
 	SetPageUptodate(page);
 	if (!PageDirty(page)) {
-		__set_page_dirty_nobuffers(page);
+		f2fs_set_page_dirty_nobuffers(page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_META);
 		SetPagePrivate(page);
 		f2fs_trace_pid(page);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3d93cf1..4a2e97d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -19,6 +19,8 @@
 #include <linux/bio.h>
 #include <linux/prefetch.h>
 #include <linux/uio.h>
+#include <linux/mm.h>
+#include <linux/memcontrol.h>
 #include <linux/cleancache.h>
 
 #include "f2fs.h"
@@ -1775,6 +1777,35 @@ int f2fs_release_page(struct page *page, gfp_t wait)
 	return 1;
 }
 
+/*
+ * This was copied from __set_page_dirty_buffers which gives higher performance
+ * in very high speed storages. (e.g., pmem)
+ */
+void f2fs_set_page_dirty_nobuffers(struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+	unsigned long flags;
+
+	if (unlikely(!mapping))
+		return;
+
+	spin_lock(&mapping->private_lock);
+	lock_page_memcg(page);
+	SetPageDirty(page);
+	spin_unlock(&mapping->private_lock);
+
+	spin_lock_irqsave(&mapping->tree_lock, flags);
+	WARN_ON_ONCE(!PageUptodate(page));
+	account_page_dirtied(page, mapping);
+	radix_tree_tag_set(&mapping->page_tree,
+			page_index(page), PAGECACHE_TAG_DIRTY);
+	spin_unlock_irqrestore(&mapping->tree_lock, flags);
+	unlock_page_memcg(page);
+
+	__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
+	return;
+}
+
 static int f2fs_set_data_page_dirty(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
@@ -1797,7 +1828,7 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	}
 
 	if (!PageDirty(page)) {
-		__set_page_dirty_nobuffers(page);
+		f2fs_set_page_dirty_nobuffers(page);
 		update_dirty_page(inode, page);
 		return 1;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bd82b6d..a05f65b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2097,6 +2097,7 @@ struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
 int do_write_data_page(struct f2fs_io_info *);
 int f2fs_map_blocks(struct inode *, struct f2fs_map_blocks *, int, int);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
+void f2fs_set_page_dirty_nobuffers(struct page *);
 void f2fs_invalidate_page(struct page *, unsigned int, unsigned int);
 int f2fs_release_page(struct page *, gfp_t);
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 69171ce..db73f3c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1646,7 +1646,7 @@ static int f2fs_set_node_page_dirty(struct page *page)
 
 	SetPageUptodate(page);
 	if (!PageDirty(page)) {
-		__set_page_dirty_nobuffers(page);
+		f2fs_set_page_dirty_nobuffers(page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
 		SetPagePrivate(page);
 		f2fs_trace_pid(page);
-- 
2.8.3


------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
