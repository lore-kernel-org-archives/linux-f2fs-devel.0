From: sunqiuyang <sunqiuyang@huawei.com>
Subject: [PATCH v4 1/1] f2fs: dax: implement direct access
Date: Thu, 15 Jun 2017 16:56:15 +0800
Message-ID: <1497516975-10604-1-git-send-email-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org, yuchao0@huawei.com, sunqiuyang@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Qiuyang Sun <sunqiuyang@huawei.com>

This patch implements Direct Access (DAX) in F2FS.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---

Changelog v3 -> v4:

<data.c>
  In f2fs_iomap_begin():
- For the write branch, if f2fs_map_blocks() returns error (probably due to
  ENOSPC), the allocated blocks beyond original_i_size are truncated.
- For the read branch, use F2FS_GET_BLOCK_FIEMAP instead of READ for 
  f2fs_map_blocks(), so that contiguous unwritten blocks can be treated in
  a batch. Accordingly, judge F2FS_MAP_UNWRITTEN before F2FS_MAP_MAPPED for
  iomap->type.

- Add a call of f2fs_update_time() in f2fs_iomap_end().

<file.c>
- In f2fs_move_file_range() and f2fs_ioc_defragment(), return -EINVAL for
  DAX files, as the current implementation uses page cache.
- Call f2fs_bug_on() in f2fs_ioc_commit_atomic_write() and 
  f2fs_ioc_(release|abort)_volatile_write() when the inode is DAX, which 
  should not happen.

<gc.c>
- Optimize the logic in dax_move_data_page().

<inode.c>
- Enable setting the S_DAX flag for an inode in f2fs_set_inode_flags().

The v4 patch is at f2fs-dev-test.

---
 fs/f2fs/data.c   | 100 +++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h   |   8 +++
 fs/f2fs/file.c   | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/gc.c     | 104 ++++++++++++++++++++++++++++--
 fs/f2fs/inline.c |   4 ++
 fs/f2fs/inode.c  |   8 ++-
 fs/f2fs/namei.c  |   5 ++
 fs/f2fs/super.c  |  15 +++++
 8 files changed, 429 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7d3af48..58efce0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2257,3 +2257,103 @@ int f2fs_migrate_page(struct address_space *mapping,
 	.migratepage    = f2fs_migrate_page,
 #endif
 };
