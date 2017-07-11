From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: Don't clear SGID when inheriting ACLs
Date: Tue, 11 Jul 2017 13:53:24 -0700
Message-ID: <20170711205324.90260-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org, Jan Kara <jack@suse.cz>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch copies commit b7f8a09f80:
  "btrfs: Don't clear SGID when inheriting ACLs" written by Jan.

Fixes: 073931017b49d9458aa351605b43a7e34598caef
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/acl.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index a140c5e3dc54..da77352c5ad3 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -211,12 +211,8 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	switch (type) {
 	case ACL_TYPE_ACCESS:
 		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
-		if (acl) {
-			error = posix_acl_update_mode(inode, &inode->i_mode, &acl);
-			if (error)
-				return error;
+		if (acl)
 			set_acl_inode(inode, inode->i_mode);
-		}
 		break;
 
 	case ACL_TYPE_DEFAULT:
@@ -249,6 +245,13 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 
 int f2fs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 {
+	int ret;
+
+	if (type == ACL_TYPE_ACCESS && acl) {
+		ret = posix_acl_update_mode(inode, &inode->i_mode, &acl);
+		if (ret)
+			return ret;
+	}
 	return __f2fs_set_acl(inode, type, acl, NULL);
 }
 
-- 
2.13.0.rc1.294.g07d810a77f-goog
