From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: support file defragment
Date: Thu, 22 Oct 2015 19:59:14 +0800
Message-ID: <032001d10cc1$294f0140$7bed03c0$@samsung.com>
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

This ioctl can be used in very limited workload: if user expects high
sequential read performance in randomly written file, this interface
can be used for defragmentation, after that file can be written as
continuous as possible in the device.

Meanwhile, it has side-effect, it will make holes in segments where
blocks located originally, so it's better to trigger GC to eliminate
fragment in segments.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c |   6 +-
 fs/f2fs/f2fs.h |   8 +++
 fs/f2fs/file.c | 200 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 972eab7..5bb375a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -566,7 +566,7 @@ out:
  *     b. do not use extent cache for better performance
  *     c. give the block addresses to blockdev
  */
-static int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
+int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 						int create, int flag)
 {
 	unsigned int maxblocks = map->m_len;
@@ -1354,6 +1354,10 @@ static int f2fs_write_data_pages(struct address_space *mapping,
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
index 9db5500..068813c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -234,6 +234,7 @@ static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int size,
 #define F2FS_IOC_ABORT_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 5)
 #define F2FS_IOC_GARBAGE_COLLECT	_IO(F2FS_IOCTL_MAGIC, 6)
 #define F2FS_IOC_WRITE_CHECKPOINT	_IO(F2FS_IOCTL_MAGIC, 7)
+#define F2FS_IOC_DEFRAGMENT		_IO(F2FS_IOCTL_MAGIC, 8)
 
 #define F2FS_IOC_SET_ENCRYPTION_POLICY					\
 		_IOR('f', 19, struct f2fs_encryption_policy)
@@ -260,6 +261,11 @@ static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int size,
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
@@ -1416,6 +1422,7 @@ enum {
 	FI_DROP_CACHE,		/* drop dirty page cache */
 	FI_DATA_EXIST,		/* indicate data exists */
 	FI_INLINE_DOTS,		/* indicate inline dot dentries */
+	FI_DO_DEFRAG,		/* indicate defragment is running */
 };
 
 static inline void set_inode_flag(struct f2fs_inode_info *fi, int flag)
@@ -1847,6 +1854,7 @@ struct page *find_data_page(struct inode *, pgoff_t);
 struct page *get_lock_data_page(struct inode *, pgoff_t, bool);
 struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
 int do_write_data_page(struct f2fs_io_info *);
+int f2fs_map_blocks(struct inode *, struct f2fs_map_blocks *, int, int);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
 void f2fs_invalidate_page(struct page *, unsigned int, unsigned int);
 int f2fs_release_page(struct page *, gfp_t);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a197215..ad59694 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1646,6 +1646,204 @@ static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
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
+	block_t blk_end = 0;
+	bool fragmented = false;
+	int err = 0;
+
+	pg_start = range->start >> PAGE_CACHE_SHIFT;
+	pg_end = (range->start + range->len) >> PAGE_CACHE_SHIFT;
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
+	/*
+	 * lookup mapping info in extent cache, skip defragmenting if physical
+	 * block addresses are continuous.
+	 */
+	if (f2fs_lookup_extent_cache(inode, pg_start, &ei)) {
+		if (ei.fofs + ei.len >= pg_end)
+			goto out;
+	}
+
+	map.m_lblk = pg_start;
+	map.m_len = pg_end - pg_start;
+
+	/*
+	 * lookup mapping info in dnode page cache, skip defragmenting if all
+	 * physical block addresses are continuous even if there are hole(s)
+	 * in logical blocks.
+	 */
+	while (map.m_lblk < pg_end) {
+		map.m_flags = 0;
+		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_READ);
+		if (err)
+			goto out;
+
+		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
+			map.m_lblk++;
+			map.m_len--;
+			continue;
+		}
+
+		if (blk_end && blk_end != map.m_pblk) {
+			fragmented = true;
+			break;
+		}
+		blk_end = map.m_pblk + map.m_len;
+
+		map.m_lblk += map.m_len;
+		map.m_len = pg_end - map.m_lblk;
+	}
+
+	if (!fragmented)
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
@@ -1679,6 +1877,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_gc(filp, arg);
 	case F2FS_IOC_WRITE_CHECKPOINT:
 		return f2fs_ioc_write_checkpoint(filp, arg);
+	case F2FS_IOC_DEFRAGMENT:
+		return f2fs_ioc_defragment(filp, arg);
 	default:
 		return -ENOTTY;
 	}
-- 
2.6.1
