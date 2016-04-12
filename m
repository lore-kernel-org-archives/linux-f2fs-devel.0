From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: use dget_parent and file_dentry in
	f2fs_file_open
Date: Tue, 12 Apr 2016 10:27:21 -0700
Message-ID: <1460482042-14011-2-git-send-email-jaegeuk@kernel.org>
References: <1460482042-14011-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aq26B-0006a9-Mn
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Apr 2016 17:27:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aq26A-0001z7-Tn
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Apr 2016 17:27:35 +0000
In-Reply-To: <1460482042-14011-1-git-send-email-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Miklos Szeredi <mszeredi@redhat.com>

This patch synced with the below two ext4 crypto fixes together.

In 4.6-rc1, f2fs newly introduced accessing f_path.dentry which crashes
overlayfs. To fix, now we need to use file_dentry() to access that field.

Fixes: c0a37d487884 ("ext4: use file_dentry()")
Fixes: 9dd78d8c9a7b ("ext4: use dget_parent() in ext4_file_open()")
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 443e077..90d1157 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -441,7 +441,7 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 static int f2fs_file_open(struct inode *inode, struct file *filp)
 {
 	int ret = generic_file_open(inode, filp);
-	struct inode *dir = filp->f_path.dentry->d_parent->d_inode;
+	struct dentry *dir;
 
 	if (!ret && f2fs_encrypted_inode(inode)) {
 		ret = fscrypt_get_encryption_info(inode);
@@ -450,9 +450,13 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 		if (!fscrypt_has_encryption_key(inode))
 			return -ENOKEY;
 	}
-	if (f2fs_encrypted_inode(dir) &&
-			!fscrypt_has_permitted_context(dir, inode))
+	dir = dget_parent(file_dentry(filp));
+	if (f2fs_encrypted_inode(d_inode(dir)) &&
+			!fscrypt_has_permitted_context(d_inode(dir), inode)) {
+		dput(dir);
 		return -EPERM;
+	}
+	dput(dir);
 	return ret;
 }
 
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
