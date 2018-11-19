From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH] f2fs: fix wrong return value of f2fs_acl_create
Date: Tue, 20 Nov 2018 05:38:34 +0800 (CST)
Message-ID: <26a3c90d.498.1672de9287d.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <kernelpatch@126.com>) id 1gOrFp-0005lC-8P
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 21:38:49 +0000
Received: from m15-63.126.com ([220.181.15.63])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1gOrFm-00EQaC-LV
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 21:38:49 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

When call f2fs_acl_create_masq() failed, the caller f2fs_acl_create()
should return -EIO instead of -ENOMEM, this patch makes it consistent
with posix_acl_create() which has been fixed in commit beaf226b863a
("posix_acl: don't ignore return value of posix_acl_create_masq()").

Fixes: 83dfe53c185e ("f2fs: fix reference leaks in f2fs_acl_create")
Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
---
 fs/f2fs/acl.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index fa707cd..b791c24 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -351,13 +351,14 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 
+	ret = -ENOMEM;
 	clone = f2fs_acl_clone(p, GFP_NOFS);
 	if (!clone)
-		goto no_mem;
+		goto err_release;
 
 	ret = f2fs_acl_create_masq(clone, mode);
 	if (ret < 0)
-		goto no_mem_clone;
+		goto err_release_clone;
 
 	if (ret == 0)
 		posix_acl_release(clone);
@@ -371,11 +372,11 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
 
 	return 0;
 
-no_mem_clone:
+err_release_clone:
 	posix_acl_release(clone);
-no_mem:
+err_release:
 	posix_acl_release(p);
-	return -ENOMEM;
+	return ret;
 }
 
 int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
-- 
1.8.3.1
