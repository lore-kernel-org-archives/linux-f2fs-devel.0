From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v3] f2fs: issue discard align to section in LFS mode
Date: Thu, 19 Jul 2018 20:58:15 +0800
Message-ID: <1532005095-111878-1-git-send-email-yunlong.song@huawei.com>
References: <1531836275-94933-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531836275-94933-1-git-send-email-yunlong.song@huawei.com>
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
f2fs_issue_discard of this same section in the next write_checkpoint:

round 1: section bitmap : 1 1 1 1 1, all valid, prefree_map: 0 0 0 0 0
then rm data block NO.2, block NO.2 becomes invalid, prefree_map: 0 0 1 0 0
write_checkpoint: section bitmap: 1 1 0 1 1, prefree_map: 0 0 0 0 0,
prefree of NO.2 is cleared, and no discard issued

round 2: rm data block NO.0, NO.1, NO.3, NO.4
all invalid, but prefree bit of NO.2 is set and cleared in round 1, then
prefree_map: 1 1 0 1 1
write_checkpoint: section bitmap: 0 0 0 0 0, prefree_map: 0 0 0 1 1, no
valid blocks of this section, so discard issued, but this time prefree
bit of NO.3 and NO.4 is skipped due to start = start_segno + sbi->segs_per_sec;

round 3:
write_checkpoint: section bitmap: 0 0 0 0 0, prefree_map: 0 0 0 1 1 ->
0 0 0 0 0, no valid blocks of this section, so discard issued,
this time prefree bit of NO.3 and NO.4 is cleared, but the discard of
this section is sent again...

To fix this problem, we can align the start and end value to section
boundary for fstrim and real-time discard operation, and decide to issue
discard only when the whole section is invalid, which can issue discard
aligned to section size as much as possible and avoid redundant discard.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cfff7cf..97770f3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1710,21 +1710,30 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 	unsigned int start = 0, end = -1;
 	unsigned int secno, start_segno;
 	bool force = (cpc->reason & CP_DISCARD);
+	bool need_align = test_opt(sbi, LFS) && sbi->segs_per_sec > 1;
 
 	mutex_lock(&dirty_i->seglist_lock);
 
 	while (1) {
 		int i;
+
+		if (need_align && end != -1)
+			end--;
 		start = find_next_bit(prefree_map, MAIN_SEGS(sbi), end + 1);
 		if (start >= MAIN_SEGS(sbi))
 			break;
 		end = find_next_zero_bit(prefree_map, MAIN_SEGS(sbi),
 								start + 1);
 
-		for (i = start; i < end; i++)
-			clear_bit(i, prefree_map);
+		if (need_align) {
+			start = rounddown(start, sbi->segs_per_sec);
+			end = roundup(end, sbi->segs_per_sec);
+		}
 
-		dirty_i->nr_dirty[PRE] -= end - start;
+		for (i = start; i < end; i++) {
+			if (test_and_clear_bit(i, prefree_map))
+				dirty_i->nr_dirty[PRE]--;
+		}
 
 		if (!test_opt(sbi, DISCARD))
 			continue;
@@ -2511,6 +2520,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	struct discard_policy dpolicy;
 	unsigned long long trimmed = 0;
 	int err = 0;
+	bool need_align = test_opt(sbi, LFS) && sbi->segs_per_sec > 1;
 
 	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
 		return -EINVAL;
@@ -2528,6 +2538,10 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	start_segno = (start <= MAIN_BLKADDR(sbi)) ? 0 : GET_SEGNO(sbi, start);
 	end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
 						GET_SEGNO(sbi, end);
+	if (need_align) {
+		start_segno = rounddown(start_segno, sbi->segs_per_sec);
+		end_segno = roundup(end_segno + 1, sbi->segs_per_sec) - 1;
+	}
 
 	cpc.reason = CP_DISCARD;
 	cpc.trim_minlen = max_t(__u64, 1, F2FS_BYTES_TO_BLK(range->minlen));
-- 
1.8.5.2
