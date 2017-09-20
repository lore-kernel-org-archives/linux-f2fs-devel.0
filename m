From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 11/25] ext4: switch to fscrypt_file_open()
Date: Wed, 20 Sep 2017 15:45:51 -0700
Message-ID: <20170920224605.22030-12-ebiggers3@gmail.com>
References: <20170920224605.22030-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <ebiggers3@gmail.com>) id 1dunlt-0000Z8-UQ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Sep 2017 22:47:09 +0000
Received: from mail-pg0-f66.google.com ([74.125.83.66])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dunlt-0006oO-6Z
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Sep 2017 22:47:09 +0000
Received: by mail-pg0-f66.google.com with SMTP id j16so2375853pga.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 20 Sep 2017 15:47:09 -0700 (PDT)
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
 fs/ext4/file.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index b1da660ac3bc..ffe9144088f8 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -364,7 +364,6 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 	struct super_block *sb = inode->i_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct vfsmount *mnt = filp->f_path.mnt;
-	struct dentry *dir;
 	struct path path;
 	char buf[64], *cp;
 	int ret;
@@ -404,25 +403,11 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 			ext4_journal_stop(handle);
 		}
 	}
-	if (ext4_encrypted_inode(inode)) {
-		ret = fscrypt_get_encryption_info(inode);
-		if (ret)
-			return -EACCES;
-		if (!fscrypt_has_encryption_key(inode))
-			return -ENOKEY;
-	}
 
-	dir = dget_parent(file_dentry(filp));
-	if (ext4_encrypted_inode(d_inode(dir)) &&
-			!fscrypt_has_permitted_context(d_inode(dir), inode)) {
-		ext4_warning(inode->i_sb,
-			     "Inconsistent encryption contexts: %lu/%lu",
-			     (unsigned long) d_inode(dir)->i_ino,
-			     (unsigned long) inode->i_ino);
-		dput(dir);
-		return -EPERM;
-	}
-	dput(dir);
+	ret = fscrypt_file_open(inode, filp);
+	if (ret)
+		return ret;
+
 	/*
 	 * Set up the jbd2_inode if we are opening the inode for
 	 * writing and the journal is present
-- 
2.14.1.821.g8fa685d3b7-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
