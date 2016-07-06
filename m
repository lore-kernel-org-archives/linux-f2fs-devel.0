From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix incorrect f_bfree calculation in ->statfs
Date: Wed, 6 Jul 2016 14:13:07 +0800
Message-ID: <20160706061307.108357-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

As manual described, f_bfree indicates total free blocks in fs, in f2fs, it
includes two parts: visible free blocks and over-provision blocks. This
patch corrrects the calculation.

fsblkcnt_t   f_bfree;   /* free blocks in fs */

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 36118cf..f468381 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -816,7 +816,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bsize = sbi->blocksize;
 
 	buf->f_blocks = total_count - start_count;
-	buf->f_bfree = buf->f_blocks - valid_user_blocks(sbi) - ovp_count;
+	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
 	buf->f_bavail = user_block_count - valid_user_blocks(sbi);
 
 	buf->f_files = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
-- 
2.8.2.311.gee88674
