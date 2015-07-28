From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2] f2fs: shrink free_nids entries
Date: Tue, 28 Jul 2015 18:33:46 +0800
Message-ID: <00e701d0c920$f9add580$ed098080$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces __count_free_nids/try_to_free_nids and registers
them in slab shrinker for shrinking under memory pressure.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
 * fix wrong bug_on in try_to_free_nids.

 fs/f2fs/f2fs.h     |  1 +
 fs/f2fs/node.c     | 28 ++++++++++++++++++++++++++++
 fs/f2fs/segment.c  |  3 +++
 fs/f2fs/shrinker.c | 14 ++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 58b05b5..a8e07cd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1682,6 +1682,7 @@ int sync_node_pages(struct f2fs_sb_info *, nid_t, struct writeback_control *);
 bool alloc_nid(struct f2fs_sb_info *, nid_t *);
 void alloc_nid_done(struct f2fs_sb_info *, nid_t);
 void alloc_nid_failed(struct f2fs_sb_info *, nid_t);
+int try_to_free_nids(struct f2fs_sb_info *, int);
 void recover_inline_xattr(struct inode *, struct page *);
 void recover_xattr_data(struct inode *, struct page *, block_t);
 int recover_inode_page(struct f2fs_sb_info *, struct page *);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ac91107..6e10c2a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1635,6 +1635,34 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 		kmem_cache_free(free_nid_slab, i);
 }
 
+int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	struct free_nid *i, *next;
+	int nr = nr_shrink;
+
+	if (!mutex_trylock(&nm_i->build_lock))
+		return 0;
+
+	spin_lock(&nm_i->free_nid_list_lock);
+	list_for_each_entry_safe(i, next, &nm_i->free_nid_list, list) {
+		if (nr_shrink <= 0 || nm_i->fcnt <= NAT_ENTRY_PER_BLOCK)
+			break;
+		if (i->state == NID_ALLOC)
+			continue;
+		__del_from_free_nid_list(nm_i, i);
+		nm_i->fcnt--;
+		spin_unlock(&nm_i->free_nid_list_lock);
+		kmem_cache_free(free_nid_slab, i);
+		nr_shrink--;
+		spin_lock(&nm_i->free_nid_list_lock);
+	}
+	spin_unlock(&nm_i->free_nid_list_lock);
+	mutex_unlock(&nm_i->build_lock);
+
+	return nr - nr_shrink;
+}
+
 void recover_inline_xattr(struct inode *inode, struct page *page)
 {
 	void *src_addr, *dst_addr;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 509a2c4..4712dbc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -317,6 +317,9 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	if (!available_free_memory(sbi, NAT_ENTRIES))
 		try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK);
 
+	if (!available_free_memory(sbi, FREE_NIDS))
+		try_to_free_nids(sbi, NAT_ENTRY_PER_BLOCK * FREE_NID_PAGES);
+
 	/* checkpoint is the only way to shrink partial cached entries */
 	if (!available_free_memory(sbi, NAT_ENTRIES) ||
 			excess_prefree_segs(sbi) ||
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 9aa4235..da0d8e0 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -23,6 +23,13 @@ static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
 	return NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
 }
 
+static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
+{
+	if (NM_I(sbi)->fcnt > NAT_ENTRY_PER_BLOCK)
+		return NM_I(sbi)->fcnt - NAT_ENTRY_PER_BLOCK;
+	return 0;
+}
+
 static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi)
 {
 	return sbi->total_ext_tree + atomic_read(&sbi->total_ext_node);
@@ -53,6 +60,9 @@ unsigned long f2fs_shrink_count(struct shrinker *shrink,
 		/* shrink clean nat cache entries */
 		count += __count_nat_entries(sbi);
 
+		/* count free nids cache entries */
+		count += __count_free_nids(sbi);
+
 		spin_lock(&f2fs_list_lock);
 		p = p->next;
 		mutex_unlock(&sbi->umount_mutex);
@@ -97,6 +107,10 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
 		if (freed < nr)
 			freed += try_to_free_nats(sbi, nr - freed);
 
+		/* shrink free nids cache entries */
+		if (freed < nr)
+			freed += try_to_free_nids(sbi, nr - freed);
+
 		spin_lock(&f2fs_list_lock);
 		p = p->next;
 		list_move_tail(&sbi->s_list, &f2fs_list);
-- 
2.4.2
