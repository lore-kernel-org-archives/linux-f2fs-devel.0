From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v2] f2fs: clear the remaining prefree_map of the section
Date: Mon, 16 Jul 2018 18:03:41 +0800
Message-ID: <1531735421-73669-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

For the case when sbi->segs_per_sec > 1 with lfs mode, take
section:segment = 5 for example, if the section prefree_map is
...previous section | current section (1 1 0 1 1) | next section...,
then the start = x, end = x + 1, after start = start_segno +
sbi->segs_per_sec, start = x + 5, then it will skip x + 3 and x + 4, but
their bitmap is still set, which will cause duplicated
f2fs_issue_discard of this same section in the next write_checkpoint, so
fix it.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cfff7cf..5dc1d5cc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1729,6 +1729,15 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 		if (!test_opt(sbi, DISCARD))
 			continue;
 
+		if (test_opt(sbi, LFS) && sbi->segs_per_sec > 1) {
+			start = rounddown(start, sbi->segs_per_sec);
+			i = end;
+			end = roundup(end, sbi->segs_per_sec);
+			while (++i < end)
+				if (test_and_clear_bit(i, prefree_map))
+					dirty_i->nr_dirty[PRE]--;
+		}
+
 		if (force && start >= cpc->trim_start &&
 					(end - 1) <= cpc->trim_end)
 				continue;
-- 
1.8.5.2
