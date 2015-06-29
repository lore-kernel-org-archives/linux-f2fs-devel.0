From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 02/12] f2fs: avoid to use failed inode immediately
Date: Mon, 29 Jun 2015 11:39:26 -0700
Message-ID: <1435603176-63219-2-git-send-email-jaegeuk@kernel.org>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Z9dyS-0004CM-O0
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:08 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z9dyR-0006iO-FE for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:08 +0000
In-Reply-To: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
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

Before iput is called, the inode number used by a bad inode can be reassigned
to other new inode, resulting in any abnormal behaviors on the new inode.
This should not happen for the new inode.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/inode.c | 19 ++++++++++++-------
 fs/f2fs/namei.c |  4 ++--
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5162204..3aaa4b9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1343,6 +1343,7 @@ enum {
 	FI_INC_LINK,		/* need to increment i_nlink */
 	FI_ACL_MODE,		/* indicate acl mode */
 	FI_NO_ALLOC,		/* should not allocate any blocks */
+	FI_FREE_NID,		/* free allocated nide */
 	FI_UPDATE_DIR,		/* should update inode block for consistency */
 	FI_DELAY_IPUT,		/* used for the recovery */
 	FI_NO_EXTENT,		/* not to use the extent cache */
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 2550868..757fed2 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -314,7 +314,8 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 void f2fs_evict_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	nid_t xnid = fi->i_xattr_nid;
 
 	/* some remained atomic pages should discarded */
 	if (f2fs_is_atomic_file(inode))
@@ -334,7 +335,7 @@ void f2fs_evict_inode(struct inode *inode)
 		goto no_delete;
 
 	sb_start_intwrite(inode->i_sb);
-	set_inode_flag(F2FS_I(inode), FI_NO_ALLOC);
+	set_inode_flag(fi, FI_NO_ALLOC);
 	i_size_write(inode, 0);
 
 	if (F2FS_HAS_BLOCKS(inode))
@@ -357,14 +358,18 @@ no_delete:
 	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
 	if (xnid)
 		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
-	if (is_inode_flag_set(F2FS_I(inode), FI_APPEND_WRITE))
+	if (is_inode_flag_set(fi, FI_APPEND_WRITE))
 		add_dirty_inode(sbi, inode->i_ino, APPEND_INO);
-	if (is_inode_flag_set(F2FS_I(inode), FI_UPDATE_WRITE))
+	if (is_inode_flag_set(fi, FI_UPDATE_WRITE))
 		add_dirty_inode(sbi, inode->i_ino, UPDATE_INO);
+	if (is_inode_flag_set(fi, FI_FREE_NID)) {
+		alloc_nid_failed(sbi, inode->i_ino);
+		clear_inode_flag(fi, FI_FREE_NID);
+	}
 out_clear:
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
-	if (F2FS_I(inode)->i_crypt_info)
-		f2fs_free_encryption_info(inode, F2FS_I(inode)->i_crypt_info);
+	if (fi->i_crypt_info)
+		f2fs_free_encryption_info(inode, fi->i_crypt_info);
 #endif
 	clear_inode(inode);
 }
@@ -384,9 +389,9 @@ void handle_failed_inode(struct inode *inode)
 
 	remove_inode_page(inode);
 
+	set_inode_flag(F2FS_I(inode), FI_FREE_NID);
 	clear_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
 	clear_inode_flag(F2FS_I(inode), FI_INLINE_DENTRY);
-	alloc_nid_failed(sbi, inode->i_ino);
 	f2fs_unlock_op(sbi);
 
 	/* iput will drop the inode object */
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index fdbae21..08656fc 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -78,9 +78,9 @@ out:
 fail:
 	trace_f2fs_new_inode(inode, err);
 	make_bad_inode(inode);
-	iput(inode);
 	if (nid_free)
-		alloc_nid_failed(sbi, ino);
+		set_inode_flag(F2FS_I(inode), FI_FREE_NID);
+	iput(inode);
 	return ERR_PTR(err);
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
