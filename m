From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: use wait_for_stable_page to avoid contention
Date: Sat, 23 Jan 2016 12:16:45 -0800
Message-ID: <1453580206-61937-3-git-send-email-jaegeuk@kernel.org>
References: <1453580206-61937-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453580206-61937-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In write_begin, if storage supports stable_page, we don't need to wait for
writeback to update its contents.
This patch introduces to use wait_for_stable_page instead of
wait_on_page_writeback.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  4 ++--
 fs/f2fs/data.c       |  7 ++++---
 fs/f2fs/dir.c        |  8 ++++----
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/file.c       |  6 +++---
 fs/f2fs/gc.c         | 10 +++++-----
 fs/f2fs/inline.c     | 16 ++++++++--------
 fs/f2fs/inode.c      |  4 ++--
 fs/f2fs/node.c       | 10 +++++-----
 fs/f2fs/node.h       |  2 +-
 fs/f2fs/recovery.c   |  2 +-
 fs/f2fs/segment.c    | 12 ++++++++----
 fs/f2fs/xattr.c      |  6 +++---
 13 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3842af9..4b6f9c0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -39,7 +39,7 @@ repeat:
 		cond_resched();
 		goto repeat;
 	}
-	f2fs_wait_on_page_writeback(page, META);
+	f2fs_wait_on_page_writeback(page, META, true);
 	SetPageUptodate(page);
 	return page;
 }
@@ -232,7 +232,7 @@ static int f2fs_write_meta_page(struct page *page,
 	if (unlikely(f2fs_cp_error(sbi)))
 		goto redirty_out;
 
-	f2fs_wait_on_page_writeback(page, META);
+	f2fs_wait_on_page_writeback(page, META, true);
 	write_meta_page(sbi, page);
 	dec_page_count(sbi, F2FS_DIRTY_META);
 	unlock_page(page);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9a8edeb..7d9f1d9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -256,7 +256,7 @@ void set_data_blkaddr(struct dnode_of_data *dn)
 	struct page *node_page = dn->node_page;
 	unsigned int ofs_in_node = dn->ofs_in_node;
 
-	f2fs_wait_on_page_writeback(node_page, NODE);
+	f2fs_wait_on_page_writeback(node_page, NODE, true);
 
 	rn = F2FS_NODE(node_page);
 
@@ -1320,7 +1320,8 @@ continue_unlock:
 
 			if (PageWriteback(page)) {
 				if (wbc->sync_mode != WB_SYNC_NONE)
-					f2fs_wait_on_page_writeback(page, DATA);
+					f2fs_wait_on_page_writeback(page,
+								DATA, false);
 				else
 					goto continue_unlock;
 			}
@@ -1548,7 +1549,7 @@ repeat:
 		}
 	}
 
