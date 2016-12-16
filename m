From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] f2fs: remove unneeded condition
Date: Fri, 16 Dec 2016 11:18:15 +0300
Message-ID: <20161216081815.GA6744@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, kernel-janitors@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

We checked that "inode" is not an error pointer earlier so there is
no need to check again here.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 56c19b0610a8..290a9d7060ef 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -321,9 +321,9 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		if (err)
 			goto err_out;
 	}
-	if (!IS_ERR(inode) && f2fs_encrypted_inode(dir) &&
-			(S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
-			!fscrypt_has_permitted_context(dir, inode)) {
+	if (f2fs_encrypted_inode(dir) &&
+	    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
+	    !fscrypt_has_permitted_context(dir, inode)) {
 		bool nokey = f2fs_encrypted_inode(inode) &&
 			!fscrypt_has_encryption_key(inode);
 		err = nokey ? -ENOKEY : -EPERM;
