From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/5 v2] f2fs: fix not to drop mount options when retrying
 fill_super
Date: Thu, 29 Jan 2015 10:21:18 -0800
Message-ID: <20150129181944.GA15313@jaegeuk-mac02.mot.com>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
 <002a01d03bb6$530c8340$f92589c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <002a01d03bb6$530c8340$f92589c0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Chang log from v1:
 o fix memory leak pointed by Chao

>From 82760814db6a01539ad15026b0469686110d92bc Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 23 Jan 2015 17:41:39 -0800
Subject: [PATCH] f2fs: fix not to drop mount options when retrying fill_super

If wrong mount option was requested, f2fs tries to fill_super again.
But, during the next trial, f2fs has no valid mount options, since
parse_options deleted all the separators in the original string.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 25f4291..47d9b04 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -951,6 +951,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	struct inode *root;
 	long err = -EINVAL;
 	bool retry = true;
+	char *options = NULL;
 	int i;
 
 try_onemore:
@@ -982,9 +983,15 @@ try_onemore:
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
@@ -1028,7 +1035,7 @@ try_onemore:
 	if (IS_ERR(sbi->meta_inode)) {
 		f2fs_msg(sb, KERN_ERR, "Failed to read F2FS meta data inode");
 		err = PTR_ERR(sbi->meta_inode);
-		goto free_sb_buf;
+		goto free_options;
 	}
 
 	err = get_valid_checkpoint(sbi);
@@ -1153,6 +1160,7 @@ try_onemore:
 		if (err)
 			goto free_kobj;
 	}
+	kfree(options);
 	return 0;
 
 free_kobj:
@@ -1177,6 +1185,8 @@ free_cp:
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
