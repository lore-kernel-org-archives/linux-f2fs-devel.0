From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: split drop_inmem_pages from
	commit_inmem_pages
Date: Sat, 06 Feb 2016 14:38:29 +0800
Message-ID: <023301d160a9$158321f0$408965d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aRwWa-0003du-BG
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Feb 2016 06:39:16 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aRwWY-0004bH-J4
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Feb 2016 06:39:16 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O2400H1E557A630@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Feb 2016 15:39:07 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Split drop_inmem_pages from commit_inmem_pages for code readability,
and prepare for the following modification.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h    |   3 +-
 fs/f2fs/file.c    |   6 ++--
 fs/f2fs/inode.c   |   2 +-
 fs/f2fs/segment.c | 103 +++++++++++++++++++++++++++++++++---------------------
 fs/f2fs/super.c   |   2 +-
 5 files changed, 70 insertions(+), 46 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f6a841b..111e2e1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1830,7 +1830,8 @@ void destroy_node_manager_caches(void);
  * segment.c
  */
 void register_inmem_page(struct inode *, struct page *);
-int commit_inmem_pages(struct inode *, bool);
+void drop_inmem_pages(struct inode *);
+int commit_inmem_pages(struct inode *);
 void f2fs_balance_fs(struct f2fs_sb_info *, bool);
 void f2fs_balance_fs_bg(struct f2fs_sb_info *);
 int f2fs_issue_flush(struct f2fs_sb_info *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3ffb6c1..2fa055e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1252,7 +1252,7 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 {
 	/* some remained atomic pages should discarded */
 	if (f2fs_is_atomic_file(inode))
-		commit_inmem_pages(inode, true);
+		drop_inmem_pages(inode);
 	if (f2fs_is_volatile_file(inode)) {
 		set_inode_flag(F2FS_I(inode), FI_DROP_CACHE);
 		filemap_fdatawrite(inode->i_mapping);
@@ -1376,7 +1376,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 
 	if (f2fs_is_atomic_file(inode)) {
 		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
-		ret = commit_inmem_pages(inode, false);
+		ret = commit_inmem_pages(inode);
 		if (ret) {
 			set_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
 			goto err_out;
@@ -1439,7 +1439,7 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 
 	if (f2fs_is_atomic_file(inode)) {
 		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
-		commit_inmem_pages(inode, true);
+		drop_inmem_pages(inode);
 	}
 	if (f2fs_is_volatile_file(inode)) {
 		clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 60e3b30..d447707 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -324,7 +324,7 @@ void f2fs_evict_inode(struct inode *inode)
 
 	/* some remained atomic pages should discarded */
 	if (f2fs_is_atomic_file(inode))
-		commit_inmem_pages(inode, true);
+		drop_inmem_pages(inode);
 
 	trace_f2fs_evict_inode(inode);
 	truncate_inode_pages_final(&inode->i_data);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 57a5f7b..3d09d63 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -191,56 +191,67 @@ void register_inmem_page(struct inode *inode, struct page *page)
 	trace_f2fs_register_inmem_page(page, INMEM);
 }
 
-int commit_inmem_pages(struct inode *inode, bool abort)
+static void __revoke_inmem_pages(struct inode *inode,
+							struct list_head *head)
+{
+	struct inmem_pages *cur, *tmp;
+
+	list_for_each_entry_safe(cur, tmp, head, list) {
+		trace_f2fs_commit_inmem_page(cur->page, INMEM_DROP);
+
+		lock_page(cur->page);
+		ClearPageUptodate(cur->page);
+		set_page_private(cur->page, 0);
+		ClearPagePrivate(cur->page);
+		f2fs_put_page(cur->page, 1);
+
+		list_del(&cur->list);
+		kmem_cache_free(inmem_entry_slab, cur);
+		dec_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
+	}
+}
+
+void drop_inmem_pages(struct inode *inode)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+
+	mutex_lock(&fi->inmem_lock);
+	__revoke_inmem_pages(inode, &fi->inmem_pages);
+	mutex_unlock(&fi->inmem_lock);
+}
+
+static int __commit_inmem_pages(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct inmem_pages *cur, *tmp;
-	bool submit_bio = false;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
 		.type = DATA,
 		.rw = WRITE_SYNC | REQ_PRIO,
 		.encrypted_page = NULL,
 	};
+	bool submit_bio = false;
 	int err = 0;
 
-	/*
-	 * The abort is true only when f2fs_evict_inode is called.
-	 * Basically, the f2fs_evict_inode doesn't produce any data writes, so
-	 * that we don't need to call f2fs_balance_fs.
-	 * Otherwise, f2fs_gc in f2fs_balance_fs can wait forever until this
-	 * inode becomes free by iget_locked in f2fs_iget.
-	 */
-	if (!abort) {
-		f2fs_balance_fs(sbi, true);
-		f2fs_lock_op(sbi);
-	}
-
-	mutex_lock(&fi->inmem_lock);
 	list_for_each_entry_safe(cur, tmp, &fi->inmem_pages, list) {
 		lock_page(cur->page);
-		if (!abort) {
-			if (cur->page->mapping == inode->i_mapping) {
-				set_page_dirty(cur->page);
-				f2fs_wait_on_page_writeback(cur->page, DATA,
-									true);
-				if (clear_page_dirty_for_io(cur->page))
-					inode_dec_dirty_pages(inode);
-				trace_f2fs_commit_inmem_page(cur->page, INMEM);
-				fio.page = cur->page;
-				err = do_write_data_page(&fio);
-				if (err) {
-					unlock_page(cur->page);
-					break;
-				}
-				clear_cold_data(cur->page);
-				submit_bio = true;
+		if (cur->page->mapping == inode->i_mapping) {
+			set_page_dirty(cur->page);
+			f2fs_wait_on_page_writeback(cur->page, DATA, true);
+			if (clear_page_dirty_for_io(cur->page))
+				inode_dec_dirty_pages(inode);
+			trace_f2fs_commit_inmem_page(cur->page, INMEM);
+			fio.page = cur->page;
+			err = do_write_data_page(&fio);
+			if (err) {
+				unlock_page(cur->page);
+				break;
 			}
-		} else {
-			ClearPageUptodate(cur->page);
-			trace_f2fs_commit_inmem_page(cur->page, INMEM_DROP);
+			clear_cold_data(cur->page);
+			submit_bio = true;
 		}
+
 		set_page_private(cur->page, 0);
 		ClearPagePrivate(cur->page);
 		f2fs_put_page(cur->page, 1);
@@ -249,14 +260,26 @@ int commit_inmem_pages(struct inode *inode, bool abort)
 		kmem_cache_free(inmem_entry_slab, cur);
 		dec_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
 	}
+
+	if (submit_bio)
+		f2fs_submit_merged_bio_cond(sbi, inode, NULL, 0, DATA, WRITE);
+	return err;
+}
+
+int commit_inmem_pages(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	int err = 0;
+
+	f2fs_balance_fs(sbi, true);
+	f2fs_lock_op(sbi);
+
+	mutex_lock(&fi->inmem_lock);
+	err = __commit_inmem_pages(inode);
 	mutex_unlock(&fi->inmem_lock);
 
-	if (!abort) {
-		f2fs_unlock_op(sbi);
-		if (submit_bio)
-			f2fs_submit_merged_bio_cond(sbi, inode, NULL, 0,
-								DATA, WRITE);
-	}
+	f2fs_unlock_op(sbi);
 	return err;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9445a34..fa4bbe0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -494,7 +494,7 @@ static int f2fs_drop_inode(struct inode *inode)
 
 			/* some remained atomic pages should discarded */
 			if (f2fs_is_atomic_file(inode))
-				commit_inmem_pages(inode, true);
+				drop_inmem_pages(inode);
 
 			/* should remain fi->extent_tree for writepage */
 			f2fs_destroy_extent_node(inode);
-- 
2.7.0.2.g1b0b6dd



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
