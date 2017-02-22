From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 3/3] f2fs: provide more chance for node and data to get ssr segment
Date: Wed, 22 Feb 2017 20:50:51 +0800
Message-ID: <1487767851-819-3-git-send-email-yunlong.song@huawei.com>
References: <1487767851-819-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487767851-819-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, yunlong.song@huawei.com, miaoxie@huawei.com
Cc: bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9d13743..5fe71b9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1540,12 +1540,17 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
+	int old_type = type;
 
 	if (IS_NODESEG(type)) {
 		for (; type >= CURSEG_HOT_NODE; type--)
 			if (v_ops->get_victim(sbi, &(curseg)->next_segno,
 							BG_GC, type, SSR))
 				return 1;
+		for (type = old_type + 1; type <= CURSEG_COLD_NODE; type++)
+			if (v_ops->get_victim(sbi, &(curseg)->next_segno,
+							BG_GC, type, SSR))
+				return 1;
 		return 0;
 	}
 
@@ -1554,6 +1559,10 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
 						BG_GC, type, SSR))
 			return 1;
+	for (type = old_type + 1; type <= CURSEG_COLD_DATA; type++)
+		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
+						BG_GC, type, SSR))
+			return 1;
 	return 0;
 }
 
-- 
1.8.5.2
