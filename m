From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: avoid race between zero_range and background GC
Date: Thu, 26 Jul 2018 18:45:36 +0800
Message-ID: <20180726104536.114340-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

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
 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 267ec3794e1e..7bd2412a8c37 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1309,6 +1309,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	if (ret)
 		return ret;
 
+	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 	ret = filemap_write_and_wait_range(mapping, offset, offset + len - 1);
 	if (ret)
@@ -1389,6 +1390,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	}
 out_sem:
 	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 	return ret;
 }
-- 
2.18.0.rc1
