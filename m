From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 14/25] ext4: switch to fscrypt_prepare_lookup()
Date: Wed, 20 Sep 2017 15:45:54 -0700
Message-ID: <20170920224605.22030-15-ebiggers3@gmail.com>
References: <20170920224605.22030-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <ebiggers3@gmail.com>) id 1dunlx-0004Q7-7w
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Sep 2017 22:47:13 +0000
Received: from mail-pg0-f65.google.com ([74.125.83.65])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dunlw-0003Mo-CO
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Sep 2017 22:47:13 +0000
Received: by mail-pg0-f65.google.com with SMTP id d8so2372880pgt.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 20 Sep 2017 15:47:12 -0700 (PDT)
In-Reply-To: <20170920224605.22030-1-ebiggers3@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fscrypt@vger.kernel.org
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@google.com>, Michael Halcrow <mhalcrow@google.com>, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/namei.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index b2fbc2b87bcf..a6b6f09e0a88 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1538,24 +1538,14 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 	struct inode *inode;
 	struct ext4_dir_entry_2 *de;
 	struct buffer_head *bh;
+	int err;
 
-	if (ext4_encrypted_inode(dir)) {
-		int res = fscrypt_get_encryption_info(dir);
-
-		/*
-		 * DCACHE_ENCRYPTED_WITH_KEY is set if the dentry is
-		 * created while the directory was encrypted and we
-		 * have access to the key.
-		 */
-		if (fscrypt_has_encryption_key(dir))
-			fscrypt_set_encrypted_dentry(dentry);
-		fscrypt_set_d_op(dentry);
-		if (res && res != -ENOKEY)
-			return ERR_PTR(res);
-	}
+	err = fscrypt_prepare_lookup(dir, dentry, flags);
+	if (err)
+		return ERR_PTR(err);
 
-       if (dentry->d_name.len > EXT4_NAME_LEN)
-	       return ERR_PTR(-ENAMETOOLONG);
+	if (dentry->d_name.len > EXT4_NAME_LEN)
+		return ERR_PTR(-ENAMETOOLONG);
 
 	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
 	if (IS_ERR(bh))
-- 
2.14.1.821.g8fa685d3b7-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
