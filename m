From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: add cleancache support
Date: Thu, 13 Nov 2014 14:34:50 +0900
Message-ID: <1415856890-2455-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

To use cleancache, fs must explicitly enable cleancache by calling
cleancache_init_fs.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 512ffd8..2ebb960 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -24,6 +24,7 @@
 #include <linux/blkdev.h>
 #include <linux/f2fs_fs.h>
 #include <linux/sysfs.h>
+#include <linux/cleancache.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -1144,6 +1145,8 @@ try_onemore:
 		if (err)
 			goto free_kobj;
 	}
+
+	cleancache_init_fs(sb);
 	return 0;
 
 free_kobj:
-- 
1.9.1

