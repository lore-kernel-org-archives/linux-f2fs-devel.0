From: sunqiuyang <sunqiuyang@huawei.com>
Subject: [PATCH v2 2/2] f2fs: dax: Implement direct access
Date: Thu, 18 May 2017 11:08:11 +0800
Message-ID: <1495076891-18261-1-git-send-email-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunqiuyang@huawei.com>) id 1dBBlu-00050m-HS
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 May 2017 03:06:38 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dBBlr-0005ed-Nj
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 May 2017 03:06:38 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: wangxiaojun11@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com, guzheng1@huawei.com, yanaijie@huawei.com, zhaohongjiang@huawei.com, dingxiang@huawei.com, wangyijing@huawei.com, sunqiuyang@huawei.com

From: Qiuyang Sun <sunqiuyang@huawei.com>

This patch implements Direct Access (DAX) in F2FS, including:
- a mount option to choose whether to enable DAX or not
- read/write and mmap of regular files in the DAX way
- zero-out of unaligned partial blocks in the DAX way
- garbage collection of DAX files, by mapping both old and new physical
  addresses of a data page into memory and copy data between them directly
- incompatibility of DAX with inline data, atomic or volatile write

TODO: The current implementation of f2fs_collapse/insert_range() does not
apply to DAX files, as filemap_write_and_wait_range() works in a different
way for such files, and thus the data pages cannot be moved correctly. In
this patch the two functions simply returns -EINVAL. A possible solution is
to enable using page cache temporarily.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
Changelog v1 -> v2:
- Remove [PATCH v1 2/3] which exported the interfaces of
  dax_map/unmap_atomic(), as the two functions no longer exist since 4.12.
  This patch is a newer version of v1 3/3.
- For dax_move_data_page() in <gc.c>, call dax_direct_access() to map the
  device into memory, instead of dax_map_atomic() in v1.
- Move the functions f2fs_iomap_begin/end() from <inode.c> to <data.c>,
  and make changes according to the new interfaces for DAX in 4.12, e.g.,
  struct iomap with an additional field (struct dax_device *dax_dev).

The v2 patches are at 4.12-rc1.
---
 fs/f2fs/data.c   |  90 +++++++++++++++++++++++++
 fs/f2fs/f2fs.h   |   8 +++
 fs/f2fs/file.c   | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/gc.c     |  95 +++++++++++++++++++++++++--
 fs/f2fs/inline.c |   4 ++
 fs/f2fs/namei.c  |   6 ++
 fs/f2fs/super.c  |  15 +++++
 7 files changed, 409 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c9a3fbd..8362a9f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -23,6 +23,7 @@
 #include <linux/memcontrol.h>
 #include <linux/cleancache.h>
 #include <linux/sched/signal.h>
+#include <linux/iomap.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -2209,3 +2210,92 @@ int f2fs_migrate_page(struct address_space *mapping,
 	.migratepage    = f2fs_migrate_page,
 #endif
 };
+
+#ifdef CONFIG_FS_DAX
+static int f2fs_iomap_begin(struct inode *inode, loff_t offset,
+	loff_t length, unsigned int flags, struct iomap *iomap)
+{
+	struct block_device *bdev;
+	unsigned long first_block = F2FS_BYTES_TO_BLK(offset);
+	unsigned long last_block = F2FS_BYTES_TO_BLK(offset + length - 1);
+	struct f2fs_map_blocks map;
+	int ret;
+	loff_t original_i_size = i_size_read(inode);
+
+	if (WARN_ON_ONCE(f2fs_has_inline_data(inode)))
+		return -ERANGE;
+
+	map.m_lblk = first_block;
+	map.m_len = last_block - first_block + 1;
+	map.m_next_pgofs = NULL;
+
+	if (!(flags & IOMAP_WRITE))
+		ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_READ);
+	else {
+		ret = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
+	/* i_size should be kept here and changed later in f2fs_iomap_end */
+		if (i_size_read(inode) != original_i_size)
+			f2fs_i_size_write(inode, original_i_size);
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
+		if (map.m_flags & F2FS_MAP_MAPPED) {
+			iomap->type = IOMAP_MAPPED;
+		} else if (map.m_flags & F2FS_MAP_UNWRITTEN) {
+			iomap->type = IOMAP_UNWRITTEN;
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
+	return 0;
+}
+
+struct iomap_ops f2fs_iomap_ops = {
+	.iomap_begin	= f2fs_iomap_begin,
+	.iomap_end	= f2fs_iomap_end,
+};
+#endif
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8095f4f..df9e309 100644
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
@@ -2344,6 +2349,9 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
 			struct page *page, enum migrate_mode mode);
 #endif
+#ifdef CONFIG_FS_DAX
+extern struct iomap_ops f2fs_iomap_ops;
+#endif
 
 /*
  * gc.c
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0b0115c..9b0fe7a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -23,6 +23,8 @@
 #include <linux/uio.h>
 #include <linux/uuid.h>
 #include <linux/file.h>
+#include <linux/dax.h>
+#include <linux/iomap.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -121,6 +123,64 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
@@ -444,7 +504,13 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
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
 
@@ -528,6 +594,18 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
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
+
 	if (cache_only) {
 		page = find_lock_page(mapping, index);
 		if (page && PageUptodate(page))
@@ -768,6 +846,19 @@ static int fill_zero(struct inode *inode, pgoff_t index,
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
+
 	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
@@ -1090,6 +1181,12 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	loff_t new_size;
 	int ret;
 
+#ifdef CONFIG_FS_DAX
+	/* The current implementation does not apply to DAX files. */
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
+
 	if (offset + len >= i_size_read(inode))
 		return -EINVAL;
 
