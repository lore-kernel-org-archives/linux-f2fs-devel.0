From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/6] f2fs: use percpu_rw_semaphore
Date: Wed,  6 Jul 2016 09:06:31 -0700
Message-ID: <20160706160632.78272-5-jaegeuk@kernel.org>
References: <20160706160632.78272-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bKpLd-0004sK-7z
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jul 2016 16:06:49 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bKpLb-0000nk-2f
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jul 2016 16:06:49 +0000
In-Reply-To: <20160706160632.78272-1-jaegeuk@kernel.org>
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

This patch replaces rw_semaphore with percpu_rw_semaphore for:
sbi->cp_rwsem
nm_i->nat_tree_lock

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 12 ++++++------
 fs/f2fs/node.c  | 47 ++++++++++++++++++++++++-----------------------
 fs/f2fs/super.c |  6 +++++-
 3 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a51f230..2f59888 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -547,7 +547,7 @@ struct f2fs_nm_info {
 	/* NAT cache management */
 	struct radix_tree_root nat_root;/* root of the nat entry cache */
 	struct radix_tree_root nat_set_root;/* root of the nat set cache */
-	struct rw_semaphore nat_tree_lock;	/* protect nat_tree_lock */
+	struct percpu_rw_semaphore nat_tree_lock;	/* protect nat_tree_lock */
 	struct list_head nat_entries;	/* cached nat entry list (clean) */
 	unsigned int nat_cnt;		/* the # of cached nat entries */
 	unsigned int dirty_nat_cnt;	/* total num of nat entries in set */
@@ -795,7 +795,7 @@ struct f2fs_sb_info {
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
 	struct inode *meta_inode;		/* cache meta blocks */
 	struct mutex cp_mutex;			/* checkpoint procedure lock */
-	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
+	struct percpu_rw_semaphore cp_rwsem;		/* blocking FS operations */
 	struct rw_semaphore node_write;		/* locking node writes */
 	wait_queue_head_t cp_wait;
 	unsigned long last_time[MAX_TIME];	/* to store time in jiffies */
@@ -1082,22 +1082,22 @@ static inline void clear_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
 
 static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
 {
-	down_read(&sbi->cp_rwsem);
+	percpu_down_read(&sbi->cp_rwsem);
 }
 
 static inline void f2fs_unlock_op(struct f2fs_sb_info *sbi)
 {
-	up_read(&sbi->cp_rwsem);
+	percpu_up_read(&sbi->cp_rwsem);
 }
 
 static inline void f2fs_lock_all(struct f2fs_sb_info *sbi)
 {
-	down_write(&sbi->cp_rwsem);
+	percpu_down_write(&sbi->cp_rwsem);
 }
 
 static inline void f2fs_unlock_all(struct f2fs_sb_info *sbi)
 {
-	up_write(&sbi->cp_rwsem);
+	percpu_up_write(&sbi->cp_rwsem);
 }
 
 static inline int __get_cp_reason(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9d994b9..b841c43 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -206,14 +206,14 @@ int need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid)
 	struct nat_entry *e;
 	bool need = false;
 
-	down_read(&nm_i->nat_tree_lock);
+	percpu_down_read(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, nid);
 	if (e) {
 		if (!get_nat_flag(e, IS_CHECKPOINTED) &&
 				!get_nat_flag(e, HAS_FSYNCED_INODE))
 			need = true;
 	}
-	up_read(&nm_i->nat_tree_lock);
+	percpu_up_read(&nm_i->nat_tree_lock);
 	return need;
 }
 
@@ -223,11 +223,11 @@ bool is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid)
 	struct nat_entry *e;
 	bool is_cp = true;
 
-	down_read(&nm_i->nat_tree_lock);
+	percpu_down_read(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, nid);
 	if (e && !get_nat_flag(e, IS_CHECKPOINTED))
 		is_cp = false;
-	up_read(&nm_i->nat_tree_lock);
+	percpu_up_read(&nm_i->nat_tree_lock);
 	return is_cp;
 }
 
@@ -237,13 +237,13 @@ bool need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino)
 	struct nat_entry *e;
 	bool need_update = true;
 
-	down_read(&nm_i->nat_tree_lock);
+	percpu_down_read(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, ino);
 	if (e && get_nat_flag(e, HAS_LAST_FSYNC) &&
 			(get_nat_flag(e, IS_CHECKPOINTED) ||
 			 get_nat_flag(e, HAS_FSYNCED_INODE)))
 		need_update = false;
-	up_read(&nm_i->nat_tree_lock);
+	percpu_up_read(&nm_i->nat_tree_lock);
 	return need_update;
 }
 
@@ -284,7 +284,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
 
-	down_write(&nm_i->nat_tree_lock);
+	percpu_down_write(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, ni->nid);
 	if (!e) {
 		e = grab_nat_entry(nm_i, ni->nid);
@@ -334,7 +334,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 			set_nat_flag(e, HAS_FSYNCED_INODE, true);
 		set_nat_flag(e, HAS_LAST_FSYNC, fsync_done);
 	}
-	up_write(&nm_i->nat_tree_lock);
+	percpu_up_write(&nm_i->nat_tree_lock);
 }
 
 int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
@@ -342,8 +342,7 @@ int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	int nr = nr_shrink;
 
-	if (!down_write_trylock(&nm_i->nat_tree_lock))
-		return 0;
+	percpu_down_write(&nm_i->nat_tree_lock);
 
 	while (nr_shrink && !list_empty(&nm_i->nat_entries)) {
 		struct nat_entry *ne;
@@ -352,7 +351,7 @@ int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
 		__del_from_nat_cache(nm_i, ne);
 		nr_shrink--;
 	}
