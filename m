From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 7/7] f2fs crypto: handle unexpected lack of encryption keys
Date: Sun, 14 Feb 2016 18:58:35 +0800
Message-ID: <010001d16716$bfda6f00$3f8f4d00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, tytso@mit.edu
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch syncs f2fs with commit abdd438b26b4 ("ext4 crypto: handle
unexpected lack of encryption keys") from ext4.

Fix up attempts by users to try to write to a file when they don't
have access to the encryption key.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/crypto_policy.c | 3 ++-
 fs/f2fs/file.c          | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/crypto_policy.c b/fs/f2fs/crypto_policy.c
index 0fb08b0..4d7d7ff 100644
--- a/fs/f2fs/crypto_policy.c
+++ b/fs/f2fs/crypto_policy.c
@@ -192,7 +192,8 @@ int f2fs_inherit_context(struct inode *parent, struct inode *child,
 		return res;
 
 	ci = F2FS_I(parent)->i_crypt_info;
-	BUG_ON(ci == NULL);
+	if (ci == NULL)
+		return -ENOKEY;
 
 	ctx.format = F2FS_ENCRYPTION_CONTEXT_FORMAT_V1;
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 05f5f2f..8dea195 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -424,6 +424,8 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		err = f2fs_get_encryption_info(inode);
 		if (err)
 			return 0;
+		if (!f2fs_encrypted_inode(inode))
+			return -ENOKEY;
 	}
 
 	/* we don't need to use inline_data strictly */
@@ -443,7 +445,9 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (!ret && f2fs_encrypted_inode(inode)) {
 		ret = f2fs_get_encryption_info(inode);
 		if (ret)
-			ret = -EACCES;
+			return -EACCES;
+		if (!f2fs_encrypted_inode(inode))
+			return -ENOKEY;
 	}
 	return ret;
 }
-- 
2.7.0.2.g1b0b6dd
