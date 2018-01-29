From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: fix heap mode to reset it back
Date: Mon, 29 Jan 2018 11:37:45 +0800
Message-ID: <1517197065-156255-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Commit 7a20b8a61eff81bdb7097a578752a74860e9d142 ("f2fs: allocate node
and hot data in the beginning of partition") introduces another mount
option, heap, to reset it back. But it does not do anything for heap
mode, so fix it.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/gc.c      | 5 +++--
 fs/f2fs/segment.c | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index aa720cc..b9d93fd 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -191,8 +191,9 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 	if (gc_type != FG_GC && p->max_search > sbi->max_victim_search)
 		p->max_search = sbi->max_victim_search;
 
-	/* let's select beginning hot/small space first */
-	if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
+	/* let's select beginning hot/small space first in no_heap mode*/
+	if (test_opt(sbi, NOHEAP) &&
+		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
 		p->offset = 0;
 	else
 		p->offset = SIT_I(sbi)->last_victim[p->gc_mode];
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e5739ce..77a48c4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2167,7 +2167,8 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 	if (sbi->segs_per_sec != 1)
 		return CURSEG_I(sbi, type)->segno;
 
-	if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
+	if (test_opt(sbi, NOHEAP) &&
+		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
 		return 0;
 
 	if (SIT_I(sbi)->last_victim[ALLOC_NEXT])
-- 
1.8.5.2
