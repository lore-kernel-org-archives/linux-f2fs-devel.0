From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: check free_sections for defragmentation
Date: Wed, 7 Sep 2016 17:18:55 -0700
Message-ID: <20160908001855.GB14665@jaegeuk>
References: <20160901204605.21448-1-jaegeuk@kernel.org>
 <33559c8d-fa39-219c-fff5-18e5586957e7@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <33559c8d-fa39-219c-fff5-18e5586957e7@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Sep 07, 2016 at 09:35:30PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2016/9/2 4:46, Jaegeuk Kim wrote:
> > Fix wrong condition check for defragmentation of a file.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 37c24be..a8aa6fd 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -2037,7 +2037,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
> >  	 * avoid defragment running in SSR mode when free section are allocated
> >  	 * intensively
> >  	 */
> > -	if (has_not_enough_free_secs(sbi, sec_num)) {
> > +	if (free_sections(sbi) <= sec_num) {
> 
> Why don't we check dirty dentry/node/imeta blocks here? they will be generated
> at any time after f2fs_balance_fs. So, isn't original condition more strict than
> new one?

I just wanted to fix this without any multiple changes.
We can do like this as well. :)

>From 6526f0377fd6616ae65b854fbd614e8ed9598fdd Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 1 Sep 2016 12:02:51 -0700
Subject: [PATCH] f2fs: check free_sections for defragmentation

Fix wrong condition check for defragmentation of a file.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    |  4 ++--
 fs/f2fs/file.c    |  2 +-
 fs/f2fs/gc.c      | 10 +++++-----
 fs/f2fs/segment.c |  6 +++---
 fs/f2fs/segment.h |  7 ++++---
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9bfca4b..3e0ef2d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1298,7 +1298,7 @@ write:
 
 	if (!wbc->for_reclaim)
 		need_balance_fs = true;
-	else if (has_not_enough_free_secs(sbi, 0))
+	else if (has_not_enough_free_secs(sbi, 0, 0))
 		goto redirty_out;
 
 	err = -EAGAIN;
@@ -1630,7 +1630,7 @@ repeat:
 	if (err)
 		goto fail;
 
-	if (need_balance && has_not_enough_free_secs(sbi, 0)) {
+	if (need_balance && has_not_enough_free_secs(sbi, 0, 0)) {
 		unlock_page(page);
 		f2fs_balance_fs(sbi, true);
 		lock_page(page);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 47f6193..d5f60ad 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2037,7 +2037,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	 * avoid defragment running in SSR mode when free section are allocated
 	 * intensively
 	 */
-	if (has_not_enough_free_secs(sbi, sec_num)) {
+	if (has_not_enough_free_secs(sbi, 0, sec_num)) {
 		err = -EAGAIN;
 		goto out;
 	}
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index cdc44a6..24acbbb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -439,7 +439,7 @@ next_step:
 		struct node_info ni;
 
 		/* stop BG_GC if there is not enough free sections. */
-		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0))
+		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0))
 			return;
 
 		if (check_valid_map(sbi, segno, off) == 0)
@@ -715,7 +715,7 @@ next_step:
 		nid_t nid = le32_to_cpu(entry->nid);
 
 		/* stop BG_GC if there is not enough free sections. */
-		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0))
+		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0))
 			return;
 
 		if (check_valid_map(sbi, segno, off) == 0)
@@ -916,7 +916,7 @@ gc_more:
 		goto stop;
 	}
 
-	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, sec_freed)) {
+	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, sec_freed, 0)) {
 		gc_type = FG_GC;
 		/*
 		 * If there is no victim and no prefree segment but still not
@@ -927,7 +927,7 @@ gc_more:
 						prefree_segments(sbi)) {
 			write_checkpoint(sbi, &cpc);
 			segno = NULL_SEGNO;
-		} else if (has_not_enough_free_secs(sbi, 0)) {
+		} else if (has_not_enough_free_secs(sbi, 0, 0)) {
 			write_checkpoint(sbi, &cpc);
 		}
 	}
@@ -944,7 +944,7 @@ gc_more:
 		sbi->cur_victim_sec = NULL_SEGNO;
 
 	if (!sync) {
-		if (has_not_enough_free_secs(sbi, sec_freed))
+		if (has_not_enough_free_secs(sbi, sec_freed, 0))
 			goto gc_more;
 
 		if (gc_type == FG_GC)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3ff4621..101b58f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -356,7 +356,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	 * We should do GC or end up with checkpoint, if there are so many dirty
 	 * dir/node pages without enough free segments.
 	 */
-	if (has_not_enough_free_secs(sbi, 0)) {
+	if (has_not_enough_free_secs(sbi, 0, 0)) {
 		mutex_lock(&sbi->gc_mutex);
 		f2fs_gc(sbi, false);
 	}
@@ -1278,7 +1278,7 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
 
-	if (IS_NODESEG(type) || !has_not_enough_free_secs(sbi, 0))
+	if (IS_NODESEG(type) || !has_not_enough_free_secs(sbi, 0, 0))
 		return v_ops->get_victim(sbi,
 				&(curseg)->next_segno, BG_GC, type, SSR);
 
@@ -1477,7 +1477,7 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 
 	/* direct_io'ed data is aligned to the segment for better performance */
 	if (direct_io && curseg->next_blkoff &&
-				!has_not_enough_free_secs(sbi, 0))
+				!has_not_enough_free_secs(sbi, 0, 0))
 		__allocate_new_segments(sbi, type);
 
 	*new_blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 87156c7..fecb856 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -479,7 +479,8 @@ static inline bool need_SSR(struct f2fs_sb_info *sbi)
 						reserved_sections(sbi) + 1);
 }
 
-static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi, int freed)
+static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
+					int freed, int needed)
 {
 	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
 	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
@@ -489,8 +490,8 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi, int freed)
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		return false;
 
-	return (free_sections(sbi) + freed) <= (node_secs + 2 * dent_secs +
-						reserved_sections(sbi));
+	return (free_sections(sbi) + freed) <=
+		(node_secs + 2 * dent_secs + reserved_sections(sbi) + needed);
 }
 
 static inline bool excess_prefree_segs(struct f2fs_sb_info *sbi)
-- 
2.8.3

