From: sunqiuyang <sunqiuyang@huawei.com>
Subject: [PATCH v2 1/2] f2fs: dax: fix races between page faults
	and truncating pages
Date: Thu, 18 May 2017 11:06:08 +0800
Message-ID: <1495076768-17953-1-git-send-email-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunqiuyang@huawei.com>) id 1dBBjL-0004vG-5u
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 May 2017 03:03:59 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dBBjI-0007CT-O6
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 May 2017 03:03:59 +0000
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

Currently in F2FS, page faults and operations that truncate the pagecahe
or data blocks, are completely unsynchronized. This can result in page
fault faulting in a page into a range that we are changing after
truncating, and thus we can end up with a page mapped to disk blocks that
will be shortly freed. Filesystem corruption will shortly follow.

This patch fixes the problem by creating new rw semaphore i_mmap_sem in
f2fs_inode_info and grab it for functions removing blocks from extent tree
and for read over page faults. The mechanism is similar to that in ext4.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
Changelog v1 -> v2:

- Apply the new rw semaphore in some other necessary scenarios:
	f2fs_write_failed
	f2fs_filemap_fault (new function)
	f2fs_vm_page_mkwrite
	f2fs_setattr
(f2fs_add_inline_entries() does not need this rw semaphore, as dir is a
directory file and its pages would not be mmap'ed.)

- Lock coverage in the scenarios below are reconsidered:
	punch_hole
	f2fs_collapse_range
	f2fs_zero_range
	f2fs_insert_range

The v2 patches are at 4.12-rc1.
---
 fs/f2fs/data.c  |  2 ++
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/file.c  | 48 +++++++++++++++++++++++++++++++++++++++---------
 fs/f2fs/super.c |  1 +
 4 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7c0f6bd..c9a3fbd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1753,8 +1753,10 @@ static void f2fs_write_failed(struct address_space *mapping, loff_t to)
 	loff_t i_size = i_size_read(inode);
 
 	if (to > i_size) {
+		down_write(&F2FS_I(inode)->i_mmap_sem);
 		truncate_pagecache(inode, i_size);
 		truncate_blocks(inode, i_size, true);
+		up_write(&F2FS_I(inode)->i_mmap_sem);
 	}
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2185c7a..8095f4f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -519,6 +519,7 @@ struct f2fs_inode_info {
 	struct mutex inmem_lock;	/* lock for inmemory pages */
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
 	struct rw_semaphore dio_rwsem[2];/* avoid racing between dio and gc */
+	struct rw_semaphore i_mmap_sem;
 };
 
 static inline void get_extent_info(struct extent_info *ext,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 61af721..0b0115c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -33,6 +33,18 @@
 #include "trace.h"
 #include <trace/events/f2fs.h>
 
+static int f2fs_filemap_fault(struct vm_fault *vmf)
+{
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	int err;
+
+	down_read(&F2FS_I(inode)->i_mmap_sem);
+	err = filemap_fault(vmf);
+	up_read(&F2FS_I(inode)->i_mmap_sem);
+
+	return err;
+}
+
 static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
@@ -59,13 +71,14 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	f2fs_balance_fs(sbi, dn.node_changed);
 
 	file_update_time(vmf->vma->vm_file);
+	down_read(&F2FS_I(inode)->i_mmap_sem);
 	lock_page(page);
 	if (unlikely(page->mapping != inode->i_mapping ||
 			page_offset(page) > i_size_read(inode) ||
 			!PageUptodate(page))) {
 		unlock_page(page);
 		err = -EFAULT;
-		goto out;
+		goto out_sem;
 	}
 
 	/*
@@ -94,6 +107,8 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
 		f2fs_wait_on_encrypted_page_writeback(sbi, dn.data_blkaddr);
 
+out_sem:
+	up_read(&F2FS_I(inode)->i_mmap_sem);
 out:
 	sb_end_pagefault(inode->i_sb);
 	f2fs_update_time(sbi, REQ_TIME);
@@ -101,7 +116,7 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 }
 
 static const struct vm_operations_struct f2fs_file_vm_ops = {
-	.fault		= filemap_fault,
+	.fault		= f2fs_filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= f2fs_vm_page_mkwrite,
 };
@@ -687,8 +702,10 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 			return -EACCES;
 
 		if (attr->ia_size <= i_size_read(inode)) {
+			down_write(&F2FS_I(inode)->i_mmap_sem);
 			truncate_setsize(inode, attr->ia_size);
 			err = f2fs_truncate(inode);
+			up_write(&F2FS_I(inode)->i_mmap_sem);
 			if (err)
 				return err;
 		} else {
@@ -696,7 +713,9 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 			 * do not trim all blocks after i_size if target size is
 			 * larger than i_size.
 			 */
+			down_write(&F2FS_I(inode)->i_mmap_sem);
 			truncate_setsize(inode, attr->ia_size);
+			up_write(&F2FS_I(inode)->i_mmap_sem);
 
 			/* should convert inline inode here */
 			if (!f2fs_may_inline_data(inode)) {
@@ -839,12 +858,14 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 			blk_start = (loff_t)pg_start << PAGE_SHIFT;
 			blk_end = (loff_t)pg_end << PAGE_SHIFT;
+			down_write(&F2FS_I(inode)->i_mmap_sem);
 			truncate_inode_pages_range(mapping, blk_start,
 					blk_end - 1);
 
 			f2fs_lock_op(sbi);
 			ret = truncate_hole(inode, pg_start, pg_end);
 			f2fs_unlock_op(sbi);
+			up_write(&F2FS_I(inode)->i_mmap_sem);
 		}
 	}
 
@@ -1083,16 +1104,17 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	pg_start = offset >> PAGE_SHIFT;
 	pg_end = (offset + len) >> PAGE_SHIFT;
 
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 	/* write out all dirty pages from offset */
 	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
 	if (ret)
-		return ret;
+		goto out;
 
 	truncate_pagecache(inode, offset);
 
 	ret = f2fs_do_collapse(inode, pg_start, pg_end);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* write out all moved pages, if possible */
 	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
@@ -1105,6 +1127,8 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
 
+out:
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 	return ret;
 }
 
