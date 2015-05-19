From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs crypto: add rwsem to avoid data races
Date: Mon, 18 May 2015 22:36:41 -0700
Message-ID: <1432013801-39069-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previoulsy, fi->i_crypt_info was not covered by any lock, resulting in
memory leak.

This patch adds a rwsem to avoid leaking objects on i_crypt_info.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto_key.c | 29 ++++++++++++++++++++++-------
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/super.c      |  1 +
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/crypto_key.c b/fs/f2fs/crypto_key.c
index 8a10569..a25b164 100644
--- a/fs/f2fs/crypto_key.c
+++ b/fs/f2fs/crypto_key.c
@@ -87,7 +87,7 @@ out:
 	return res;
 }
 
-void f2fs_free_encryption_info(struct inode *inode)
+static void _f2fs_free_encryption_info(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_crypt_info *ci = fi->i_crypt_info;
@@ -103,6 +103,13 @@ void f2fs_free_encryption_info(struct inode *inode)
 	fi->i_crypt_info = NULL;
 }
 
+void f2fs_free_encryption_info(struct inode *inode)
+{
+	down_write(&F2FS_I(inode)->crypto_rwsem);
+	_f2fs_free_encryption_info(inode);
+	up_write(&F2FS_I(inode)->crypto_rwsem);
+}
+
 int _f2fs_get_encryption_info(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -119,12 +126,13 @@ int _f2fs_get_encryption_info(struct inode *inode)
 	if (res)
 		return res;
 
-	if (fi->i_crypt_info) {
-		if (!fi->i_crypt_info->ci_keyring_key ||
-			key_validate(fi->i_crypt_info->ci_keyring_key) == 0)
-			return 0;
-		f2fs_free_encryption_info(inode);
+	down_read(&fi->crypto_rwsem);
+	if (fi->i_crypt_info && (!fi->i_crypt_info->ci_keyring_key ||
+			key_validate(fi->i_crypt_info->ci_keyring_key) == 0)) {
+		up_read(&fi->crypto_rwsem);
+		return 0;
 	}
+	up_read(&fi->crypto_rwsem);
 
 	res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
 				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
@@ -187,8 +195,11 @@ out:
 			res = 0;
 		kmem_cache_free(f2fs_crypt_info_cachep, crypt_info);
 	} else {
+		down_write(&fi->crypto_rwsem);
+		_f2fs_free_encryption_info(inode);
 		fi->i_crypt_info = crypt_info;
 		crypt_info->ci_keyring_key = keyring_key;
+		up_write(&fi->crypto_rwsem);
 		keyring_key = NULL;
 	}
 	if (keyring_key)
@@ -199,6 +210,10 @@ out:
 int f2fs_has_encryption_key(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
+	int ret;
 
-	return (fi->i_crypt_info != NULL);
+	down_read(&fi->crypto_rwsem);
+	ret = (fi->i_crypt_info != NULL);
+	up_read(&fi->crypto_rwsem);
+	return ret;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5119167..c44d7bf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -431,6 +431,7 @@ struct f2fs_inode_info {
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	/* Encryption params */
 	struct f2fs_crypt_info *i_crypt_info;
+	struct rw_semaphore crypto_rwsem;	/* lock for crypt_info */
 #endif
 };
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bbeb6d7..137d1b7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -418,6 +418,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	fi->i_crypt_info = NULL;
+	init_rwsem(&fi->crypto_rwsem);
 #endif
 	return &fi->vfs_inode;
 }
-- 
2.1.1
