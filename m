From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] f2fs: use percpu_counter for # of dirty
	pages in inode
Date: Mon, 16 May 2016 15:30:45 -0700
Message-ID: <1463437847-40412-3-git-send-email-jaegeuk@kernel.org>
References: <1463437847-40412-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b2R2S-0002BM-Qw
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 22:31:00 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b2R2Q-0000RY-SB
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 22:31:00 +0000
In-Reply-To: <1463437847-40412-1-git-send-email-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds percpu_counter for # of dirty pages in inode.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 10 +++++-----
 fs/f2fs/file.c  |  2 +-
 fs/f2fs/super.c |  8 +++++++-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2851078..ae978a1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -456,7 +456,7 @@ struct f2fs_inode_info {
 	/* Use below internally in f2fs*/
 	unsigned long flags;		/* use to pass per-file flags */
 	struct rw_semaphore i_sem;	/* protect fi info */
-	atomic_t dirty_pages;		/* # of dirty pages */
+	struct percpu_counter dirty_pages;	/* # of dirty pages */
 	f2fs_hash_t chash;		/* hash value of given file name */
 	unsigned int clevel;		/* maximum level of given file name */
 	nid_t i_xattr_nid;		/* node id that contains xattrs */
@@ -1186,7 +1186,7 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 
 static inline void inode_inc_dirty_pages(struct inode *inode)
 {
-	atomic_inc(&F2FS_I(inode)->dirty_pages);
+	percpu_counter_inc(&F2FS_I(inode)->dirty_pages);
 	inc_page_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA);
 }
@@ -1202,7 +1202,7 @@ static inline void inode_dec_dirty_pages(struct inode *inode)
 			!S_ISLNK(inode->i_mode))
 		return;
 
-	atomic_dec(&F2FS_I(inode)->dirty_pages);
+	percpu_counter_dec(&F2FS_I(inode)->dirty_pages);
 	dec_page_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA);
 }
@@ -1212,9 +1212,9 @@ static inline s64 get_pages(struct f2fs_sb_info *sbi, int count_type)
 	return percpu_counter_sum_positive(&sbi->nr_pages[count_type]);
 }
 
-static inline int get_dirty_pages(struct inode *inode)
+static inline s64 get_dirty_pages(struct inode *inode)
 {
-	return atomic_read(&F2FS_I(inode)->dirty_pages);
+	return percpu_counter_sum_positive(&F2FS_I(inode)->dirty_pages);
 }
 
 static inline int get_blocktype_secs(struct f2fs_sb_info *sbi, int block_type)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b5e3999..69451b83 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1457,7 +1457,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		goto out;
 
 	f2fs_msg(F2FS_I_SB(inode)->sb, KERN_WARNING,
-		"Unexpected flush for atomic writes: ino=%lu, npages=%u",
+		"Unexpected flush for atomic writes: ino=%lu, npages=%lld",
 					inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b3030ed..56f177b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -526,9 +526,13 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 	init_once((void *) fi);
 
+	if (percpu_counter_init(&fi->dirty_pages, 0, GFP_NOFS)) {
+		kmem_cache_free(f2fs_inode_cachep, fi);
+		return NULL;
+	}
+
 	/* Initialize f2fs-specific inode info */
 	fi->vfs_inode.i_version = 1;
-	atomic_set(&fi->dirty_pages, 0);
 	fi->i_current_depth = 1;
 	fi->i_advise = 0;
 	init_rwsem(&fi->i_sem);
@@ -598,6 +602,8 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
 static void f2fs_i_callback(struct rcu_head *head)
 {
 	struct inode *inode = container_of(head, struct inode, i_rcu);
+
+	percpu_counter_destroy(&F2FS_I(inode)->dirty_pages);
 	kmem_cache_free(f2fs_inode_cachep, F2FS_I(inode));
 }
 
-- 
2.6.3


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