+
+#ifdef CONFIG_FS_DAX
+#include <linux/iomap.h>
+#include <linux/dax.h>
+
+static int f2fs_iomap_begin(struct inode *inode, loff_t offset,
+	loff_t length, unsigned int flags, struct iomap *iomap)
+{
+	struct block_device *bdev;
+	unsigned long first_block = F2FS_BYTES_TO_BLK(offset);
+	unsigned long last_block = F2FS_BYTES_TO_BLK(offset + length - 1);
+	struct f2fs_map_blocks map;
+	int ret;
+
+	if (WARN_ON_ONCE(f2fs_has_inline_data(inode)))
+		return -ERANGE;
+
+	map.m_lblk = first_block;
+	map.m_len = last_block - first_block + 1;
+	map.m_next_pgofs = NULL;
+
+	if (!(flags & IOMAP_WRITE))
+		ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
+	else {
+	/* i_size should be kept here and changed later in f2fs_iomap_end */
+		loff_t original_i_size = i_size_read(inode);
+
+		ret = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
+		if (i_size_read(inode) > original_i_size) {
+			f2fs_i_size_write(inode, original_i_size);
+			if (ret) {
+				truncate_pagecache(inode, original_i_size);
+				truncate_blocks(inode, original_i_size, true);
+			}
+		}
+	}
+
+	if (ret)
+		return ret;
+
+	iomap->flags = 0;
+	bdev = inode->i_sb->s_bdev;
+	iomap->bdev = bdev;
+	if (blk_queue_dax(bdev->bd_queue))
+		iomap->dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
+	else
+		iomap->dax_dev = NULL;
+	iomap->offset = F2FS_BLK_TO_BYTES((u64)first_block);
+
+	if (map.m_len == 0) {
+		iomap->type = IOMAP_HOLE;
+		iomap->blkno = IOMAP_NULL_BLOCK;
+		iomap->length = F2FS_BLKSIZE;
+	} else {
+		if (map.m_flags & F2FS_MAP_UNWRITTEN) {
+			iomap->type = IOMAP_UNWRITTEN;
+		} else if (map.m_flags & F2FS_MAP_MAPPED) {
+			iomap->type = IOMAP_MAPPED;
+		} else {
+			WARN_ON_ONCE(1);
+			return -EIO;
+		}
+		iomap->blkno =
+			(sector_t)map.m_pblk << F2FS_LOG_SECTORS_PER_BLOCK;
+		iomap->length = F2FS_BLK_TO_BYTES((u64)map.m_len);
+	}
+
+	if (map.m_flags & F2FS_MAP_NEW)
+		iomap->flags |= IOMAP_F_NEW;
+	return 0;
+}
+
+static int f2fs_iomap_end(struct inode *inode, loff_t offset, loff_t length,
+	ssize_t written, unsigned int flags, struct iomap *iomap)
+{
+	put_dax(iomap->dax_dev);
+	if (!(flags & IOMAP_WRITE) || (flags & IOMAP_FAULT))
+		return 0;
+
+	if (offset + written > i_size_read(inode))
+		f2fs_i_size_write(inode, offset + written);
+
+	if (iomap->offset + iomap->length >
+			ALIGN(i_size_read(inode), F2FS_BLKSIZE)) {
+		block_t written_blk = F2FS_BYTES_TO_BLK(offset + written);
+		block_t end_blk = F2FS_BYTES_TO_BLK(offset + length);
+
+		if (written_blk < end_blk)
+			f2fs_write_failed(inode->i_mapping, offset + length);
+	}
+
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	return 0;
+}
+
+struct iomap_ops f2fs_iomap_ops = {
+	.iomap_begin	= f2fs_iomap_begin,
+	.iomap_end	= f2fs_iomap_end,
+};
+#endif
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 91db1d0..f862b6b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -88,6 +88,11 @@ struct f2fs_fault_info {
 #define F2FS_MOUNT_FAULT_INJECTION	0x00010000
 #define F2FS_MOUNT_ADAPTIVE		0x00020000
 #define F2FS_MOUNT_LFS			0x00040000
+#ifdef CONFIG_FS_DAX
+#define F2FS_MOUNT_DAX			0x00080000 /* Direct Access */
+#else
+#define F2FS_MOUNT_DAX			0
+#endif
 
 #define clear_opt(sbi, option)	((sbi)->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	((sbi)->mount_opt.opt |= F2FS_MOUNT_##option)
@@ -2390,6 +2395,9 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
 			struct page *page, enum migrate_mode mode);
 #endif
