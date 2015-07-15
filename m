From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: use atomic_t to record hit ratio info
	of extent cache
Date: Wed, 15 Jul 2015 17:29:49 +0800
Message-ID: <012c01d0bee0$e37a9e00$aa6fda00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZFJ1V-0004hk-45
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Jul 2015 09:30:41 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZFJ1T-0002AW-KC
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Jul 2015 09:30:41 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NRI01RY0VQS3120@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Jul 2015 18:30:28 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Variables for recording extent cache ratio info were updated without
protection, this patch tries to alter them to atomic_t type for more
accurate stat.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/debug.c        | 7 +++++--
 fs/f2fs/extent_cache.c | 6 +++---
 fs/f2fs/f2fs.h         | 7 ++++---
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 2aeaf4e..bc215fd 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -33,8 +33,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	int i;
 
 	/* validation check of the segment numbers */
-	si->hit_ext = sbi->read_hit_ext;
-	si->total_ext = sbi->total_hit_ext;
+	si->hit_ext = atomic_read(&sbi->read_hit_ext);
+	si->total_ext = atomic_read(&sbi->total_hit_ext);
 	si->ext_tree = sbi->total_ext_tree;
 	si->ext_node = atomic_read(&sbi->total_ext_node);
 	si->ndirty_node = get_pages(sbi, F2FS_DIRTY_NODES);
@@ -369,6 +369,9 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	si->sbi = sbi;
 	sbi->stat_info = si;
 
+	atomic_set(&sbi->total_hit_ext, 0);
+	atomic_set(&sbi->read_hit_ext, 0);
+
 	atomic_set(&sbi->inline_xattr, 0);
 	atomic_set(&sbi->inline_inode, 0);
 	atomic_set(&sbi->inline_dir, 0);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 5f78fc1..362df8c 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -279,7 +279,7 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 			et->largest.fofs + et->largest.len > pgofs) {
 		*ei = et->largest;
 		ret = true;
-		stat_inc_read_hit(sbi->sb);
+		stat_inc_read_hit(sbi);
 		goto out;
 	}
 
@@ -292,10 +292,10 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 		et->cached_en = en;
 		spin_unlock(&sbi->extent_lock);
 		ret = true;
-		stat_inc_read_hit(sbi->sb);
+		stat_inc_read_hit(sbi);
 	}
 out:
-	stat_inc_total_hit(sbi->sb);
+	stat_inc_total_hit(sbi);
 	read_unlock(&et->lock);
 
 	trace_f2fs_lookup_extent_tree_end(inode, pgofs, ei);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b18b852..38ba525 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -781,7 +781,8 @@ struct f2fs_sb_info {
 	unsigned int segment_count[2];		/* # of allocated segments */
 	unsigned int block_count[2];		/* # of allocated blocks */
 	atomic_t inplace_count;		/* # of inplace update */
-	int total_hit_ext, read_hit_ext;	/* extent cache hit ratio */
+	atomic_t total_hit_ext;			/* # of lookup extent cache */
+	atomic_t read_hit_ext;			/* # of hit extent cache */
 	atomic_t inline_xattr;			/* # of inline_xattr inodes */
 	atomic_t inline_inode;			/* # of inline_data inodes */
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
@@ -1837,8 +1838,8 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_inc_bggc_count(sbi)	((sbi)->bg_gc++)
 #define stat_inc_dirty_dir(sbi)		((sbi)->n_dirty_dirs++)
 #define stat_dec_dirty_dir(sbi)		((sbi)->n_dirty_dirs--)
-#define stat_inc_total_hit(sb)		((F2FS_SB(sb))->total_hit_ext++)
-#define stat_inc_read_hit(sb)		((F2FS_SB(sb))->read_hit_ext++)
+#define stat_inc_total_hit(sbi)		(atomic_inc(&(sbi)->total_hit_ext))
+#define stat_inc_read_hit(sbi)		(atomic_inc(&(sbi)->read_hit_ext))
 #define stat_inc_inline_xattr(inode)					\
 	do {								\
 		if (f2fs_has_inline_xattr(inode))			\
-- 
2.4.2



------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
