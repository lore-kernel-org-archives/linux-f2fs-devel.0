From: DongOh Shin <doscode.kr@gmail.com>
Subject: [PATCH 2/2] Fix 446 coding style warnings in f2fs.h
Date: Mon, 30 Jan 2017 10:55:18 -0800
Message-ID: <20170130185518.916-3-doscode.kr@gmail.com>
References: <20170130185518.916-1-doscode.kr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <doscode.kr@gmail.com>) id 1cYH79-0002Ge-N1
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Jan 2017 18:55:43 +0000
Received: from mail-pg0-f66.google.com ([74.125.83.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cYH77-0003cd-43
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Jan 2017 18:55:43 +0000
Received: by mail-pg0-f66.google.com with SMTP id 75so32197744pgf.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 30 Jan 2017 10:55:41 -0800 (PST)
In-Reply-To: <20170130185518.916-1-doscode.kr@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: doscode.kr@gmail.com, linux-f2fs-devel@lists.sourceforge.net

1) Nine coding style warnings below have been resolved:
"Missing a blank line after declarations"

2) 435 coding style warnings below have been resolved:
"function definition argument 'x' should also have an identifier name"

3) Two coding style warnings below have been resolved:
"macros should not use a trailing semicolon"

Signed-off-by: DongOh Shin <doscode.kr@gmail.com>
---
 fs/f2fs/f2fs.h | 498 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 270 insertions(+), 228 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 85bd8c1..d501f4f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -212,6 +212,7 @@ struct fsync_inode_entry {
 static inline int update_nats_in_cursum(struct f2fs_journal *journal, int i)
 {
 	int before = nats_in_cursum(journal);
+
 	journal->n_nats = cpu_to_le16(before + i);
 	return before;
 }
@@ -219,6 +220,7 @@ static inline int update_nats_in_cursum(struct f2fs_journal *journal, int i)
 static inline int update_sits_in_cursum(struct f2fs_journal *journal, int i)
 {
 	int before = sits_in_cursum(journal);
+
 	journal->n_sits = cpu_to_le16(before + i);
 	return before;
 }
@@ -304,12 +306,14 @@ static inline void make_dentry_ptr(struct inode *inode,
 
 	if (type == 1) {
 		struct f2fs_dentry_block *t = (struct f2fs_dentry_block *)src;
+
 		d->max = NR_DENTRY_IN_BLOCK;
 		d->bitmap = &t->dentry_bitmap;
 		d->dentry = t->dentry;
 		d->filename = t->filename;
 	} else {
 		struct f2fs_inline_dentry *t = (struct f2fs_inline_dentry *)src;
+
 		d->max = NR_INLINE_DENTRY;
 		d->bitmap = &t->dentry_bitmap;
 		d->dentry = t->dentry;
@@ -498,7 +502,7 @@ static inline bool __is_front_mergeable(struct extent_info *cur,
 	return __is_extent_mergeable(cur, front);
 }
 
-extern void f2fs_mark_inode_dirty_sync(struct inode *, bool);
+extern void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync);
 static inline void __try_update_largest_extent(struct inode *inode,
 			struct extent_tree *et, struct extent_node *en)
 {
@@ -1454,6 +1458,7 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 {
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	struct page *page = find_lock_page(mapping, index);
+
 	if (page)
 		return page;
 
@@ -1537,6 +1542,7 @@ static inline void f2fs_radix_tree_insert(struct radix_tree_root *root,
 static inline bool IS_INODE(struct page *page)
 {
 	struct f2fs_node *p = F2FS_NODE(page);
+
 	return RAW_IS_INODE(p);
 }
 
@@ -1550,6 +1556,7 @@ static inline block_t datablock_addr(struct page *node_page,
 {
 	struct f2fs_node *raw_node;
 	__le32 *addr_array;
+
 	raw_node = F2FS_NODE(node_page);
 	addr_array = blkaddr_in_node(raw_node);
 	return le32_to_cpu(addr_array[offset]);
@@ -1785,6 +1792,7 @@ static inline unsigned int addrs_per_inode(struct inode *inode)
 static inline void *inline_xattr_addr(struct page *page)
 {
 	struct f2fs_inode *ri = F2FS_INODE(page);
+
 	return (void *)&(ri->i_addr[DEF_ADDRS_PER_INODE -
 					F2FS_INLINE_XATTR_ADDRS]);
 }
@@ -1846,6 +1854,7 @@ static inline bool f2fs_is_drop_cache(struct inode *inode)
 static inline void *inline_data_addr(struct page *page)
 {
 	struct f2fs_inode *ri = F2FS_INODE(page);
+
 	return (void *)&(ri->i_addr[1]);
 }
 
@@ -1968,29 +1977,30 @@ static inline void *f2fs_kvzalloc(size_t size, gfp_t flags)
 /*
  * file.c
  */
-int f2fs_sync_file(struct file *, loff_t, loff_t, int);
-void truncate_data_blocks(struct dnode_of_data *);
-int truncate_blocks(struct inode *, u64, bool);
-int f2fs_truncate(struct inode *);
-int f2fs_getattr(struct vfsmount *, struct dentry *, struct kstat *);
-int f2fs_setattr(struct dentry *, struct iattr *);
-int truncate_hole(struct inode *, pgoff_t, pgoff_t);
-int truncate_data_blocks_range(struct dnode_of_data *, int);
-long f2fs_ioctl(struct file *, unsigned int, unsigned long);
-long f2fs_compat_ioctl(struct file *, unsigned int, unsigned long);
+int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
+void truncate_data_blocks(struct dnode_of_data *dn);
+int truncate_blocks(struct inode *inode, u64 from, bool lock);
+int f2fs_truncate(struct inode *inode);
+int f2fs_getattr(struct vfsmount *mnt, struct dentry *dentry,
+			struct kstat *stat);
+int f2fs_setattr(struct dentry *dentry, struct iattr *attr);
+int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
+int truncate_data_blocks_range(struct dnode_of_data *dn, int count);
+long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
 /*
  * inode.c
  */
-void f2fs_set_inode_flags(struct inode *);
-struct inode *f2fs_iget(struct super_block *, unsigned long);
-struct inode *f2fs_iget_retry(struct super_block *, unsigned long);
-int try_to_free_nats(struct f2fs_sb_info *, int);
-int update_inode(struct inode *, struct page *);
-int update_inode_page(struct inode *);
-int f2fs_write_inode(struct inode *, struct writeback_control *);
-void f2fs_evict_inode(struct inode *);
-void handle_failed_inode(struct inode *);
+void f2fs_set_inode_flags(struct inode *inode);
+struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
+struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
+int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
+int update_inode(struct inode *inode, struct page *node_page);
+int update_inode_page(struct inode *inode);
+int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc);
+void f2fs_evict_inode(struct inode *inode);
+void handle_failed_inode(struct inode *inode);
 
 /*
  * namei.c
@@ -2000,40 +2010,47 @@ static inline void *f2fs_kvzalloc(size_t size, gfp_t flags)
 /*
  * dir.c
  */
-void set_de_type(struct f2fs_dir_entry *, umode_t);
-unsigned char get_de_type(struct f2fs_dir_entry *);
-struct f2fs_dir_entry *find_target_dentry(struct fscrypt_name *,
-			f2fs_hash_t, int *, struct f2fs_dentry_ptr *);
-int f2fs_fill_dentries(struct dir_context *, struct f2fs_dentry_ptr *,
-			unsigned int, struct fscrypt_str *);
-void do_make_empty_dir(struct inode *, struct inode *,
-			struct f2fs_dentry_ptr *);
-struct page *init_inode_metadata(struct inode *, struct inode *,
-		const struct qstr *, const struct qstr *, struct page *);
-void update_parent_metadata(struct inode *, struct inode *, unsigned int);
-int room_for_filename(const void *, int, int);
-void f2fs_drop_nlink(struct inode *, struct inode *);
-struct f2fs_dir_entry *__f2fs_find_entry(struct inode *, struct fscrypt_name *,
-							struct page **);
-struct f2fs_dir_entry *f2fs_find_entry(struct inode *, const struct qstr *,
-							struct page **);
-struct f2fs_dir_entry *f2fs_parent_dir(struct inode *, struct page **);
-ino_t f2fs_inode_by_name(struct inode *, const struct qstr *, struct page **);
-void f2fs_set_link(struct inode *, struct f2fs_dir_entry *,
-				struct page *, struct inode *);
-int update_dent_inode(struct inode *, struct inode *, const struct qstr *);
-void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *,
-			const struct qstr *, f2fs_hash_t, unsigned int);
-int f2fs_add_regular_entry(struct inode *, const struct qstr *,
-			const struct qstr *, struct inode *, nid_t, umode_t);
-int __f2fs_do_add_link(struct inode *, struct fscrypt_name*, struct inode *,
-			nid_t, umode_t);
-int __f2fs_add_link(struct inode *, const struct qstr *, struct inode *, nid_t,
-			umode_t);
-void f2fs_delete_entry(struct f2fs_dir_entry *, struct page *, struct inode *,
-							struct inode *);
-int f2fs_do_tmpfile(struct inode *, struct inode *);
-bool f2fs_empty_dir(struct inode *);
+void set_de_type(struct f2fs_dir_entry *de, umode_t mode);
+unsigned char get_de_type(struct f2fs_dir_entry *de);
+struct f2fs_dir_entry *find_target_dentry(struct fscrypt_name *fname,
+			f2fs_hash_t namehash, int *max_slots,
+			struct f2fs_dentry_ptr *d);
+int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
+			unsigned int start_pos, struct fscrypt_str *fstr);
+void do_make_empty_dir(struct inode *inode, struct inode *parent,
+			struct f2fs_dentry_ptr *d);
+struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
+			const struct qstr *new_name,
+			const struct qstr *orig_name, struct page *dpage);
+void update_parent_metadata(struct inode *dir, struct inode *inode,
+			unsigned int current_depth);
+int room_for_filename(const void *bitmap, int slots, int max_slots);
+void f2fs_drop_nlink(struct inode *dir, struct inode *inode);
+struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
+			struct fscrypt_name *fname, struct page **res_page);
+struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
+			const struct qstr *child, struct page **res_page);
+struct f2fs_dir_entry *f2fs_parent_dir(struct inode *dir, struct page **p);
+ino_t f2fs_inode_by_name(struct inode *dir, const struct qstr *qstr,
+			struct page **page);
+void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
+			struct page *page, struct inode *inode);
+int update_dent_inode(struct inode *inode, struct inode *to,
+			const struct qstr *name);
+void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
+			const struct qstr *name, f2fs_hash_t name_hash,
+			unsigned int bit_pos);
+int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
+			const struct qstr *orig_name,
+			struct inode *inode, nid_t ino, umode_t mode);
+int __f2fs_do_add_link(struct inode *dir, struct fscrypt_name *fname,
+			struct inode *inode, nid_t ino, umode_t mode);
+int __f2fs_add_link(struct inode *dir, const struct qstr *name,
+			struct inode *inode, nid_t ino, umode_t mode);
+void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
+			struct inode *dir, struct inode *inode);
+int f2fs_do_tmpfile(struct inode *inode, struct inode *dir);
+bool f2fs_empty_dir(struct inode *dir);
 
 static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
 {
@@ -2044,18 +2061,18 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
 /*
  * super.c
  */
-int f2fs_inode_dirtied(struct inode *, bool);
-void f2fs_inode_synced(struct inode *);
-int f2fs_commit_super(struct f2fs_sb_info *, bool);
-int f2fs_sync_fs(struct super_block *, int);
+int f2fs_inode_dirtied(struct inode *inode, bool sync);
+void f2fs_inode_synced(struct inode *inode);
+int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
+int f2fs_sync_fs(struct super_block *sb, int sync);
 extern __printf(3, 4)
-void f2fs_msg(struct super_block *, const char *, const char *, ...);
+void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...);
 int sanity_check_ckpt(struct f2fs_sb_info *sbi);
 
 /*
  * hash.c
  */