+#ifdef CONFIG_FS_DAX
+extern struct iomap_ops f2fs_iomap_ops;
+#endif
 
 /*
  * gc.c
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6a201c6..e7352a6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -23,6 +23,10 @@
 #include <linux/uio.h>
 #include <linux/uuid.h>
 #include <linux/file.h>
+#ifdef CONFIG_FS_DAX
+#include <linux/dax.h>
+#include <linux/iomap.h>
+#endif
 
 #include "f2fs.h"
 #include "node.h"
@@ -121,6 +125,64 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	.page_mkwrite	= f2fs_vm_page_mkwrite,
 };
 
+#ifdef CONFIG_FS_DAX
+static int f2fs_dax_huge_fault(struct vm_fault *vmf,
+	enum page_entry_size pe_size)
+{
+	int result;
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct super_block *sb = inode->i_sb;
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+
+	if (write) {
+		sb_start_pagefault(sb);
+		file_update_time(vmf->vma->vm_file);
+	}
+	down_read(&F2FS_I(inode)->i_mmap_sem);
+	result = dax_iomap_fault(vmf, pe_size, &f2fs_iomap_ops);
+	up_read(&F2FS_I(inode)->i_mmap_sem);
+	if (write)
+		sb_end_pagefault(sb);
+
+	return result;
+}
+
+static int f2fs_dax_fault(struct vm_fault *vmf)
+{
+	return f2fs_dax_huge_fault(vmf, PE_SIZE_PTE);
+}
+
+static int f2fs_dax_pfn_mkwrite(struct vm_fault *vmf)
+{
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct super_block *sb = inode->i_sb;
+	loff_t size;
+	int ret;
+
+	sb_start_pagefault(sb);
+	file_update_time(vmf->vma->vm_file);
+	down_read(&F2FS_I(inode)->i_mmap_sem);
+	size = (i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	if (vmf->pgoff >= size)
+		ret = VM_FAULT_SIGBUS;
+	else
+		ret = dax_pfn_mkwrite(vmf);
+	up_read(&F2FS_I(inode)->i_mmap_sem);
+	sb_end_pagefault(sb);
+
+	return ret;
+}
+
+static const struct vm_operations_struct f2fs_dax_vm_ops = {
+	.fault		= f2fs_dax_fault,
+	.huge_fault	= f2fs_dax_huge_fault,
+	.page_mkwrite	= f2fs_dax_fault,
+	.pfn_mkwrite	= f2fs_dax_pfn_mkwrite,
+};
+#else
+#define f2fs_dax_vm_ops f2fs_file_vm_ops
+#endif
+
 static int get_parent_ino(struct inode *inode, nid_t *pino)
 {
 	struct dentry *dentry;
@@ -436,7 +498,13 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		return err;
 
 	file_accessed(file);
-	vma->vm_ops = &f2fs_file_vm_ops;
+
+	if (IS_DAX(inode)) {
+		vma->vm_ops = &f2fs_dax_vm_ops;
+		vma->vm_flags |= VM_MIXEDMAP | VM_HUGEPAGE;
+	} else
+		vma->vm_ops = &f2fs_file_vm_ops;
+
 	return 0;
 }
 
@@ -520,6 +588,17 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 	if (!offset && !cache_only)
 		return 0;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode)) {
+		int ret;
+
+		down_read(&F2FS_I(inode)->dio_rwsem[WRITE]);
+		ret = iomap_zero_range(inode, from, PAGE_SIZE - offset,
+			NULL, &f2fs_iomap_ops);
+		up_read(&F2FS_I(inode)->dio_rwsem[WRITE]);
+		return ret;
+	}
+#endif
 	if (cache_only) {
 		page = find_lock_page(mapping, index);
 		if (page && PageUptodate(page))
@@ -786,6 +865,18 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	if (!len)
 		return 0;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode)) {
+		int ret;
+
+		down_read(&F2FS_I(inode)->dio_rwsem[WRITE]);
+		ret = iomap_zero_range(inode,
+			F2FS_BLK_TO_BYTES((loff_t)index) + start,
+			len, NULL, &f2fs_iomap_ops);
+		up_read(&F2FS_I(inode)->dio_rwsem[WRITE]);
+		return ret;
+	}
+#endif
 	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
@@ -1108,6 +1199,11 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	loff_t new_size;
 	int ret;
 
+#ifdef CONFIG_FS_DAX
+	/* The current implementation does not apply to DAX files. */
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
 	if (offset + len >= i_size_read(inode))
 		return -EINVAL;
 
@@ -1298,6 +1394,11 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	loff_t new_size;
 	int ret = 0;
 
+#ifdef CONFIG_FS_DAX
+	/* The current implementation does not apply to DAX files. */
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
 	new_size = i_size_read(inode) + len;
 	ret = inode_newsize_ok(inode, new_size);
 	if (ret)
@@ -1561,6 +1662,10 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
@@ -1610,6 +1715,9 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+#ifdef CONFIG_FS_DAX
+	f2fs_bug_on(F2FS_I_SB(inode), IS_DAX(inode));
+#endif
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
@@ -1646,6 +1754,10 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
@@ -1681,6 +1793,9 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+#ifdef CONFIG_FS_DAX
+	f2fs_bug_on(F2FS_I_SB(inode), IS_DAX(inode));
+#endif
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
@@ -1710,6 +1825,9 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+#ifdef CONFIG_FS_DAX
+	f2fs_bug_on(F2FS_I_SB(inode), IS_DAX(inode));
+#endif
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
@@ -2080,6 +2198,10 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
 	struct f2fs_defragment range;
 	int err;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -2129,6 +2251,10 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	size_t dst_osize;
 	int ret;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(src) || IS_DAX(dst))
+		return -EINVAL;
+#endif
 	if (file_in->f_path.mnt != file_out->f_path.mnt ||
 				src->i_sb != dst->i_sb)
 		return -EXDEV;
@@ -2368,6 +2494,61 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	}
 }
 
