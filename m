From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: fix small discards when se->valid_blocks is zero
Date: Tue, 3 Jan 2017 17:01:57 +0800
Message-ID: <1483434117-24427-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, yunlong.song@huawei.com
Cc: bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In the small discard case, when se->valid_blocks is zero, the add_discard_addrs
will directly return without __add_discard_entry. This will cause the file
delete have no small discard. The case is like this:

1. Allocate free 2M segment
2. Write a file (size n blocks < 512) in that 2M segment, se->valid_blocks = n
3. Delete that file, se->valid_blocks = 0, add_discard_addrs will return without
sending any discard of that file, and forever due to cur_map[i] ^ ckpt_map[i] =
0 after that checkpoint

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0738f48..8610f14 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -838,7 +838,7 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		return;
 
 	if (!force) {
-		if (!test_opt(sbi, DISCARD) || !se->valid_blocks ||
+		if (!test_opt(sbi, DISCARD) ||
 		    SM_I(sbi)->nr_discards >= SM_I(sbi)->max_discards)
 			return;
 	}
-- 
1.8.5.2