-f2fs_hash_t f2fs_dentry_hash(const struct qstr *);
+f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info);
 
 /*
  * node.c
@@ -2063,164 +2080,183 @@ extern __printf(3, 4)
 struct dnode_of_data;
 struct node_info;
 
-bool available_free_memory(struct f2fs_sb_info *, int);
-int need_dentry_mark(struct f2fs_sb_info *, nid_t);
-bool is_checkpointed_node(struct f2fs_sb_info *, nid_t);
-bool need_inode_block_update(struct f2fs_sb_info *, nid_t);
-void get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
-pgoff_t get_next_page_offset(struct dnode_of_data *, pgoff_t);
-int get_dnode_of_data(struct dnode_of_data *, pgoff_t, int);
-int truncate_inode_blocks(struct inode *, pgoff_t);
-int truncate_xattr_node(struct inode *, struct page *);
-int wait_on_node_pages_writeback(struct f2fs_sb_info *, nid_t);
-int remove_inode_page(struct inode *);
-struct page *new_inode_page(struct inode *);
-struct page *new_node_page(struct dnode_of_data *, unsigned int, struct page *);
-void ra_node_page(struct f2fs_sb_info *, nid_t);
-struct page *get_node_page(struct f2fs_sb_info *, pgoff_t);
-struct page *get_node_page_ra(struct page *, int);
-void move_node_page(struct page *, int);
-int fsync_node_pages(struct f2fs_sb_info *, struct inode *,
-			struct writeback_control *, bool);
-int sync_node_pages(struct f2fs_sb_info *, struct writeback_control *);
-void build_free_nids(struct f2fs_sb_info *, bool);
-bool alloc_nid(struct f2fs_sb_info *, nid_t *);
-void alloc_nid_done(struct f2fs_sb_info *, nid_t);
-void alloc_nid_failed(struct f2fs_sb_info *, nid_t);
-int try_to_free_nids(struct f2fs_sb_info *, int);
-void recover_inline_xattr(struct inode *, struct page *);
-void recover_xattr_data(struct inode *, struct page *, block_t);
-int recover_inode_page(struct f2fs_sb_info *, struct page *);
-int restore_node_summary(struct f2fs_sb_info *, unsigned int,
-				struct f2fs_summary_block *);
-void flush_nat_entries(struct f2fs_sb_info *);
-int build_node_manager(struct f2fs_sb_info *);
-void destroy_node_manager(struct f2fs_sb_info *);
+bool available_free_memory(struct f2fs_sb_info *sbi, int type);
+int need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid);
+bool is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid);
+bool need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino);
+void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni);
+pgoff_t get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs);
+int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode);
+int truncate_inode_blocks(struct inode *inode, pgoff_t from);
+int truncate_xattr_node(struct inode *inode, struct page *page);
+int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino);
+int remove_inode_page(struct inode *inode);
+struct page *new_inode_page(struct inode *inode);
+struct page *new_node_page(struct dnode_of_data *dn,
+			unsigned int ofs, struct page *ipage);
+void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
+struct page *get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
+struct page *get_node_page_ra(struct page *parent, int start);
+void move_node_page(struct page *node_page, int gc_type);
+int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
+			struct writeback_control *wbc, bool atomic);
+int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc);
+void build_free_nids(struct f2fs_sb_info *sbi, bool sync);
+bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
+void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
+void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid);
+int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink);
+void recover_inline_xattr(struct inode *inode, struct page *page);
+void recover_xattr_data(struct inode *inode, struct page *page,
+			block_t blkaddr);
+int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
+int restore_node_summary(struct f2fs_sb_info *sbi,
+			unsigned int segno, struct f2fs_summary_block *sum);
+void flush_nat_entries(struct f2fs_sb_info *sbi);
+int build_node_manager(struct f2fs_sb_info *sbi);
+void destroy_node_manager(struct f2fs_sb_info *sbi);
 int __init create_node_manager_caches(void);
 void destroy_node_manager_caches(void);
 
 /*
  * segment.c
  */
