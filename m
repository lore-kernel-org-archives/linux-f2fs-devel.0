From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 09/10] f2fs crypto: sync ext4_lookup and
	ext4_file_open
Date: Thu, 25 Feb 2016 11:26:07 -0800
Message-ID: <1456428368-41527-10-git-send-email-jaegeuk@kernel.org>
References: <1456428368-41527-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aZ1Z4-0001Uc-9g
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Feb 2016 19:27:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aZ1Z3-0003RO-JQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Feb 2016 19:27:06 +0000
In-Reply-To: <1456428368-41527-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, tytso@mit.edu
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch tries to catch up with lookup and open policies in ext4.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c   |  2 +-
 fs/f2fs/file.c  |  4 ++++
 fs/f2fs/namei.c | 23 +++++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index aa06700..31c30dc 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -855,7 +855,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 
 	if (f2fs_encrypted_inode(inode)) {
 		err = fscrypt_get_encryption_info(inode);
-		if (err && err != -EOPNOTSUPP)
+		if (err && err != -ENOKEY && err != -EOPNOTSUPP)
 			return err;
 
 		err = fscrypt_fname_alloc_buffer(inode, F2FS_NAME_LEN, &fstr);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f326764..533c2dc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -441,6 +441,7 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 static int f2fs_file_open(struct inode *inode, struct file *filp)
 {
 	int ret = generic_file_open(inode, filp);
+	struct inode *dir = filp->f_path.dentry->d_parent->d_inode;
 
 	if (!ret && f2fs_encrypted_inode(inode)) {
 		ret = fscrypt_get_encryption_info(inode);
@@ -449,6 +450,9 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 		if (!f2fs_encrypted_inode(inode))
 			return -ENOKEY;
 	}
+	if (f2fs_encrypted_inode(dir) &&
+			!fscrypt_has_permitted_context(dir, inode))
+		return -EPERM;
 	return ret;
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 748022e..55a7362 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -261,6 +261,21 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	nid_t ino;
 	int err = 0;
 
+	if (f2fs_encrypted_inode(dir)) {
+		int res = fscrypt_get_encryption_info(dir);
+
+		/*
+		 * DCACHE_ENCRYPTED_WITH_KEY is set if the dentry is
+		 * created while the directory was encrypted and we
+		 * don't have access to the key.
+		 */
+		if (fscrypt_has_encryption_key(dir))
+			fscrypt_set_encrypted_dentry(dentry);
+		fscrypt_set_d_op(dentry);
+		if (res && res != -ENOKEY)
+			return ERR_PTR(res);
+	}
+
 	if (dentry->d_name.len > F2FS_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
@@ -281,6 +296,14 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		if (err)
 			goto err_out;
 	}
+	if (!IS_ERR(inode) && f2fs_encrypted_inode(dir) &&
+			(S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
+			!fscrypt_has_permitted_context(dir, inode)) {
+		bool nokey = f2fs_encrypted_inode(inode) &&
+			!fscrypt_has_encryption_key(inode);
+		iput(inode);
+		return nokey ? ERR_PTR(-ENOKEY) : ERR_PTR(-EPERM);
+	}
 	return d_splice_alias(inode, dentry);
 
 err_out:
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