@@ -1169,9 +1193,10 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	if (ret)
 		return ret;
 
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 	ret = filemap_write_and_wait_range(mapping, offset, offset + len - 1);
 	if (ret)
-		return ret;
+		goto out_sem;
 
 	truncate_pagecache_range(inode, offset, offset + len - 1);
 
@@ -1185,7 +1210,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 		ret = fill_zero(inode, pg_start, off_start,
 						off_end - off_start);
 		if (ret)
-			return ret;
+			goto out_sem;
 
 		new_size = max_t(loff_t, new_size, offset + len);
 	} else {
@@ -1193,7 +1218,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			ret = fill_zero(inode, pg_start++, off_start,
 						PAGE_SIZE - off_start);
 			if (ret)
-				return ret;
+				goto out_sem;
 
 			new_size = max_t(loff_t, new_size,
 					(loff_t)pg_start << PAGE_SHIFT);
@@ -1242,6 +1267,8 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 out:
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size)
 		f2fs_i_size_write(inode, new_size);
+out_sem:
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 
 	return ret;
 }
@@ -1271,14 +1298,15 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	f2fs_balance_fs(sbi, true);
 
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 	ret = truncate_blocks(inode, i_size_read(inode), true);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* write out all dirty pages from offset */
 	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
 	if (ret)
-		return ret;
+		goto out;
 
 	truncate_pagecache(inode, offset);
 
@@ -1307,6 +1335,8 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
+out:
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 	return ret;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 83355ec..8472c98 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -624,6 +624,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	mutex_init(&fi->inmem_lock);
 	init_rwsem(&fi->dio_rwsem[READ]);
 	init_rwsem(&fi->dio_rwsem[WRITE]);
+	init_rwsem(&fi->i_mmap_sem);
 
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
-- 
1.8.3.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
