From: Chao Yu <chao2.yu@samsung.com>
Subject: [RFC PATCH] f2fs: support file defragment
Date: Thu, 17 Sep 2015 20:54:30 +0800
Message-ID: <00a201d0f148$165f0650$431d12f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces a new ioctl F2FS_IOC_DEFRAGMENT to support file
defragment in a specified range of regular file.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c |   6 +-
 fs/f2fs/f2fs.h |   8 +++
 fs/f2fs/file.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3a5e847..1585f3d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -561,7 +561,7 @@ out:
  *     b. do not use extent cache for better performance
  *     c. give the block addresses to blockdev
  */
-static int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
+int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 						int create, int flag)
 {
 	unsigned int maxblocks = map->m_len;
@@ -1336,6 +1336,10 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 			available_free_memory(sbi, DIRTY_DENTS))
 		goto skip_write;
 
+	/* skip writing during file defragment */
+	if (is_inode_flag_set(F2FS_I(inode), FI_DO_DEFRAG))
+		goto skip_write;
+
 	/* during POR, we don't need to trigger writepage at all. */
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto skip_write;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3f616cf..3342619 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -230,6 +230,7 @@ static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int size,
 #define F2FS_IOC_RELEASE_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 4)
 #define F2FS_IOC_ABORT_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 5)
 #define F2FS_IOC_GARBAGE_COLLECT	_IO(F2FS_IOCTL_MAGIC, 6)
+#define F2FS_IOC_DEFRAGMENT		_IO(F2FS_IOCTL_MAGIC, 7)
 
 #define F2FS_IOC_SET_ENCRYPTION_POLICY					\
 		_IOR('f', 19, struct f2fs_encryption_policy)
@@ -255,6 +256,11 @@ static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int size,
 #define F2FS_IOC32_SETFLAGS             FS_IOC32_SETFLAGS
 #endif
 
+struct f2fs_defragment {
+	u64 start;
+	u64 len;
+};
+
 /*
  * For INODE and NODE manager
  */
@@ -1391,6 +1397,7 @@ enum {
 	FI_DROP_CACHE,		/* drop dirty page cache */
 	FI_DATA_EXIST,		/* indicate data exists */
 	FI_INLINE_DOTS,		/* indicate inline dot dentries */
+	FI_DO_DEFRAG,		/* indicate defragment is running */
 };
 
 static inline void set_inode_flag(struct f2fs_inode_info *fi, int flag)
@@ -1799,6 +1806,7 @@ struct page *find_data_page(struct inode *, pgoff_t);
 struct page *get_lock_data_page(struct inode *, pgoff_t);
 struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
 int do_write_data_page(struct f2fs_io_info *);
+int f2fs_map_blocks(struct inode *, struct f2fs_map_blocks *, int, int);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
 void f2fs_invalidate_page(struct page *, unsigned int, unsigned int);
 int f2fs_release_page(struct page *, gfp_t);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6702157..d36652c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1642,6 +1642,187 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 	return 0;
 }
 
