From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: truncate preallocated blocks in error case
Date: Fri, 30 Mar 2018 18:57:10 -0700
Message-ID: <20180331015710.72893-1-jaegeuk@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If write is failed, we must deallocate the blocks that we couldn't write.

Cc: stable@vger.kernel.org
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8068b015ece5..f18f62dd60a3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2911,6 +2911,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	ret = generic_write_checks(iocb, from);
 	if (ret > 0) {
+		bool preallocated = false;
+		size_t target_size;
 		int err;
 
 		if (iov_iter_fault_in_readable(from, iov_iter_count(from)))
@@ -2927,6 +2929,9 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 				}
 
 		} else {
+			preallocated = true;
+			target_size = iocb->ki_pos + iov_iter_count(from);
+
 			err = f2fs_preallocate_blocks(iocb, from);
 			if (err) {
 				clear_inode_flag(inode, FI_NO_PREALLOC);
@@ -2939,6 +2944,10 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		blk_finish_plug(&plug);
 		clear_inode_flag(inode, FI_NO_PREALLOC);
 
+		/* if we couldn't write data, we should deallocate blocks. */
+		if (preallocated && i_size_read(inode) < target_size)
+			f2fs_truncate(inode);
+
 		if (ret > 0)
 			f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
 	}
-- 
2.15.0.531.g2ccb3012c9-goog
