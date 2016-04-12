From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] fscrypto: use dget_parent() in
	fscrypt_d_revalidate()
Date: Tue, 12 Apr 2016 10:27:20 -0700
Message-ID: <1460482042-14011-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aq26A-0006Zu-EY
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Apr 2016 17:27:34 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aq269-0002Gp-Jv
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Apr 2016 17:27:34 +0000
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

This patch updates fscrypto along with the below ext4 crypto change.

Fixes: 3d43bcfef5f0 ("ext4 crypto: use dget_parent() in ext4_d_revalidate()")
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/crypto/crypto.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 7f58045..58ae0ba 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -345,13 +345,17 @@ EXPORT_SYMBOL(fscrypt_zeroout_range);
  */
 static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 {
-	struct inode *dir = d_inode(dentry->d_parent);
-	struct fscrypt_info *ci = dir->i_crypt_info;
+	struct dentry *dir;
+	struct fscrypt_info *ci;
 	int dir_has_key, cached_with_key;
 
-	if (!dir->i_sb->s_cop->is_encrypted(dir))
+	dir = dget_parent(dentry);
+	if (!d_inode(dir)->i_sb->s_cop->is_encrypted(d_inode(dir))) {
+		dput(dir);
 		return 0;
+	}
 
+	ci = d_inode(dir)->i_crypt_info;
 	if (ci && ci->ci_keyring_key &&
 	    (ci->ci_keyring_key->flags & ((1 << KEY_FLAG_INVALIDATED) |
 					  (1 << KEY_FLAG_REVOKED) |
@@ -363,6 +367,7 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 	cached_with_key = dentry->d_flags & DCACHE_ENCRYPTED_WITH_KEY;
 	spin_unlock(&dentry->d_lock);
 	dir_has_key = (ci != NULL);
+	dput(dir);
 
 	/*
 	 * If the dentry was cached without the key, and it is a
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