-void register_inmem_page(struct inode *, struct page *);
-void drop_inmem_pages(struct inode *);
-int commit_inmem_pages(struct inode *);
-void f2fs_balance_fs(struct f2fs_sb_info *, bool);
-void f2fs_balance_fs_bg(struct f2fs_sb_info *);
-int f2fs_issue_flush(struct f2fs_sb_info *);
-int create_flush_cmd_control(struct f2fs_sb_info *);
-void destroy_flush_cmd_control(struct f2fs_sb_info *, bool);
-void invalidate_blocks(struct f2fs_sb_info *, block_t);
-bool is_checkpointed_data(struct f2fs_sb_info *, block_t);
-void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
-void f2fs_wait_discard_bio(struct f2fs_sb_info *, block_t);
-void clear_prefree_segments(struct f2fs_sb_info *, struct cp_control *);
-void release_discard_addrs(struct f2fs_sb_info *);
-int npages_for_summary_flush(struct f2fs_sb_info *, bool);
-void allocate_new_segments(struct f2fs_sb_info *);
-int f2fs_trim_fs(struct f2fs_sb_info *, struct fstrim_range *);
-bool exist_trim_candidates(struct f2fs_sb_info *, struct cp_control *);
-struct page *get_sum_page(struct f2fs_sb_info *, unsigned int);
-void update_meta_page(struct f2fs_sb_info *, void *, block_t);
-void write_meta_page(struct f2fs_sb_info *, struct page *);
-void write_node_page(unsigned int, struct f2fs_io_info *);
-void write_data_page(struct dnode_of_data *, struct f2fs_io_info *);
-void rewrite_data_page(struct f2fs_io_info *);
-void __f2fs_replace_block(struct f2fs_sb_info *, struct f2fs_summary *,
-					block_t, block_t, bool, bool);
-void f2fs_replace_block(struct f2fs_sb_info *, struct dnode_of_data *,
-				block_t, block_t, unsigned char, bool, bool);
-void allocate_data_block(struct f2fs_sb_info *, struct page *,
-		block_t, block_t *, struct f2fs_summary *, int);
-void f2fs_wait_on_page_writeback(struct page *, enum page_type, bool);
-void f2fs_wait_on_encrypted_page_writeback(struct f2fs_sb_info *, block_t);
-void write_data_summaries(struct f2fs_sb_info *, block_t);
-void write_node_summaries(struct f2fs_sb_info *, block_t);
-int lookup_journal_in_cursum(struct f2fs_journal *, int, unsigned int, int);
-void flush_sit_entries(struct f2fs_sb_info *, struct cp_control *);
-int build_segment_manager(struct f2fs_sb_info *);
-void destroy_segment_manager(struct f2fs_sb_info *);
+void register_inmem_page(struct inode *inode, struct page *page);
+void drop_inmem_pages(struct inode *inode);
+int commit_inmem_pages(struct inode *inode);
+void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need);
+void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi);
+int f2fs_issue_flush(struct f2fs_sb_info *sbi);
+int create_flush_cmd_control(struct f2fs_sb_info *sbi);
+void destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
+void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
+bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
+void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new);
+void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr);
+void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc);
+void release_discard_addrs(struct f2fs_sb_info *sbi);
+int npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
+void allocate_new_segments(struct f2fs_sb_info *sbi);
+int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
+bool exist_trim_candidates(struct f2fs_sb_info *sbi, struct cp_control *cpc);
+struct page *get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno);
+void update_meta_page(struct f2fs_sb_info *sbi, void *src, block_t blk_addr);
+void write_meta_page(struct f2fs_sb_info *sbi, struct page *page);
+void write_node_page(unsigned int nid, struct f2fs_io_info *fio);
+void write_data_page(struct dnode_of_data *dn, struct f2fs_io_info *fio);
+void rewrite_data_page(struct f2fs_io_info *fio);
+void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
+			block_t old_blkaddr, block_t new_blkaddr,
+			bool recover_curseg, bool recover_newaddr);
+void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
+			block_t old_addr, block_t new_addr,
+			unsigned char version, bool recover_curseg,
+			bool recover_newaddr);
+void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
+			block_t old_blkaddr, block_t *new_blkaddr,
+			struct f2fs_summary *sum, int type);
+void f2fs_wait_on_page_writeback(struct page *page,
+			enum page_type type, bool ordered);
+void f2fs_wait_on_encrypted_page_writeback(struct f2fs_sb_info *sbi,
+			block_t blkaddr);
+void write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
+void write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
+int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
+			unsigned int val, int alloc);
+void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
+int build_segment_manager(struct f2fs_sb_info *sbi);
+void destroy_segment_manager(struct f2fs_sb_info *sbi);
 int __init create_segment_manager_caches(void);
 void destroy_segment_manager_caches(void);
 
 /*
  * checkpoint.c
  */
