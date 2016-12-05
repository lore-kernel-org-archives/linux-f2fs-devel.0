From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] Revert "f2fs: use percpu_counter for # of
	dirty pages in inode"
Date: Mon,  5 Dec 2016 11:43:44 -0800
Message-ID: <20161205194345.55114-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cDzB6-00061T-7H
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Dec 2016 19:43:56 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cDzB4-0002KX-Ay
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Dec 2016 19:43:56 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org

This reverts commit 1beba1b3a953107c3ff5448ab4e4297db4619c76.

The perpcu_counter doesn't provide atomicity in single core and consume more
DRAM. That incurs fs_mark test failure due to ENOMEM.

Cc: stable@vger.kernel.org
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 10 +++++-----
 fs/f2fs/file.c  |  2 +-
 fs/f2fs/super.c |  7 +------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8a659493796b..35dbab157ec3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -431,7 +431,7 @@ struct f2fs_inode_info {
 	/* Use below internally in f2fs*/
 	unsigned long flags;		/* use to pass per-file flags */
 	struct rw_semaphore i_sem;	/* protect fi info */
-	struct percpu_counter dirty_pages;	/* # of dirty pages */
+	atomic_t dirty_pages;		/* # of dirty pages */
 	f2fs_hash_t chash;		/* hash value of given file name */
 	unsigned int clevel;		/* maximum level of given file name */
 	nid_t i_xattr_nid;		/* node id that contains xattrs */
@@ -1269,7 +1269,7 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 
 static inline void inode_inc_dirty_pages(struct inode *inode)
 {
-	percpu_counter_inc(&F2FS_I(inode)->dirty_pages);
+	atomic_inc(&F2FS_I(inode)->dirty_pages);
 	inc_page_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA);
 }
@@ -1285,7 +1285,7 @@ static inline void inode_dec_dirty_pages(struct inode *inode)
 			!S_ISLNK(inode->i_mode))
 		return;
 
-	percpu_counter_dec(&F2FS_I(inode)->dirty_pages);
+	atomic_dec(&F2FS_I(inode)->dirty_pages);
 	dec_page_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA);
 }
@@ -1295,9 +1295,9 @@ static inline s64 get_pages(struct f2fs_sb_info *sbi, int count_type)
 	return atomic_read(&sbi->nr_pages[count_type]);
 }
 
-static inline s64 get_dirty_pages(struct inode *inode)
+static inline int get_dirty_pages(struct inode *inode)
 {
-	return percpu_counter_sum_positive(&F2FS_I(inode)->dirty_pages);
+	return atomic_read(&F2FS_I(inode)->dirty_pages);
 }
 
 static inline int get_blocktype_secs(struct f2fs_sb_info *sbi, int block_type)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9053a9c5a47e..4c87261c1cd2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1533,7 +1533,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		goto out;
 
 	f2fs_msg(F2FS_I_SB(inode)->sb, KERN_WARNING,
-		"Unexpected flush for atomic writes: ino=%lu, npages=%lld",
+		"Unexpected flush for atomic writes: ino=%lu, npages=%u",
 					inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2852a0b34d64..7591d2d7b612 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -571,13 +571,9 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 	init_once((void *) fi);
 
-	if (percpu_counter_init(&fi->dirty_pages, 0, GFP_NOFS)) {
-		kmem_cache_free(f2fs_inode_cachep, fi);
-		return NULL;
-	}
-
 	/* Initialize f2fs-specific inode info */
 	fi->vfs_inode.i_version = 1;
+	atomic_set(&fi->dirty_pages, 0);
 	fi->i_current_depth = 1;
 	fi->i_advise = 0;
 	init_rwsem(&fi->i_sem);
@@ -703,7 +699,6 @@ static void f2fs_i_callback(struct rcu_head *head)
 
 static void f2fs_destroy_inode(struct inode *inode)
 {
-	percpu_counter_destroy(&F2FS_I(inode)->dirty_pages);
 	call_rcu(&inode->i_rcu, f2fs_i_callback);
 }
 
-- 
2.11.0


------------------------------------------------------------------------------
