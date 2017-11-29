From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2 1/5] f2fs: switch to fscrypt_file_open()
Date: Wed, 29 Nov 2017 12:35:28 -0800
Message-ID: <20171129203532.87729-2-ebiggers3@gmail.com>
References: <20171129203532.87729-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <ebiggers3@gmail.com>) id 1eK96I-0000SF-2U
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 29 Nov 2017 20:36:58 +0000
Received: from mail-it0-f66.google.com ([209.85.214.66])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1eK96H-0003cz-5r
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 29 Nov 2017 20:36:58 +0000
Received: by mail-it0-f66.google.com with SMTP id f143so5775808itb.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 29 Nov 2017 12:36:57 -0800 (PST)
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
 fs/f2fs/file.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7874bbd7311d..ae2cf96190e4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -472,22 +472,10 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 static int f2fs_file_open(struct inode *inode, struct file *filp)
 {
-	struct dentry *dir;
+	int err = fscrypt_file_open(inode, filp);
 
-	if (f2fs_encrypted_inode(inode)) {
-		int ret = fscrypt_get_encryption_info(inode);
-		if (ret)
-			return -EACCES;
-		if (!fscrypt_has_encryption_key(inode))
-			return -ENOKEY;
-	}
-	dir = dget_parent(file_dentry(filp));
-	if (f2fs_encrypted_inode(d_inode(dir)) &&
-			!fscrypt_has_permitted_context(d_inode(dir), inode)) {
-		dput(dir);
-		return -EPERM;
-	}
-	dput(dir);
+	if (err)
+		return err;
 	return dquot_file_open(inode, filp);
 }
 
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
