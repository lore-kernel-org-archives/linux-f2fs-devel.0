From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v4] f2fs: fix out-of-free problem caused by atomic write
Date: Wed, 8 Nov 2017 10:17:26 +0800
Message-ID: <1510107446-52423-1-git-send-email-yunlong.song@huawei.com>
References: <1509934071-116656-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509934071-116656-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

f2fs_balance_fs only actives once in the commit_inmem_pages, but there
are more than one page to commit, so all the other pages will miss the
check. This will lead to out-of-free problem when commit a very large
file. However, we cannot do f2fs_balance_fs for each inmem page, since
this will break atomicity. As a result, we should do f2fs_balance_fs
for all the inmem pages together.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/debug.c   |  5 +++--
 fs/f2fs/f2fs.h    | 26 ++++++++++++++++++++++++--
 fs/f2fs/segment.c | 30 ++++++++++++++++++++++++------
 fs/f2fs/segment.h |  4 +++-
 4 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index f7eec50..41c47c4 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -50,6 +50,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
 	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
 	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
+	si->inmem_commit_pages = get_pages(sbi, F2FS_INMEM_COMMIT_PAGES);
 	si->aw_cnt = atomic_read(&sbi->aw_cnt);
 	si->vw_cnt = atomic_read(&sbi->vw_cnt);
 	si->max_aw_cnt = atomic_read(&sbi->max_aw_cnt);
@@ -360,9 +361,9 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->nr_discarding, si->nr_discarded,
 			   si->nr_discard_cmd, si->undiscard_blks);
 		seq_printf(s, "  - inmem: %4d, atomic IO: %4d (Max. %4d), "
-			"volatile IO: %4d (Max. %4d)\n",
+			"volatile IO: %4d (Max. %4d), commit: %4d\n",
 			   si->inmem_pages, si->aw_cnt, si->max_aw_cnt,
-			   si->vw_cnt, si->max_vw_cnt);
+			   si->vw_cnt, si->max_vw_cnt, si->inmem_commit_pages);
 		seq_printf(s, "  - nodes: %4d in %4d\n",
 			   si->ndirty_node, si->node_pages);
 		seq_printf(s, "  - dents: %4d in dirs:%4d (%4d)\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 13a96b8..749bdb6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -610,6 +610,7 @@ struct f2fs_inode_info {
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct task_struct *inmem_task;	/* store inmemory task */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
+	unsigned long inmem_blocks;	/* inmemory blocks */
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
 	struct rw_semaphore dio_rwsem[2];/* avoid racing between dio and gc */
 	struct rw_semaphore i_mmap_sem;
@@ -863,6 +864,7 @@ enum count_type {
 	F2FS_DIRTY_NODES,
 	F2FS_DIRTY_META,
 	F2FS_INMEM_PAGES,
+	F2FS_INMEM_COMMIT_PAGES,
 	F2FS_DIRTY_IMETA,
 	F2FS_WB_CP_DATA,
 	F2FS_WB_DATA,
@@ -1600,7 +1602,21 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 	atomic_inc(&sbi->nr_pages[count_type]);
 
 	if (count_type == F2FS_DIRTY_DATA || count_type == F2FS_INMEM_PAGES ||
-		count_type == F2FS_WB_CP_DATA || count_type == F2FS_WB_DATA)
+		count_type == F2FS_WB_CP_DATA || count_type == F2FS_WB_DATA ||
+		count_type == F2FS_INMEM_COMMIT_PAGES)
+		return;
+
+	set_sbi_flag(sbi, SBI_IS_DIRTY);
+}
+
+static inline void inc_pages_count(struct f2fs_sb_info *sbi, int count_type,
+					int pages)
+{
+	atomic_add(pages, &sbi->nr_pages[count_type]);
+
+	if (count_type == F2FS_DIRTY_DATA || count_type == F2FS_INMEM_PAGES ||
+		count_type == F2FS_WB_CP_DATA || count_type == F2FS_WB_DATA ||
+		count_type == F2FS_INMEM_COMMIT_PAGES)
 		return;
 
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
@@ -1618,6 +1634,12 @@ static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
 	atomic_dec(&sbi->nr_pages[count_type]);
 }
 
+static inline void dec_pages_count(struct f2fs_sb_info *sbi, int count_type,
+					int pages)
+{
+	atomic_sub(pages, &sbi->nr_pages[count_type]);
+}
+
 static inline void inode_dec_dirty_pages(struct inode *inode)
 {
 	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
@@ -2716,7 +2738,7 @@ struct f2fs_stat_info {
 	unsigned long long hit_total, total_ext;
 	int ext_tree, zombie_tree, ext_node;
 	int ndirty_node, ndirty_dent, ndirty_meta, ndirty_data, ndirty_imeta;
-	int inmem_pages;
+	int inmem_pages, inmem_commit_pages;
 	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
 	int nats, dirty_nats, sits, dirty_sits;
 	int free_nids, avail_nids, alloc_nids;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 46dfbca..2ff1bba4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -174,6 +174,8 @@ bool need_SSR(struct f2fs_sb_info *sbi)
 	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
 	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
 	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
+	int inmem_commit_secs = get_blocktype_secs(sbi,
+						F2FS_INMEM_COMMIT_PAGES);
 
 	if (test_opt(sbi, LFS))
 		return false;
@@ -181,7 +183,7 @@ bool need_SSR(struct f2fs_sb_info *sbi)
 		return true;
 
 	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
-						2 * reserved_sections(sbi));
+				inmem_commit_secs + 2 * reserved_sections(sbi));
 }
 
 void register_inmem_page(struct inode *inode, struct page *page)