-void f2fs_stop_checkpoint(struct f2fs_sb_info *, bool);
-struct page *grab_meta_page(struct f2fs_sb_info *, pgoff_t);
-struct page *get_meta_page(struct f2fs_sb_info *, pgoff_t);
-struct page *get_tmp_page(struct f2fs_sb_info *, pgoff_t);
-bool is_valid_blkaddr(struct f2fs_sb_info *, block_t, int);
-int ra_meta_pages(struct f2fs_sb_info *, block_t, int, int, bool);
-void ra_meta_pages_cond(struct f2fs_sb_info *, pgoff_t);
-long sync_meta_pages(struct f2fs_sb_info *, enum page_type, long);
-void add_ino_entry(struct f2fs_sb_info *, nid_t, int type);
-void remove_ino_entry(struct f2fs_sb_info *, nid_t, int type);
-void release_ino_entry(struct f2fs_sb_info *, bool);
-bool exist_written_data(struct f2fs_sb_info *, nid_t, int);
-int f2fs_sync_inode_meta(struct f2fs_sb_info *);
-int acquire_orphan_inode(struct f2fs_sb_info *);
-void release_orphan_inode(struct f2fs_sb_info *);
-void add_orphan_inode(struct inode *);
-void remove_orphan_inode(struct f2fs_sb_info *, nid_t);
-int recover_orphan_inodes(struct f2fs_sb_info *);
-int get_valid_checkpoint(struct f2fs_sb_info *);
-void update_dirty_page(struct inode *, struct page *);
-void remove_dirty_inode(struct inode *);
-int sync_dirty_inodes(struct f2fs_sb_info *, enum inode_type);
-int write_checkpoint(struct f2fs_sb_info *, struct cp_control *);
-void init_ino_entry_info(struct f2fs_sb_info *);
+void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io);
+struct page *grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
+struct page *get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
+struct page *get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index);
+bool is_valid_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type);
+int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
+			int type, bool sync);
+void ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index);
+long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
+			long nr_to_write);
+void add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type);
+void remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type);
+void release_ino_entry(struct f2fs_sb_info *sbi, bool all);
+bool exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode);
+int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi);
+int acquire_orphan_inode(struct f2fs_sb_info *sbi);
+void release_orphan_inode(struct f2fs_sb_info *sbi);
+void add_orphan_inode(struct inode *inode);
+void remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino);
+int recover_orphan_inodes(struct f2fs_sb_info *sbi);
+int get_valid_checkpoint(struct f2fs_sb_info *sbi);
+void update_dirty_page(struct inode *inode, struct page *page);
+void remove_dirty_inode(struct inode *inode);
+int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type);
+int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc);
+void init_ino_entry_info(struct f2fs_sb_info *sbi);
 int __init create_checkpoint_caches(void);
 void destroy_checkpoint_caches(void);
 
 /*
  * data.c
  */