+#ifdef CONFIG_FS_DAX
+static ssize_t f2fs_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	inode_lock_shared(inode);
+
+	if (!IS_DAX(inode)) {
+		inode_unlock_shared(inode);
+		return generic_file_read_iter(iocb, to);
+	}
+
+	down_read(&F2FS_I(inode)->dio_rwsem[READ]);
+	ret = dax_iomap_rw(iocb, to, &f2fs_iomap_ops);
+	up_read(&F2FS_I(inode)->dio_rwsem[READ]);
+	inode_unlock_shared(inode);
+
+	file_accessed(iocb->ki_filp);
+	return ret;
+}
+
+static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	if (!iov_iter_count(to))
+		return 0; /* skip atime */
+
+	if (IS_DAX(file_inode(iocb->ki_filp)))
+		return f2fs_dax_read_iter(iocb, to);
+
+	return generic_file_read_iter(iocb, to);
+}
+
+static ssize_t f2fs_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	ret = file_remove_privs(iocb->ki_filp);
+	if (ret)
+		return ret;
+	ret = file_update_time(iocb->ki_filp);
+	if (ret)
+		return ret;
+
+	down_read(&F2FS_I(inode)->dio_rwsem[WRITE]);
+	ret = dax_iomap_rw(iocb, from, &f2fs_iomap_ops);
+	up_read(&F2FS_I(inode)->dio_rwsem[WRITE]);
+
+	return ret;
+}
+#else
+#define f2fs_dax_write_iter	__generic_file_write_iter
+#endif
+
 static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -2389,7 +2570,10 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			return err;
 		}
 		blk_start_plug(&plug);
-		ret = __generic_file_write_iter(iocb, from);
+		if (IS_DAX(inode))
+			ret = f2fs_dax_write_iter(iocb, from);
+		else
+			ret = __generic_file_write_iter(iocb, from);
 		blk_finish_plug(&plug);
 		clear_inode_flag(inode, FI_NO_PREALLOC);
 	}
@@ -2437,7 +2621,11 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 const struct file_operations f2fs_file_operations = {
 	.llseek		= f2fs_llseek,
+#ifdef CONFIG_FS_DAX
+	.read_iter	= f2fs_file_read_iter,
+#else
 	.read_iter	= generic_file_read_iter,
+#endif
 	.write_iter	= f2fs_file_write_iter,
 	.open		= f2fs_file_open,
 	.release	= f2fs_release_file,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index fa3d2e2..ade4f71 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -700,6 +700,100 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 	f2fs_put_page(page, 1);
 }
 
