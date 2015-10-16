From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: convert inline_data for f2fs_fiemap
Date: Fri, 16 Oct 2015 09:07:17 -0700
Message-ID: <1445011637-16015-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

For fiemap, we should convert inline_data for user.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 77dfc9e..174a299 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -771,6 +771,13 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (ret)
 		return ret;
 
+	/* we don't need to use inline_data strictly */
+	if (f2fs_has_inline_data(inode)) {
+		ret = f2fs_convert_inline_inode(inode);
+		if (ret)
+			return ret;
+	}
+
 	mutex_lock(&inode->i_mutex);
 
 	if (len >= isize) {
-- 
2.1.1
