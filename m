From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: remove unmatched zero_user_segment when convert inline dentry
Date: Tue, 3 Apr 2018 19:42:41 +0800
Message-ID: <1522755761-131554-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Since the layout of regular dentry block is different from inline dentry
block, zero_user_segment starting from MAX_INLINE_DATA(dir) is not
correct for regular dentry block, besides, bitmap is already copied and
used, so there is no necessary to zero page at all, so just remove the
zero_user_segment is OK.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/inline.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 3b77d64..573ec2f 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -367,7 +367,6 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 		goto out;
 
 	f2fs_wait_on_page_writeback(page, DATA, true);
-	zero_user_segment(page, MAX_INLINE_DATA(dir), PAGE_SIZE);
 
 	dentry_blk = page_address(page);
 
-- 
1.8.5.2