-	f2fs_wait_on_page_writeback(page, DATA);
+	f2fs_wait_on_page_writeback(page, DATA, false);
 
 	/* wait for GCed encrypted page writeback */
 	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index faa7495..8950fc3 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -296,7 +296,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 {
 	enum page_type type = f2fs_has_inline_dentry(dir) ? NODE : DATA;
 	lock_page(page);
-	f2fs_wait_on_page_writeback(page, type);
+	f2fs_wait_on_page_writeback(page, type, true);
 	de->ino = cpu_to_le32(inode->i_ino);
 	set_de_type(de, inode->i_mode);
 	f2fs_dentry_kunmap(dir, page);
@@ -311,7 +311,7 @@ static void init_dent_inode(const struct qstr *name, struct page *ipage)
 {
 	struct f2fs_inode *ri;
 
-	f2fs_wait_on_page_writeback(ipage, NODE);
+	f2fs_wait_on_page_writeback(ipage, NODE, true);
 
 	/* copy name info. to this inode page */
 	ri = F2FS_INODE(ipage);
@@ -598,7 +598,7 @@ start:
 	++level;
 	goto start;
 add_dentry:
-	f2fs_wait_on_page_writeback(dentry_page, DATA);
+	f2fs_wait_on_page_writeback(dentry_page, DATA, true);
 
 	if (inode) {
 		down_write(&F2FS_I(inode)->i_sem);
@@ -709,7 +709,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		return f2fs_delete_inline_entry(dentry, page, dir, inode);
 
 	lock_page(page);
-	f2fs_wait_on_page_writeback(page, DATA);
+	f2fs_wait_on_page_writeback(page, DATA, true);
 
 	dentry_blk = page_address(page);
 	bit_pos = dentry - dentry_blk->dentry;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6c08cb1..c4e723b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1837,7 +1837,7 @@ void f2fs_replace_block(struct f2fs_sb_info *, struct dnode_of_data *,
 				block_t, block_t, unsigned char, bool);
 void allocate_data_block(struct f2fs_sb_info *, struct page *,
 		block_t, block_t *, struct f2fs_summary *, int);
-void f2fs_wait_on_page_writeback(struct page *, enum page_type);
+void f2fs_wait_on_page_writeback(struct page *, enum page_type, bool);
 void f2fs_wait_on_encrypted_page_writeback(struct f2fs_sb_info *, block_t);
 void write_data_summaries(struct f2fs_sb_info *, block_t);
 void write_node_summaries(struct f2fs_sb_info *, block_t);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 18ddb1e..b19617e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -86,7 +86,7 @@ static int f2fs_vm_page_mkwrite(struct vm_area_struct *vma,
 	trace_f2fs_vm_page_mkwrite(page, DATA);
 mapped:
 	/* fill the page */
-	f2fs_wait_on_page_writeback(page, DATA);
+	f2fs_wait_on_page_writeback(page, DATA, false);
 
 	/* wait for GCed encrypted page writeback */
 	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
@@ -521,7 +521,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 	if (IS_ERR(page))
 		return 0;
 truncate_out:
-	f2fs_wait_on_page_writeback(page, DATA);
+	f2fs_wait_on_page_writeback(page, DATA, true);
 	zero_user(page, offset, PAGE_CACHE_SIZE - offset);
 	if (!cache_only || !f2fs_encrypted_inode(inode) || !S_ISREG(inode->i_mode))
 		set_page_dirty(page);
@@ -743,7 +743,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	f2fs_wait_on_page_writeback(page, DATA);
+	f2fs_wait_on_page_writeback(page, DATA, true);
 	zero_user(page, start, len);
 	set_page_dirty(page);
 	f2fs_put_page(page, 1);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f610c2a..0204433 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -446,7 +446,7 @@ next_step:
 
 		/* set page dirty and write it */
 		if (gc_type == FG_GC) {
-			f2fs_wait_on_page_writeback(node_page, NODE);
+			f2fs_wait_on_page_writeback(node_page, NODE, true);
 			set_page_dirty(node_page);
 		} else {
 			if (!PageWriteback(node_page))
@@ -567,7 +567,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	 * don't cache encrypted data into meta inode until previous dirty
 	 * data were writebacked to avoid racing between GC and flush.
 	 */
-	f2fs_wait_on_page_writeback(page, DATA);
+	f2fs_wait_on_page_writeback(page, DATA, true);
 
 	get_node_info(fio.sbi, dn.nid, &ni);
 	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
@@ -596,14 +596,14 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 		goto put_page_out;
 
 	set_page_dirty(fio.encrypted_page);
-	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA);
+	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true);
 	if (clear_page_dirty_for_io(fio.encrypted_page))
 		dec_page_count(fio.sbi, F2FS_DIRTY_META);
 
 	set_page_writeback(fio.encrypted_page);
 
 	/* allocate block address */
-	f2fs_wait_on_page_writeback(dn.node_page, NODE);
+	f2fs_wait_on_page_writeback(dn.node_page, NODE, true);
 	allocate_data_block(fio.sbi, NULL, fio.blk_addr,
 					&fio.blk_addr, &sum, CURSEG_COLD_DATA);
 	fio.rw = WRITE_SYNC;
@@ -645,7 +645,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
 			.encrypted_page = NULL,
 		};
 		set_page_dirty(page);
-		f2fs_wait_on_page_writeback(page, DATA);
+		f2fs_wait_on_page_writeback(page, DATA, true);
 		if (clear_page_dirty_for_io(page))
 			inode_dec_dirty_pages(inode);
 		set_cold_data(page);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index c3f0b7d..8df13e5 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -71,7 +71,7 @@ bool truncate_inline_inode(struct page *ipage, u64 from)
 
 	addr = inline_data_addr(ipage);
 
-	f2fs_wait_on_page_writeback(ipage, NODE);
+	f2fs_wait_on_page_writeback(ipage, NODE, true);
 	memset(addr + from, 0, MAX_INLINE_DATA - from);
 
 	return true;
@@ -124,7 +124,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 	if (err)
 		return err;
 
-	f2fs_wait_on_page_writeback(page, DATA);
+	f2fs_wait_on_page_writeback(page, DATA, true);
 
 	if (PageUptodate(page))
 		goto no_update;
@@ -150,7 +150,7 @@ no_update:
 	write_data_page(dn, &fio);
 	set_data_blkaddr(dn);
 	f2fs_update_extent_cache(dn);
-	f2fs_wait_on_page_writeback(page, DATA);
+	f2fs_wait_on_page_writeback(page, DATA, true);
 	if (dirty)
 		inode_dec_dirty_pages(dn->inode);
 
@@ -223,7 +223,7 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 
 	f2fs_bug_on(F2FS_I_SB(inode), page->index);
 
-	f2fs_wait_on_page_writeback(dn.inode_page, NODE);
+	f2fs_wait_on_page_writeback(dn.inode_page, NODE, true);
 	src_addr = kmap_atomic(page);
 	dst_addr = inline_data_addr(dn.inode_page);
 	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
@@ -261,7 +261,7 @@ process_inline:
 		ipage = get_node_page(sbi, inode->i_ino);
 		f2fs_bug_on(sbi, IS_ERR(ipage));
 
-		f2fs_wait_on_page_writeback(ipage, NODE);
+		f2fs_wait_on_page_writeback(ipage, NODE, true);
 
 		src_addr = inline_data_addr(npage);
 		dst_addr = inline_data_addr(ipage);
@@ -389,7 +389,7 @@ static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
 	if (err)
 		goto out;
 
-	f2fs_wait_on_page_writeback(page, DATA);
+	f2fs_wait_on_page_writeback(page, DATA, true);
 	zero_user_segment(page, MAX_INLINE_DATA, PAGE_CACHE_SIZE);
 
 	dentry_blk = kmap_atomic(page);
@@ -469,7 +469,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
 		}
 	}
 
