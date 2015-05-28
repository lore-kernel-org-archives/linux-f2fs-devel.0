From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs crypto: avoid f2fs_inherit_context for symlink
Date: Wed, 27 May 2015 21:21:41 -0700
Message-ID: <1432786901-7935-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes to call f2fs_inherit_context twice for newly created symlink.
The original one is called by f2fs_add_link(), which invokes f2fs_setxattr.
If the second one is called again, f2fs_setxattr is triggered again with same
encryption index.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 3188464..2c41911 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -360,10 +360,6 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	if (f2fs_encrypted_inode(dir)) {
 		struct qstr istr = QSTR_INIT(symname, len);
 
-		err = f2fs_inherit_context(dir, inode, NULL);
-		if (err)
-			goto err_out;
-
 		err = f2fs_get_encryption_info(inode);
 		if (err)
 			goto err_out;
-- 
2.1.1

