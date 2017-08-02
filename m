From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: do not change the valid_block value if cur_valid_map was wrongly set or cleared
Date: Wed, 2 Aug 2017 22:16:54 +0800
Message-ID: <1501683414-54834-1-git-send-email-yunlong.song@huawei.com>
References: <1501680013-48861-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501680013-48861-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 40e40c5..9e3249a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1540,6 +1540,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			f2fs_msg(sbi->sb, KERN_ERR,
 				"Bitmap was wrongly set, blk:%u", blkaddr);
 			f2fs_bug_on(sbi, 1);
+			se->valid_blocks--;
+			del = 0;
 		}
 
 		if (f2fs_discard_en(sbi) &&
@@ -1567,6 +1569,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			f2fs_msg(sbi->sb, KERN_ERR,
 				"Bitmap was wrongly cleared, blk:%u", blkaddr);
 			f2fs_bug_on(sbi, 1);
+			se->valid_blocks++;
+			del = 0;
 		}
 
 		if (f2fs_discard_en(sbi) &&
-- 
1.8.5.2
