From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: avoid unnecessary f2fs_balance_fs calls
Date: Thu,  7 Jan 2016 17:36:34 -0800
Message-ID: <1452216996-9689-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Only when node page is newly dirtied, it needs to check whether we need to do
f2fs_gc.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c  |  4 ++--
 fs/f2fs/f2fs.h  |  4 ++--
 fs/f2fs/inode.c | 19 ++++++++++---------
 fs/f2fs/node.c  | 26 ++++++++++++++------------
 fs/f2fs/node.h  |  4 ++--
 fs/f2fs/super.c |  2 --
 6 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 77c3bbb..3cf86fd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -225,8 +225,8 @@ void set_data_blkaddr(struct dnode_of_data *dn)
 	/* Get physical address of data block */
 	addr_array = blkaddr_in_node(rn);
 	addr_array[ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
-	set_page_dirty(node_page);
-	dn->node_changed = true;
+	if (set_page_dirty(node_page))
+		dn->node_changed = true;
 }
 
 int reserve_new_block(struct dnode_of_data *dn)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 882baba..461b329 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1674,8 +1674,8 @@ long f2fs_compat_ioctl(struct file *, unsigned int, unsigned long);
 void f2fs_set_inode_flags(struct inode *);
 struct inode *f2fs_iget(struct super_block *, unsigned long);
 int try_to_free_nats(struct f2fs_sb_info *, int);
-void update_inode(struct inode *, struct page *);
-void update_inode_page(struct inode *);
+int update_inode(struct inode *, struct page *);
+int update_inode_page(struct inode *);
 int f2fs_write_inode(struct inode *, struct writeback_control *);
 void f2fs_evict_inode(struct inode *);
 void handle_failed_inode(struct inode *);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index e955008..cabc1ff 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -222,7 +222,7 @@ bad_inode:
 	return ERR_PTR(ret);
 }
 
-void update_inode(struct inode *inode, struct page *node_page)
+int update_inode(struct inode *inode, struct page *node_page)
 {
 	struct f2fs_inode *ri;
 
@@ -260,15 +260,16 @@ void update_inode(struct inode *inode, struct page *node_page)
 
 	__set_inode_rdev(inode, ri);
 	set_cold_node(inode, node_page);
-	set_page_dirty(node_page);
-
 	clear_inode_flag(F2FS_I(inode), FI_DIRTY_INODE);
+
+	return set_page_dirty(node_page);
 }
 
-void update_inode_page(struct inode *inode)
+int update_inode_page(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *node_page;
+	int ret = 0;
 retry:
 	node_page = get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(node_page)) {
@@ -279,10 +280,11 @@ retry:
 		} else if (err != -ENOENT) {
 			f2fs_stop_checkpoint(sbi);
 		}
-		return;
+		return 0;
 	}
-	update_inode(inode, node_page);
+	ret = update_inode(inode, node_page);
 	f2fs_put_page(node_page, 1);
+	return ret;
 }
 
 int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
@@ -300,9 +302,8 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	 * We need to balance fs here to prevent from producing dirty node pages
 	 * during the urgent cleaning time when runing out of free sections.
 	 */
-	update_inode_page(inode);
-
-	f2fs_balance_fs(sbi);
+	if (update_inode_page(inode))
+		f2fs_balance_fs(sbi);
 	return 0;
 }
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 5a2d800..c091b75 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -543,7 +543,6 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
 			set_nid(parent, offset[i - 1], nids[i], i == 1);
 			alloc_nid_done(sbi, nids[i]);
-			dn->node_changed = true;
 			done = true;
 		} else if (mode == LOOKUP_NODE_RA && i == level && level > 1) {
 			npage[i] = get_node_page_ra(parent, offset[i - 1]);
@@ -679,8 +678,8 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 			ret = truncate_dnode(&rdn);
 			if (ret < 0)
 				goto out_err;
-			set_nid(page, i, 0, false);
-			dn->node_changed = true;
+			if (set_nid(page, i, 0, false))
+				dn->node_changed = true;
 		}
 	} else {
 		child_nofs = nofs + ofs * (NIDS_PER_BLOCK + 1) + 1;
@@ -693,8 +692,8 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 			rdn.nid = child_nid;
 			ret = truncate_nodes(&rdn, child_nofs, 0, depth - 1);
 			if (ret == (NIDS_PER_BLOCK + 1)) {
-				set_nid(page, i, 0, false);
-				dn->node_changed = true;
+				if (set_nid(page, i, 0, false))
+					dn->node_changed = true;
 				child_nofs += ret;
 			} else if (ret < 0 && ret != -ENOENT) {
 				goto out_err;
@@ -755,8 +754,8 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 		err = truncate_dnode(dn);
 		if (err < 0)
 			goto fail;
-		set_nid(pages[idx], i, 0, false);
-		dn->node_changed = true;
+		if (set_nid(pages[idx], i, 0, false))
+			dn->node_changed = true;
 	}
 
 	if (offset[idx + 1] == 0) {
@@ -981,7 +980,8 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
 	set_cold_node(dn->inode, page);
 	SetPageUptodate(page);
-	set_page_dirty(page);
+	if (set_page_dirty(page))
+		dn->node_changed = true;
 
 	if (f2fs_has_xattr_block(ofs))
 		F2FS_I(dn->inode)->i_xattr_nid = dn->nid;
@@ -1138,18 +1138,20 @@ struct page *get_node_page_ra(struct page *parent, int start)
 
 void sync_inode_page(struct dnode_of_data *dn)
 {
+	int ret = 0;
+
 	if (IS_INODE(dn->node_page) || dn->inode_page == dn->node_page) {
-		update_inode(dn->inode, dn->node_page);
+		ret = update_inode(dn->inode, dn->node_page);
 	} else if (dn->inode_page) {
 		if (!dn->inode_page_locked)
 			lock_page(dn->inode_page);
-		update_inode(dn->inode, dn->inode_page);
+		ret = update_inode(dn->inode, dn->inode_page);
 		if (!dn->inode_page_locked)
 			unlock_page(dn->inode_page);
 	} else {
-		update_inode_page(dn->inode);
+		ret = update_inode_page(dn->inode);
 	}
-	dn->node_changed = true;
+	dn->node_changed = ret ? true: false;
 }
 
 int sync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 2de759a..d4d1f63 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -317,7 +317,7 @@ static inline bool IS_DNODE(struct page *node_page)
 	return true;
 }
 
-static inline void set_nid(struct page *p, int off, nid_t nid, bool i)
+static inline int set_nid(struct page *p, int off, nid_t nid, bool i)
 {
 	struct f2fs_node *rn = F2FS_NODE(p);
 
@@ -327,7 +327,7 @@ static inline void set_nid(struct page *p, int off, nid_t nid, bool i)
 		rn->i.i_nid[off - NODE_DIR1_BLOCK] = cpu_to_le32(nid);
 	else
 		rn->in.nid[off] = cpu_to_le32(nid);
-	set_page_dirty(p);
+	return set_page_dirty(p);
 }
 
 static inline nid_t get_nid(struct page *p, int off, bool i)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0bbd756..f5cc790 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -591,8 +591,6 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 		mutex_lock(&sbi->gc_mutex);
 		err = write_checkpoint(sbi, &cpc);
 		mutex_unlock(&sbi->gc_mutex);
-	} else {
-		f2fs_balance_fs(sbi);
 	}
 	f2fs_trace_ios(NULL, 1);
 
-- 
2.6.3
