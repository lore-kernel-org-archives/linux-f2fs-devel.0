From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v2] f2fs: collect prefree segments to avoild write checkpoint fail
Date: Fri, 1 Sep 2017 20:00:19 +0800
Message-ID: <1504267219-76575-1-git-send-email-yunlong.song@huawei.com>
References: <1503748019-152845-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1503748019-152845-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In come corner case, the reserved segments are used to do gc, and there are
not enough free segments for write checkpoint to finish its job, then the
gc process will fail to change the prefree segments to free segments.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/gc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index cd147e7..6552b04 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1056,6 +1056,16 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 	if (!sync) {
 		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
 			segno = NULL_SEGNO;
+#ifndef CONFIG_F2FS_CHECK_FS
+			if (prefree_segments(sbi) &&
+				has_not_enough_free_secs(sbi,
+					reserved_sections(sbi), 0)) {
+				ret = write_checkpoint(sbi, &cpc);
+				if (ret)
+					goto stop;
+				sec_freed = 0;
+			}
+#endif
 			goto gc_more;
 		}
 
-- 
1.8.5.2
