From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: report ENOENT correct in f2fs_rename
Date: Mon, 17 Sep 2018 19:18:04 -0700
Message-ID: <20180918021805.85032-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This fixes wrong error report in f2fs_rename.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 98d3ab7c3ce6..d653be777529 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -833,7 +833,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct f2fs_dir_entry *old_entry;
 	struct f2fs_dir_entry *new_entry;
 	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
-	int err = -ENOENT;
+	int err;
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
@@ -854,6 +854,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (err)
 		goto out;
 
+	err = -ENOENT;
 	if (new_inode) {
 		err = dquot_initialize(new_inode);
 		if (err)
-- 
2.17.0.441.gb46fe60e1d-goog
