From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: check if inode's state is dirty or not before skip fsync
Date: Mon, 01 Dec 2014 16:05:20 +0900
Message-ID: <1417417520-7192-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

It makes sense to check inode's state than check if
inode page is dirty or not.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/file.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7c2ec3e..0c5ae87 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -173,14 +173,11 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	if (!is_inode_flag_set(fi, FI_APPEND_WRITE) &&
 			!exist_written_data(sbi, ino, APPEND_INO)) {
-		struct page *i = find_get_page(NODE_MAPPING(sbi), ino);
 
 		/* But we need to avoid that there are some inode updates */
-		if ((i && PageDirty(i)) || need_inode_block_update(sbi, ino)) {
-			f2fs_put_page(i, 0);
+		if (is_inode_flag_set(fi, FI_DIRTY_INODE) ||
+					need_inode_block_update(sbi, ino))
 			goto go_write;
-		}
-		f2fs_put_page(i, 0);
 
 		if (is_inode_flag_set(fi, FI_UPDATE_WRITE) ||
 				exist_written_data(sbi, ino, UPDATE_INO))
-- 
1.9.1

