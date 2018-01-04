From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2 v2] f2fs: show precise # of blocks that user/root can
 use
Date: Wed, 3 Jan 2018 22:50:50 -0800
Message-ID: <20180104065050.GA54234@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180103185845.29953-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180103185845.29953-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Let's show precise # of blocks that user/root can use through bavail and bfree
respectively.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

Change log from v1:
 - clean up obsolete values

 fs/f2fs/super.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0a820ba55b10..f1300cda6bfd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -994,20 +994,19 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct super_block *sb = dentry->d_sb;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
-	block_t total_count, user_block_count, start_count, ovp_count;
+	block_t total_count, user_block_count, start_count;
 	u64 avail_node_count;
 
 	total_count = le64_to_cpu(sbi->raw_super->block_count);
 	user_block_count = sbi->user_block_count;
 	start_count = le32_to_cpu(sbi->raw_super->segment0_blkaddr);
-	ovp_count = SM_I(sbi)->ovp_segments << sbi->log_blocks_per_seg;
 	buf->f_type = F2FS_SUPER_MAGIC;
 	buf->f_bsize = sbi->blocksize;
 
 	buf->f_blocks = total_count - start_count;
-	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
-	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
+	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
 						sbi->current_reserved_blocks;
+	buf->f_bavail = buf->f_bfree;
 
 	avail_node_count = sbi->total_node_count - sbi->nquota_files -
 						F2FS_RESERVED_NODE_NUM;
-- 
2.15.0.531.g2ccb3012c9-goog
