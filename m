From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/7] f2fs: set fsync mark only for the last dnode
Date: Mon, 25 Apr 2016 17:06:58 -0700
Message-ID: <1461629220-16280-5-git-send-email-jaegeuk@kernel.org>
References: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1auqX1-0003Vm-CW
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:07:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1auqX0-0007ov-AT
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:07:11 +0000
In-Reply-To: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
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

In order to give atomic writes, we should consider power failure during
sync_node_pages in fsync.
So, this patch marks fsync flag only in the last dnode block.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h     |   4 +-
 fs/f2fs/file.c     |  14 +++++--
 fs/f2fs/node.c     | 106 +++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/f2fs/recovery.c |   9 ++---
 4 files changed, 113 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 269abe5..ca828b0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -159,7 +159,6 @@ struct fsync_inode_entry {
 	struct inode *inode;	/* vfs inode pointer */
 	block_t blkaddr;	/* block address locating the last fsync */
 	block_t last_dentry;	/* block address locating the last dentry */
-	block_t last_inode;	/* block address locating the last inode */
 };
 
 #define nats_in_cursum(jnl)		(le16_to_cpu(jnl->n_nats))
@@ -1784,7 +1783,8 @@ void ra_node_page(struct f2fs_sb_info *, nid_t);
 struct page *get_node_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_node_page_ra(struct page *, int);
 void sync_inode_page(struct dnode_of_data *);
-int fsync_node_pages(struct f2fs_sb_info *, nid_t, struct writeback_control *);
+int fsync_node_pages(struct f2fs_sb_info *, nid_t, struct writeback_control *,
+								bool);
 int sync_node_pages(struct f2fs_sb_info *, struct writeback_control *);
 bool alloc_nid(struct f2fs_sb_info *, nid_t *);
 void alloc_nid_done(struct f2fs_sb_info *, nid_t);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 60fd64c..dc47d5c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -182,7 +182,8 @@ static void try_to_fix_pino(struct inode *inode)
 	}
 }
 
-int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
+static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
+						int datasync, bool atomic)
 {
 	struct inode *inode = file->f_mapping->host;
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -256,7 +257,7 @@ go_write:
 		goto out;
 	}
 sync_nodes:
-	ret = fsync_node_pages(sbi, ino, &wbc);
+	ret = fsync_node_pages(sbi, ino, &wbc, atomic);
 	if (ret)
 		goto out;
 
@@ -290,6 +291,11 @@ out:
 	return ret;
 }
 
+int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return f2fs_do_sync_file(file, start, end, datasync, false);
+}
+
 static pgoff_t __get_first_dirty_index(struct address_space *mapping,
 						pgoff_t pgofs, int whence)
 {
@@ -1407,7 +1413,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		}
 	}
 
-	ret = f2fs_sync_file(filp, 0, LLONG_MAX, 0);
+	ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 err_out:
 	mnt_drop_write_file(filp);
 	return ret;
@@ -1465,7 +1471,7 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 		drop_inmem_pages(inode);
 	if (f2fs_is_volatile_file(inode)) {
 		clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
-		ret = f2fs_sync_file(filp, 0, LLONG_MAX, 0);
+		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 	}
 
 	mnt_drop_write_file(filp);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8a1e211..de070a5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1222,13 +1222,81 @@ iput_out:
 	iput(inode);
 }
 
+static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
+{
+	pgoff_t index, end;
+	struct pagevec pvec;
+	struct page *last_page = NULL;
+
+	pagevec_init(&pvec, 0);
+	index = 0;
+	end = ULONG_MAX;
+
+	while (index <= end) {
+		int i, nr_pages;
+		nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
+				PAGECACHE_TAG_DIRTY,
+				min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1);
+		if (nr_pages == 0)
+			break;
+
+		for (i = 0; i < nr_pages; i++) {
+			struct page *page = pvec.pages[i];
+
+			if (unlikely(f2fs_cp_error(sbi))) {
+				f2fs_put_page(last_page, 0);
+				pagevec_release(&pvec);
+				return ERR_PTR(-EIO);
+			}
+
+			if (!IS_DNODE(page) || !is_cold_node(page))
+				continue;
+			if (ino_of_node(page) != ino)
+				continue;
+
+			lock_page(page);
+
+			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
+continue_unlock:
+				unlock_page(page);
+				continue;
+			}
+			if (ino_of_node(page) != ino)
+				goto continue_unlock;
+
+			if (!PageDirty(page)) {
+				/* someone wrote it for us */
+				goto continue_unlock;
+			}
+
+			if (last_page)
+				f2fs_put_page(last_page, 0);
+
+			get_page(page);
+			last_page = page;
+			unlock_page(page);
+		}
+		pagevec_release(&pvec);
+		cond_resched();
+	}
+	return last_page;
+}
+
 int fsync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