@@ -1280,6 +1377,12 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	loff_t new_size;
 	int ret = 0;
 
+#ifdef CONFIG_FS_DAX
+	/* The current implementation does not apply to DAX files. */
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
+
 	new_size = i_size_read(inode) + len;
 	ret = inode_newsize_ok(inode, new_size);
 	if (ret)
@@ -1542,6 +1645,11 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
@@ -1591,6 +1699,11 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
@@ -1627,6 +1740,11 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
@@ -1662,6 +1780,11 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
@@ -1691,6 +1814,11 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
@@ -2349,6 +2477,64 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
+static ssize_t f2fs_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return __generic_file_write_iter(iocb, from);
+}
+#endif
+
 static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -2375,7 +2561,10 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
@@ -2423,7 +2612,11 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
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
index 0265221..ccf3950 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -16,6 +16,7 @@
 #include <linux/kthread.h>
 #include <linux/delay.h>
 #include <linux/freezer.h>
+#include <linux/dax.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -688,6 +689,90 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 	f2fs_put_page(page, 1);
 }
 
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
+	if (blk_queue_dax(bdev->bd_queue))
+		dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
+	else
+		return;
+
+	if (!check_valid_map(sbi, segno, off))
+		return;
+
+	if (f2fs_is_atomic_file(inode))
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
+		goto out_map;
+	old_blkaddr = dn.data_blkaddr;
+	/* This page is already truncated */
+	if (old_blkaddr == NULL_ADDR) {
+		f2fs_put_dnode(&dn);
+		goto out_map;
+	}
+
+	/* allocate a new block address */
+	get_node_info(sbi, dn.nid, &ni);
+	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
+	mutex_lock(&sbi->wio_mutex[DATA]);
+	allocate_data_block(sbi, NULL, old_blkaddr,
+					&new_blkaddr, &sum, CURSEG_COLD_DATA);
+
+	/* copy data page from old to new address in dax_bdev */
+	id = dax_read_lock();
+	err = bdev_dax_pgoff(bdev, SECTOR_FROM_BLOCK(old_blkaddr),
+			PAGE_SIZE, &pgoff);
+	if (err)
+		goto unlock;
+	map_len = dax_direct_access(dax_dev, pgoff, 1, &kaddr_old, &pfn);
+	if (map_len < 0)
+		goto unlock;
+	err = bdev_dax_pgoff(bdev, SECTOR_FROM_BLOCK(new_blkaddr),
+			PAGE_SIZE, &pgoff);
+	if (err)
+		goto unlock;
+	map_len = dax_direct_access(dax_dev, pgoff, 1, &kaddr_new, &pfn);
+	if (map_len < 0)
+		goto unlock;
+	copy_page((void __force *)kaddr_new, (void __force *)kaddr_old);
+
+	f2fs_update_data_blkaddr(&dn, new_blkaddr);
+	set_inode_flag(inode, FI_APPEND_WRITE);
+	if (bidx == 0)
+		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
+	f2fs_put_dnode(&dn);
+
+unlock:
+	dax_read_unlock(id);
+	mutex_unlock(&sbi->wio_mutex[DATA]);
+out_map:
+	unmap_mapping_range(inode->i_mapping, (loff_t)bidx << PAGE_SHIFT,
+			PAGE_SIZE, 1);
+	up_write(&F2FS_I(inode)->i_mmap_sem);
+}
+
 static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 							unsigned int segno, int off)
 {
@@ -805,9 +890,9 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
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
@@ -845,7 +930,9 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
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
index e4c527c..f858817 100644
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
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index c31b40e..f3edc6c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -60,6 +60,12 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode))
 		f2fs_set_encrypted_inode(inode);
 
+#ifdef CONFIG_FS_DAX
+	if (test_opt(sbi, DAX) && S_ISREG(inode->i_mode) &&
+	!f2fs_has_inline_data(inode) && !f2fs_encrypted_inode(inode))
+		inode->i_flags |= S_DAX;
+#endif
+
 	set_inode_flag(inode, FI_NEW_INODE);
 
 	if (test_opt(sbi, INLINE_XATTR))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8472c98..ddcd9cd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -108,6 +108,7 @@ enum {
 	Opt_fault_injection,
 	Opt_lazytime,
 	Opt_nolazytime,
+	Opt_dax,
 	Opt_err,
 };
 
@@ -143,6 +144,7 @@ enum {
 	{Opt_fault_injection, "fault_injection=%u"},
 	{Opt_lazytime, "lazytime"},
 	{Opt_nolazytime, "nolazytime"},
+	{Opt_dax, "dax"},
 	{Opt_err, NULL},
 };
 
@@ -490,6 +492,15 @@ static int parse_options(struct super_block *sb, char *options)
 			f2fs_msg(sb, KERN_INFO, "noacl options not supported");
 			break;
 #endif
+#ifdef CONFIG_FS_DAX
+		case Opt_dax:
+			set_opt(sbi, DAX);
+			break;
+#else
+		case Opt_dax:
+			f2fs_msg(sb, KERN_INFO, "dax options not supported");
+			break;
+#endif
 		case Opt_active_logs:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
@@ -983,6 +994,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	if (test_opt(sbi, FAULT_INJECTION))
 		seq_puts(seq, ",fault_injection");
 #endif
+#ifdef CONFIG_FS_DAX
+	if (test_opt(sbi, DAX))
+		seq_puts(seq, ",dax");
+#endif
 
 	return 0;
 }
-- 
1.8.3.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
