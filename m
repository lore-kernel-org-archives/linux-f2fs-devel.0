From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/7] f2fs: don't need to call lock_op and
	lock_page for abort
Date: Sun, 14 Dec 2014 23:27:34 -0800
Message-ID: <1418628458-82740-3-git-send-email-jaegeuk@kernel.org>
References: <1418628458-82740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y0Q4K-0006Zw-IH
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Dec 2014 07:27:48 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y0Q4J-0000Xt-Kh for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Dec 2014 07:27:48 +0000
In-Reply-To: <1418628458-82740-1-git-send-email-jaegeuk@kernel.org>
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

We don't need to call lock_op and lock_page at the aborting path.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 11e4b5c..3ce86c5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -240,33 +240,38 @@ void commit_inmem_pages(struct inode *inode, bool abort)
 	 * Otherwise, f2fs_gc in f2fs_balance_fs can wait forever until this
 	 * inode becomes free by iget_locked in f2fs_iget.
 	 */
-	if (!abort)
+	if (!abort) {
 		f2fs_balance_fs(sbi);
-
-	f2fs_lock_op(sbi);
+		f2fs_lock_op(sbi);
+	}
 
 	mutex_lock(&fi->inmem_lock);
 	list_for_each_entry_safe(cur, tmp, &fi->inmem_pages, list) {
-		lock_page(cur->page);
-		if (!abort && cur->page->mapping == inode->i_mapping) {
-			f2fs_wait_on_page_writeback(cur->page, DATA);
-			if (clear_page_dirty_for_io(cur->page))
-				inode_dec_dirty_pages(inode);
-			do_write_data_page(cur->page, &fio);
-			submit_bio = true;
+		if (!abort) {
+			lock_page(cur->page);
+			if (cur->page->mapping == inode->i_mapping) {
+				f2fs_wait_on_page_writeback(cur->page, DATA);
+				if (clear_page_dirty_for_io(cur->page))
+					inode_dec_dirty_pages(inode);
+				do_write_data_page(cur->page, &fio);
+				submit_bio = true;
+			}
+			f2fs_put_page(cur->page, 1);
+		} else {
+			put_page(cur->page);
 		}
 		radix_tree_delete(&fi->inmem_root, cur->page->index);
-		f2fs_put_page(cur->page, 1);
 		list_del(&cur->list);
 		kmem_cache_free(inmem_entry_slab, cur);
 		dec_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
 	}
-	if (submit_bio)
-		f2fs_submit_merged_bio(sbi, DATA, WRITE);
 	mutex_unlock(&fi->inmem_lock);
 
-	filemap_fdatawait_range(inode->i_mapping, 0, LLONG_MAX);
-	f2fs_unlock_op(sbi);
+	if (!abort) {
+		f2fs_unlock_op(sbi);
+		if (submit_bio)
+			f2fs_submit_merged_bio(sbi, DATA, WRITE);
+	}
 }
 
 /*
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
