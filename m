From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: use rw_semaphore to protect SIT cache
Date: Mon, 30 Oct 2017 17:49:53 +0800
Message-ID: <20171030094954.80691-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e96iV-0003yR-Sy
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Oct 2017 09:50:47 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e96iT-0005qZ-Jd
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Oct 2017 09:50:47 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

There are some cases user didn't update SIT cache under this lock,
so let's use rw_semaphore instead of mutex to enhance concurrently
accessing.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c      | 12 ++++++------
 fs/f2fs/segment.c | 34 +++++++++++++++++++---------------
 fs/f2fs/segment.h |  2 +-
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a2e5278b6c86..7af91c423456 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -456,10 +456,10 @@ static int check_valid_map(struct f2fs_sb_info *sbi,
 	struct seg_entry *sentry;
 	int ret;
 
-	mutex_lock(&sit_i->sentry_lock);
+	down_read(&sit_i->sentry_lock);
 	sentry = get_seg_entry(sbi, segno);
 	ret = f2fs_test_bit(offset, sentry->cur_valid_map);
-	mutex_unlock(&sit_i->sentry_lock);
+	up_read(&sit_i->sentry_lock);
 	return ret;
 }
 
@@ -893,10 +893,10 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
 	struct sit_info *sit_i = SIT_I(sbi);
 	int ret;
 
-	mutex_lock(&sit_i->sentry_lock);
+	down_write(&sit_i->sentry_lock);
 	ret = DIRTY_I(sbi)->v_ops->get_victim(sbi, victim, gc_type,
 					      NO_CHECK_TYPE, LFS);
-	mutex_unlock(&sit_i->sentry_lock);
+	up_write(&sit_i->sentry_lock);
 	return ret;
 }
 
@@ -944,8 +944,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		/*
 		 * this is to avoid deadlock:
 		 * - lock_page(sum_page)         - f2fs_replace_block
-		 *  - check_valid_map()            - mutex_lock(sentry_lock)
-		 *   - mutex_lock(sentry_lock)     - change_curseg()
+		 *  - check_valid_map()            - down_write(sentry_lock)
+		 *   - down_read(sentry_lock)     - change_curseg()
 		 *                                  - lock_page(sum_page)
 		 */
 		if (type == SUM_TYPE_NODE)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 873da0e4a75a..f4ffcfc918f7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1911,14 +1911,14 @@ void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
 		return;
 
 	/* add it into sit main buffer */
-	mutex_lock(&sit_i->sentry_lock);
+	down_write(&sit_i->sentry_lock);
 
 	update_sit_entry(sbi, addr, -1);
 
 	/* add it into dirty seglist */
 	locate_dirty_segment(sbi, segno);
 
-	mutex_unlock(&sit_i->sentry_lock);
+	up_write(&sit_i->sentry_lock);
 }
 
 bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
@@ -1931,7 +1931,7 @@ bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
 	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR)
 		return true;
 
-	mutex_lock(&sit_i->sentry_lock);
+	down_read(&sit_i->sentry_lock);
 
 	segno = GET_SEGNO(sbi, blkaddr);
 	se = get_seg_entry(sbi, segno);
@@ -1940,7 +1940,7 @@ bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
 	if (f2fs_test_bit(offset, se->ckpt_valid_map))
 		is_cp = true;
 
-	mutex_unlock(&sit_i->sentry_lock);
+	up_read(&sit_i->sentry_lock);
 
 	return is_cp;
 }
@@ -2336,12 +2336,16 @@ void allocate_new_segments(struct f2fs_sb_info *sbi)
 	unsigned int old_segno;
 	int i;
 
+	down_write(&SIT_I(sbi)->sentry_lock);
+
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
 		curseg = CURSEG_I(sbi, i);
 		old_segno = curseg->segno;
 		SIT_I(sbi)->s_ops->allocate_segment(sbi, i, true);
 		locate_dirty_segment(sbi, old_segno);
 	}
