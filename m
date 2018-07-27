From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/4] f2fs: don't keep meta pages used for block migration
Date: Fri, 27 Jul 2018 18:15:13 +0800
Message-ID: <20180727101516.41403-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

For migration of encrypted inode's block, we load data of encrypted block
into meta inode's page cache, after checkpoint, those all intermediate
pages should be clean, and no one will read them again, so let's just
release them for more memory.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 12bebb8fa13d..67834d0ca422 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1499,6 +1499,14 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	commit_checkpoint(sbi, ckpt, start_blk);
 	wait_on_all_pages_writeback(sbi);
 
+	/*
+	 * invalidate intermediate page cache borrowed from meta inode
+	 * which are used for migration of encrypted inode's blocks.
+	 */
+	if (f2fs_sb_has_encrypt(sbi->sb))
+		invalidate_mapping_pages(META_MAPPING(sbi),
+				MAIN_BLKADDR(sbi), MAX_BLKADDR(sbi) - 1);
+
 	f2fs_release_ino_entry(sbi, false);
 
 	f2fs_reset_fsync_node_info(sbi);
-- 
2.18.0.rc1
