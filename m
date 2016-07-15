From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: reset default idle interval value
Date: Fri, 15 Jul 2016 19:25:47 +0800
Message-ID: <20160715112547.67268-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The default value of idle interval is 2 mins, but for most time when
screen shutdown, there are still operations during the 2 mins interval,
and gc's sleep time is about 30 secs to 60 secs, so there is almost no
chance for GC thread to do garbage collecting.

Set default value of idle interval value from 2 mins to 5 secs for
fixing.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0b616c9..55f1a41 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -164,7 +164,7 @@ enum {
 #define BATCHED_TRIM_BLOCKS(sbi)	\
 		(BATCHED_TRIM_SEGMENTS(sbi) << (sbi)->log_blocks_per_seg)
 #define DEF_CP_INTERVAL			60	/* 60 secs */
-#define DEF_IDLE_INTERVAL		120	/* 2 mins */
+#define DEF_IDLE_INTERVAL		5	/* 5 secs */
 
 struct cp_control {
 	int reason;
-- 
2.8.2.311.gee88674
