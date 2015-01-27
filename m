From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/5] f2fs: fix not to drop mount options when retrying fill_super
Date: Tue, 27 Jan 2015 15:31:39 -0800
Message-ID: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If wrong mount option was requested, f2fs tries to fill_super again.
But, during the next trial, f2fs has no valid mount options, since
parse_options deleted all the separators in the original string.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5706c17..fbc7f5a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -950,6 +950,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	struct inode *root;
 	long err = -EINVAL;
 	bool retry = true;
+	char *options = NULL;
 	int i;
 
 try_onemore:
@@ -981,9 +982,15 @@ try_onemore:
 	set_opt(sbi, POSIX_ACL);
 #endif
 	/* parse mount options */
-	err = parse_options(sb, (char *)data);
-	if (err)
+	options = kstrdup((const char *)data, GFP_KERNEL);
+	if (data && !options) {
+		err = -ENOMEM;
 		goto free_sb_buf;
+	}
+
+	err = parse_options(sb, options);
+	if (err)
+		goto free_options;
 
 	sb->s_maxbytes = max_file_size(le32_to_cpu(raw_super->log_blocksize));
 	sb->s_max_links = F2FS_LINK_MAX;
@@ -1027,7 +1034,7 @@ try_onemore:
 	if (IS_ERR(sbi->meta_inode)) {
 		f2fs_msg(sb, KERN_ERR, "Failed to read F2FS meta data inode");
 		err = PTR_ERR(sbi->meta_inode);
-		goto free_sb_buf;
+		goto free_options;
 	}
 
 	err = get_valid_checkpoint(sbi);
@@ -1176,6 +1183,8 @@ free_cp:
 free_meta_inode:
 	make_bad_inode(sbi->meta_inode);
 	iput(sbi->meta_inode);
+free_options:
+	kfree(options);
 free_sb_buf:
 	brelse(raw_super_buf);
 free_sbi:
-- 
2.1.1
