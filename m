From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix lock dependency in between dio_rwsem & i_mmap_sem
Date: Thu, 23 Nov 2017 23:26:52 +0800
Message-ID: <20171123152652.16232-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

test/generic/208 reports a potential deadlock as below:

Chain exists of:
  &mm->mmap_sem --> &fi->i_mmap_sem --> &fi->dio_rwsem[WRITE]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fi->dio_rwsem[WRITE]);
                               lock(&fi->i_mmap_sem);
                               lock(&fi->dio_rwsem[WRITE]);
  lock(&mm->mmap_sem);

This patch changes the lock dependency as below in fallocate() to
fix this issue:
- dio_rwsem
 - i_mmap_sem

Fixes: bb06664a534b ("f2fs: avoid race in between GC and block exchange")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a292a1a3a692..d08e003e6d6b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1185,14 +1185,14 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	pg_start = offset >> PAGE_SHIFT;
 	pg_end = (offset + len) >> PAGE_SHIFT;
 
+	/* avoid gc operation during block exchange */
+	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 	/* write out all dirty pages from offset */
 	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
 	if (ret)
-		goto out;
-
-	/* avoid gc operation during block exchange */
-	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+		goto out_unlock;
 
 	truncate_pagecache(inode, offset);
 
@@ -1211,9 +1211,8 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
 out_unlock:
-	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
-out:
 	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 	return ret;
 }
 
@@ -1384,6 +1383,9 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	f2fs_balance_fs(sbi, true);
 
+	/* avoid gc operation during block exchange */
+	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 	ret = truncate_blocks(inode, i_size_read(inode), true);
 	if (ret)
@@ -1394,9 +1396,6 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		goto out;
 
-	/* avoid gc operation during block exchange */
-	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
-
 	truncate_pagecache(inode, offset);
 
 	pg_start = offset >> PAGE_SHIFT;
@@ -1424,10 +1423,9 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
-
-	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 out:
 	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 	return ret;
 }
 
-- 
2.14.1.145.gb3622a4ee