-void f2fs_submit_merged_bio(struct f2fs_sb_info *, enum page_type, int);
-void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *, struct inode *,
-				struct page *, nid_t, enum page_type, int);
-void f2fs_flush_merged_bios(struct f2fs_sb_info *);
-int f2fs_submit_page_bio(struct f2fs_io_info *);
-int f2fs_submit_page_mbio(struct f2fs_io_info *);
-struct block_device *f2fs_target_device(struct f2fs_sb_info *,
-				block_t, struct bio *);
-int f2fs_target_device_index(struct f2fs_sb_info *, block_t);
-void set_data_blkaddr(struct dnode_of_data *);
-void f2fs_update_data_blkaddr(struct dnode_of_data *, block_t);
-int reserve_new_blocks(struct dnode_of_data *, blkcnt_t);
-int reserve_new_block(struct dnode_of_data *);
-int f2fs_get_block(struct dnode_of_data *, pgoff_t);
-int f2fs_preallocate_blocks(struct kiocb *, struct iov_iter *);
-int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
-struct page *get_read_data_page(struct inode *, pgoff_t, int, bool);
-struct page *find_data_page(struct inode *, pgoff_t);
-struct page *get_lock_data_page(struct inode *, pgoff_t, bool);
-struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
-int do_write_data_page(struct f2fs_io_info *);
-int f2fs_map_blocks(struct inode *, struct f2fs_map_blocks *, int, int);
-int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
-void f2fs_set_page_dirty_nobuffers(struct page *);
-void f2fs_invalidate_page(struct page *, unsigned int, unsigned int);
-int f2fs_release_page(struct page *, gfp_t);
+void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi, enum page_type type,
+			int rw);
+void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *sbi,
+				struct inode *inode, struct page *page,
+				nid_t ino, enum page_type type, int rw);
+void f2fs_flush_merged_bios(struct f2fs_sb_info *sbi);
+int f2fs_submit_page_bio(struct f2fs_io_info *fio);
+int f2fs_submit_page_mbio(struct f2fs_io_info *fio);
+struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
+			block_t blk_addr, struct bio *bio);
+int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr);
+void set_data_blkaddr(struct dnode_of_data *dn);
+void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
+int reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count);
+int reserve_new_block(struct dnode_of_data *dn);
+int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index);
+int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from);
+int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index);
+struct page *get_read_data_page(struct inode *inode, pgoff_t index,
+			int op_flags, bool for_write);
+struct page *find_data_page(struct inode *inode, pgoff_t index);
+struct page *get_lock_data_page(struct inode *inode, pgoff_t index,
+			bool for_write);
+struct page *get_new_data_page(struct inode *inode,
+			struct page *ipage, pgoff_t index, bool new_i_size);
+int do_write_data_page(struct f2fs_io_info *fio);
+int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
+			int create, int flag);
+int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+			u64 start, u64 len);
+void f2fs_set_page_dirty_nobuffers(struct page *page);
+void f2fs_invalidate_page(struct page *page, unsigned int offset,
+			unsigned int length);
+int f2fs_release_page(struct page *page, gfp_t wait);
 #ifdef CONFIG_MIGRATION
