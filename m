From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/6] f2fs: make atomic/volatile operation exclusive
Date: Mon, 9 May 2016 19:56:33 +0800
Message-ID: <20160509115635.123946-4-yuchao0@huawei.com>
References: <20160509115635.123946-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509115635.123946-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

atomic/volatile ioctl interfaces are exposed to user like other file
operation interface, it needs to make them getting exclusion against
to each other to avoid potential conflict among these operations
in concurrent scenario.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 828b53e..24d7189 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1430,6 +1430,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	if (ret)
 		return ret;
 
+	inode_lock(inode);
+
 	if (f2fs_is_atomic_file(inode))
 		goto out;
 
@@ -1450,6 +1452,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	if (ret)
 		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
 out:
+	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
 }
@@ -1466,6 +1469,8 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	if (ret)
 		return ret;
 
+	inode_lock(inode);
+
 	if (f2fs_is_volatile_file(inode))
 		goto err_out;
 
@@ -1480,6 +1485,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 
 	ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 err_out:
+	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
 }
@@ -1496,6 +1502,8 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 	if (ret)
 		return ret;
 
+	inode_lock(inode);
+
 	if (f2fs_is_volatile_file(inode))
 		goto out;
 
@@ -1506,6 +1514,7 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 	set_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 out:
+	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
 }
@@ -1522,6 +1531,8 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
 	if (ret)
 		return ret;
 
+	inode_lock(inode);
+
 	if (!f2fs_is_volatile_file(inode))
 		goto out;
 
@@ -1532,6 +1543,7 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
 
 	ret = punch_hole(inode, 0, F2FS_BLKSIZE);
 out:
+	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
 }
@@ -1548,6 +1560,8 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	if (ret)
 		return ret;
 
+	inode_lock(inode);
+
 	if (f2fs_is_atomic_file(inode))
 		drop_inmem_pages(inode);
 	if (f2fs_is_volatile_file(inode)) {
@@ -1555,6 +1569,8 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 	}
 
+	inode_unlock(inode);
+
 	mnt_drop_write_file(filp);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return ret;
-- 
2.8.2.311.gee88674
