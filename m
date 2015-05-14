From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] Space leak in f2fs
Date: Thu, 14 May 2015 14:14:11 -0700
Message-ID: <20150514211250.GA76424@jaegeuk-mac02.mot.com>
References: <5552FA7D.7000704@huawei.com>
 <20150513174417.GA56247@jaegeuk-mac02.mot.com>
 <20150514002417.GC68412@jaegeuk-mac02>
 <5553FD09.9030508@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5553FD09.9030508@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: hujianyang <hujianyang@huawei.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Hu,

I've been rethinking about whole this issue differently.
And, now I'm starting to test with the below patch instead of previous one.

Thanks,

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 19 +++++++++++++++++++
 fs/f2fs/data.c       |  4 ++++
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/super.c      | 15 ---------------
 4 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7b7a9d8..74875fb 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -378,6 +378,20 @@ static void __remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 	spin_unlock(&im->ino_lock);
 }
 
+static bool __exist_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
+{
+	struct inode_management *im = &sbi->im[type];
+	struct ino_entry *e;
+	bool exist = false;
+
+	spin_lock(&im->ino_lock);
+	e = radix_tree_lookup(&im->ino_root, ino);
+	if (e)
+		exist = true;
+	spin_unlock(&im->ino_lock);
+	return exist;
+}
+
 void add_dirty_inode(struct f2fs_sb_info *sbi, nid_t ino, int type)
 {
 	/* add new dirty ino entry into list */
@@ -458,6 +472,11 @@ void remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 	__remove_ino_entry(sbi, ino, ORPHAN_INO);
 }
 
+bool is_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
+{
+	return __exist_ino_entry(sbi, ino, ORPHAN_INO);
+}
+
 static void recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	struct inode *inode = f2fs_iget(sbi->sb, ino);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b0cc2aa..1988f5f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1749,6 +1749,10 @@ write:
 		goto out;
 	}
 
+	/* if orphan inode, we don't need to write its data */
+	if (is_orphan_inode(sbi, inode->i_ino))
+		goto out;
+
 	if (!wbc->for_reclaim)
 		need_balance_fs = true;
 	else if (has_not_enough_free_secs(sbi, 0))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8f1f21a..697346a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1726,6 +1726,7 @@ int acquire_orphan_inode(struct f2fs_sb_info *);
 void release_orphan_inode(struct f2fs_sb_info *);
 void add_orphan_inode(struct f2fs_sb_info *, nid_t);
 void remove_orphan_inode(struct f2fs_sb_info *, nid_t);
+bool is_orphan_inode(struct f2fs_sb_info *, nid_t);
 void recover_orphan_inodes(struct f2fs_sb_info *);
 int get_valid_checkpoint(struct f2fs_sb_info *);
 void update_dirty_page(struct inode *, struct page *);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 19438f2..1d0973a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -422,20 +422,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	return &fi->vfs_inode;
 }
 
-static int f2fs_drop_inode(struct inode *inode)
-{
-	/*
-	 * This is to avoid a deadlock condition like below.
-	 * writeback_single_inode(inode)
-	 *  - f2fs_write_data_page
-	 *    - f2fs_gc -> iput -> evict
-	 *       - inode_wait_for_writeback(inode)
-	 */
-	if (!inode_unhashed(inode) && inode->i_state & I_SYNC)
-		return 0;
-	return generic_drop_inode(inode);
-}
-
 /*
  * f2fs_dirty_inode() is called from __mark_inode_dirty()
  *
@@ -759,7 +745,6 @@ restore_opts:
 
 static struct super_operations f2fs_sops = {
 	.alloc_inode	= f2fs_alloc_inode,
-	.drop_inode	= f2fs_drop_inode,
 	.destroy_inode	= f2fs_destroy_inode,
 	.write_inode	= f2fs_write_inode,
 	.dirty_inode	= f2fs_dirty_inode,
-- 
2.1.1


