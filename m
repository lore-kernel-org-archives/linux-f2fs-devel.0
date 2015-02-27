From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: clear page's up-to-date if block was
	deallocated
Date: Fri, 27 Feb 2015 11:21:04 -0800
Message-ID: <1425064865-74602-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YRQTM-000284-Av
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Feb 2015 19:21:16 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YRQTL-0007IO-81 for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Feb 2015 19:21:16 +0000
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

If page's on-disk block was deallocated, let's remove up-to-date flag to avoid
further access with wrong contents.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 6 +++++-
 fs/f2fs/dir.c  | 1 +
 fs/f2fs/node.c | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ae5c414..62e31b2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1259,8 +1259,10 @@ int do_write_data_page(struct page *page, struct f2fs_io_info *fio)
 	fio->blk_addr = dn.data_blkaddr;
 
 	/* This page is already truncated */
-	if (fio->blk_addr == NULL_ADDR)
+	if (fio->blk_addr == NULL_ADDR) {
+		ClearPageUptodate(page);
 		goto out_writepage;
+	}
 
 	set_page_writeback(page);
 
@@ -1355,6 +1357,8 @@ done:
 	clear_cold_data(page);
 out:
 	inode_dec_dirty_pages(inode);
+	if (err)
+		ClearPageUptodate(page);
 	unlock_page(page);
 	if (need_balance_fs)
 		f2fs_balance_fs(sbi);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 583896c..590aeef 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -682,6 +682,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	if (bit_pos == NR_DENTRY_IN_BLOCK) {
 		truncate_hole(dir, page->index, page->index + 1);
 		clear_page_dirty_for_io(page);
+		ClearPagePrivate(page);
 		ClearPageUptodate(page);
 		inode_dec_dirty_pages(dir);
 	}
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2842369..35a9117 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1002,6 +1002,7 @@ static int read_node_page(struct page *page, int rw)
 	get_node_info(sbi, page->index, &ni);
 
 	if (unlikely(ni.blk_addr == NULL_ADDR)) {
+		ClearPageUptodate(page);
 		f2fs_put_page(page, 1);
 		return -ENOENT;
 	}
@@ -1313,6 +1314,7 @@ static int f2fs_write_node_page(struct page *page,
 
 	/* This page is already truncated */
 	if (unlikely(ni.blk_addr == NULL_ADDR)) {
+		ClearPageUptodate(page);
 		dec_page_count(sbi, F2FS_DIRTY_NODES);
 		unlock_page(page);
 		return 0;
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
