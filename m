From: Chao Yu <chao@kernel.org>
Subject: [PATCH RESEND v2] f2fs: release cp and dnode lock before
	IPU
Date: Thu, 27 Apr 2017 00:17:21 +0800
Message-ID: <20170426161721.9362-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1d3PfI-000136-1g
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Apr 2017 16:19:40 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d3PfG-0005Aw-Gg
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Apr 2017 16:19:39 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Hou Pengyang <houpengyang@huawei.com>

We don't need to rewrite the page under cp_rwsem and dnode locks.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    | 39 ++++++++++++++++++++++++---------------
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/gc.c      |  1 +
 fs/f2fs/segment.c |  1 +
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ca21ecbd6bbd..632008241470 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1361,12 +1361,17 @@ int do_write_data_page(struct f2fs_io_info *fio)
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
 
@@ -1387,22 +1392,26 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	 * it had better in-place writes for updated data.
 	 */
 	if (ipu_force || need_inplace_update(fio)) {
-		f2fs_bug_on(fio->sbi, !fio->cp_rwsem_locked);
-		f2fs_unlock_op(fio->sbi);
-		fio->cp_rwsem_locked = false;
-
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
 
@@ -1427,7 +1436,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 		.page = page,
 		.encrypted_page = NULL,
 		.submitted = false,
-		.cp_rwsem_locked = true,
+		.need_lock = true,
 	};
 
 	trace_f2fs_writepage(page, DATA);
@@ -1463,6 +1472,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 
 	/* Dentry blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode)) {
+		fio.need_lock = false;
 		err = do_write_data_page(&fio);
 		goto done;
 	}
@@ -1480,13 +1490,12 @@ static int __write_data_page(struct page *page, bool *submitted,
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
2.12.2.575.gb14f27f


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
