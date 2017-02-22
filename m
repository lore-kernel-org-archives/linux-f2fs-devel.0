From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 1/3] f2fs: clean up codes in get_ssr_segment
Date: Wed, 22 Feb 2017 20:50:49 +0800
Message-ID: <1487767851-819-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, yunlong.song@huawei.com, miaoxie@huawei.com
Cc: bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index df2ff5c..80997f5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1541,7 +1541,7 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
 
-	if (IS_NODESEG(type) || !has_not_enough_free_secs(sbi, 0, 0))
+	if (IS_NODESEG(type))
 		return v_ops->get_victim(sbi,
 				&(curseg)->next_segno, BG_GC, type, SSR);
 
-- 
1.8.5.2