-int f2fs_migrate_page(struct address_space *, struct page *, struct page *,
-				enum migrate_mode);
+int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
+			struct page *page, enum migrate_mode mode);
 #endif
 
 /*
  * gc.c
  */
-int start_gc_thread(struct f2fs_sb_info *);
-void stop_gc_thread(struct f2fs_sb_info *);
-block_t start_bidx_of_node(unsigned int, struct inode *);
-int f2fs_gc(struct f2fs_sb_info *, bool, bool);
-void build_gc_manager(struct f2fs_sb_info *);
+int start_gc_thread(struct f2fs_sb_info *sbi);
+void stop_gc_thread(struct f2fs_sb_info *sbi);
+block_t start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
+int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background);
+void build_gc_manager(struct f2fs_sb_info *sbi);
 
 /*
  * recovery.c
  */
-int recover_fsync_data(struct f2fs_sb_info *, bool);
-bool space_for_roll_forward(struct f2fs_sb_info *);
+int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only);
+bool space_for_roll_forward(struct f2fs_sb_info *sbi);
 
 /*
  * debug.c
@@ -2314,9 +2350,9 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_inc_inplace_blocks(sbi)					\
 		(atomic_inc(&(sbi)->inplace_count))
 #define stat_inc_atomic_write(inode)					\
-		(atomic_inc(&F2FS_I_SB(inode)->aw_cnt));
+		(atomic_inc(&F2FS_I_SB(inode)->aw_cnt))
 #define stat_dec_atomic_write(inode)					\
-		(atomic_dec(&F2FS_I_SB(inode)->aw_cnt));
+		(atomic_dec(&F2FS_I_SB(inode)->aw_cnt))
 #define stat_update_max_atomic_write(inode)				\
 	do {								\
 		int cur = atomic_read(&F2FS_I_SB(inode)->aw_cnt);	\
@@ -2356,8 +2392,8 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		si->bg_node_blks += (gc_type == BG_GC) ? (blks) : 0;	\
 	} while (0)
 
-int f2fs_build_stats(struct f2fs_sb_info *);
-void f2fs_destroy_stats(struct f2fs_sb_info *);
+int f2fs_build_stats(struct f2fs_sb_info *sbi);
+void f2fs_destroy_stats(struct f2fs_sb_info *sbi);
 int __init f2fs_create_root_stats(void);
 void f2fs_destroy_root_stats(void);
 #else
@@ -2409,49 +2445,55 @@ static inline void f2fs_destroy_root_stats(void) { }
 /*
  * inline.c
  */
