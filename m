From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix wrong bfree and bavail
Date: Tue,  5 Sep 2017 14:06:53 -0700
Message-ID: <20170905210653.46186-1-jaegeuk@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes bavail and bfree finally.

long    f_bfree;    /* free blocks in fs */
long    f_bavail;   /* free blocks avail to non-superuser */

So, bfree represents all the reserved blocks, while bavail does the space only
visible to normal user.

Fix: 3e6d0b4d9c1c ("f2fs: fix incorrect f_bfree calculation in ->statfs")
Cc: <stable@vger.kernel.org> # 4.8+
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7e29db227910..17cca4cb93af 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -955,8 +955,8 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bsize = sbi->blocksize;
 
 	buf->f_blocks = total_count - start_count;
-	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
-	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
+	buf->f_bfree = user_block_count - valid_user_blocks(sbi);
+	buf->f_bavail = user_block_count - valid_user_blocks(sbi) - ovp_count -
 						sbi->reserved_blocks;
 
 	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
