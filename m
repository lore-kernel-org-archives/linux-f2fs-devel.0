From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v3 3/3] f2fs: support FALLOC_FL_ZERO_RANGE
Date: Wed, 06 May 2015 13:11:13 +0800
Message-ID: <004901d087bb$2c287f30$84797d90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Now, FALLOC_FL_ZERO_RANGE flag in ->fallocate is supported in ext4/xfs.

In commit, the semantics of this flag is descripted as following:"
1) Make sure that both offset and len are block size aligned.
2) Update the i_size of inode by len bytes.
3) Compute the file's logical block number against offset. If the computed
   block number is not the starting block of the extent, split the extent
   such that the block number is the starting block of the extent.
4) Shift all the extents which are lying between
   [offset, last allocated extent] towards right by len bytes. This step
   will make a hole of len bytes at offset."

This patch implements fallocate's FALLOC_FL_ZERO_RANGE for f2fs.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
 * rebase to last git repository of f2fs (20150430)
v3:
 * rebase to last git repository of f2fs (20150506)

 fs/f2fs/file.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index dbddc79..7293746 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -891,6 +891,108 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	return ret;
 }
 
+static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
+								int mode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t index, pg_start, pg_end;
+	loff_t new_size = i_size_read(inode);
+	loff_t off_start, off_end;
+	int ret = 0;
+
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	ret = inode_newsize_ok(inode, (len + offset));
+	if (ret)
+		return ret;
+
+	f2fs_balance_fs(sbi);
+
+	if (f2fs_has_inline_data(inode)) {
+		ret = f2fs_convert_inline_inode(inode);
+		if (ret)
+			return ret;
+	}
+
+	ret = filemap_write_and_wait_range(mapping, offset, offset + len - 1);
+	if (ret)
+		return ret;
+
+	truncate_pagecache_range(inode, offset, offset + len - 1);
+
+	pg_start = ((unsigned long long) offset) >> PAGE_CACHE_SHIFT;
+	pg_end = ((unsigned long long) offset + len) >> PAGE_CACHE_SHIFT;
+
+	off_start = offset & (PAGE_CACHE_SIZE - 1);
+	off_end = (offset + len) & (PAGE_CACHE_SIZE - 1);
+
+	if (pg_start == pg_end) {
+		fill_zero(inode, pg_start, off_start, off_end - off_start);
+		if (offset + len > new_size)
+			new_size = offset + len;
+		new_size = max_t(loff_t, new_size, offset + len);
+	} else {
+		if (off_start) {
+			fill_zero(inode, pg_start++, off_start,
+					PAGE_CACHE_SIZE - off_start);
+			new_size = max_t(loff_t, new_size,
+						pg_start << PAGE_CACHE_SHIFT);
+		}
+
+		for (index = pg_start; index < pg_end; index++) {
+			struct dnode_of_data dn;
+			struct page *ipage;
+
+			f2fs_lock_op(sbi);
+
+			ipage = get_node_page(sbi, inode->i_ino);
+			if (IS_ERR(ipage)) {
+				ret = PTR_ERR(ipage);
+				f2fs_unlock_op(sbi);
+				goto out;
+			}
+
+			set_new_dnode(&dn, inode, ipage, NULL, 0);
+			ret = f2fs_reserve_block(&dn, index);
+			if (ret) {
+				f2fs_unlock_op(sbi);
+				goto out;
+			}
+
+			if (dn.data_blkaddr != NEW_ADDR) {
+				invalidate_blocks(sbi, dn.data_blkaddr);
+
+				dn.data_blkaddr = NEW_ADDR;
+				set_data_blkaddr(&dn);
+
+				dn.data_blkaddr = NULL_ADDR;
+				f2fs_update_extent_cache(&dn);
+			}
+			f2fs_put_dnode(&dn);
+			f2fs_unlock_op(sbi);
+
+			new_size = max_t(loff_t, new_size,
+					(index + 1) << PAGE_CACHE_SHIFT);
+		}
+
+		if (off_end) {
+			fill_zero(inode, pg_end, 0, off_end);
+			new_size = max_t(loff_t, new_size, offset + len);
+		}
+	}
+
+out:
+	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size) {
+		i_size_write(inode, new_size);
+		mark_inode_dirty(inode);
+		update_inode_page(inode);
+	}
+
+	return ret;
+}
+
 static int expand_inode_data(struct inode *inode, loff_t offset,
 					loff_t len, int mode)
 {
@@ -959,7 +1061,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 	long ret = 0;
 
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
-			FALLOC_FL_COLLAPSE_RANGE))
+			FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE))
 		return -EOPNOTSUPP;
 
 	mutex_lock(&inode->i_mutex);
@@ -971,6 +1073,8 @@ static long f2fs_fallocate(struct file *file, int mode,
 		ret = punch_hole(inode, offset, len);
 	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
 		ret = f2fs_collapse_range(inode, offset, len);
+	} else if (mode & FALLOC_FL_ZERO_RANGE) {
+		ret = f2fs_zero_range(inode, offset, len, mode);
 	} else {
 		ret = expand_inode_data(inode, offset, len, mode);
 	}
-- 
2.3.3
