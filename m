From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix lost xattrs of directories
Date: Mon, 29 Aug 2016 19:13:35 -0700
Message-ID: <20160830021335.1547-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1beYYd-0004gD-5X
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Aug 2016 02:13:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1beYYc-0004l3-3n
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Aug 2016 02:13:47 +0000
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

This patch enhances the xattr consistency of dirs from suddern power-cuts.

Possible scenario would be:
1. dir->setxattr used by per-file encryption
2. file->setxattr goes into inline_xattr
3. file->fsync

In that case, we should do checkpoint for #1.
Otherwise we'd lose dir's key information for the file given #2.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 1 +
 fs/f2fs/f2fs.h       | 1 +
 fs/f2fs/file.c       | 2 ++
 fs/f2fs/xattr.c      | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 64a685d..727e97e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1152,6 +1152,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	clear_prefree_segments(sbi, cpc);
 	clear_sbi_flag(sbi, SBI_IS_DIRTY);
+	clear_sbi_flag(sbi, SBI_NEED_CP);
 
 	return 0;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c2478a1..b9611d4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -756,6 +756,7 @@ enum {
 	SBI_NEED_FSCK,				/* need fsck.f2fs to fix */
 	SBI_POR_DOING,				/* recovery is doing or not */
 	SBI_NEED_SB_WRITE,			/* need to recover superblock */
+	SBI_NEED_CP,				/* need to checkpoint */
 };
 
 enum {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7c6ee7e..21aa99b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -135,6 +135,8 @@ static inline bool need_do_checkpoint(struct inode *inode)
 
 	if (!S_ISREG(inode->i_mode) || inode->i_nlink != 1)
 		need_cp = true;
+	else if (is_sbi_flag_set(sbi, SBI_NEED_CP))
+		need_cp = true;
 	else if (file_enc_name(inode) && need_dentry_mark(sbi, inode->i_ino))
 		need_cp = true;
 	else if (file_wrong_pino(inode))
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index c8898b5..d39a792 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -548,6 +548,8 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
 		f2fs_set_encrypted_inode(inode);
 	f2fs_mark_inode_dirty_sync(inode);
+	if (!error && S_ISDIR(inode->i_mode))
+		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
 exit:
 	kzfree(base_addr);
 	return error;
-- 
2.8.3


------------------------------------------------------------------------------
