From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH v2] f2fs: fix wrong return value of
 f2fs_acl_create
Date: Wed, 21 Nov 2018 07:21:38 +0800 (CST)
Message-ID: <3ff4ba33.a5b.167336de02f.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <kernelpatch@126.com>) id 1gPFL6-0002rW-0A
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Nov 2018 23:21:52 +0000
Received: from m15-62.126.com ([220.181.15.62])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1gPFL2-00AmA3-96
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Nov 2018 23:21:51 +0000
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
 fs/f2fs/acl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index fa707cd..22f0d17 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -352,12 +352,14 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
 		return PTR_ERR(p);
 
 	clone = f2fs_acl_clone(p, GFP_NOFS);
-	if (!clone)
-		goto no_mem;
+	if (!clone) {
+		ret = -ENOMEM;
+		goto release_acl;
+	}
 
 	ret = f2fs_acl_create_masq(clone, mode);
 	if (ret < 0)
-		goto no_mem_clone;
+		goto release_clone;
 
 	if (ret == 0)
 		posix_acl_release(clone);
@@ -371,11 +373,11 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
 
 	return 0;
 
-no_mem_clone:
+release_clone:
 	posix_acl_release(clone);
-no_mem:
+release_acl:
 	posix_acl_release(p);
-	return -ENOMEM;
+	return ret;
 }
 
 int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
-- 
1.8.3.1
