From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 2/5] f2fs: clear the remaining prefree_map of the section
Date: Thu, 12 Jul 2018 23:09:27 +0800
Message-ID: <1531408170-45758-3-git-send-email-yunlong.song@huawei.com>
References: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

For the case when sbi->segs_per_sec > 1, take section:segment = 5 for
example, if the section prefree_map is ...previous section | current
section (1 1 0 1 1) | next section..., then the start = x, end = x + 1,
after start = start_segno + sbi->segs_per_sec, start = x + 5, then it
will skip x + 3 and x + 4, but their bitmap is still set, which will
cause duplicated f2fs_issue_discard of this same section in the next
write_checkpoint, so fix it.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 47b6595..fd38b61 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1684,8 +1684,23 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 		start = start_segno + sbi->segs_per_sec;
 		if (start < end)
 			goto next;
-		else
-			end = start - 1;
+		else {
+			start_segno = start;
+
+			while (1) {
+				start = find_next_bit(prefree_map, start_segno,
+									end + 1);
+				if (start >= start_segno)
+					break;
+				end = find_next_zero_bit(prefree_map, start_segno,
+										start + 1);
+				for (i = start; i < end; i++)
+					clear_bit(i, prefree_map);
+				dirty_i->nr_dirty[PRE] -= end - start;
+			}
+
+			end = start_segno - 1;
+		}
 	}
 	mutex_unlock(&dirty_i->seglist_lock);
 
-- 
1.8.5.2
