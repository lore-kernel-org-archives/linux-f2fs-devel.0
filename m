From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 07/10] f2fs: don't allow encrypted operations
	without keys
Date: Fri, 30 Dec 2016 10:51:14 -0800
Message-ID: <20161230185117.3832-7-jaegeuk@kernel.org>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cN2H9-0004EC-Uz
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Dec 2016 18:51:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cN2H9-0003t2-08
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Dec 2016 18:51:35 +0000
In-Reply-To: <20161230185117.3832-1-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>

This patch fixes the renaming bug on encrypted filenames, which was pointed by

 (ext4: don't allow encrypted operations without keys)

Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 51c4d6d78058..6d511d349198 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -663,6 +663,12 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
 	int err = -ENOENT;
 
+	if ((f2fs_encrypted_inode(old_dir) &&
+			!fscrypt_has_encryption_key(old_dir)) ||
+			(f2fs_encrypted_inode(new_dir) &&
+			!fscrypt_has_encryption_key(new_dir)))
+		return -ENOKEY;
+
 	if ((old_dir != new_dir) && f2fs_encrypted_inode(new_dir) &&
 			!fscrypt_has_permitted_context(new_dir, old_inode)) {
 		err = -EPERM;
@@ -843,6 +849,12 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	int old_nlink = 0, new_nlink = 0;
 	int err = -ENOENT;
 
+	if ((f2fs_encrypted_inode(old_dir) &&
+			!fscrypt_has_encryption_key(old_dir)) ||
+			(f2fs_encrypted_inode(new_dir) &&
+			!fscrypt_has_encryption_key(new_dir)))
+		return -ENOKEY;
+
 	if ((f2fs_encrypted_inode(old_dir) || f2fs_encrypted_inode(new_dir)) &&
 			(old_dir != new_dir) &&
 			(!fscrypt_has_permitted_context(new_dir, old_inode) ||
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
