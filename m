From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: expose some sectors to user in inline data or dentry case
Date: Fri, 13 Oct 2017 10:31:45 -0700
Message-ID: <20171013173145.36510-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If there's some data written through inline data or dentry, we need to shouw
st_blocks. This fixes reporting zero blocks even though there is small written
data.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2eb3efe92018..f7be6c394fa8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -698,6 +698,11 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 				  STATX_ATTR_NODUMP);
 
 	generic_fillattr(inode, stat);
+
+	/* we need to show initial sectors used for inline_data/dentries */
+	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
+		stat->blocks += (stat->size + 511) >> 9;
+
 	return 0;
 }
 
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
