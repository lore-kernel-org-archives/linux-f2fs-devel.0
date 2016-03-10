From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to avoid unneeded unlock_new_inode
Date: Thu, 10 Mar 2016 22:24:23 +0800
Message-ID: <56E18397.9010501@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

During ->lookup, I_NEW state of inode was been cleared in f2fs_iget,
so in error path, we don't need to clear it again.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/namei.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 7b07a47..7876f10 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -308,13 +308,13 @@ static struct dentry *f2fs_lookup(struct inode *dir,
struct dentry *dentry,
 			!fscrypt_has_permitted_context(dir, inode)) {
 		bool nokey = f2fs_encrypted_inode(inode) &&
 			!fscrypt_has_encryption_key(inode);
-		iput(inode);
-		return nokey ? ERR_PTR(-ENOKEY) : ERR_PTR(-EPERM);
+		err = nokey ? -ENOKEY : -EPERM;
+		goto err_out;
 	}
 	return d_splice_alias(inode, dentry);

 err_out:
-	iget_failed(inode);
+	iput(inode);
 	return ERR_PTR(err);
 }

-- 
2.7.2
