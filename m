From: Taesoo Kim <tsgatesv@gmail.com>
Subject: [PATCH 1/1] f2fs: correctly check empty xattr key
Date: Fri, 20 Mar 2015 00:19:07 -0400
Message-ID: <1426825147-26981-1-git-send-email-tsgatesv@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, cm224.lee@samsung.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, changwoo@gatech.edu, sanidhya@gatech.edu, blee@gatech.edu, csong84@gatech.edu, Taesoo Kim <tsgatesv@gmail.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When xattr name (key) is empty (""), correctly return -EINVAL
error. xattr_advise_set/get() seem to make the same mistake.

Signed-off-by: Taesoo Kim <tsgatesv@gmail.com>
---
 fs/f2fs/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 5072bf9..6b1fbc4 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -132,7 +132,7 @@ static int f2fs_xattr_advise_get(struct dentry *dentry, const char *name,
 {
 	struct inode *inode = dentry->d_inode;
 
-	if (strcmp(name, "") != 0)
+	if (strcmp(name, "") == 0)
 		return -EINVAL;
 
 	*((char *)buffer) = F2FS_I(inode)->i_advise;
@@ -144,7 +144,7 @@ static int f2fs_xattr_advise_set(struct dentry *dentry, const char *name,
 {
 	struct inode *inode = dentry->d_inode;
 
-	if (strcmp(name, "") != 0)
+	if (strcmp(name, "") == 0)
 		return -EINVAL;
 	if (!inode_owner_or_capable(inode))
 		return -EPERM;
-- 
2.3.3