+
+	up_write(&SIT_I(sbi)->sentry_lock);
 }
 
 static const struct segment_allocation default_salloc_ops = {
@@ -2353,14 +2357,14 @@ bool exist_trim_candidates(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	__u64 trim_start = cpc->trim_start;
 	bool has_candidate = false;
 
-	mutex_lock(&SIT_I(sbi)->sentry_lock);
+	down_write(&SIT_I(sbi)->sentry_lock);
 	for (; cpc->trim_start <= cpc->trim_end; cpc->trim_start++) {
 		if (add_discard_addrs(sbi, cpc, true)) {
 			has_candidate = true;
 			break;
 		}
 	}
-	mutex_unlock(&SIT_I(sbi)->sentry_lock);
+	up_write(&SIT_I(sbi)->sentry_lock);
 
 	cpc->trim_start = trim_start;
 	return has_candidate;
@@ -2520,7 +2524,7 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 
 	mutex_lock(&curseg->curseg_mutex);
-	mutex_lock(&sit_i->sentry_lock);
+	down_write(&sit_i->sentry_lock);
 
 	*new_blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
@@ -2554,7 +2558,7 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
 
-	mutex_unlock(&sit_i->sentry_lock);
+	up_write(&sit_i->sentry_lock);
 
 	if (page && IS_NODESEG(type)) {
 		fill_node_footer_blkaddr(page, NEXT_FREE_BLKADDR(sbi, curseg));
@@ -2712,7 +2716,7 @@ void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	curseg = CURSEG_I(sbi, type);
 
 	mutex_lock(&curseg->curseg_mutex);
-	mutex_lock(&sit_i->sentry_lock);
+	down_write(&sit_i->sentry_lock);
 
 	old_cursegno = curseg->segno;
 	old_blkoff = curseg->next_blkoff;
@@ -2744,7 +2748,7 @@ void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		curseg->next_blkoff = old_blkoff;
 	}
 
-	mutex_unlock(&sit_i->sentry_lock);
+	up_write(&sit_i->sentry_lock);
 	mutex_unlock(&curseg->curseg_mutex);
 }
 
@@ -3199,7 +3203,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	bool to_journal = true;
 	struct seg_entry *se;
 
-	mutex_lock(&sit_i->sentry_lock);
+	down_write(&sit_i->sentry_lock);
 
 	if (!sit_i->dirty_sentries)
 		goto out;
@@ -3293,7 +3297,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 		cpc->trim_start = trim_start;
 	}
-	mutex_unlock(&sit_i->sentry_lock);
+	up_write(&sit_i->sentry_lock);
 
 	set_prefree_as_free_segments(sbi);
 }
@@ -3386,7 +3390,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK;
 	sit_i->elapsed_time = le64_to_cpu(sbi->ckpt->elapsed_time);
 	sit_i->mounted_time = ktime_get_real_seconds();
-	mutex_init(&sit_i->sentry_lock);
+	init_rwsem(&sit_i->sentry_lock);
 	return 0;
 }
 
@@ -3627,7 +3631,7 @@ static void init_min_max_mtime(struct f2fs_sb_info *sbi)
 	struct sit_info *sit_i = SIT_I(sbi);
 	unsigned int segno;
 
-	mutex_lock(&sit_i->sentry_lock);
+	down_write(&sit_i->sentry_lock);
 
 	sit_i->min_mtime = LLONG_MAX;
 
@@ -3644,7 +3648,7 @@ static void init_min_max_mtime(struct f2fs_sb_info *sbi)
 			sit_i->min_mtime = mtime;
 	}
 	sit_i->max_mtime = get_mtime(sbi);
-	mutex_unlock(&sit_i->sentry_lock);
+	up_write(&sit_i->sentry_lock);
 }
 
 int build_segment_manager(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 8d93652d5b6a..245acb34cab5 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -231,7 +231,7 @@ struct sit_info {
 	unsigned long *dirty_sentries_bitmap;	/* bitmap for dirty sentries */
 	unsigned int dirty_sentries;		/* # of dirty sentries */
 	unsigned int sents_per_block;		/* # of SIT entries per block */
-	struct mutex sentry_lock;		/* to protect SIT cache */
+	struct rw_semaphore sentry_lock;	/* to protect SIT cache */
 	struct seg_entry *sentries;		/* SIT segment-level cache */
 	struct sec_entry *sec_entries;		/* SIT section-level cache */
 
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
