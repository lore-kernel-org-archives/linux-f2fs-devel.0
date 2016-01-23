From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: avoid multiple node page writes due to inline_data
Date: Sat, 23 Jan 2016 12:15:47 -0800
Message-ID: <1453580148-61861-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The sceanrio is:
1. create fully node blocks
2. flush node blocks
3. write inline_data for all the node blocks again
4. flush node blocks redundantly

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8d0d9ec..011456e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1622,14 +1622,22 @@ static int f2fs_write_end(struct file *file,
 
 	trace_f2fs_write_end(inode, pos, len, copied);
 
-	set_page_dirty(page);
-
 	if (pos + copied > i_size_read(inode)) {
 		i_size_write(inode, pos + copied);
 		mark_inode_dirty(inode);
-		update_inode_page(inode);
 	}
 
+	if (f2fs_has_inline_data(inode) &&
+			is_inode_flag_set(F2FS_I(inode), FI_DATA_EXIST)) {
+		int err = f2fs_write_inline_data(inode, page);
+		if (err)
+			set_page_dirty(page);
+	} else {
+		set_page_dirty(page);
+	}
+
+	f2fs_write_inode(inode, NULL);
+
 	f2fs_put_page(page, 1);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return copied;
-- 
2.6.3

