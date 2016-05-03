From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 09/11] f2fs: revisit error handling flows
Date: Tue,  3 May 2016 11:21:46 -0700
Message-ID: <1462299708-67906-9-git-send-email-jaegeuk@kernel.org>
References: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1axexY-0002LO-R9
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:12 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1axexX-0002mK-R9
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:12 +0000
In-Reply-To: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
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

This patch fixes a couple of bugs regarding to orphan inodes when handling
errors.

This tries to
 - call alloc_nid_done with add_orphan_inode in handle_failed_inode
 - let truncate blocks in f2fs_evict_inode
 - not make a bad inode due to i_mode change

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c   | 20 ++++++++++++--------
 fs/f2fs/inode.c | 40 ++++++++++++++++------------------------
 2 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 50f42be..5373f33 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -391,9 +391,14 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 			return page;
 
 		if (S_ISDIR(inode->i_mode)) {
+			/* in order to handle error case */
+			get_page(page);
 			err = make_empty_dir(inode, dir, page);
-			if (err)
-				goto error;
+			if (err) {
+				lock_page(page);
+				goto put_error;
+			}
+			put_page(page);
 		}
 
 		err = f2fs_init_acl(inode, dir, page, dpage);
@@ -437,13 +442,12 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 	return page;
 
 put_error:
-	f2fs_put_page(page, 1);
-error:
-	/* once the failed inode becomes a bad inode, i_mode is S_IFREG */
+	/* truncate empty dir pages */
 	truncate_inode_pages(&inode->i_data, 0);
-	truncate_blocks(inode, 0, false);
-	remove_dirty_inode(inode);
-	remove_inode_page(inode);
+
+	clear_nlink(inode);
+	update_inode(inode, page);
+	f2fs_put_page(page, 1);
 	return ERR_PTR(err);
 }
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index cb269c4..f4ac851 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -368,10 +368,7 @@ no_delete:
 	if (is_inode_flag_set(fi, FI_UPDATE_WRITE))
 		add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
 	if (is_inode_flag_set(fi, FI_FREE_NID)) {
-		if (err && err != -ENOENT)
-			alloc_nid_done(sbi, inode->i_ino);
-		else
-			alloc_nid_failed(sbi, inode->i_ino);
+		alloc_nid_failed(sbi, inode->i_ino);
 		clear_inode_flag(fi, FI_FREE_NID);
 	}
 
@@ -397,37 +394,32 @@ out_clear:
 void handle_failed_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int err = 0;
+	struct node_info ni;
 
-	clear_nlink(inode);
-	make_bad_inode(inode);
+	/* don't make bad inode, since it becomes a regular file. */
 	unlock_new_inode(inode);
 
-	i_size_write(inode, 0);
-	if (F2FS_HAS_BLOCKS(inode))
-		err = f2fs_truncate(inode, false);
-
-	if (!err)
-		err = remove_inode_page(inode);
-
 	/*
-	 * if we skip truncate_node in remove_inode_page bacause we failed
-	 * before, it's better to find another way to release resource of
-	 * this inode (e.g. valid block count, node block or nid). Here we
-	 * choose to add this inode to orphan list, so that we can call iput
-	 * for releasing in orphan recovery flow.
-	 *
 	 * Note: we should add inode to orphan list before f2fs_unlock_op()
 	 * so we can prevent losing this orphan when encoutering checkpoint
 	 * and following suddenly power-off.
 	 */
-	if (err && err != -ENOENT) {
-		err = acquire_orphan_inode(sbi);
-		if (!err)
+	get_node_info(sbi, inode->i_ino, &ni);
+
+	if (ni.blk_addr != NULL_ADDR) {
+		int err = acquire_orphan_inode(sbi);
+		if (err) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_msg(sbi->sb, KERN_WARNING,
+				"Too many orphan inodes, run fsck to fix.");
+		} else {
 			add_orphan_inode(sbi, inode->i_ino);
+		}
+		alloc_nid_done(sbi, inode->i_ino);
+	} else {
+		set_inode_flag(F2FS_I(inode), FI_FREE_NID);
 	}
 
-	set_inode_flag(F2FS_I(inode), FI_FREE_NID);
 	f2fs_unlock_op(sbi);
 
 	/* iput will drop the inode object */
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
