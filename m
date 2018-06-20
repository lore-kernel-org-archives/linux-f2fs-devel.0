From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH] f2fs-tools: fix compile errors on AOSP
Date: Wed, 20 Jun 2018 21:06:16 +0800
Message-ID: <20180620130616.100017-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fVcon-0004dS-U4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Jun 2018 13:06:37 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fVcom-003Xil-0U
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Jun 2018 13:06:37 +0000
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
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Include needed header files directly to fix compile errors on AOSP.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 include/f2fs_fs.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 49ecee9..0a1ed84 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -13,6 +13,8 @@
 #define __F2FS_FS_H__
 
 #include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
@@ -40,14 +42,6 @@
 #include <linux/blkzoned.h>
 #endif
 
-#ifdef HAVE_STDLIB_H
-#include <stdlib.h>
-#endif
-
-#ifdef HAVE_STRING_H
-#include <string.h>
-#endif
-
 #ifdef HAVE_LIBSELINUX
 #include <selinux/selinux.h>
 #include <selinux/label.h>
-- 
2.17.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
