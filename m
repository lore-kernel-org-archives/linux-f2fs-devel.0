From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 3/3] f2fs: introduce __f2fs_commit_super
Date: Wed, 16 Dec 2015 13:19:35 +0800
Message-ID: <014401d137c1$724252a0$56c6f7e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Introduce __f2fs_commit_super to include duplicated codes in
f2fs_commit_super for cleanup.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
 - clean up codes.
---
 fs/f2fs/super.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0d2d5c2..c3070c1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1194,14 +1194,13 @@ next:
 	return 0;
 }
 
-int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
+int __f2fs_commit_super(struct f2fs_sb_info *sbi, int block)
 {
 	struct f2fs_super_block *super = F2FS_RAW_SUPER(sbi);
 	struct buffer_head *bh;
 	int err;
 
-	/* write back-up superblock first */
-	bh = sb_getblk(sbi->sb, sbi->valid_super_block ? 0 : 1);
+	bh = sb_getblk(sbi->sb, block);
 	if (!bh)
 		return -EIO;
 
@@ -1215,25 +1214,22 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	err = __sync_dirty_buffer(bh, WRITE_FLUSH_FUA);
 	brelse(bh);
 
+	return err;
+}
+
+int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
+{
+	int err;
+
+	/* write back-up superblock first */
+	err = __f2fs_commit_super(sbi, sbi->valid_super_block ? 0 : 1);
+
 	/* if we are in recovery path, skip writing valid superblock */
 	if (recover || err)
 		return err;
 
-	bh = sb_getblk(sbi->sb, sbi->valid_super_block);
-	if (!bh)
-		return -EIO;
-
 	/* write current valid superblock */
-	lock_buffer(bh);
-	memcpy(bh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
-	set_buffer_uptodate(bh);
-	set_buffer_dirty(bh);
-	unlock_buffer(bh);
-
-	err = __sync_dirty_buffer(bh, WRITE_FLUSH_FUA);
-	brelse(bh);
-
-	return err;
+	return __f2fs_commit_super(sbi, sbi->valid_super_block);
 }
 
 static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
-- 
2.6.3
