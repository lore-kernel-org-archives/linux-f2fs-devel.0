From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/6] f2fs: don't need to sync node page at every time
Date: Mon, 25 Jan 2016 14:05:30 -0800
Message-ID: <1453759531-16076-5-git-send-email-jaegeuk@kernel.org>
References: <1453759531-16076-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453759531-16076-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In write_end, we don't need to sync inode page at every time.
Instead, we can expect f2fs_write_inode will update later.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 260c0eb..a6a6f08 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1627,7 +1627,6 @@ static int f2fs_write_end(struct file *file,
 	if (pos + copied > i_size_read(inode)) {
 		i_size_write(inode, pos + copied);
 		mark_inode_dirty(inode);
-		update_inode_page(inode);
 	}
 
 	f2fs_put_page(page, 1);
-- 
2.6.3