+static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
+					struct file *filp,
+					struct f2fs_defragment *range)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_map_blocks map;
+	struct extent_info ei;
+	pgoff_t pg_start, pg_end;
+	unsigned int blk_per_seg = 1 << sbi->log_blocks_per_seg;
+	unsigned int total = 0, sec_num;
+	unsigned int pages_per_sec = sbi->segs_per_sec *
+					(1 << sbi->log_blocks_per_seg);
+	unsigned long long extent = 0;
+	int err = 0;
+
+	pg_start = range->start >> PAGE_CACHE_SHIFT;
+	pg_end = (range->start + range->len) >> PAGE_CACHE_SHIFT;
+	map.m_lblk = pg_start;
+	map.m_len = pg_end - pg_start;
+
+	f2fs_balance_fs(sbi);
+
+	mutex_lock(&inode->i_mutex);
+
+	/* writeback all dirty pages in the range */
+	err = filemap_write_and_wait_range(inode->i_mapping, range->start,
+						range->start + range->len);
+	if (err)
+		goto out;
+
+	if (f2fs_lookup_extent_cache(inode, pg_start, &ei)) {
+		if (ei.fofs + ei.len >= pg_end)
+			goto out;
+	}
+
+	while (map.m_lblk < pg_end) {
+		map.m_flags = 0;
+		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_READ);
+		if (err)
+			goto out;
+
+		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
+			map.m_lblk++;
+			continue;
+		}
+		extent++;
+
+		map.m_lblk += map.m_len;
+		map.m_len = pg_end - map.m_lblk;
+	}
+
+	if (extent <= 1)
+		goto out;
+
+	map.m_lblk = pg_start;
+	map.m_len = pg_end - pg_start;
+
+	sec_num = (map.m_len + pages_per_sec - 1) / pages_per_sec;
+
+	if (has_not_enough_free_secs(sbi, sec_num))
+		goto out;
+
+	while (map.m_lblk < pg_end) {
+		pgoff_t idx;
+		int cnt = 0;
+
+do_map:
+		map.m_flags = 0;
+		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_READ);
+		if (err)
+			goto out;
+
+		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
+			map.m_lblk++;
+			continue;
+		}
+
+		set_inode_flag(F2FS_I(inode), FI_DO_DEFRAG);
+
+		idx = map.m_lblk;
+		while (idx < map.m_lblk + map.m_len && cnt < blk_per_seg) {
+			struct address_space *mapping = inode->i_mapping;
+			struct page *page;
+
+			page = find_or_create_page(mapping, idx, GFP_NOFS);
+			if (!page) {
+				err = -ENOMEM;
+				goto out;
+			}
+
+			f2fs_wait_on_page_writeback(page, DATA);
+
+			if (!PageUptodate(page)) {
+				err = mapping->a_ops->readpage(filp, page);
+				if (unlikely(err)) {
+					f2fs_put_page(page, 0);
+					goto out;
+				}
+
+				lock_page_killable(page);
+
+				if (!PageUptodate(page)) {
+					f2fs_put_page(page, 1);
+					err = -EIO;
+					goto out;
+				}
+			}
+			set_page_dirty(page);
+			f2fs_put_page(page, 1);
+
+			idx++;
+			cnt++;
+			total++;
+		}
+
+		map.m_lblk = idx;
+		map.m_len = pg_end - idx;
+
+		if (idx < pg_end && cnt < blk_per_seg)
+			goto do_map;
+
+		clear_inode_flag(F2FS_I(inode), FI_DO_DEFRAG);
+
+		err = filemap_fdatawrite(inode->i_mapping);
+		if (err)
+			goto out;
+	}
+out:
+	mutex_unlock(&inode->i_mutex);
+	if (!err)
+		range->len = (u64)total << PAGE_CACHE_SHIFT;
+	return err;
+}
+
+static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_defragment range;
+	int err;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	err = mnt_want_write_file(filp);
+	if (err)
+		return err;
+
+	if (f2fs_readonly(sbi->sb)) {
+		err = -EROFS;
+		goto out;
+	}
+
+	if (copy_from_user(&range, (struct f2fs_defragment __user *)arg,
+							sizeof(range))) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	/* verify alignment of offset & size */
+	if (range.start & (F2FS_BLKSIZE - 1) ||
+		range.len & (F2FS_BLKSIZE - 1)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = f2fs_defragment_range(sbi, filp, &range);
+	if (err < 0)
+		goto out;
+
+	if (copy_to_user((struct f2fs_defragment __user *)arg, &range,
+							sizeof(range)))
+		err = -EFAULT;
+out:
+	mnt_drop_write_file(filp);
+	return err;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -1673,6 +1854,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_get_encryption_pwsalt(filp, arg);
 	case F2FS_IOC_GARBAGE_COLLECT:
 		return f2fs_ioc_gc(filp, arg);
+	case F2FS_IOC_DEFRAGMENT:
+		return f2fs_ioc_defragment(filp, arg);
 	default:
 		return -ENOTTY;
 	}
-- 
2.5.2
