From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to cover f2fs_fiemap with inode_lock
Date: Wed, 10 Jan 2018 14:18:06 +0800
Message-ID: <20180110061806.15744-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fix to cover f2fs_fiemap with inode_lock in order to make
the whole interface avoiding race with mapping change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d6302051a65d..330085d3adfc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1146,18 +1146,18 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	u32 flags = 0;
 	int ret = 0;
 
+	inode_lock(inode);
+
 	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (f2fs_has_inline_data(inode)) {
 		ret = f2fs_inline_data_fiemap(inode, fieinfo, start, len);
 		if (ret != -EAGAIN)
-			return ret;
+			goto out;
 	}
 
-	inode_lock(inode);
-
 	if (logical_to_blk(inode, len) == 0)
 		len = blk_to_logical(inode, 1);
 
-- 
2.15.0.55.gc2ece9dc4de6
