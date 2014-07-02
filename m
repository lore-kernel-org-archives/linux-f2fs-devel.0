From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 2/2] f2fs: introduce f2fs_write_failed to handle
 error case when write
Date: Wed, 02 Jul 2014 13:25:04 +0800
Message-ID: <000101cf95b6$18137ab0$483a7010$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When we fail in ->write_begin()/->direct_IO(), our allocated node block in disk
and page cache are still kept, despite these may not be used again.

This patch introduce f2fs_write_failed() to handle the error case of these two
interfaces, it will truncate page cache and blocks of this file according to
i_size.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c |   42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2eb2764..05154d6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -914,6 +914,16 @@ skip_write:
 	return 0;
 }
 
+static void f2fs_write_failed(struct address_space *mapping, loff_t to)
+{
+	struct inode *inode = mapping->host;
+
+	if (to > inode->i_size) {
+		truncate_pagecache(inode, inode->i_size);
+		truncate_blocks(inode, inode->i_size);
+	}
+}
+
 static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 		loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, void **fsdata)
@@ -931,11 +941,13 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 repeat:
 	err = f2fs_convert_inline_data(inode, pos + len);
 	if (err)
-		return err;
+		goto fail;
 
 	page = grab_cache_page_write_begin(mapping, index, flags);
-	if (!page)
-		return -ENOMEM;
+	if (!page) {
+		err = -ENOMEM;
+		goto fail;
+	}
 
 	/* to avoid latency during memory pressure */
 	unlock_page(page);
@@ -949,10 +961,9 @@ repeat:
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = f2fs_reserve_block(&dn, index);
 	f2fs_unlock_op(sbi);
-
 	if (err) {
 		f2fs_put_page(page, 0);
-		return err;
+		goto fail;
 	}
 inline_data:
 	lock_page(page);
@@ -982,19 +993,20 @@ inline_data:
 			err = f2fs_read_inline_data(inode, page);
 			if (err) {
 				page_cache_release(page);
-				return err;
+				goto fail;
 			}
 		} else {
 			err = f2fs_submit_page_bio(sbi, page, dn.data_blkaddr,
 							READ_SYNC);
 			if (err)
-				return err;
+				goto fail;
 		}
 
 		lock_page(page);
 		if (unlikely(!PageUptodate(page))) {
 			f2fs_put_page(page, 1);
-			return -EIO;
+			err = -EIO;
+			goto fail;
 		}
 		if (unlikely(page->mapping != mapping)) {
 			f2fs_put_page(page, 1);
@@ -1005,6 +1017,9 @@ out:
 	SetPageUptodate(page);
 	clear_cold_data(page);
 	return 0;
+fail:
+	f2fs_write_failed(mapping, pos + len);
+	return err;
 }
 
 static int f2fs_write_end(struct file *file,
@@ -1049,7 +1064,10 @@ static ssize_t f2fs_direct_IO(int rw, struct kiocb *iocb,
 		struct iov_iter *iter, loff_t offset)
 {
 	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
+	size_t count = iov_iter_count(iter);
+	int err;
 
 	/* Let buffer I/O handle the inline data case. */
 	if (f2fs_has_inline_data(inode))
@@ -1061,8 +1079,10 @@ static ssize_t f2fs_direct_IO(int rw, struct kiocb *iocb,
 	/* clear fsync mark to recover these blocks */
 	fsync_mark_clear(F2FS_SB(inode->i_sb), inode->i_ino);
 
-	return blockdev_direct_IO(rw, iocb, inode, iter, offset,
-				  get_data_block);
+	err = blockdev_direct_IO(rw, iocb, inode, iter, offset, get_data_block);
+	if (err < 0 && (rw & WRITE))
+		f2fs_write_failed(mapping, offset + count);
+	return err;
 }
 
 static void f2fs_invalidate_data_page(struct page *page, unsigned int offset,
-- 
1.7.9.5
