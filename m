From: Zhang Zhen <zhenzhang.zhang@huawei.com>
Subject: [PATCH] fs/f2fs: atomically set inode->i_flags
Date: Mon, 24 Aug 2015 11:28:36 +0800
Message-ID: <55DA8F64.3060307@huawei.com>
References: <55DA845C.2020700@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhenzhang.zhang@huawei.com>) id 1ZTiRU-0003zG-6H
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 03:29:04 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZTiRQ-0003MC-4D
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 03:29:04 +0000
In-Reply-To: <55DA845C.2020700@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, cm224.lee@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

According to commit 5f16f3225b06 ("ext4: atomically set inode->i_flags in
ext4_set_inode_flags()").

Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
---
 fs/f2fs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 2550868..141ca63 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -12,7 +12,6 @@
 #include <linux/f2fs_fs.h>
 #include <linux/buffer_head.h>
 #include <linux/writeback.h>
-#include <linux/bitops.h>

 #include "f2fs.h"
 #include "node.h"
@@ -34,8 +33,8 @@ void f2fs_set_inode_flags(struct inode *inode)
 		new_fl |= S_NOATIME;
 	if (flags & FS_DIRSYNC_FL)
 		new_fl |= S_DIRSYNC;
-	set_mask_bits(&inode->i_flags,
-			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC, new_fl);
+	inode_set_flags(inode, new_fl,
+			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
 }

 static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
-- 
1.9.1


.







------------------------------------------------------------------------------
