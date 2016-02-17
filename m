From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] f2fs: slightly reorganize read_raw_super_block
Date: Wed, 17 Feb 2016 08:59:01 +0800
Message-ID: <1455670741-22642-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: Chao Yu <chao2.yu@samsung.com>, Shawn Lin <shawn.lin@kernel-upstream.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

read_raw_super_block was introduced to help find the
first valid superblock. Commit da554e48caab ("f2fs:
recovering broken superblock during mount") changed the
behaviour to read both of them and check whether need
the recovery flag or not. So the comment before this
function isn't consistent with what it actually does.
Also, the origin code use two tags to round the err
cases, which isn't so readable. So this patch amend
the comment and slightly reorganize it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 fs/f2fs/super.c | 73 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9445a34..73847fa 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1166,14 +1166,15 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 
 /*
  * Read f2fs raw super block.
- * Because we have two copies of super block, so read the first one at first,
- * if the first one is invalid, move to read the second one.
+ * Because we have two copies of super block, so read both of them
+ * to get the first valid one. If any one of them is broken, we pass
+ * them recovery flag back to the caller.
  */
 static int read_raw_super_block(struct super_block *sb,
 			struct f2fs_super_block **raw_super,
 			int *valid_super_block, int *recovery)
 {
-	int block = 0;
+	int block;
 	struct buffer_head *bh;
 	struct f2fs_super_block *super, *buf;
 	int err = 0;
@@ -1181,50 +1182,48 @@ static int read_raw_super_block(struct super_block *sb,
 	super = kzalloc(sizeof(struct f2fs_super_block), GFP_KERNEL);
 	if (!super)
 		return -ENOMEM;
-retry:
-	bh = sb_bread(sb, block);
-	if (!bh) {
-		*recovery = 1;
-		f2fs_msg(sb, KERN_ERR, "Unable to read %dth superblock",
+
+	for (block = 0; block < 2; block++) {
+		bh = sb_bread(sb, block);
+		if (!bh) {
+			f2fs_msg(sb, KERN_ERR, "Unable to read %dth superblock",
 				block + 1);
-		err = -EIO;
-		goto next;
-	}
+			err = -EIO;
+			continue;
+		}
 
-	buf = (struct f2fs_super_block *)(bh->b_data + F2FS_SUPER_OFFSET);
+		buf = (struct f2fs_super_block *)
+				(bh->b_data + F2FS_SUPER_OFFSET);
 
-	/* sanity checking of raw super */
-	if (sanity_check_raw_super(sb, buf)) {
-		brelse(bh);
-		*recovery = 1;
-		f2fs_msg(sb, KERN_ERR,
-			"Can't find valid F2FS filesystem in %dth superblock",
-								block + 1);
-		err = -EINVAL;
-		goto next;
-	}
+		/* sanity checking of raw super */
+		if (sanity_check_raw_super(sb, buf)) {
+			f2fs_msg(sb, KERN_ERR,
+				"Can't find valid F2FS filesystem in %dth superblock",
+				block + 1);
+			err = -EINVAL;
+			brelse(bh);
+			continue;
+		}
 
-	if (!*raw_super) {
-		memcpy(super, buf, sizeof(*super));
-		*valid_super_block = block;
-		*raw_super = super;
+		if (!*raw_super) {
+			memcpy(super, buf, sizeof(*super));
+			*valid_super_block = block;
+			*raw_super = super;
+		}
+		brelse(bh);
 	}
-	brelse(bh);
 
-next:
-	/* check the validity of the second superblock */
-	if (block == 0) {
-		block++;
-		goto retry;
-	}
+	/* Fail to read any one of the superblocks*/
+	if (err < 0)
+		*recovery = 1;
 
 	/* No valid superblock */
-	if (!*raw_super) {
+	if (!*raw_super)
 		kfree(super);
-		return err;
-	}
+	else
+		err = 0;
 
-	return 0;
+	return err;
 }
 
 static int __f2fs_commit_super(struct f2fs_sb_info *sbi, int block)
-- 
2.3.7
