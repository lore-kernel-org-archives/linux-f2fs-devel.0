From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/7] f2fs: split sync_node_pages with
	fsync_node_pages
Date: Mon, 25 Apr 2016 17:06:56 -0700
Message-ID: <1461629220-16280-3-git-send-email-jaegeuk@kernel.org>
References: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1auqWy-0006Ks-LD
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:07:08 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1auqWx-00018Q-Kx
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:07:08 +0000
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

This patch splits the existing sync_node_pages into (f)sync_node_pages.
The fsync_node_pages is used for f2fs_sync_file only.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |   2 +-
 fs/f2fs/f2fs.h       |   3 +-
 fs/f2fs/file.c       |   2 +-
 fs/f2fs/gc.c         |   2 +-
 fs/f2fs/node.c       | 108 +++++++++++++++++++++++++++++++++++++--------------
 5 files changed, 84 insertions(+), 33 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b92782f..bf040b5 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -892,7 +892,7 @@ retry_flush_nodes:
 
 	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
 		up_write(&sbi->node_write);
-		err = sync_node_pages(sbi, 0, &wbc);
+		err = sync_node_pages(sbi, &wbc);
 		if (err) {
 			f2fs_unlock_all(sbi);
 			goto out;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3f15513..269abe5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1784,7 +1784,8 @@ void ra_node_page(struct f2fs_sb_info *, nid_t);
 struct page *get_node_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_node_page_ra(struct page *, int);
 void sync_inode_page(struct dnode_of_data *);
-int sync_node_pages(struct f2fs_sb_info *, nid_t, struct writeback_control *);
+int fsync_node_pages(struct f2fs_sb_info *, nid_t, struct writeback_control *);
+int sync_node_pages(struct f2fs_sb_info *, struct writeback_control *);
 bool alloc_nid(struct f2fs_sb_info *, nid_t *);
 void alloc_nid_done(struct f2fs_sb_info *, nid_t);
 void alloc_nid_failed(struct f2fs_sb_info *, nid_t);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7de90e6..3d53ee0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -256,7 +256,7 @@ go_write:
 		goto out;
 	}
 sync_nodes:
-	sync_node_pages(sbi, ino, &wbc);
+	fsync_node_pages(sbi, ino, &wbc);
 
 	/* if cp_error was enabled, we should avoid infinite loop */
 	if (unlikely(f2fs_cp_error(sbi))) {
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b0051a9..e820465 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -841,7 +841,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 				.nr_to_write = LONG_MAX,
 				.for_reclaim = 0,
 			};
-			sync_node_pages(sbi, 0, &wbc);
+			sync_node_pages(sbi, &wbc);
 		} else {
 			f2fs_submit_merged_bio(sbi, DATA, WRITE);
 		}
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index cccee50..675b730 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1222,12 +1222,84 @@ iput_out:
 	iput(inode);
 }
 
-int sync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
+int fsync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
 					struct writeback_control *wbc)
 {
 	pgoff_t index, end;
 	struct pagevec pvec;
-	int step = ino ? 2 : 0;
+	int nwritten = 0;
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
+				pagevec_release(&pvec);
+				return -EIO;
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
+			f2fs_wait_on_page_writeback(page, NODE, true);
+			BUG_ON(PageWriteback(page));
+			if (!clear_page_dirty_for_io(page))
+				goto continue_unlock;
+
+			set_fsync_mark(page, 1);
+			if (IS_INODE(page))
+				set_dentry_mark(page,
+						need_dentry_mark(sbi, ino));
+			nwritten++;
+
+			if (NODE_MAPPING(sbi)->a_ops->writepage(page, wbc))
+				unlock_page(page);
+
+			if (--wbc->nr_to_write == 0)
+				break;
+		}
+		pagevec_release(&pvec);
+		cond_resched();
+
+		if (wbc->nr_to_write == 0)
+			break;
+	}
+	return nwritten;
+}
+
+int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc)
+{
+	pgoff_t index, end;
+	struct pagevec pvec;
+	int step = 0;
 	int nwritten = 0;
 
 	pagevec_init(&pvec, 0);
@@ -1266,28 +1338,15 @@ next_step:
 			if (step == 2 && (!IS_DNODE(page) ||
 						!is_cold_node(page)))
 				continue;
-
-			/*
-			 * If an fsync mode,
-			 * we should not skip writing node pages.
-			 */
 lock_node:
-			if (ino) {
-				if (ino_of_node(page) == ino)
-					lock_page(page);
-				else
-					continue;
-			} else if (!trylock_page(page)) {
+			if (!trylock_page(page))
 				continue;
-			}
 
 			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
 continue_unlock:
 				unlock_page(page);
 				continue;
 			}
-			if (ino && ino_of_node(page) != ino)
-				goto continue_unlock;
 
 			if (!PageDirty(page)) {
 				/* someone wrote it for us */
@@ -1295,7 +1354,7 @@ continue_unlock:
 			}
 
 			/* flush inline_data */
-			if (!ino && is_inline_node(page)) {
+			if (is_inline_node(page)) {
 				clear_inline_node(page);
 				unlock_page(page);
 				flush_inline_data(sbi, ino_of_node(page));
@@ -1308,17 +1367,8 @@ continue_unlock:
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
-			/* called by fsync() */
-			if (ino && IS_DNODE(page)) {
-				set_fsync_mark(page, 1);
-				if (IS_INODE(page))
-					set_dentry_mark(page,
-						need_dentry_mark(sbi, ino));
-				nwritten++;
-			} else {
-				set_fsync_mark(page, 0);
-				set_dentry_mark(page, 0);
-			}
+			set_fsync_mark(page, 0);
+			set_dentry_mark(page, 0);
 
 			if (NODE_MAPPING(sbi)->a_ops->writepage(page, wbc))
 				unlock_page(page);
@@ -1466,7 +1516,7 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 
 	diff = nr_pages_to_write(sbi, NODE, wbc);
 	wbc->sync_mode = WB_SYNC_NONE;
-	sync_node_pages(sbi, 0, wbc);
+	sync_node_pages(sbi, wbc);
 	wbc->nr_to_write = max((long)0, wbc->nr_to_write - diff);
 	return 0;
 
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
