From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2 4/5] f2fs: switch to fscrypt_prepare_lookup()
Date: Wed, 29 Nov 2017 12:35:31 -0800
Message-ID: <20171129203532.87729-5-ebiggers3@gmail.com>
References: <20171129203532.87729-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <ebiggers3@gmail.com>) id 1eK96N-0004Bd-6A
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 29 Nov 2017 20:37:03 +0000
Received: from mail-it0-f67.google.com ([209.85.214.67])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1eK96L-0004Jn-3c
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 29 Nov 2017 20:37:03 +0000
Received: by mail-it0-f67.google.com with SMTP id f143so5776062itb.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 29 Nov 2017 12:37:01 -0800 (PST)
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
 fs/f2fs/namei.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e910d2ebe0c6..bbb3fc1e2bef 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -357,20 +357,9 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 
 	trace_f2fs_lookup_start(dir, dentry, flags);
 
-	if (f2fs_encrypted_inode(dir)) {
-		err = fscrypt_get_encryption_info(dir);
-
-		/*
-		 * DCACHE_ENCRYPTED_WITH_KEY is set if the dentry is
-		 * created while the directory was encrypted and we
-		 * don't have access to the key.
-		 */
-		if (fscrypt_has_encryption_key(dir))
-			fscrypt_set_encrypted_dentry(dentry);
-		fscrypt_set_d_op(dentry);
-		if (err && err != -ENOKEY)
-			goto out;
-	}
+	err = fscrypt_prepare_lookup(dir, dentry, flags);
+	if (err)
+		goto out;
 
 	if (dentry->d_name.len > F2FS_NAME_LEN) {
 		err = -ENAMETOOLONG;
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