-bool f2fs_may_inline_data(struct inode *);
-bool f2fs_may_inline_dentry(struct inode *);
-void read_inline_data(struct page *, struct page *);
-bool truncate_inline_inode(struct page *, u64);
-int f2fs_read_inline_data(struct inode *, struct page *);
-int f2fs_convert_inline_page(struct dnode_of_data *, struct page *);
-int f2fs_convert_inline_inode(struct inode *);
-int f2fs_write_inline_data(struct inode *, struct page *);
-bool recover_inline_data(struct inode *, struct page *);
-struct f2fs_dir_entry *find_in_inline_dir(struct inode *,
-				struct fscrypt_name *, struct page **);
-int make_empty_inline_dir(struct inode *inode, struct inode *, struct page *);
-int f2fs_add_inline_entry(struct inode *, const struct qstr *,
-		const struct qstr *, struct inode *, nid_t, umode_t);
-void f2fs_delete_inline_entry(struct f2fs_dir_entry *, struct page *,
-						struct inode *, struct inode *);
-bool f2fs_empty_inline_dir(struct inode *);
-int f2fs_read_inline_dir(struct file *, struct dir_context *,
-						struct fscrypt_str *);
-int f2fs_inline_data_fiemap(struct inode *,
-		struct fiemap_extent_info *, __u64, __u64);
+bool f2fs_may_inline_data(struct inode *inode);
+bool f2fs_may_inline_dentry(struct inode *inode);
+void read_inline_data(struct page *page, struct page *ipage);
+bool truncate_inline_inode(struct page *ipage, u64 from);
+int f2fs_read_inline_data(struct inode *inode, struct page *page);
+int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page);
+int f2fs_convert_inline_inode(struct inode *inode);
+int f2fs_write_inline_data(struct inode *inode, struct page *page);
+bool recover_inline_data(struct inode *inode, struct page *npage);
+struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
+			struct fscrypt_name *fname, struct page **res_page);
+int make_empty_inline_dir(struct inode *inode, struct inode *parent,
+			struct page *ipage);
+int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
+			const struct qstr *orig_name,
+			struct inode *inode, nid_t ino, umode_t mode);
+void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
+			struct inode *dir, struct inode *inode);
+bool f2fs_empty_inline_dir(struct inode *dir);
+int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
+			struct fscrypt_str *fstr);
+int f2fs_inline_data_fiemap(struct inode *inode,
+			struct fiemap_extent_info *fieinfo,
+			__u64 start, __u64 len);
 
 /*
  * shrinker.c
  */
