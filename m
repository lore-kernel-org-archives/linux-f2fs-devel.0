From: sunqiuyang <sunqiuyang@huawei.com>
Subject: [PATCH 3/3] f2fs:dax: Implement direct access
Date: Thu, 4 May 2017 08:17:38 +0800
Message-ID: <1493857058-40776-1-git-send-email-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunqiuyang@huawei.com>) id 1d64QQ-0007W2-Ta
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 May 2017 00:15:18 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d64QO-0001Ix-BR
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 May 2017 00:15:18 +0000
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
Cc: wenyuzhong1@huawei.com, wangxiaojun11@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com, guzheng1@huawei.com, yanaijie@huawei.com, zhaohongjiang@huawei.com, dingxiang@huawei.com, wangyijing@huawei.com, sunqiuyang@huawei.com

This patch implements Direct Access (DAX) in F2FS, including:
 - a mount option to enable DAX
 - read/write and mmap of regular files in the DAX way
 - zero-out of non-aligned partial blocks in the DAX way
 - garbage collection of DAX files
 - incompatibility of DAX with inline data, atomic or volatile write

TODO: We may need new implementation of f2fs_collapse/insert_range() for 
DAX files, as filemap_write_and_wait_range() does not work for DAX files, 
and thus the data pages cannot be moved correctly.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/f2fs/f2fs.h   |   8 +++
 fs/f2fs/file.c   | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/gc.c     |  69 +++++++++++++++++--
 fs/f2fs/inline.c |   4 ++
 fs/f2fs/inode.c  |  88 +++++++++++++++++++++++++
 fs/f2fs/namei.c  |   7 ++
 fs/f2fs/super.c  |  16 +++++
 7 files changed, 383 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f7957ca..d0e8af5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -87,6 +87,11 @@ struct f2fs_fault_info {
 #define F2FS_MOUNT_FAULT_INJECTION	0x00010000
 #define F2FS_MOUNT_ADAPTIVE		0x00020000
 #define F2FS_MOUNT_LFS			0x00040000
+#ifdef CONFIG_FS_DAX
+#define F2FS_MOUNT_DAX			0x00080000 /* Direct Access */
+#else
+#define F2FS_MOUNT_DAX			0
+#endif
 
 #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
@@ -2063,6 +2068,9 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc);
 void f2fs_evict_inode(struct inode *inode);
 void handle_failed_inode(struct inode *inode);
+#ifdef CONFIG_FS_DAX
+extern struct iomap_ops f2fs_iomap_ops;
+#endif
 
 /*
  * namei.c
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 165acbf..4eeb17b 100644
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
@@ -106,6 +108,64 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
@@ -434,7 +494,13 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		return err;
 
 	file_accessed(file);
-	vma->vm_ops = &f2fs_file_vm_ops;
+	if (IS_DAX(file_inode(file))) {
+		vma->vm_ops = &f2fs_dax_vm_ops;
+		vma->vm_flags |= VM_MIXEDMAP | VM_HUGEPAGE;
+	} else {
+		vma->vm_ops = &f2fs_file_vm_ops;
+	}
+
 	return 0;
 }
 
@@ -518,6 +584,18 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
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
@@ -750,6 +828,19 @@ static int fill_zero(struct inode *inode, pgoff_t index,
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
@@ -1073,6 +1164,12 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	loff_t new_size;
 	int ret;
 
+#ifdef CONFIG_FS_DAX
+	/* The original implementation does not apply to DAX files. */
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
+
 	if (offset + len >= i_size_read(inode))
 		return -EINVAL;
 
@@ -1265,6 +1362,12 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	loff_t new_size;
 	int ret = 0;
 
+#ifdef CONFIG_FS_DAX
+	/* The original implementation does not apply to DAX files. */
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
+
 	new_size = i_size_read(inode) + len;
 	if (new_size > inode->i_sb->s_maxbytes)
 		return -EFBIG;
@@ -1527,6 +1630,11 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -1568,6 +1676,11 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -1604,6 +1717,11 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -1633,6 +1751,11 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -1662,6 +1785,11 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return -EINVAL;
+#endif
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -2252,6 +2380,64 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
@@ -2278,7 +2464,10 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
@@ -2326,7 +2515,11 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
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
index 418fd98..70cbd39 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -16,6 +16,7 @@
 #include <linux/kthread.h>
 #include <linux/delay.h>
 #include <linux/freezer.h>
+#include <linux/dax.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -671,6 +672,64 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 	f2fs_put_page(page, 1);
 }
 
