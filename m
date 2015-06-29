From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 10/12] f2fs: shrink extent_cache entries
Date: Mon, 29 Jun 2015 11:39:34 -0700
Message-ID: <1435603176-63219-10-git-send-email-jaegeuk@kernel.org>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Z9dyh-0004Dn-LT
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:23 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z9dyg-0005BG-Ny for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:23 +0000
In-Reply-To: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
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

This patch registers shrinking extent_caches.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c     | 19 +++++++++++--------
 fs/f2fs/f2fs.h     |  2 +-
 fs/f2fs/segment.c  |  3 ++-
 fs/f2fs/shrinker.c | 14 +++++++++++++-
 4 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 676e7b9..18bd0ac 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -767,7 +767,7 @@ out:
 		update_inode_page(inode);
 }
 
-void f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
+unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 {
 	struct extent_tree *treevec[EXT_TREE_VEC_SIZE];
 	struct extent_node *en, *tmp;
@@ -778,10 +778,7 @@ void f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 	unsigned int node_cnt = 0, tree_cnt = 0;
 
 	if (!test_opt(sbi, EXTENT_CACHE))
-		return;
-
-	if (available_free_memory(sbi, EXTENT_CACHE))
-		return;
+		return 0;
 
 	spin_lock(&sbi->extent_lock);
 	list_for_each_entry_safe(en, tmp, &sbi->extent_list, list) {
@@ -791,7 +788,9 @@ void f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 	}
 	spin_unlock(&sbi->extent_lock);
 
-	down_read(&sbi->extent_tree_lock);
+	if (!down_read_trylock(&sbi->extent_tree_lock))
+		goto out;
+
 	while ((found = radix_tree_gang_lookup(&sbi->extent_tree_root,
 				(void **)treevec, ino, EXT_TREE_VEC_SIZE))) {
 		unsigned i;
@@ -809,7 +808,9 @@ void f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 	}
 	up_read(&sbi->extent_tree_lock);
 
-	down_write(&sbi->extent_tree_lock);
+	if (!down_write_trylock(&sbi->extent_tree_lock))
+		goto out;
+
 	radix_tree_for_each_slot(slot, &sbi->extent_tree_root, &iter,
 							F2FS_ROOT_INO(sbi)) {
 		struct extent_tree *et = (struct extent_tree *)*slot;
@@ -822,8 +823,10 @@ void f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 		}
 	}
 	up_write(&sbi->extent_tree_lock);
-
+out:
 	trace_f2fs_shrink_extent_tree(sbi, node_cnt, tree_cnt);
+
+	return node_cnt + tree_cnt;
 }
 
 void f2fs_destroy_extent_tree(struct inode *inode)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e82af8c..eeef3eb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1754,7 +1754,7 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *);
 void set_data_blkaddr(struct dnode_of_data *);
 int reserve_new_block(struct dnode_of_data *);
 int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
-void f2fs_shrink_extent_tree(struct f2fs_sb_info *, int);
+unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *, int);
 void f2fs_destroy_extent_tree(struct inode *);
 void f2fs_init_extent_cache(struct inode *, struct f2fs_extent *);
 void f2fs_update_extent_cache(struct dnode_of_data *);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index dec3afb..08b2ebc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -303,7 +303,8 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi)
 void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 {
 	/* try to shrink extent cache when there is no enough memory */
-	f2fs_shrink_extent_tree(sbi, EXTENT_CACHE_SHRINK_NUMBER);
+	if (!available_free_memory(sbi, EXTENT_CACHE))
+		f2fs_shrink_extent_tree(sbi, EXTENT_CACHE_SHRINK_NUMBER);
 
 	/* check the # of cached NAT entries */
 	if (!available_free_memory(sbi, NAT_ENTRIES))
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 3350ac3..a7d7a7c 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -23,6 +23,11 @@ static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
 	return NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
 }
 
+static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi)
+{
+	return sbi->total_ext_tree + atomic_read(&sbi->total_ext_node);
+}
+
 unsigned long f2fs_shrink_count(struct shrinker *shrink,
 				struct shrink_control *sc)
 {
@@ -42,6 +47,9 @@ unsigned long f2fs_shrink_count(struct shrinker *shrink,
 		}
 		spin_unlock(&f2fs_list_lock);
 
+		/* count extent cache entries */
+		count += __count_extent_cache(sbi);
+
 		/* shrink clean nat cache entries */
 		count += __count_nat_entries(sbi);
 
@@ -82,8 +90,12 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
 
 		sbi->shrinker_run_no = run_no;
 
+		/* shrink extent cache entries */
+		freed += f2fs_shrink_extent_tree(sbi, nr >> 1);
+
 		/* shrink clean nat cache entries */
-		freed += try_to_free_nats(sbi, nr);
+		if (freed < nr)
+			freed += try_to_free_nats(sbi, nr - freed);
 
 		spin_lock(&f2fs_list_lock);
 		p = p->next;
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
