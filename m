From: sunqiuyang <sunqiuyang@huawei.com>
Subject: [PATCH] f2fs: fix block address for __check_sit_bitmap
Date: Tue, 18 Dec 2018 17:32:23 +0800
Message-ID: <20181218093223.25242-1-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: fangwei1@huawei.com, yuchangchun1@huawei.com, sunqiuyang@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Qiuyang Sun <sunqiuyang@huawei.com>

Should use lstart (logical start address) instead of start (in dev) here.
This fixes a bug in multi-device scenarios.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 204d31e..1a11e7e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1150,7 +1150,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		list_move_tail(&dc->list, wait_list);
 
 		/* sanity check on discard range */
-		__check_sit_bitmap(sbi, start, start + len);
+		__check_sit_bitmap(sbi, lstart, lstart + len);
 
 		bio->bi_private = dc;
 		bio->bi_end_io = f2fs_submit_discard_endio;
-- 
1.8.3.1
