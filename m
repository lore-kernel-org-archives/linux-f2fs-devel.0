From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/4] f2fs: fix avoid race between truncate and background GC
Date: Fri, 27 Jul 2018 18:15:15 +0800
Message-ID: <20180727101516.41403-3-yuchao0@huawei.com>
References: <20180727101516.41403-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180727101516.41403-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Thread A				Background GC
- f2fs_setattr isize to 0
 - truncate_setsize
					- gc_data_segment
					 - f2fs_get_read_data_page page #0
					  - set_page_dirty
					  - set_cold_data
 - f2fs_truncate

- f2fs_setattr isize to 4k
- read 4k <--- hit data in cached page #0

Above race condition can cause read out invalid data in a truncated
page, fix it by i_gc_rwsem[WRITE] lock.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c |  4 ++++
 fs/f2fs/file.c | 33 +++++++++++++++++++--------------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 071224ded5f4..a29f3162b887 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2214,10 +2214,14 @@ static void f2fs_write_failed(struct address_space *mapping, loff_t to)
 	loff_t i_size = i_size_read(inode);
 
 	if (to > i_size) {
+		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		down_write(&F2FS_I(inode)->i_mmap_sem);
+
 		truncate_pagecache(inode, i_size);
 		f2fs_truncate_blocks(inode, i_size, true);
+
 		up_write(&F2FS_I(inode)->i_mmap_sem);
+		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	}
 }
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7bd2412a8c37..ed5c9b0e0d0c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -796,22 +796,25 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 
 	if (attr->ia_valid & ATTR_SIZE) {
-		if (attr->ia_size <= i_size_read(inode)) {
-			down_write(&F2FS_I(inode)->i_mmap_sem);
-			truncate_setsize(inode, attr->ia_size);
+		bool to_smaller = (attr->ia_size <= i_size_read(inode));
+
+		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+		down_write(&F2FS_I(inode)->i_mmap_sem);
+
+		truncate_setsize(inode, attr->ia_size);
+
+		if (to_smaller)
 			err = f2fs_truncate(inode);
-			up_write(&F2FS_I(inode)->i_mmap_sem);
-			if (err)
-				return err;
-		} else {
-			/*
-			 * do not trim all blocks after i_size if target size is
-			 * larger than i_size.
-			 */
-			down_write(&F2FS_I(inode)->i_mmap_sem);
-			truncate_setsize(inode, attr->ia_size);
-			up_write(&F2FS_I(inode)->i_mmap_sem);
+		/*
+		 * do not trim all blocks after i_size if target size is
+		 * larger than i_size.
+		 */
+		up_write(&F2FS_I(inode)->i_mmap_sem);
+		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+		if (err)
+			return err;
 
+		if (!to_smaller) {
 			/* should convert inline inode here */
 			if (!f2fs_may_inline_data(inode)) {
 				err = f2fs_convert_inline_inode(inode);
@@ -958,6 +961,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 			blk_start = (loff_t)pg_start << PAGE_SHIFT;
 			blk_end = (loff_t)pg_end << PAGE_SHIFT;
+			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 			down_write(&F2FS_I(inode)->i_mmap_sem);
 			truncate_inode_pages_range(mapping, blk_start,
 					blk_end - 1);
@@ -966,6 +970,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 			ret = f2fs_truncate_hole(inode, pg_start, pg_end);
 			f2fs_unlock_op(sbi);
 			up_write(&F2FS_I(inode)->i_mmap_sem);
+			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		}
 	}
 
-- 
2.18.0.rc1
