From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: clean up codes in f2fs_gc related with write_checkpoint
Date: Tue, 21 Feb 2017 20:43:48 +0800
Message-ID: <1487681028-19410-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, yunlong.song@huawei.com, miaoxie@huawei.com
Cc: bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/gc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 88e5e7b..e5f2569 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -943,23 +943,15 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
 		 * enough free sections, we should flush dent/node blocks and do
 		 * garbage collections.
 		 */
-		if (__get_victim(sbi, &segno, gc_type) ||
-						prefree_segments(sbi)) {
-			ret = write_checkpoint(sbi, &cpc);
-			if (ret)
-				goto stop;
-			segno = NULL_SEGNO;
-		} else if (has_not_enough_free_secs(sbi, 0, 0)) {
-			ret = write_checkpoint(sbi, &cpc);
-			if (ret)
-				goto stop;
-		}
+		ret = write_checkpoint(sbi, &cpc);
+		if (ret)
+			goto stop;
 	} else if (gc_type == BG_GC && !background) {
 		/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
 		goto stop;
 	}
 
-	if (segno == NULL_SEGNO && !__get_victim(sbi, &segno, gc_type))
+	if (!__get_victim(sbi, &segno, gc_type))
 		goto stop;
 	ret = 0;
 
-- 
1.8.5.2
