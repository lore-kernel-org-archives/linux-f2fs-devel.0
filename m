From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 02/10] f2fs: remove lengthy inode->i_ino
Date: Sun, 14 Sep 2014 15:14:16 -0700
Message-ID: <1410732864-53069-2-git-send-email-jaegeuk@kernel.org>
References: <1410732864-53069-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XTI40-0001Bx-21
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 14 Sep 2014 22:14:32 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XTI3z-0007Jr-4d for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 14 Sep 2014 22:14:32 +0000
In-Reply-To: <1410732864-53069-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch is to remove lengthy name by adding a new variable.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5cde363..77426c7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -139,6 +139,7 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	struct inode *inode = file->f_mapping->host;
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	nid_t ino = inode->i_ino;
 	int ret = 0;
 	bool need_cp = false;
 	struct writeback_control wbc = {
@@ -168,9 +169,9 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * if there is no written data, don't waste time to write recovery info.
 	 */
 	if (!is_inode_flag_set(fi, FI_APPEND_WRITE) &&
-		!exist_written_data(sbi, inode->i_ino, APPEND_INO)) {
+			!exist_written_data(sbi, ino, APPEND_INO)) {
 		if (is_inode_flag_set(fi, FI_UPDATE_WRITE) ||
-			exist_written_data(sbi, inode->i_ino, UPDATE_INO))
+				exist_written_data(sbi, ino, UPDATE_INO))
 			goto flush_out;
 		goto out;
 	}
@@ -208,23 +209,23 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		}
 	} else {
 		/* if there is no written node page, write its inode page */
-		while (!sync_node_pages(sbi, inode->i_ino, &wbc)) {
-			if (fsync_mark_done(sbi, inode->i_ino))
+		while (!sync_node_pages(sbi, ino, &wbc)) {
+			if (fsync_mark_done(sbi, ino))
 				goto out;
 			mark_inode_dirty_sync(inode);
 			ret = f2fs_write_inode(inode, NULL);
 			if (ret)
 				goto out;
 		}
-		ret = wait_on_node_pages_writeback(sbi, inode->i_ino);
+		ret = wait_on_node_pages_writeback(sbi, ino);
 		if (ret)
 			goto out;
 
 		/* once recovery info is written, don't need to tack this */
-		remove_dirty_inode(sbi, inode->i_ino, APPEND_INO);
+		remove_dirty_inode(sbi, ino, APPEND_INO);
 		clear_inode_flag(fi, FI_APPEND_WRITE);
 flush_out:
-		remove_dirty_inode(sbi, inode->i_ino, UPDATE_INO);
+		remove_dirty_inode(sbi, ino, UPDATE_INO);
 		clear_inode_flag(fi, FI_UPDATE_WRITE);
 		ret = f2fs_issue_flush(F2FS_I_SB(inode));
 	}
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
