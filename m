From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 01/09] f2fs: do not make dirty any inmemory pages
Date: Sun, 19 Oct 2014 22:18:24 -0700
Message-ID: <1413782312-11631-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xg5Mf-0004s7-Hv
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:18:41 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xg5Me-0005La-99 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:18:41 +0000
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

This patch let inmemory pages be clean all the time.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    | 11 +++++++----
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 14 +++++++++++++-
 fs/f2fs/super.c   |  1 +
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8e58c4c..84f20e9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1052,10 +1052,7 @@ static int f2fs_write_end(struct file *file,
 
 	trace_f2fs_write_end(inode, pos, len, copied);
 
-	if (f2fs_is_atomic_file(inode) || f2fs_is_volatile_file(inode))
-		register_inmem_page(inode, page);
-	else
-		set_page_dirty(page);
+	set_page_dirty(page);
 
 	if (pos + copied > i_size_read(inode)) {
 		i_size_write(inode, pos + copied);
@@ -1138,6 +1135,12 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	trace_f2fs_set_page_dirty(page, DATA);
 
 	SetPageUptodate(page);
+
+	if (f2fs_is_atomic_file(inode) || f2fs_is_volatile_file(inode)) {
+		register_inmem_page(inode, page);
+		return 1;
+	}
+
 	mark_inode_dirty(inode);
 
 	if (!PageDirty(page)) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8171e80..28f24ea 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -269,6 +269,7 @@ struct f2fs_inode_info {
 	struct extent_info ext;		/* in-memory extent cache entry */
 	struct dir_inode_entry *dirty_dir;	/* the pointer of dirty dir */
 
+	struct radix_tree_root inmem_root;	/* radix tree for inmem pages */
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
 };
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 923cb76..9d4a7ab 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -178,7 +178,8 @@ void register_inmem_page(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct inmem_pages *new;
-
+	int err;
+retry:
 	new = f2fs_kmem_cache_alloc(inmem_entry_slab, GFP_NOFS);
 
 	/* add atomic page indices to the list */
@@ -187,6 +188,16 @@ void register_inmem_page(struct inode *inode, struct page *page)
 
 	/* increase reference count with clean state */
 	mutex_lock(&fi->inmem_lock);
+	err = radix_tree_insert(&fi->inmem_root, page->index, new);
+	if (err == -EEXIST) {
+		mutex_unlock(&fi->inmem_lock);
+		kmem_cache_free(inmem_entry_slab, new);
+		return;
+	} else if (err) {
+		mutex_unlock(&fi->inmem_lock);
+		kmem_cache_free(inmem_entry_slab, new);
+		goto retry;
+	}
 	get_page(page);
 	list_add_tail(&new->list, &fi->inmem_pages);
 	mutex_unlock(&fi->inmem_lock);
@@ -216,6 +227,7 @@ void commit_inmem_pages(struct inode *inode, bool abort)
 			do_write_data_page(cur->page, &fio);
 			submit_bio = true;
 		}
+		radix_tree_delete(&fi->inmem_root, cur->page->index);
 		f2fs_put_page(cur->page, 1);
 		list_del(&cur->list);
 		kmem_cache_free(inmem_entry_slab, cur);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 41d6f70..76b14c8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -373,6 +373,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	fi->i_advise = 0;
 	rwlock_init(&fi->ext.ext_lock);
 	init_rwsem(&fi->i_sem);
+	INIT_RADIX_TREE(&fi->inmem_root, GFP_NOFS);
 	INIT_LIST_HEAD(&fi->inmem_pages);
 	mutex_init(&fi->inmem_lock);
 
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
