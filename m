From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: introduce prepare_write_begin to clean
	up
Date: Wed, 23 Dec 2015 18:15:17 -0800
Message-ID: <1450923320-41113-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aBvRD-0001xE-Om
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 02:15:31 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aBvRC-0008Bv-MH for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 02:15:31 +0000
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

This patch adds prepare_write_begin to clean f2fs_write_begin.
The major role of this function is to convert any inline_data and allocate
or find block address.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 92 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 54 insertions(+), 38 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 958d826..49092da 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1410,6 +1410,51 @@ static void f2fs_write_failed(struct address_space *mapping, loff_t to)
 	}
 }
 
+static int prepare_write_begin(struct f2fs_sb_info *sbi,
+			struct page *page, loff_t pos, unsigned len,
+			block_t *blk_addr, bool *node_changed)
+{
+	struct inode *inode = page->mapping->host;
+	pgoff_t index = page->index;
+	struct dnode_of_data dn;
+	struct page *ipage;
+	int err = 0;
+
+	f2fs_lock_op(sbi);
+
+	/* check inline_data */
+	ipage = get_node_page(sbi, inode->i_ino);
+	if (IS_ERR(ipage)) {
+		err = PTR_ERR(ipage);
+		goto unlock_out;
+	}
+
+	set_new_dnode(&dn, inode, ipage, ipage, 0);
+
+	if (f2fs_has_inline_data(inode)) {
+		if (pos + len <= MAX_INLINE_DATA) {
+			read_inline_data(page, ipage);
+			set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
+			sync_inode_page(&dn);
+			goto done;
+		} else {
+			err = f2fs_convert_inline_page(&dn, page);
+			if (err)
+				goto err_out;
+		}
+	}
+	err = f2fs_get_block(&dn, index);
+done:
+	/* convert_inline_page can make node_changed */
+	*blk_addr = dn.data_blkaddr;
+	*node_changed = dn.node_changed;
+err_out:
+	f2fs_put_dnode(&dn);
+unlock_out:
+	f2fs_unlock_op(sbi);
+	return err;
+}
+
 static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 		loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, void **fsdata)
@@ -1417,9 +1462,9 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *page = NULL;
-	struct page *ipage;
 	pgoff_t index = ((unsigned long long) pos) >> PAGE_CACHE_SHIFT;
-	struct dnode_of_data dn;
+	bool need_balance = false;
+	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
 	trace_f2fs_write_begin(inode, pos, len, flags);
@@ -1443,37 +1488,12 @@ repeat:
 
 	*pagep = page;
 
-	f2fs_lock_op(sbi);
-
-	/* check inline_data */
-	ipage = get_node_page(sbi, inode->i_ino);
-	if (IS_ERR(ipage)) {
-		err = PTR_ERR(ipage);
-		goto unlock_fail;
-	}
-
-	set_new_dnode(&dn, inode, ipage, ipage, 0);
-
-	if (f2fs_has_inline_data(inode)) {
-		if (pos + len <= MAX_INLINE_DATA) {
-			read_inline_data(page, ipage);
-			set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
-			sync_inode_page(&dn);
-			goto put_next;
-		}
-		err = f2fs_convert_inline_page(&dn, page);
-		if (err)
-			goto put_fail;
-	}
-
-	err = f2fs_get_block(&dn, index);
+	err = prepare_write_begin(sbi, page, pos + len,
+					&blkaddr, &need_balance);
 	if (err)
-		goto put_fail;
-put_next:
-	f2fs_put_dnode(&dn);
-	f2fs_unlock_op(sbi);
+		goto fail;
 
-	if (dn.node_changed && has_not_enough_free_secs(sbi, 0)) {
+	if (need_balance && has_not_enough_free_secs(sbi, 0)) {
 		unlock_page(page);
 		f2fs_balance_fs(sbi);
 		lock_page(page);
@@ -1488,7 +1508,7 @@ put_next:
 
 	/* wait for GCed encrypted page writeback */
 	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
-		f2fs_wait_on_encrypted_page_writeback(sbi, dn.data_blkaddr);
+		f2fs_wait_on_encrypted_page_writeback(sbi, blkaddr);
 
 	if (len == PAGE_CACHE_SIZE)
 		goto out_update;
@@ -1504,14 +1524,14 @@ put_next:
 		goto out_update;
 	}
 
-	if (dn.data_blkaddr == NEW_ADDR) {
+	if (blkaddr == NEW_ADDR) {
 		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
 	} else {
 		struct f2fs_io_info fio = {
 			.sbi = sbi,
 			.type = DATA,
 			.rw = READ_SYNC,
-			.blk_addr = dn.data_blkaddr,
+			.blk_addr = blkaddr,
 			.page = page,
 			.encrypted_page = NULL,
 		};
@@ -1542,10 +1562,6 @@ out_clear:
 	clear_cold_data(page);
 	return 0;
 
-put_fail:
-	f2fs_put_dnode(&dn);
-unlock_fail:
-	f2fs_unlock_op(sbi);
 fail:
 	f2fs_put_page(page, 1);
 	f2fs_write_failed(mapping, pos + len);
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
