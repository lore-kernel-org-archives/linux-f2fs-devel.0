From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: wait on atomic writes to count F2FS_CP_WB_DATA
Date: Thu,  3 Jan 2019 20:20:24 -0800
Message-ID: <20190104042025.31982-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Otherwise, we can get wrong counts incurring checkpoint hang.

IO_W (CP:  -24, Data:   24, Flush: (   0    0    1), Discard: (   0    0))

Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bba56b39dcc5..ae2b45e75847 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1750,10 +1750,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
-	if (!get_dirty_pages(inode))
-		goto skip_flush;
-
-	f2fs_msg(F2FS_I_SB(inode)->sb, KERN_WARNING,
+	/*
+	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
+	 * f2fs_is_atomic_file.
+	 */
+	if (get_dirty_pages(inode))
+		f2fs_msg(F2FS_I_SB(inode)->sb, KERN_WARNING,
 		"Unexpected flush for atomic writes: ino=%lu, npages=%u",
 					inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
@@ -1761,7 +1763,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		goto out;
 	}
-skip_flush:
+
 	set_inode_flag(inode, FI_ATOMIC_FILE);
 	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-- 
2.19.0.605.g01d371f741-goog