-					struct writeback_control *wbc)
+			struct writeback_control *wbc, bool atomic)
 {
 	pgoff_t index, end;
 	struct pagevec pvec;
 	int ret = 0;
+	struct page *last_page = NULL;
+	bool marked = false;
 
+	if (atomic) {
+		last_page = last_fsync_dnode(sbi, ino);
+		if (IS_ERR_OR_NULL(last_page))
+			return PTR_ERR_OR_ZERO(last_page);
+	}
+retry:
 	pagevec_init(&pvec, 0);
 	index = 0;
 	end = ULONG_MAX;
@@ -1245,6 +1313,7 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
 			struct page *page = pvec.pages[i];
 
 			if (unlikely(f2fs_cp_error(sbi))) {
+				f2fs_put_page(last_page, 0);
 				pagevec_release(&pvec);
 				return -EIO;
 			}
@@ -1264,33 +1333,54 @@ continue_unlock:
 			if (ino_of_node(page) != ino)
 				goto continue_unlock;
 
-			if (!PageDirty(page)) {
+			if (!PageDirty(page) && page != last_page) {
 				/* someone wrote it for us */
 				goto continue_unlock;
 			}
 
 			f2fs_wait_on_page_writeback(page, NODE, true);
 			BUG_ON(PageWriteback(page));
-			if (!clear_page_dirty_for_io(page))
-				goto continue_unlock;
 
-			set_fsync_mark(page, 1);
-			if (IS_INODE(page))
-				set_dentry_mark(page,
+			if (!atomic || page == last_page) {
+				set_fsync_mark(page, 1);
+				if (IS_INODE(page))
+					set_dentry_mark(page,
 						need_dentry_mark(sbi, ino));
+				/*  may be written by other thread */
+				if (!PageDirty(page))
+					set_page_dirty(page);
+			}
+
+			if (!clear_page_dirty_for_io(page))
+				goto continue_unlock;
 
 			ret = NODE_MAPPING(sbi)->a_ops->writepage(page, wbc);
 			if (ret) {
 				unlock_page(page);
+				f2fs_put_page(last_page, 0);
+				break;
+			}
+			if (page == last_page) {
+				f2fs_put_page(page, 0);
+				marked = true;
 				break;
 			}
 		}
 		pagevec_release(&pvec);
 		cond_resched();
 
-		if (ret)
+		if (ret || marked)
 			break;
 	}
+	if (!ret && atomic && !marked) {
+		f2fs_msg(sbi->sb, KERN_DEBUG,
+			"Retry to write fsync mark: ino=%u, idx=%lx",
+					ino, last_page->index);
+		lock_page(last_page);
+		set_page_dirty(last_page);
+		unlock_page(last_page);
+		goto retry;
+	}
 	return ret ? -EIO: 0;
 }
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 2c87c12..a646d3b 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -257,11 +257,8 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 		}
 		entry->blkaddr = blkaddr;
 
-		if (IS_INODE(page)) {
-			entry->last_inode = blkaddr;
-			if (is_dent_dnode(page))
-				entry->last_dentry = blkaddr;
-		}
+		if (IS_INODE(page) && is_dent_dnode(page))
+			entry->last_dentry = blkaddr;
 next:
 		/* check next segment */
 		blkaddr = next_blkaddr_of_node(page);
@@ -521,7 +518,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *head)
 		 * In this case, we can lose the latest inode(x).
 		 * So, call recover_inode for the inode update.
 		 */
-		if (entry->last_inode == blkaddr)
+		if (IS_INODE(page))
 			recover_inode(entry->inode, page);
 		if (entry->last_dentry == blkaddr) {
 			err = recover_dentry(entry->inode, page);
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