@@ -210,6 +212,7 @@ void register_inmem_page(struct inode *inode, struct page *page)
 		list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
 	inc_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
+	fi->inmem_blocks++;
 	mutex_unlock(&fi->inmem_lock);
 
 	trace_f2fs_register_inmem_page(page, INMEM);
@@ -221,6 +224,7 @@ static int __revoke_inmem_pages(struct inode *inode,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct inmem_pages *cur, *tmp;
 	int err = 0;
+	struct f2fs_inode_info *fi = F2FS_I(inode);
 
 	list_for_each_entry_safe(cur, tmp, head, list) {
 		struct page *page = cur->page;
@@ -263,6 +267,7 @@ static int __revoke_inmem_pages(struct inode *inode,
 		list_del(&cur->list);
 		kmem_cache_free(inmem_entry_slab, cur);
 		dec_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
+		fi->inmem_blocks--;
 	}
 	return err;
 }
@@ -302,6 +307,10 @@ void drop_inmem_pages(struct inode *inode)
 	if (!list_empty(&fi->inmem_ilist))
 		list_del_init(&fi->inmem_ilist);
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
+	if (fi->inmem_blocks) {
+		f2fs_bug_on(sbi, 1);
+		fi->inmem_blocks = 0;
+	}
 	mutex_unlock(&fi->inmem_lock);
 
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
@@ -326,6 +335,7 @@ void drop_inmem_page(struct inode *inode, struct page *page)
 
 	f2fs_bug_on(sbi, !cur || cur->page != page);
 	list_del(&cur->list);
+	fi->inmem_blocks--;
 	mutex_unlock(&fi->inmem_lock);
 
 	dec_page_count(sbi, F2FS_INMEM_PAGES);
@@ -354,7 +364,7 @@ static int __commit_inmem_pages(struct inode *inode,
 		.io_type = FS_DATA_IO,
 	};
 	pgoff_t last_idx = ULONG_MAX;
-	int err = 0;
+	int err = 0, inmem_blocks = fi->inmem_blocks;
 
 	list_for_each_entry_safe(cur, tmp, &fi->inmem_pages, list) {
 		struct page *page = cur->page;
@@ -390,6 +400,8 @@ static int __commit_inmem_pages(struct inode *inode,
 		}
 		unlock_page(page);
 		list_move_tail(&cur->list, revoke_list);
+		dec_page_count(sbi, F2FS_INMEM_COMMIT_PAGES);
+		inmem_blocks--;
 	}
 
 	if (last_idx != ULONG_MAX)
@@ -397,6 +409,8 @@ static int __commit_inmem_pages(struct inode *inode,
 
 	if (!err)
 		__revoke_inmem_pages(inode, revoke_list, false, false);
+	else
+		dec_pages_count(sbi, F2FS_INMEM_COMMIT_PAGES, inmem_blocks);
 
 	return err;
 }
@@ -409,12 +423,12 @@ int commit_inmem_pages(struct inode *inode)
 	int err;
 
 	INIT_LIST_HEAD(&revoke_list);
+	set_inode_flag(inode, FI_ATOMIC_COMMIT);
+	mutex_lock(&fi->inmem_lock);
+	inc_pages_count(sbi, F2FS_INMEM_COMMIT_PAGES, fi->inmem_blocks);
 	f2fs_balance_fs(sbi, true);
 	f2fs_lock_op(sbi);
 
-	set_inode_flag(inode, FI_ATOMIC_COMMIT);
-
-	mutex_lock(&fi->inmem_lock);
 	err = __commit_inmem_pages(inode, &revoke_list);
 	if (err) {
 		int ret;
@@ -437,11 +451,15 @@ int commit_inmem_pages(struct inode *inode)
 	if (!list_empty(&fi->inmem_ilist))
 		list_del_init(&fi->inmem_ilist);
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
+	if (fi->inmem_blocks) {
+		f2fs_bug_on(sbi, 1);
+		fi->inmem_blocks = 0;
+	}
+	f2fs_unlock_op(sbi);
 	mutex_unlock(&fi->inmem_lock);
 
 	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
 
-	f2fs_unlock_op(sbi);
 	return err;
 }
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 8d93652..f3885de 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -503,12 +503,14 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
 	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
 	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
+	int inmem_commit_secs = get_blocktype_secs(sbi,
+						F2FS_INMEM_COMMIT_PAGES);
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		return false;
 
 	return (free_sections(sbi) + freed) <=
-		(node_secs + 2 * dent_secs + imeta_secs +
+		(node_secs + 2 * dent_secs + imeta_secs + inmem_commit_secs +
 		reserved_sections(sbi) + needed);
 }
 
-- 
1.8.5.2
