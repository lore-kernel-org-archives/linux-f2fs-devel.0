From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/6] f2fs crypto: free encryption_info at f2fs_evict_inode
Date: Tue, 12 May 2015 17:40:29 -0700
Message-ID: <1431477634-48111-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes not calling freeing encryption info when f2fs_evict_inode
was called.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 13936f9..ea6ba3b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -362,6 +362,10 @@ no_delete:
 	if (is_inode_flag_set(F2FS_I(inode), FI_UPDATE_WRITE))
 		add_dirty_inode(sbi, inode->i_ino, UPDATE_INO);
 out_clear:
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+	if (F2FS_I(inode)->i_crypt_info)
+		f2fs_free_encryption_info(inode);
+#endif
 	clear_inode(inode);
 }
 
-- 
2.1.1
