From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: don't allow rename unencrypted file to
	encrypted directory
Date: Wed, 8 Mar 2017 20:08:20 +0800
Message-ID: <20170308120820.86785-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1claP9-00047D-Sb
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 12:09:19 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1claP8-000752-Ou
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 12:09:19 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In commit d9cdc9033181 ("ext4 crypto: enforce context consistency") we
declared that:

2) All files or directories in a directory must be protected using the
    same key as their containing directory.

But in f2fs_cross_rename there is a vulnerability that allow to cross
rename unencrypted file into encrypted directory, it needs to be refused.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/namei.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 25c073f6c7d4..8de684b84cb9 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -855,6 +855,10 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 			!fscrypt_has_encryption_key(new_dir)))
 		return -ENOKEY;
 
+	if (f2fs_encrypted_inode(old_dir) && !f2fs_encrypted_inode(new_inode) ||
+		f2fs_encrypted_inode(new_dir) && !f2fs_encrypted_inode(old_inode))
+		return -EPERM;
+
 	if ((f2fs_encrypted_inode(old_dir) || f2fs_encrypted_inode(new_dir)) &&
 			(old_dir != new_dir) &&
 			(!fscrypt_has_permitted_context(new_dir, old_inode) ||
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
