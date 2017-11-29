From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2 5/5] f2fs: switch to fscrypt_prepare_setattr()
Date: Wed, 29 Nov 2017 12:35:32 -0800
Message-ID: <20171129203532.87729-6-ebiggers3@gmail.com>
References: <20171129203532.87729-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <ebiggers3@gmail.com>) id 1eK96O-0004Bk-8H
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 29 Nov 2017 20:37:04 +0000
Received: from mail-io0-f195.google.com ([209.85.223.195])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1eK96M-00057O-AY
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 29 Nov 2017 20:37:04 +0000
Received: by mail-io0-f195.google.com with SMTP id h12so5110617iof.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 29 Nov 2017 12:37:02 -0800 (PST)
In-Reply-To: <20171129203532.87729-1-ebiggers3@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org, Eric Biggers <ebiggers@google.com>

From: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ae2cf96190e4..52b8f95b9bee 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -743,6 +743,10 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (err)
 		return err;
 
+	err = fscrypt_prepare_setattr(dentry, attr);
+	if (err)
+		return err;
+
 	if (is_quota_modification(inode, attr)) {
 		err = dquot_initialize(inode);
 		if (err)
@@ -758,14 +762,6 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 
 	if (attr->ia_valid & ATTR_SIZE) {
-		if (f2fs_encrypted_inode(inode)) {
-			err = fscrypt_get_encryption_info(inode);
-			if (err)
-				return err;
-			if (!fscrypt_has_encryption_key(inode))
-				return -ENOKEY;
-		}
-
 		if (attr->ia_size <= i_size_read(inode)) {
 			down_write(&F2FS_I(inode)->i_mmap_sem);
 			truncate_setsize(inode, attr->ia_size);
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