+static void dax_move_data_page(struct inode *inode, block_t bidx,
+			unsigned int segno, int off)
+{
+	struct block_device *bdev = inode->i_sb->s_bdev;
+	struct dnode_of_data dn;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_summary sum;
+	struct node_info ni;
+	block_t old_blkaddr, new_blkaddr;
+	struct blk_dax_ctl old_dax, new_dax;
+	int err;
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
+	unmap_mapping_range(inode->i_mapping,
+		(loff_t)bidx << PAGE_SHIFT, PAGE_SIZE, 1);
+	/* find the old block address */
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
+	err = get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
+	if (err || dn.data_blkaddr == NULL_ADDR)
+		return;
+	old_blkaddr = dn.data_blkaddr;
+
+	/* allocate a new block address */
+	get_node_info(sbi, dn.nid, &ni);
+	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
+	mutex_lock(&sbi->wio_mutex[DATA]);
+	allocate_data_block(sbi, NULL, old_blkaddr,
+			&new_blkaddr, &sum, CURSEG_COLD_DATA);
+	/* copy data page within directly accessed bdev */
+	old_dax.sector = SECTOR_FROM_BLOCK(old_blkaddr);
+	new_dax.sector = SECTOR_FROM_BLOCK(new_blkaddr);
+	old_dax.size = new_dax.size = PAGE_SIZE;
+	dax_map_atomic(bdev, &old_dax);
+	dax_map_atomic(bdev, &new_dax);
+	copy_page((void __force *)new_dax.addr, (void __force *)old_dax.addr);
+	dax_unmap_atomic(bdev, &new_dax);
+	dax_unmap_atomic(bdev, &old_dax);
+	mutex_unlock(&sbi->wio_mutex[DATA]);
+
+	f2fs_update_data_blkaddr(&dn, new_blkaddr);
+	set_inode_flag(inode, FI_APPEND_WRITE);
+	if (bidx == 0)
+		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
+	f2fs_put_dnode(&dn);
+
+	unmap_mapping_range(inode->i_mapping,
+		(loff_t)bidx << PAGE_SHIFT, PAGE_SIZE, 1);
+	up_write(&F2FS_I(inode)->i_mmap_sem);
+}
+
 static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 							unsigned int segno, int off)
 {
@@ -786,9 +845,9 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
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
@@ -826,7 +885,9 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
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
index e32a9e5..4b9d853 100644
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
index 24bb821..96e1f57 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -13,6 +13,7 @@
 #include <linux/buffer_head.h>
 #include <linux/backing-dev.h>
 #include <linux/writeback.h>
+#include <linux/iomap.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -478,3 +479,90 @@ void handle_failed_inode(struct inode *inode)
 	/* iput will drop the inode object */
 	iput(inode);
 }
+
+#ifdef CONFIG_FS_DAX
+static int f2fs_iomap_begin(struct inode *inode, loff_t offset,
+	loff_t length, unsigned int flags, struct iomap *iomap)
+{
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
+	iomap->bdev = inode->i_sb->s_bdev;
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
+			ALIGN(inode->i_size, F2FS_BLKSIZE)) {
+		block_t written_blk = F2FS_BYTES_TO_BLK(offset + written);
+		block_t end_blk = F2FS_BYTES_TO_BLK(offset + length);
+
+		if (written_blk < end_blk) {
+			down_write(&F2FS_I(inode)->i_mmap_sem);
+			truncate_inode_pages(inode->i_mapping, inode->i_size);
+			f2fs_truncate(inode);
+			up_write(&F2FS_I(inode)->i_mmap_sem);
+		}
+	}
+
+	return 0;
+}
+
+struct iomap_ops f2fs_iomap_ops = {
+	.iomap_begin	= f2fs_iomap_begin,
+	.iomap_end		= f2fs_iomap_end,
+};
+#endif
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 98f00a3..922d42f 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -60,6 +60,13 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode))
 		f2fs_set_encrypted_inode(inode);
 
+#ifdef CONFIG_FS_DAX
+	if (test_opt(sbi, DAX) &&
+	S_ISREG(inode->i_mode) &&
+	!f2fs_has_inline_data(inode) &&
+	!f2fs_encrypted_inode(inode))
+		inode->i_flags |= S_DAX;
+#endif
 	set_inode_flag(inode, FI_NEW_INODE);
 
 	if (test_opt(sbi, INLINE_XATTR))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 30855cf..3463bf9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -106,6 +106,7 @@ enum {
 	Opt_fault_injection,
 	Opt_lazytime,
 	Opt_nolazytime,
+	Opt_dax,
 	Opt_err,
 };
 
@@ -140,6 +141,7 @@ enum {
 	{Opt_fault_injection, "fault_injection=%u"},
 	{Opt_lazytime, "lazytime"},
 	{Opt_nolazytime, "nolazytime"},
+	{Opt_dax, "dax"},
 	{Opt_err, NULL},
 };
 
@@ -482,6 +484,16 @@ static int parse_options(struct super_block *sb, char *options)
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
+
 		case Opt_active_logs:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
@@ -966,6 +978,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
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
