From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: fix a build failure due to missing the
	kobject header
Date: Thu, 08 Aug 2013 16:05:32 +0900
Message-ID: <1375945532-15766-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1V7KIX-0006xd-Md
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Aug 2013 07:06:13 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V7KIS-00088J-13 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Aug 2013 07:06:13 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MR70048IADXW390@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Aug 2013 16:06:01 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, Namjae Jeon <namjae.jeon@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch should resolve the following error reported by kbuild test robot.

All error/warnings:

   In file included from fs/f2fs/dir.c:13:0:
   >> fs/f2fs/f2fs.h:435:17: error: field 's_kobj' has incomplete type
        struct kobject s_kobj;

The failure was caused by missing the kobject header file in dir.c.
So, this patch move the header file to the right location, f2fs.h.

CC: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h  | 1 +
 fs/f2fs/super.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 13db10b..d8e386ce 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/crc32.h>
 #include <linux/magic.h>
+#include <linux/kobject.h>
 
 /*
  * For mount options
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 94c0e20..66d1ec1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -23,7 +23,6 @@
 #include <linux/exportfs.h>
 #include <linux/blkdev.h>
 #include <linux/f2fs_fs.h>
-#include <linux/kobject.h>
 #include <linux/sysfs.h>
 
 #include "f2fs.h"
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
