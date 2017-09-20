From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 15/25] ext4: switch to fscrypt_prepare_setattr()
Date: Wed, 20 Sep 2017 15:45:55 -0700
Message-ID: <20170920224605.22030-16-ebiggers3@gmail.com>
References: <20170920224605.22030-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <ebiggers3@gmail.com>) id 1dunly-0003ml-8c
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Sep 2017 22:47:14 +0000
Received: from mail-pg0-f67.google.com ([74.125.83.67])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dunlx-0004tv-EC
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Sep 2017 22:47:14 +0000
Received: by mail-pg0-f67.google.com with SMTP id u18so2378975pgo.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 20 Sep 2017 15:47:13 -0700 (PDT)
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
 fs/ext4/inode.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d5a471939fbc..617c7feced24 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5311,6 +5311,10 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 	if (error)
 		return error;
 
+	error = fscrypt_prepare_setattr(dentry, attr);
+	if (error)
+		return error;
+
 	if (is_quota_modification(inode, attr)) {
 		error = dquot_initialize(inode);
 		if (error)
@@ -5356,14 +5360,6 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		loff_t oldsize = inode->i_size;
 		int shrink = (attr->ia_size <= inode->i_size);
 
-		if (ext4_encrypted_inode(inode)) {
-			error = fscrypt_get_encryption_info(inode);
-			if (error)
-				return error;
-			if (!fscrypt_has_encryption_key(inode))
-				return -ENOKEY;
-		}
-
 		if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
 			struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
-- 
2.14.1.821.g8fa685d3b7-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
