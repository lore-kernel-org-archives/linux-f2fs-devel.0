From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 3/3] f2fs: flush dirty directory pages when
 scattered pages are gathered
Date: Tue, 15 Apr 2014 19:57:03 +0900
Message-ID: <1397559423-27411-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1397559423-27411-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Wa15D-0005YS-0U
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Apr 2014 10:59:19 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Wa15B-0001mu-5Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Apr 2014 10:59:18 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N4200L6DJUJ83A0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Apr 2014 19:59:07 +0900 (KST)
In-reply-to: <1397559423-27411-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If a lot of directory inodes have the small number of dentry pages in each
page cache, there is no chance to flush them periodically.
This patch proposes the average number of dirty dentry pages for the threshold.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c |  2 ++
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/segment.h    | 16 +++++++++-------
 fs/f2fs/super.c      |  1 +
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5133aec..d57d93f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -562,6 +562,7 @@ static int __add_dirty_inode(struct inode *inode, struct dir_inode_entry *new)
 	set_inode_flag(F2FS_I(inode), FI_DIRTY_DIR);
 	F2FS_I(inode)->dirty_dir = new;
 	list_add_tail(&new->list, &sbi->dir_inode_list);
+	atomic_inc(&sbi->dirty_dir_inodes);
 	stat_inc_dirty_dir(sbi);
 	return 0;
 }
@@ -626,6 +627,7 @@ void remove_dirty_dir_inode(struct inode *inode)
 	list_del(&entry->list);
 	F2FS_I(inode)->dirty_dir = NULL;
 	clear_inode_flag(F2FS_I(inode), FI_DIRTY_DIR);
+	atomic_dec(&sbi->dirty_dir_inodes);
 	stat_dec_dirty_dir(sbi);
 	spin_unlock(&sbi->dir_inode_lock);
 	kmem_cache_free(inode_entry_slab, entry);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d3180f8..e708d02 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -450,6 +450,7 @@ struct f2fs_sb_info {
 
 	/* for directory inode management */
 	struct list_head dir_inode_list;	/* dir inode list */
+	atomic_t dirty_dir_inodes;		/* # of dirty inodes */
 	spinlock_t dir_inode_lock;		/* for dir inode list lock */
 
 	/* basic file system units */
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 7091204..8eb23a0 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -668,20 +668,22 @@ static inline unsigned int max_hw_blocks(struct f2fs_sb_info *sbi)
 /*
  * It is very important to gather dirty pages and write at once, so that we can
  * submit a big bio without interfering other data writes.
- * By default, 512 pages for directory data,
+ * By default, avg. dirty pages for directory data,
  * 512 pages (2MB) * 3 for three types of nodes, and
  * max_bio_blocks for meta are set.
  */
 static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 {
-	if (type == DATA)
-		return sbi->blocks_per_seg;
-	else if (type == NODE)
+	if (type == DATA) {
+		unsigned int dirty = atomic_read(&sbi->dirty_dir_inodes);
+		if (dirty > sbi->blocks_per_seg * sbi->blocks_per_seg)
+			return div_u64(get_pages(sbi, F2FS_DIRTY_DENTS), dirty);
+	} else if (type == NODE) {
 		return 3 * sbi->blocks_per_seg;
-	else if (type == META)
+	} else if (type == META) {
 		return MAX_BIO_BLOCKS(max_hw_blocks(sbi));
-	else
-		return 0;
+	}
+	return sbi->blocks_per_seg;
 }
 
 /*
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5e20d2a..eabf8df 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -973,6 +973,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	sbi->alloc_valid_block_count = 0;
 	INIT_LIST_HEAD(&sbi->dir_inode_list);
+	atomic_set(&sbi->dirty_dir_inodes, 0);
 	spin_lock_init(&sbi->dir_inode_lock);
 
 	init_orphan_info(sbi);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