+#ifdef CONFIG_FS_DAX
+#include <linux/dax.h>
+
+static void dax_move_data_page(struct inode *inode, block_t bidx,
+				unsigned int segno, int off)
+{
+	struct block_device *bdev = inode->i_sb->s_bdev;
+	struct dax_device *dax_dev;
+	struct dnode_of_data dn;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_summary sum;
+	struct node_info ni;
+	block_t old_blkaddr, new_blkaddr;
+	int err, id;
+	long map_len;
+	pgoff_t pgoff;
+	void *kaddr_old, *kaddr_new;
+	pfn_t pfn;
+
+	f2fs_bug_on(sbi, f2fs_is_atomic_file(inode));
+
+	if (blk_queue_dax(bdev->bd_queue))
+		dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
+	else
+		return;
+
+	if (!check_valid_map(sbi, segno, off))
+		return;
+
+	if (!down_write_trylock(&F2FS_I(inode)->i_mmap_sem))
+		return;
+
+	unmap_mapping_range(inode->i_mapping, (loff_t)bidx << PAGE_SHIFT,
+			PAGE_SIZE, 1);
+	/* find the old block address */
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
+	err = get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
+	if (err)
+		goto out;
+	old_blkaddr = dn.data_blkaddr;
+	/* This page is already truncated */
+	if (old_blkaddr == NULL_ADDR)
+		goto put_dn;
+
+	/* allocate a new block address */
+	get_node_info(sbi, dn.nid, &ni);
+	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
+	allocate_data_block(sbi, NULL, old_blkaddr, &new_blkaddr,
+			&sum, CURSEG_COLD_DATA, NULL, false);
+
+	/* copy data page from old to new address in dax_bdev */
+	id = dax_read_lock();
+	err = bdev_dax_pgoff(bdev, SECTOR_FROM_BLOCK(old_blkaddr),
+			PAGE_SIZE, &pgoff);
+	if (err)
+		goto recover;
+	map_len = dax_direct_access(dax_dev, pgoff, 1, &kaddr_old, &pfn);
+	if (map_len < 0)
+		goto recover;
+	err = bdev_dax_pgoff(bdev, SECTOR_FROM_BLOCK(new_blkaddr),
+			PAGE_SIZE, &pgoff);
+	if (err)
+		goto recover;
+	map_len = dax_direct_access(dax_dev, pgoff, 1, &kaddr_new, &pfn);
+	if (map_len < 0)
+		goto recover;
+	copy_page((void __force *)kaddr_new, (void __force *)kaddr_old);
+
+	f2fs_update_data_blkaddr(&dn, new_blkaddr);
+	set_inode_flag(inode, FI_APPEND_WRITE);
+	if (bidx == 0)
+		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
+
+recover:
+	if (err || map_len < 0)
+		__f2fs_replace_block(sbi, &sum, new_blkaddr, old_blkaddr,
+							true, true);
+	dax_read_unlock(id);
+put_dn:
+	f2fs_put_dnode(&dn);
+out:
+	unmap_mapping_range(inode->i_mapping, (loff_t)bidx << PAGE_SHIFT,
+			PAGE_SIZE, 1);
+	up_write(&F2FS_I(inode)->i_mmap_sem);
+	put_dax(dax_dev);
+}
+#else
+static void dax_move_data_page(struct inode *inode, block_t bidx,
+				unsigned int segno, int off)
+{
+	return;
+}
+#endif
+
 static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 							unsigned int segno, int off)
 {
@@ -818,9 +912,9 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			if (IS_ERR(inode) || is_bad_inode(inode))
 				continue;
 
-			/* if encrypted inode, let's go phase 3 */
-			if (f2fs_encrypted_inode(inode) &&
-						S_ISREG(inode->i_mode)) {
+			/* if DAX or encrypted inode, let's go phase 3 */
+			if (IS_DAX(inode) || (f2fs_encrypted_inode(inode) &&
+						S_ISREG(inode->i_mode))) {
 				add_gc_inode(gc_list, inode);
 				continue;
 			}
@@ -858,7 +952,9 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 			start_bidx = start_bidx_of_node(nofs, inode)
 								+ ofs_in_node;
-			if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
+			if (IS_DAX(inode))
+				dax_move_data_page(inode, start_bidx, segno, off);
+			else if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
 				move_encrypted_block(inode, start_bidx, segno, off);
 			else
 				move_data_page(inode, start_bidx, gc_type, segno, off);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index e0fd437..fd8b290 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -28,6 +28,10 @@ bool f2fs_may_inline_data(struct inode *inode)
 	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
 		return false;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return false;
+#endif
 	return true;
 }
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 1ff5bd4..aa16c52 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -43,8 +43,14 @@ void f2fs_set_inode_flags(struct inode *inode)
 		new_fl |= S_NOATIME;
 	if (flags & FS_DIRSYNC_FL)
 		new_fl |= S_DIRSYNC;
+#ifdef CONFIG_FS_DAX
+	if (test_opt(F2FS_I_SB(inode), DAX) && S_ISREG(inode->i_mode) &&
+		!f2fs_has_inline_data(inode) && !f2fs_encrypted_inode(inode) &&
+		!f2fs_is_atomic_file(inode) && !f2fs_is_volatile_file(inode))
+		new_fl |= S_DAX;
+#endif
 	inode_set_flags(inode, new_fl,
-			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
+			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|S_DAX);
 }
 
 static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index c31b40e..8feeb9a 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -60,6 +60,11 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode))
 		f2fs_set_encrypted_inode(inode);
 
+#ifdef CONFIG_FS_DAX
+	if (test_opt(sbi, DAX) && S_ISREG(inode->i_mode) &&
+		!f2fs_has_inline_data(inode) && !f2fs_encrypted_inode(inode))
+		inode->i_flags |= S_DAX;
+#endif
 	set_inode_flag(inode, FI_NEW_INODE);
 
 	if (test_opt(sbi, INLINE_XATTR))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8e39b85..74277cd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -106,6 +106,7 @@ enum {
 	Opt_fault_injection,
 	Opt_lazytime,
 	Opt_nolazytime,
+	Opt_dax,
 	Opt_err,
 };
 
@@ -141,6 +142,7 @@ enum {
 	{Opt_fault_injection, "fault_injection=%u"},
 	{Opt_lazytime, "lazytime"},
 	{Opt_nolazytime, "nolazytime"},
+	{Opt_dax, "dax"},
 	{Opt_err, NULL},
 };
 
@@ -380,6 +382,15 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_nolazytime:
 			sb->s_flags &= ~MS_LAZYTIME;
 			break;
+#ifdef CONFIG_FS_DAX
+		case Opt_dax:
+			set_opt(sbi, DAX);
+			break;
+#else
+		case Opt_dax:
+			f2fs_msg(sb, KERN_INFO, "dax option not supported");
+			break;
+#endif
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -775,6 +786,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",fault_injection=%u",
 				sbi->fault_info.inject_rate);
 #endif
+#ifdef CONFIG_FS_DAX
+	if (test_opt(sbi, DAX))
+		seq_puts(seq, ",dax");
+#endif
 
 	return 0;
 }
-- 
1.8.3.1
