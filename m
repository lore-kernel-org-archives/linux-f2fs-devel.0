From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: update cur_valid_map_mir together with cur_valid_map
Date: Tue, 1 Aug 2017 15:56:46 +0800
Message-ID: <1501574206-150946-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, sylinux@163.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When cur_valid_map passes the f2fs_test_and_set(,clear)_bit test,
cur_valid_map_mir update is skipped unlikely, so fix it.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 151968e..6f7731a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1535,6 +1535,10 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			f2fs_bug_on(sbi, 1);
 #endif
 		}
+#ifdef CONFIG_F2FS_CHECK_FS
+		else
+			f2fs_set_bit(offset, se->cur_valid_map_mir);
+#endif
 		if (f2fs_discard_en(sbi) &&
 			!f2fs_test_and_set_bit(offset, se->discard_map))
 			sbi->discard_blks--;
@@ -1556,6 +1560,10 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			f2fs_bug_on(sbi, 1);
 #endif
 		}
+#ifdef CONFIG_F2FS_CHECK_FS
+		else
+			f2fs_clear_bit(offset, se->cur_valid_map_mir);
+#endif
 		if (f2fs_discard_en(sbi) &&
 			f2fs_test_and_clear_bit(offset, se->discard_map))
 			sbi->discard_blks++;
-- 
1.8.5.2
