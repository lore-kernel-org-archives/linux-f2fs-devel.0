From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: skip filesystem level truncate when size
	isn't changed
Date: Tue, 28 Feb 2017 21:34:53 +0800
Message-ID: <83e7d52c-148c-1b7c-f41d-2cbd89d87094@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cihvp-0004DB-9h
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Feb 2017 13:35:09 +0000
Received: from mail-io0-f193.google.com ([209.85.223.193])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cihvn-0003TN-Jp
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Feb 2017 13:35:09 +0000
Received: by mail-io0-f193.google.com with SMTP id w10so1409549iod.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 28 Feb 2017 05:35:07 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

When size isn't changed, it's needless to do f2fs level truncate.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c6ca00c..d144aa3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -676,6 +676,7 @@ static void __setattr_copy(struct inode *inode, const struct iattr *attr)
 int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
+	loff_t old_size = i_size_read(inode);
 	int err;
 	bool size_changed = false;
 
@@ -688,12 +689,13 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 				fscrypt_get_encryption_info(inode))
 			return -EACCES;
 
-		if (attr->ia_size <= i_size_read(inode)) {
+		if (attr->ia_size < old_size) {
 			truncate_setsize(inode, attr->ia_size);
 			err = f2fs_truncate(inode);
 			if (err)
 				return err;
-		} else {
+			size_changed = true;
+		} else if (attr->ia_size > old_size) {
 			/*
 			 * do not trim all blocks after i_size if target size is
 			 * larger than i_size.
@@ -707,9 +709,8 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 					return err;
 			}
 			inode->i_mtime = inode->i_ctime = current_time(inode);
+			size_changed = true;
 		}
-
-		size_changed = true;
 	}
 
 	__setattr_copy(inode, attr);
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
