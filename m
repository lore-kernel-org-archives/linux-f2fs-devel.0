From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: put allocate_segment after refresh_sit_entry
Date: Tue, 21 Feb 2017 16:59:26 +0800
Message-ID: <1487667566-2110-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, yunlong.song@huawei.com, miaoxie@huawei.com
Cc: bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

SIT information should be updated before segment allocation, since SSR needs
latest valid block information. Current code does not update the old_blkaddr
info in sit_entry, so adjust the allocate_segment to its proper location. Commit
5e443818fa0b2a2845561ee25bec181424fb2889 ("f2fs: handle dirty segments inside
refresh_sit_entry") puts it into wrong location.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index df2ff5c..89052df 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1743,14 +1743,15 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 
 	stat_inc_block_count(sbi, curseg);
 
-	if (!__has_curseg_space(sbi, type))
-		sit_i->s_ops->allocate_segment(sbi, type, false);
 	/*
 	 * SIT information should be updated before segment allocation,
 	 * since SSR needs latest valid block information.
 	 */
 	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
 
+	if (!__has_curseg_space(sbi, type))
+		sit_i->s_ops->allocate_segment(sbi, type, false);
+
 	mutex_unlock(&sit_i->sentry_lock);
 
 	if (page && IS_NODESEG(type))
-- 
1.8.5.2
