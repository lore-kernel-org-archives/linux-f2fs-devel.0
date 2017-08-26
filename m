From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: discard small invalid blocks in current active segments
Date: Sat, 26 Aug 2017 20:49:32 +0800
Message-ID: <1503751772-158812-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

1. write file A with 5 blocks to current empty active segment
2. remove file A
3. write checkpoint
4. write file B with 507 blocks to the same active segment

If file B is alive all the time, the blocks used by file A will never be
discarded. So current active segment should also be treated as a candidate
for small discards.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8375257..a2e7c8f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1339,7 +1339,9 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 		return false;
 
 	if (!force) {
-		if (!test_opt(sbi, DISCARD) || !se->valid_blocks ||
+		if (!test_opt(sbi, DISCARD) ||
+			(!se->valid_blocks &&
+			!IS_CURSEG(sbi, cpc->trim_start)) ||
 			SM_I(sbi)->dcc_info->nr_discards >=
 				SM_I(sbi)->dcc_info->max_discards)
 			return false;
-- 
1.8.5.2
