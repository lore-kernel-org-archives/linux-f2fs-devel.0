From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: release cp and dnode lock before IPU
Date: Wed, 26 Apr 2017 11:18:05 +0800
Message-ID: <20170426031805.92884-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Hou Pengyang <houpengyang@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Hou Pengyang <houpengyang@huawei.com>

We don't need to rewrite the page under dnode locks.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    | 40 ++++++++++++++++++++++++++--------------
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/gc.c      |  1 +
 fs/f2fs/segment.c |  1 +
 4 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b8245a17ed69..bbe2c28810bf 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1357,12 +1357,17 @@ int do_write_data_page(struct f2fs_io_info *fio)
 		if (fio->old_blkaddr != NULL_ADDR &&
 				fio->old_blkaddr != NEW_ADDR) {
 			ipu_force = true;
+			fio->need_lock = false;
 			goto got_it;
 		}
 	}
+
+	if (fio->need_lock)
+		f2fs_lock_op(fio->sbi);
+
 	err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
 	if (err)
-		return err;
+		goto out;
 
 	fio->old_blkaddr = dn.data_blkaddr;
 
@@ -1383,21 +1388,26 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	 * it had better in-place writes for updated data.
 	 */
 	if (ipu_force || need_inplace_update(fio)) {
-		f2fs_bug_on(fio->sbi, !fio->cp_rwsem_locked);
-		f2fs_unlock_op(fio->sbi);
-		fio->cp_rwsem_locked = false;
+		f2fs_put_dnode(&dn);
+		if (fio->need_lock)
+			f2fs_unlock_op(fio->sbi);
 		err = rewrite_data_page(fio);
 		trace_f2fs_do_write_data_page(fio->page, IPU);
 		set_inode_flag(inode, FI_UPDATE_WRITE);
-	} else {
-		write_data_page(&dn, fio);
-		trace_f2fs_do_write_data_page(page, OPU);
-		set_inode_flag(inode, FI_APPEND_WRITE);
-		if (page->index == 0)
-			set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
+		return err;
 	}
+
+	/* LFS mode write path */
+	write_data_page(&dn, fio);
+	trace_f2fs_do_write_data_page(page, OPU);
+	set_inode_flag(inode, FI_APPEND_WRITE);
+	if (page->index == 0)
+		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 out_writepage:
 	f2fs_put_dnode(&dn);
+out:
+	if (fio->need_lock)
+		f2fs_unlock_op(fio->sbi);
 	return err;
 }
 
@@ -1422,7 +1432,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 		.page = page,
 		.encrypted_page = NULL,
 		.submitted = false,
-		.cp_rwsem_locked = true,
+		.need_lock = true,
 	};
 
 	trace_f2fs_writepage(page, DATA);
@@ -1458,6 +1468,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 
 	/* Dentry blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode)) {
+		fio.need_lock = false,
 		err = do_write_data_page(&fio);
 		goto done;
 	}
@@ -1471,17 +1482,18 @@ static int __write_data_page(struct page *page, bool *submitted,
 
 	err = -EAGAIN;
 	if (f2fs_has_inline_data(inode)) {
+		f2fs_lock_op(sbi);
 		err = f2fs_write_inline_data(inode, page);
+		f2fs_unlock_op(sbi);
 		if (!err)
 			goto out;
 	}
-	f2fs_lock_op(sbi);
+
 	if (err == -EAGAIN)
 		err = do_write_data_page(&fio);
 	if (F2FS_I(inode)->last_disk_size < psize)
 		F2FS_I(inode)->last_disk_size = psize;
-	if (fio.cp_rwsem_locked)
-		f2fs_unlock_op(sbi);
+
 done:
 	if (err && err != -ENOENT)
 		goto redirty_out;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bf48213642ab..95fb347e7abe 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -802,7 +802,7 @@ struct f2fs_io_info {
 	struct page *page;	/* page to be written */
 	struct page *encrypted_page;	/* encrypted page */
 	bool submitted;		/* indicate IO submission */
-	bool cp_rwsem_locked;	/* indicate cp_rwsem is held */
+	bool need_lock;		/* indicate we need to lock cp_rwsem */
 };
 
 #define is_read_io(rw) ((rw) == READ)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c2a9ae8397d3..ffabdcf52b85 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -717,6 +717,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 			.old_blkaddr = NULL_ADDR,
 			.page = page,
 			.encrypted_page = NULL,
+			.need_lock = false,
 		};
 		bool is_dirty = PageDirty(page);
 		int err;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4ba61ca430d0..63ea066f7dc0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -293,6 +293,7 @@ static int __commit_inmem_pages(struct inode *inode,
 		.op_flags = REQ_SYNC | REQ_PRIO,
 		.old_blkaddr = NULL_ADDR,
 		.encrypted_page = NULL,
+		.need_lock = false,
 	};
 	pgoff_t last_idx = ULONG_MAX;
 	int err = 0;
-- 
2.12.2.510.ge1104a5ee539