-	up_write(&nm_i->nat_tree_lock);
+	percpu_up_write(&nm_i->nat_tree_lock);
 	return nr - nr_shrink;
 }
 
@@ -374,13 +373,13 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 	ni->nid = nid;
 
 	/* Check nat cache */
-	down_read(&nm_i->nat_tree_lock);
+	percpu_down_read(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, nid);
 	if (e) {
 		ni->ino = nat_get_ino(e);
 		ni->blk_addr = nat_get_blkaddr(e);
 		ni->version = nat_get_version(e);
-		up_read(&nm_i->nat_tree_lock);
+		percpu_up_read(&nm_i->nat_tree_lock);
 		return;
 	}
 
@@ -404,11 +403,11 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 	node_info_from_raw_nat(ni, &ne);
 	f2fs_put_page(page, 1);
 cache:
-	up_read(&nm_i->nat_tree_lock);
+	percpu_up_read(&nm_i->nat_tree_lock);
 	/* cache nat entry */
-	down_write(&nm_i->nat_tree_lock);
+	percpu_down_write(&nm_i->nat_tree_lock);
 	cache_nat_entry(sbi, nid, &ne);
-	up_write(&nm_i->nat_tree_lock);
+	percpu_up_write(&nm_i->nat_tree_lock);
 }
 
 /*
@@ -1783,7 +1782,7 @@ void build_free_nids(struct f2fs_sb_info *sbi)
 	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
 							META_NAT, true);
 
-	down_read(&nm_i->nat_tree_lock);
+	percpu_down_read(&nm_i->nat_tree_lock);
 
 	while (1) {
 		struct page *page = get_current_nat_page(sbi, nid);
@@ -1815,7 +1814,7 @@ void build_free_nids(struct f2fs_sb_info *sbi)
 			remove_free_nid(nm_i, nid);
 	}
 	up_read(&curseg->journal_rwsem);
-	up_read(&nm_i->nat_tree_lock);
+	percpu_up_read(&nm_i->nat_tree_lock);
 
 	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
 					nm_i->ra_nid_pages, META_NAT, false);
@@ -2204,7 +2203,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
 	if (!nm_i->dirty_nat_cnt)
 		return;
 
-	down_write(&nm_i->nat_tree_lock);
+	percpu_down_write(&nm_i->nat_tree_lock);
 
 	/*
 	 * if there are no enough space in journal to store dirty nat
@@ -2227,7 +2226,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
 	list_for_each_entry_safe(set, tmp, &sets, set_list)
 		__flush_nat_entry_set(sbi, set);
 
-	up_write(&nm_i->nat_tree_lock);
+	percpu_up_write(&nm_i->nat_tree_lock);
 
 	f2fs_bug_on(sbi, nm_i->dirty_nat_cnt);
 }
@@ -2263,7 +2262,8 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 
 	mutex_init(&nm_i->build_lock);
 	spin_lock_init(&nm_i->free_nid_list_lock);
-	init_rwsem(&nm_i->nat_tree_lock);
+	if (percpu_init_rwsem(&nm_i->nat_tree_lock))
+		return -ENOMEM;
 
 	nm_i->next_scan_nid = le32_to_cpu(sbi->ckpt->next_free_nid);
 	nm_i->bitmap_size = __bitmap_size(sbi, NAT_BITMAP);
@@ -2320,7 +2320,7 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 	spin_unlock(&nm_i->free_nid_list_lock);
 
 	/* destroy nat cache */
-	down_write(&nm_i->nat_tree_lock);
+	percpu_down_write(&nm_i->nat_tree_lock);
 	while ((found = __gang_lookup_nat_cache(nm_i,
 					nid, NATVEC_SIZE, natvec))) {
 		unsigned idx;
@@ -2345,8 +2345,9 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 			kmem_cache_free(nat_entry_set_slab, setvec[idx]);
 		}
 	}
-	up_write(&nm_i->nat_tree_lock);
+	percpu_up_write(&nm_i->nat_tree_lock);
 
+	percpu_free_rwsem(&nm_i->nat_tree_lock);
 	kfree(nm_i->nat_bitmap);
 	sbi->nm_info = NULL;
 	kfree(nm_i);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e0a975d..2bac917 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -695,6 +695,8 @@ static void destroy_percpu_info(struct f2fs_sb_info *sbi)
 		percpu_counter_destroy(&sbi->nr_pages[i]);
 	percpu_counter_destroy(&sbi->alloc_valid_block_count);
 	percpu_counter_destroy(&sbi->total_valid_inode_count);
+
+	percpu_free_rwsem(&sbi->cp_rwsem);
 }
 
 static void f2fs_put_super(struct super_block *sb)
@@ -1471,6 +1473,9 @@ static int init_percpu_info(struct f2fs_sb_info *sbi)
 {
 	int i, err;
 
+	if (percpu_init_rwsem(&sbi->cp_rwsem))
+		return -ENOMEM;
+
 	for (i = 0; i < NR_COUNT_TYPE; i++) {
 		err = percpu_counter_init(&sbi->nr_pages[i], 0, GFP_KERNEL);
 		if (err)
@@ -1671,7 +1676,6 @@ try_onemore:
 		sbi->write_io[i].bio = NULL;
 	}
 
-	init_rwsem(&sbi->cp_rwsem);
 	init_waitqueue_head(&sbi->cp_wait);
 	init_sb_info(sbi);
 
-- 
2.8.3


------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
