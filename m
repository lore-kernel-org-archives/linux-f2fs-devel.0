From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] mkfs.f2fs: support formating large size file in
 32-bits platform
Date: Wed, 17 Oct 2018 09:40:56 +0800
Message-ID: <20181017014056.25796-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gCaq1-0004lL-NU
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Oct 2018 01:41:29 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gCapy-00Ahqg-Dl
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Oct 2018 01:41:29 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

In 32-bits platform, {f,}stat on a large size file during mkfs, it will
cause EOVERFLOW error, this patch fixes to add macro definition
_FILE_OFFSET_BITS to avoid that error.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 lib/libf2fs.c            | 1 +
 mkfs/f2fs_format_utils.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 8bda1fed082c..529f1caa4144 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -7,6 +7,7 @@
  * Dual licensed under the GPL or LGPL version 2 licenses.
  */
 #define _LARGEFILE64_SOURCE
+#define _FILE_OFFSET_BITS 64
 
 #include <f2fs_fs.h>
 #include <stdio.h>
diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index 5b9cc0c6ac69..e620190df4b7 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -16,6 +16,10 @@
 #define _GNU_SOURCE
 #endif
 
+#ifndef _FILE_OFFSET_BITS
+#define _FILE_OFFSET_BITS 64
+#endif
+
 #include <f2fs_fs.h>
 
 #include <stdio.h>
-- 
2.18.0.rc1
