From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: set SBI_NEED_FSCK when encountering exception in recovery
Date: Mon, 16 Mar 2015 21:08:44 +0800
Message-ID: <002e01d05fea$6efffac0$4cfff040$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch tries to set SBI_NEED_FSCK flag into sbi only when we fail to recover
in fill_super, so we could skip fscking image when we fail to fill super for
other reason.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/super.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e649f21..476df03 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -966,7 +966,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	struct buffer_head *raw_super_buf;
 	struct inode *root;
 	long err = -EINVAL;
-	bool retry = true;
+	bool retry = true, need_fsck = false;
 	char *options = NULL;
 	int i;
 
@@ -1155,9 +1155,6 @@ try_onemore:
 	if (err)
 		goto free_proc;
 
-	if (!retry)
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-
 	/* recover fsynced data */
 	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
 		/*
@@ -1169,8 +1166,13 @@ try_onemore:
 			err = -EROFS;
 			goto free_kobj;
 		}
+
+		if (need_fsck)
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+
 		err = recover_fsync_data(sbi);
 		if (err) {
+			need_fsck = true;
 			f2fs_msg(sb, KERN_ERR,
 				"Cannot recover all fsync data errno=%ld", err);
 			goto free_kobj;
-- 
2.3.0