-	f2fs_wait_on_page_writeback(ipage, NODE);
+	f2fs_wait_on_page_writeback(ipage, NODE, true);
 
 	name_hash = f2fs_dentry_hash(name);
 	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 2);
@@ -507,7 +507,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	int i;
 
 	lock_page(page);
-	f2fs_wait_on_page_writeback(page, NODE);
+	f2fs_wait_on_page_writeback(page, NODE, true);
 
 	inline_dentry = inline_data_addr(page);
 	bit_pos = dentry - inline_dentry->dentry;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 2adeff2..229e11b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -83,7 +83,7 @@ static void __recover_inline_status(struct inode *inode, struct page *ipage)
 
 	while (start < end) {
 		if (*start++) {
-			f2fs_wait_on_page_writeback(ipage, NODE);
+			f2fs_wait_on_page_writeback(ipage, NODE, true);
 
 			set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
 			set_raw_inline(F2FS_I(inode), F2FS_INODE(ipage));
@@ -227,7 +227,7 @@ int update_inode(struct inode *inode, struct page *node_page)
 {
 	struct f2fs_inode *ri;
 
-	f2fs_wait_on_page_writeback(node_page, NODE);
+	f2fs_wait_on_page_writeback(node_page, NODE, true);
 
 	ri = F2FS_INODE(node_page);
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6369281..23b800d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -861,7 +861,7 @@ skip_partial:
 				f2fs_put_page(page, 1);
 				goto restart;
 			}
-			f2fs_wait_on_page_writeback(page, NODE);
+			f2fs_wait_on_page_writeback(page, NODE, true);
 			ri->i_nid[offset[0] - NODE_DIR1_BLOCK] = 0;
 			set_page_dirty(page);
 			unlock_page(page);
@@ -976,7 +976,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	new_ni.ino = dn->inode->i_ino;
 	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
 
-	f2fs_wait_on_page_writeback(page, NODE);
+	f2fs_wait_on_page_writeback(page, NODE, true);
 	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
 	set_cold_node(dn->inode, page);
 	SetPageUptodate(page);
@@ -1287,7 +1287,7 @@ int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
 				continue;
 
 			if (ino && ino_of_node(page) == ino) {
-				f2fs_wait_on_page_writeback(page, NODE);
+				f2fs_wait_on_page_writeback(page, NODE, true);
 				if (TestClearPageError(page))
 					ret = -EIO;
 			}
@@ -1326,7 +1326,7 @@ static int f2fs_write_node_page(struct page *page,
 	if (unlikely(f2fs_cp_error(sbi)))
 		goto redirty_out;
 
-	f2fs_wait_on_page_writeback(page, NODE);
+	f2fs_wait_on_page_writeback(page, NODE, true);
 
 	/* get old block addr of this node page */
 	nid = nid_of_node(page);
@@ -1703,7 +1703,7 @@ void recover_inline_xattr(struct inode *inode, struct page *page)
 	src_addr = inline_xattr_addr(page);
 	inline_size = inline_xattr_size(inode);
 
-	f2fs_wait_on_page_writeback(ipage, NODE);
+	f2fs_wait_on_page_writeback(ipage, NODE, true);
 	memcpy(dst_addr, src_addr, inline_size);
 update_inode:
 	update_inode(inode, ipage);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 56c4519..23bd992 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -330,7 +330,7 @@ static inline int set_nid(struct page *p, int off, nid_t nid, bool i)
 {
 	struct f2fs_node *rn = F2FS_NODE(p);
 
-	f2fs_wait_on_page_writeback(p, NODE);
+	f2fs_wait_on_page_writeback(p, NODE, true);
 
 	if (i)
 		rn->i.i_nid[off - NODE_DIR1_BLOCK] = cpu_to_le32(nid);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 589b20b..5a8fd4a 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -418,7 +418,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	if (err)
 		goto out;
 
-	f2fs_wait_on_page_writeback(dn.node_page, NODE);
+	f2fs_wait_on_page_writeback(dn.node_page, NODE, true);
 
 	get_node_info(sbi, dn.nid, &ni);
 	f2fs_bug_on(sbi, ni.ino != ino_of_node(page));
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 53baf4a..e21c896 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -223,7 +223,8 @@ int commit_inmem_pages(struct inode *inode, bool abort)
 		if (!abort) {
 			if (cur->page->mapping == inode->i_mapping) {
 				set_page_dirty(cur->page);
-				f2fs_wait_on_page_writeback(cur->page, DATA);
+				f2fs_wait_on_page_writeback(cur->page, DATA,
+									true);
 				if (clear_page_dirty_for_io(cur->page))
 					inode_dec_dirty_pages(inode);
 				trace_f2fs_commit_inmem_page(cur->page, INMEM);
@@ -1417,14 +1418,17 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 }
 
 void f2fs_wait_on_page_writeback(struct page *page,
-				enum page_type type)
+				enum page_type type, bool ordered)
 {
 	if (PageWriteback(page)) {
 		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 
 		if (is_merged_page(sbi, page, type))
 			f2fs_submit_merged_bio(sbi, type, WRITE);
-		wait_on_page_writeback(page);
+		if (ordered)
+			wait_on_page_writeback(page);
+		else
+			wait_for_stable_page(page);
 	}
 }
 
@@ -1440,7 +1444,7 @@ void f2fs_wait_on_encrypted_page_writeback(struct f2fs_sb_info *sbi,
 
 	cpage = find_lock_page(META_MAPPING(sbi), blkaddr);
 	if (cpage) {
-		f2fs_wait_on_page_writeback(cpage, DATA);
+		f2fs_wait_on_page_writeback(cpage, DATA, true);
 		f2fs_put_page(cpage, 1);
 	}
 }
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 10f1e78..06a72dc 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -300,7 +300,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 
 		if (ipage) {
 			inline_addr = inline_xattr_addr(ipage);
-			f2fs_wait_on_page_writeback(ipage, NODE);
+			f2fs_wait_on_page_writeback(ipage, NODE, true);
 		} else {
 			page = get_node_page(sbi, inode->i_ino);
 			if (IS_ERR(page)) {
@@ -308,7 +308,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 				return PTR_ERR(page);
 			}
 			inline_addr = inline_xattr_addr(page);
-			f2fs_wait_on_page_writeback(page, NODE);
+			f2fs_wait_on_page_writeback(page, NODE, true);
 		}
 		memcpy(inline_addr, txattr_addr, inline_size);
 		f2fs_put_page(page, 1);
@@ -329,7 +329,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 			return PTR_ERR(xpage);
 		}
 		f2fs_bug_on(sbi, new_nid);
-		f2fs_wait_on_page_writeback(xpage, NODE);
+		f2fs_wait_on_page_writeback(xpage, NODE, true);
 	} else {
 		struct dnode_of_data dn;
 		set_new_dnode(&dn, inode, NULL, NULL, new_nid);
-- 
2.6.3
