From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 4/4] f2fs: call f2fs_balance_fs only when
	node was changed
Date: Wed, 23 Dec 2015 11:14:28 -0800
Message-ID: <20151223191428.GE30505@jaegeuk.local>
References: <1450832388-29118-1-git-send-email-jaegeuk@kernel.org>
	<1450832388-29118-4-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aBort-0007Ho-IW
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 19:14:37 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aBors-0003WX-Gn for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 19:14:37 +0000
Content-Disposition: inline
In-Reply-To: <1450832388-29118-4-git-send-email-jaegeuk@kernel.org>
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

Change log v2:
 - add dio case

>From c2d16a526371954671f9c8cff5f09f9d230f7993 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 22 Dec 2015 13:23:35 -0800
Subject: [PATCH] f2fs: call f2fs_balance_fs only when node was changed

If user tries to update or read data, we don't need to call f2fs_balance_fs
which triggers f2fs_gc, which increases unnecessary long latency.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c   | 26 ++++++++++++++++++++++----
 fs/f2fs/file.c   | 26 +++++++++-----------------
 fs/f2fs/inline.c |  4 ++++
 3 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 82ecaa30..958d826 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -509,7 +509,6 @@ static void __allocate_data_blocks(struct inode *inode, loff_t offset,
 	u64 end_offset;
 
 	while (len) {
-		f2fs_balance_fs(sbi);
 		f2fs_lock_op(sbi);
 
 		/* When reading holes, we need its node page */
@@ -542,6 +541,9 @@ static void __allocate_data_blocks(struct inode *inode, loff_t offset,
 
 		f2fs_put_dnode(&dn);
 		f2fs_unlock_op(sbi);
+
+		if (dn.node_changed)
+			f2fs_balance_fs(sbi);
 	}
 	return;
 
@@ -551,6 +553,8 @@ sync_out:
 	f2fs_put_dnode(&dn);
 out:
 	f2fs_unlock_op(sbi);
+	if (dn.node_changed)
+		f2fs_balance_fs(sbi);
 	return;
 }
 
@@ -649,6 +653,8 @@ get_next:
 
 		if (create) {
 			f2fs_unlock_op(sbi);
+			if (dn.node_changed)
+				f2fs_balance_fs(sbi);
 			f2fs_lock_op(sbi);
 		}
 
@@ -706,8 +712,11 @@ sync_out:
 put_out:
 	f2fs_put_dnode(&dn);
 unlock_out:
-	if (create)
+	if (create) {
 		f2fs_unlock_op(sbi);
+		if (dn.node_changed)
+			f2fs_balance_fs(sbi);
+	}
 out:
 	trace_f2fs_map_blocks(inode, map, err);
 	return err;
@@ -1415,8 +1424,6 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 	trace_f2fs_write_begin(inode, pos, len, flags);
 
-	f2fs_balance_fs(sbi);
-
 	/*
 	 * We should check this at this moment to avoid deadlock on inode page
 	 * and #0 page. The locking rule for inline_data conversion should be:
@@ -1466,6 +1473,17 @@ put_next:
 	f2fs_put_dnode(&dn);
 	f2fs_unlock_op(sbi);
 
+	if (dn.node_changed && has_not_enough_free_secs(sbi, 0)) {
+		unlock_page(page);
+		f2fs_balance_fs(sbi);
+		lock_page(page);
+		if (page->mapping != mapping) {
+			/* The page got truncated from under us */
+			f2fs_put_page(page, 1);
+			goto repeat;
+		}
+	}
+
 	f2fs_wait_on_page_writeback(page, DATA);
 
 	/* wait for GCed encrypted page writeback */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f2effe1..888ce47 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -40,8 +40,6 @@ static int f2fs_vm_page_mkwrite(struct vm_area_struct *vma,
 	struct dnode_of_data dn;
 	int err;
 
-	f2fs_balance_fs(sbi);
-
 	sb_start_pagefault(inode->i_sb);
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
@@ -57,6 +55,9 @@ static int f2fs_vm_page_mkwrite(struct vm_area_struct *vma,
 	f2fs_put_dnode(&dn);
 	f2fs_unlock_op(sbi);
 
+	if (dn.node_changed)
+		f2fs_balance_fs(sbi);
+
 	file_update_time(vma->vm_file);
 	lock_page(page);
 	if (unlikely(page->mapping != inode->i_mapping ||
@@ -233,9 +234,6 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out;
 	}
 go_write:
-	/* guarantee free sections for fsync */
-	f2fs_balance_fs(sbi);
-
 	/*
 	 * Both of fdatasync() and fsync() are able to be recovered from
 	 * sudden-power-off.
@@ -267,6 +265,8 @@ sync_nodes:
 	if (need_inode_block_update(sbi, ino)) {
 		mark_inode_dirty_sync(inode);
 		f2fs_write_inode(inode, NULL);
+
+		f2fs_balance_fs(sbi);
 		goto sync_nodes;
 	}
 
@@ -945,8 +945,6 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (offset & (F2FS_BLKSIZE - 1) || len & (F2FS_BLKSIZE - 1))
 		return -EINVAL;
 
-	f2fs_balance_fs(F2FS_I_SB(inode));
-
 	ret = f2fs_convert_inline_inode(inode);
 	if (ret)
 		return ret;
@@ -993,8 +991,6 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	if (ret)
 		return ret;
 
-	f2fs_balance_fs(sbi);
-
 	ret = f2fs_convert_inline_inode(inode);
 	if (ret)
 		return ret;
@@ -1104,12 +1100,12 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	if (offset & (F2FS_BLKSIZE - 1) || len & (F2FS_BLKSIZE - 1))
 		return -EINVAL;
 
-	f2fs_balance_fs(sbi);
-
 	ret = f2fs_convert_inline_inode(inode);
 	if (ret)
 		return ret;
 
+	f2fs_balance_fs(sbi);
+
 	ret = truncate_blocks(inode, i_size_read(inode), true);
 	if (ret)
 		return ret;
@@ -1152,8 +1148,6 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	loff_t off_start, off_end;
 	int ret = 0;
 
-	f2fs_balance_fs(sbi);
-
 	ret = inode_newsize_ok(inode, (len + offset));
 	if (ret)
 		return ret;
@@ -1162,6 +1156,8 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	if (ret)
 		return ret;
 
+	f2fs_balance_fs(sbi);
+
 	pg_start = ((unsigned long long) offset) >> PAGE_CACHE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_CACHE_SHIFT;
 
@@ -1349,8 +1345,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
-	f2fs_balance_fs(F2FS_I_SB(inode));
-
 	if (f2fs_is_atomic_file(inode))
 		return 0;
 
@@ -1437,8 +1431,6 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	if (ret)
 		return ret;
 
-	f2fs_balance_fs(F2FS_I_SB(inode));
-
 	clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
 	clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
 	commit_inmem_pages(inode, true);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8090854..c24e5d9 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -202,6 +202,10 @@ out:
 	f2fs_unlock_op(sbi);
 
 	f2fs_put_page(page, 1);
+
+	if (dn.node_changed)
+		f2fs_balance_fs(sbi);
+
 	return err;
 }
 
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
