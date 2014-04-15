From: Zhang Zhen <zhenzhang.zhang@huawei.com>
Subject: [PATCH] f2fs: atomically set inode->i_flags in
	f2fs_set_inode_flags()
Date: Tue, 15 Apr 2014 14:19:38 +0800
Message-ID: <534CCF7A.3070703@huawei.com>
References: <1397466760-14722-1-git-send-email-zhenzhang.zhang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhenzhang.zhang@huawei.com>) id 1WZwjO-0004Et-9d
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Apr 2014 06:20:30 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WZwjL-0001TU-4J
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Apr 2014 06:20:30 +0000
In-Reply-To: <1397466760-14722-1-git-send-email-zhenzhang.zhang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Use set_mask_bits() to atomically set i_flags instead of clearing out the
S_IMMUTABLE, S_APPEND, etc. flags and then setting them from the
FS_IMMUTABLE_FL, FS_APPEND_FL, etc. flags, since this opens up a race
where an immutable file has the immutable flag cleared for a brief
window of time.

Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
---
 fs/f2fs/inode.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ee829d3..f7a6553 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -12,6 +12,7 @@
 #include <linux/f2fs_fs.h>
 #include <linux/buffer_head.h>
 #include <linux/writeback.h>
+#include <linux/bitops.h>

 #include "f2fs.h"
 #include "node.h"
@@ -21,20 +22,20 @@
 void f2fs_set_inode_flags(struct inode *inode)
 {
 	unsigned int flags = F2FS_I(inode)->i_flags;
-
-	inode->i_flags &= ~(S_SYNC | S_APPEND | S_IMMUTABLE |
-			S_NOATIME | S_DIRSYNC);
+	unsigned int new_fl = 0;

 	if (flags & FS_SYNC_FL)
-		inode->i_flags |= S_SYNC;
+		new_fl |= S_SYNC;
 	if (flags & FS_APPEND_FL)
-		inode->i_flags |= S_APPEND;
+		new_fl |= S_APPEND;
 	if (flags & FS_IMMUTABLE_FL)
-		inode->i_flags |= S_IMMUTABLE;
+		new_fl |= S_IMMUTABLE;
 	if (flags & FS_NOATIME_FL)
-		inode->i_flags |= S_NOATIME;
+		new_fl |= S_NOATIME;
 	if (flags & FS_DIRSYNC_FL)
-		inode->i_flags |= S_DIRSYNC;
+		new_fl |= S_DIRSYNC;
+	set_mask_bits(&inode->i_flags,
+			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC, new_fl);
 }

 static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
-- 
1.6.0.2


.





------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
