From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: early check broken symlink length in the encrypted case
Date: Thu, 24 Dec 2015 17:00:05 -0800
Message-ID: <1451005205-49141-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If link is broken, its len is zero, and we don't need to move forward.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index fb41c80..5cc4128 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -931,7 +931,7 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void **cook
 {
 	struct page *cpage = NULL;
 	char *caddr, *paddr = NULL;
-	struct f2fs_str cstr;
+	struct f2fs_str cstr = FSTR_INIT(NULL, 0);
 	struct f2fs_str pstr = FSTR_INIT(NULL, 0);
 	struct inode *inode = d_inode(dentry);
 	struct f2fs_encrypted_symlink_data *sd;
@@ -952,6 +952,12 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void **cook
 	/* Symlink is encrypted */
 	sd = (struct f2fs_encrypted_symlink_data *)caddr;
 	cstr.len = le16_to_cpu(sd->len);
+
+	/* this is broken symlink case */
+	if (cstr.len == 0) {
+		res = -ENOENT;
+		goto errout;
+	}
 	cstr.name = kmalloc(cstr.len, GFP_NOFS);
 	if (!cstr.name) {
 		res = -ENOMEM;
@@ -960,7 +966,7 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void **cook
 	memcpy(cstr.name, sd->encrypted_path, cstr.len);
 
 	/* this is broken symlink case */
-	if (cstr.name[0] == 0 && cstr.len == 0) {
+	if (cstr.name[0] == 0) {
 		res = -ENOENT;
 		goto errout;
 	}
-- 
2.5.4 (Apple Git-61)
