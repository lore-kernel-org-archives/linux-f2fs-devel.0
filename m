From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: avoid race between zero_range and background GC
Date: Sun,  5 Aug 2018 23:02:22 +0800
Message-ID: <20180805150222.9261-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Thread A				Background GC
- f2fs_zero_range
 - truncate_pagecache_range
					- gc_data_segment
					 - get_read_data_page
					  - move_data_page
					   - set_page_dirty
					   - set_cold_data
 - f2fs_do_zero_range
  - dn->data_blkaddr = NEW_ADDR;
  - f2fs_set_data_blkaddr

Actually, we don't need to set dirty & checked flag on the page, since
all valid data in the page should be zeroed by zero_range().

Use i_gc_rwsem[WRITE] to avoid such race condition.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- decrease i_gc_rwsem lock coverage.
 fs/f2fs/file.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 606c5a215542..bcffb3b608ed 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1311,8 +1311,6 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	if (ret)
 		goto out_sem;
 
-	truncate_pagecache_range(inode, offset, offset + len - 1);
-
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
 
@@ -1342,12 +1340,19 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			unsigned int end_offset;
 			pgoff_t end;
 
+			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+
+			truncate_pagecache_range(inode,
+				(loff_t)index << PAGE_SHIFT,
+				((loff_t)pg_end << PAGE_SHIFT) - 1);
+
 			f2fs_lock_op(sbi);
 
 			set_new_dnode(&dn, inode, NULL, NULL, 0);
 			ret = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
 			if (ret) {
 				f2fs_unlock_op(sbi);
+				up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 				goto out;
 			}
 
@@ -1356,7 +1361,9 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 
 			ret = f2fs_do_zero_range(&dn, index, end);
 			f2fs_put_dnode(&dn);
+
 			f2fs_unlock_op(sbi);
+			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 			f2fs_balance_fs(sbi, dn.node_changed);
 
-- 
2.18.0
