From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: set 4KB discard granularity by default
Date: Fri, 10 Aug 2018 18:08:05 +0800
Message-ID: <20180810100806.9298-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Small granularity (size < 64K) fragmentation will cause f2fs suspending
all pending discards, result in performance regression, so let's set
4KB discard granularity by default.

So that without fstrim, we also have the ability to avoid any performance
regression caused by non-alignment mapping between fs and flash device.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 58431b9bfd8f..273ffdaf4891 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -248,7 +248,7 @@ struct discard_entry {
 };
 
 /* default discard granularity of inner discard thread, unit: block count */
-#define DEFAULT_DISCARD_GRANULARITY		16
+#define DEFAULT_DISCARD_GRANULARITY		1
 
 /* max discard pend list number */
 #define MAX_PLIST_NUM		512
-- 
2.18.0.rc1
