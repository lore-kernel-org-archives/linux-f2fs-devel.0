From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 06/11] f2fs: skip unnecessary data writes during
	fsync
Date: Fri, 25 Jul 2014 15:47:20 -0700
Message-ID: <1406328445-63707-6-git-send-email-jaegeuk@kernel.org>
References: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XAoIo-0000QU-V8
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Jul 2014 22:49:26 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XAoIo-0006MT-4g for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Jul 2014 22:49:26 +0000
In-Reply-To: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
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

This patch intends to improve the fsync performance by skipping remaining the
recovery information, only when there is no data that we should recover.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7c652b3..121689a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -133,6 +133,17 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		return ret;
 	}
 
+	/*
+	 * if there is no written data, don't waste time to write recovery info.
+	 */
+	if (!is_inode_flag_set(fi, FI_APPEND_WRITE) &&
+		!exist_written_data(sbi, inode->i_ino, APPEND_INO)) {
+		if (is_inode_flag_set(fi, FI_UPDATE_WRITE) &&
+			exist_written_data(sbi, inode->i_ino, UPDATE_INO))
+			goto flush_out;
+		goto out;
+	}
+
 	/* guarantee free sections for fsync */
 	f2fs_balance_fs(sbi);
 
@@ -188,6 +199,11 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		ret = wait_on_node_pages_writeback(sbi, inode->i_ino);
 		if (ret)
 			goto out;
+
+		/* once recovery info is written, don't need to tack this */
+		remove_dirty_inode(sbi, inode->i_ino, APPEND_INO);
+flush_out:
+		remove_dirty_inode(sbi, inode->i_ino, UPDATE_INO);
 		ret = f2fs_issue_flush(F2FS_SB(inode->i_sb));
 	}
 out:
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
