From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs crypto: avoid unneeded memory allocation in
	->readdir
Date: Sun, 28 Aug 2016 22:00:12 +0800
Message-ID: <1472392812-3302-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1be0fK-0008B9-V2
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 28 Aug 2016 14:02:26 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1be0fJ-0007ub-62
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 28 Aug 2016 14:02:26 +0000
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

When decrypting dirents in ->readdir, fscrypt_fname_disk_to_usr won't
change content of original encrypted dirent, we don't need to allocate
additional buffer for storing mirror of it, so get rid of it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 3522f6f..fbc8ede 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -796,16 +796,9 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			int save_len = fstr->len;
 			int ret;
 
-			de_name.name = f2fs_kmalloc(de_name.len, GFP_NOFS);
-			if (!de_name.name)
-				return false;
-
-			memcpy(de_name.name, d->filename[bit_pos], de_name.len);
-
 			ret = fscrypt_fname_disk_to_usr(d->inode,
 						(u32)de->hash_code, 0,
 						&de_name, fstr);
-			kfree(de_name.name);
 			if (ret < 0)
 				return true;
 
-- 
2.7.2


------------------------------------------------------------------------------
