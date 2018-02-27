From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to avoid race in between atomic write and background GC
Date: Tue, 27 Feb 2018 22:45:24 +0800
Message-ID: <20180227144524.8296-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Sqlite user			Background GC
				- move_data_block
				  : move page #1
				 - f2fs_is_atomic_file
- f2fs_ioc_start_atomic_write
- f2fs_ioc_commit_atomic_write
 - commit_inmem_pages
   : commit page #1 & set node #2 dirty
				 - f2fs_submit_page_write
				  - f2fs_update_data_blkaddr
				   - set_page_dirty
				     : set node #2 dirty
 - f2fs_do_sync_file
  - fsync_node_pages
   : commit node #1 & node #2, then sudden power-cut

In a race case, we may check FI_ATOMIC_FILE flag before starting atomic
write flow, then we will commit meta data before data with reversed
order, after a sudden pow-cut, database transaction will be inconsistent.

So we'd better to exclude gc/atomic_write to each other by using lock
instead of flag checking.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4821ea97e080..d3d5ef6596f6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1716,6 +1716,8 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 
 	inode_lock(inode);
 
+	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+
 	if (f2fs_is_volatile_file(inode))
 		goto err_out;
 
@@ -1734,6 +1736,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
 	}
 err_out:
+	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
-- 
2.14.1.145.gb3622a4ee
