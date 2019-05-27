From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH v2] f2fs: ratelimit recovery messages
Date: Mon, 27 May 2019 18:40:55 +0530
Message-ID: <1558962655-25994-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: Sahitya Tummala <stummala@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Ratelimit the recovery logs, which are expected in case
of sudden power down and which could result into too
many prints.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2:
 - fix minor formatting and add new line for printk

 fs/f2fs/recovery.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index e04f82b..60d7652 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -188,8 +188,8 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 		name = "<encrypted>";
 	else
 		name = raw_inode->i_name;
-	f2fs_msg(inode->i_sb, KERN_NOTICE,
-			"%s: ino = %x, name = %s, dir = %lx, err = %d",
+	printk_ratelimited(KERN_NOTICE
+			"%s: ino = %x, name = %s, dir = %lx, err = %d\n",
 			__func__, ino_of_node(ipage), name,
 			IS_ERR(dir) ? 0 : dir->i_ino, err);
 	return err;
@@ -292,8 +292,8 @@ static int recover_inode(struct inode *inode, struct page *page)
 	else
 		name = F2FS_INODE(page)->i_name;
 
-	f2fs_msg(inode->i_sb, KERN_NOTICE,
-		"recover_inode: ino = %x, name = %s, inline = %x",
+	printk_ratelimited(KERN_NOTICE
+			"recover_inode: ino = %x, name = %s, inline = %x\n",
 			ino_of_node(page), name, raw->i_inline);
 	return 0;
 }
@@ -642,11 +642,11 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 err:
 	f2fs_put_dnode(&dn);
 out:
-	f2fs_msg(sbi->sb, KERN_NOTICE,
-		"recover_data: ino = %lx (i_size: %s) recovered = %d, err = %d",
-		inode->i_ino,
-		file_keep_isize(inode) ? "keep" : "recover",
-		recovered, err);
+	printk_ratelimited(KERN_NOTICE
+			"recover_data: ino = %lx (i_size: %s) recovered = %d, err = %d\n",
+			inode->i_ino,
+			file_keep_isize(inode) ? "keep" : "recover",
+			recovered, err);
 	return err;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