-unsigned long f2fs_shrink_count(struct shrinker *, struct shrink_control *);
-unsigned long f2fs_shrink_scan(struct shrinker *, struct shrink_control *);
-void f2fs_join_shrinker(struct f2fs_sb_info *);
-void f2fs_leave_shrinker(struct f2fs_sb_info *);
+unsigned long f2fs_shrink_count(struct shrinker *shrink,
+			struct shrink_control *sc);
+unsigned long f2fs_shrink_scan(struct shrinker *shrink,
+			struct shrink_control *sc);
+void f2fs_join_shrinker(struct f2fs_sb_info *sbi);
+void f2fs_leave_shrinker(struct f2fs_sb_info *sbi);
 
 /*
  * extent_cache.c
  */
-unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *, int);
-bool f2fs_init_extent_tree(struct inode *, struct f2fs_extent *);
-void f2fs_drop_extent_tree(struct inode *);
-unsigned int f2fs_destroy_extent_node(struct inode *);
-void f2fs_destroy_extent_tree(struct inode *);
-bool f2fs_lookup_extent_cache(struct inode *, pgoff_t, struct extent_info *);
-void f2fs_update_extent_cache(struct dnode_of_data *);
+unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink);
+bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext);
+void f2fs_drop_extent_tree(struct inode *inode);
+unsigned int f2fs_destroy_extent_node(struct inode *inode);
+void f2fs_destroy_extent_tree(struct inode *inode);
+bool f2fs_lookup_extent_cache(struct inode *inode, pgoff_t pgofs,
+			struct extent_info *ei);
+void f2fs_update_extent_cache(struct dnode_of_data *dn);
 void f2fs_update_extent_cache_range(struct dnode_of_data *dn,
-						pgoff_t, block_t, unsigned int);
-void init_extent_cache_info(struct f2fs_sb_info *);
+			pgoff_t fofs, block_t blkaddr, unsigned int len);
+void init_extent_cache_info(struct f2fs_sb_info *sbi);
 int __init create_extent_cache(void);
 void destroy_extent_cache(void);
 
-- 
1.8.3.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
