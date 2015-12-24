From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: avoid f2fs_lock_op in f2fs_write_begin
Date: Wed, 23 Dec 2015 18:15:19 -0800
Message-ID: <1450923320-41113-3-git-send-email-jaegeuk@kernel.org>
References: <1450923320-41113-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aBvRF-0007nD-MI
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 02:15:33 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aBvRE-0006Ml-Tz for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 02:15:33 +0000
In-Reply-To: <1450923320-41113-1-git-send-email-jaegeuk@kernel.org>
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

If f2fs_write_begin is to update data, we can bypass calling f2fs_lock_op() in
order to avoid the checkpoint latency in the write syscall.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 49092da..d53cf4f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1418,10 +1418,16 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	pgoff_t index = page->index;
 	struct dnode_of_data dn;
 	struct page *ipage;
+	bool locked = false;
+	struct extent_info ei;
 	int err = 0;
 
-	f2fs_lock_op(sbi);
-
+	if (f2fs_has_inline_data(inode) ||
+			(pos & PAGE_CACHE_MASK) >= i_size_read(inode)) {
+		f2fs_lock_op(sbi);
+		locked = true;
+	}
+restart:
 	/* check inline_data */
 	ipage = get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(ipage)) {
@@ -1436,22 +1442,41 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			read_inline_data(page, ipage);
 			set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
 			sync_inode_page(&dn);
-			goto done;
 		} else {
 			err = f2fs_convert_inline_page(&dn, page);
 			if (err)
-				goto err_out;
+				goto out;
+			err = f2fs_get_block(&dn, index);
+		}
+	} else if (locked) {
+		err = f2fs_get_block(&dn, index);
+	} else {
+		if (f2fs_lookup_extent_cache(inode, index, &ei)) {
+			dn.data_blkaddr = ei.blk + index - ei.fofs;
+		} else {
+			bool restart = false;
+
+			/* hole case */
+			err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
+			if (err || (!err && dn.data_blkaddr == NULL_ADDR))
+				restart = true;
+			if (restart) {
+				f2fs_put_dnode(&dn);
+				f2fs_lock_op(sbi);
+				locked = true;
+				goto restart;
+			}
 		}
 	}
-	err = f2fs_get_block(&dn, index);
-done:
+
 	/* convert_inline_page can make node_changed */
 	*blk_addr = dn.data_blkaddr;
 	*node_changed = dn.node_changed;
-err_out:
+out:
 	f2fs_put_dnode(&dn);
 unlock_out:
-	f2fs_unlock_op(sbi);
+	if (locked)
+		f2fs_unlock_op(sbi);
 	return err;
 }
 
@@ -1488,7 +1513,7 @@ repeat:
 
 	*pagep = page;
 
-	err = prepare_write_begin(sbi, page, pos + len,
+	err = prepare_write_begin(sbi, page, pos,  len,
 					&blkaddr, &need_balance);
 	if (err)
 		goto fail;
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
