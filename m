From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: turn off atomic writes when deteting
 abnormal behaviors
Date: Sun, 15 Jul 2018 10:10:59 +0900
Message-ID: <20180715011101.11382-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1feVZC-0002sM-Cb
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 15 Jul 2018 01:11:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1feVZA-003cyX-Ut
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 15 Jul 2018 01:11:14 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

In order to prevent abusing atomic writes by abnormal users, we've added a
threshold, 20% over memory footprint, which disallows further atomic writes.
Previously, however, SQLite doesn't know the files became normal, so that
it could write stale data and commit on revoked normal database file.

Once f2fs detects such the abnormal behavior, this patch simply disables
all the atomic operations such as:
- write_begin() gives EINVAL to avoid stale data writes, and SQLite will call
  F2FS_IOC_ABORT_VOLATILE_WRITE to notify aborting the transaction,
- F2FS_IOC_START_ATOMIC_WRITE gives EINVAL for SQLite to fall back normal
  journal_mode,
- F2FS_IOC_COMMIT_ATOMIC_WRITE gives EINVAL, if the file was revoked, so that
  Framework retries to submit the transaction given propagated SQLite error.

Note that, this patch also turns off atomic operations, if foreground GC tries
to move atomic files too frequently.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    |  7 ++++---
 fs/f2fs/f2fs.h    |  4 ++--
 fs/f2fs/file.c    |  6 +++++-
 fs/f2fs/gc.c      |  4 +---
 fs/f2fs/segment.c | 21 +++++++++++----------
 5 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5e53d210e222..c9e75aa61c24 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2247,8 +2247,9 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	trace_f2fs_write_begin(inode, pos, len, flags);
 
 	if (f2fs_is_atomic_file(inode) &&
-			!f2fs_available_free_memory(sbi, INMEM_PAGES)) {
-		err = -ENOMEM;
+			(is_sbi_flag_set(sbi, SBI_DISABLE_ATOMIC_WRITE) ||
+			!f2fs_available_free_memory(sbi, INMEM_PAGES))) {
+		err = -EINVAL;
 		drop_atomic = true;
 		goto fail;
 	}
@@ -2331,7 +2332,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	f2fs_put_page(page, 1);
 	f2fs_write_failed(mapping, pos + len);
 	if (drop_atomic)
-		f2fs_drop_inmem_pages_all(sbi, false);
+		f2fs_disable_atomic_write(sbi);
 	return err;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4d8b1de83143..1d5c8d543eda 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -621,7 +621,6 @@ enum {
 
 enum {
 	GC_FAILURE_PIN,
-	GC_FAILURE_ATOMIC,
 	MAX_GC_FAILURE
 };
 
@@ -1066,6 +1065,7 @@ enum {
 	SBI_POR_DOING,				/* recovery is doing or not */
 	SBI_NEED_SB_WRITE,			/* need to recover superblock */
 	SBI_NEED_CP,				/* need to checkpoint */
+	SBI_DISABLE_ATOMIC_WRITE,		/* turn off atomic write */
 };
 
 enum {
@@ -2833,7 +2833,7 @@ void f2fs_destroy_node_manager_caches(void);
  */
 bool f2fs_need_SSR(struct f2fs_sb_info *sbi);
 void f2fs_register_inmem_page(struct inode *inode, struct page *page);
-void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure);
+void f2fs_disable_atomic_write(struct f2fs_sb_info *sbi);
 void f2fs_drop_inmem_pages(struct inode *inode);
 void f2fs_drop_inmem_page(struct inode *inode, struct page *page);
 int f2fs_commit_inmem_pages(struct inode *inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6880c6f78d58..b029a4ed3bb0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1682,6 +1682,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
+	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_DISABLE_ATOMIC_WRITE))
+		return -EINVAL;
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -1750,7 +1753,6 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 		if (!ret) {
 			clear_inode_flag(inode, FI_ATOMIC_FILE);
-			F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
 			stat_dec_atomic_write(inode);
 		}
 	} else {
@@ -1853,6 +1855,8 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 	}
 
+	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
+
 	inode_unlock(inode);
 
 	mnt_drop_write_file(filp);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 9093be6e7a7d..6d762f3cdfc7 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -629,7 +629,6 @@ static void move_data_block(struct inode *inode, block_t bidx,
 		goto out;
 
 	if (f2fs_is_atomic_file(inode)) {
-		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC]++;
 		F2FS_I_SB(inode)->skipped_atomic_files[gc_type]++;
 		goto out;
 	}
@@ -745,7 +744,6 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		goto out;
 
 	if (f2fs_is_atomic_file(inode)) {
-		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC]++;
 		F2FS_I_SB(inode)->skipped_atomic_files[gc_type]++;
 		goto out;
 	}
@@ -1100,7 +1098,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
 			if (skipped_round > MAX_SKIP_ATOMIC_COUNT &&
 				skipped_round * 2 >= round)
-				f2fs_drop_inmem_pages_all(sbi, true);
+				f2fs_disable_atomic_write(sbi);
 			segno = NULL_SEGNO;
 			goto gc_more;
 		}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9efce174c51a..05877a2f1894 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -274,11 +274,14 @@ static int __revoke_inmem_pages(struct inode *inode,
 	return err;
 }
 
-void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
+void f2fs_disable_atomic_write(struct f2fs_sb_info *sbi)
 {
 	struct list_head *head = &sbi->inode_list[ATOMIC_FILE];
 	struct inode *inode;
 	struct f2fs_inode_info *fi;
+
+	/* just turn it off */
+	set_sbi_flag(sbi, SBI_DISABLE_ATOMIC_WRITE);
 next:
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	if (list_empty(head)) {
@@ -290,17 +293,16 @@ void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
 
 	if (inode) {
-		if (gc_failure) {
-			if (fi->i_gc_failures[GC_FAILURE_ATOMIC])
-				goto drop;
-			goto skip;
+		inode_lock(inode);
+		/* need to check whether it was already revoked */
+		if (f2fs_is_atomic_file(inode)) {
+			f2fs_drop_inmem_pages(inode);
+			set_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
 		}
-drop:
-		set_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
-		f2fs_drop_inmem_pages(inode);
+		inode_unlock(inode);
 		iput(inode);
 	}
-skip:
+
 	congestion_wait(BLK_RW_ASYNC, HZ/50);
 	cond_resched();
 	goto next;
@@ -320,7 +322,6 @@ void f2fs_drop_inmem_pages(struct inode *inode)
 	mutex_unlock(&fi->inmem_lock);
 
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
-	fi->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
 	stat_dec_atomic_write(inode);
 }
 
-- 
2.17.0.441.gb46fe60e1d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
