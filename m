From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: revert segment allocation for direct IO
Date: Fri, 11 Nov 2016 13:03:03 -0800
Message-ID: <20161111210304.4736-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c5Iyg-0001cL-Ow
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Nov 2016 21:03:14 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c5Iyf-00049u-Mf
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Nov 2016 21:03:14 +0000
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

Now we don't need to be too much careful about storage alignment for dio, since
its speed becomes quite fast and we'd better avoid any misalignment first.

Revert: 38aa0889b250 (f2fs: align direct_io'ed data to section)

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    |  6 +-----
 fs/f2fs/f2fs.h    |  1 -
 fs/f2fs/segment.c | 36 +++++++++---------------------------
 3 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 47ded0c..ca53da5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -588,7 +588,6 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct f2fs_summary sum;
 	struct node_info ni;
-	int seg = CURSEG_WARM_DATA;
 	pgoff_t fofs;
 	blkcnt_t count = 1;
 
@@ -606,11 +605,8 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	get_node_info(sbi, dn->nid, &ni);
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 
-	if (dn->ofs_in_node == 0 && dn->inode_page == dn->node_page)
-		seg = CURSEG_DIRECT_IO;
-
 	allocate_data_block(sbi, NULL, dn->data_blkaddr, &dn->data_blkaddr,
-								&sum, seg);
+						&sum, CURSEG_WARM_DATA);
 	set_data_blkaddr(dn);
 
 	/* update i_size */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a6e2ede..0496e82 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -591,7 +591,6 @@ enum {
 	CURSEG_WARM_NODE,	/* direct node blocks of normal files */
 	CURSEG_COLD_NODE,	/* indirect node blocks */
 	NO_CHECK_TYPE,
-	CURSEG_DIRECT_IO,	/* to use for the direct IO path */
 };
 
 struct flush_cmd {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7fb7dd3..4cc589a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1346,25 +1346,21 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 	stat_inc_seg_type(sbi, curseg);
 }
 
-static void __allocate_new_segments(struct f2fs_sb_info *sbi, int type)
-{
-	struct curseg_info *curseg = CURSEG_I(sbi, type);
-	unsigned int old_segno;
-
-	old_segno = curseg->segno;
-	SIT_I(sbi)->s_ops->allocate_segment(sbi, type, true);
-	locate_dirty_segment(sbi, old_segno);
-}
-
 void allocate_new_segments(struct f2fs_sb_info *sbi)
 {
+	struct curseg_info *curseg;
+	unsigned int old_segno;
 	int i;
 
 	if (test_opt(sbi, LFS))
 		return;
 
-	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++)
-		__allocate_new_segments(sbi, i);
+	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
+		curseg = CURSEG_I(sbi, i);
+		old_segno = curseg->segno;
+		SIT_I(sbi)->s_ops->allocate_segment(sbi, i, true);
+		locate_dirty_segment(sbi, old_segno);
+	}
 }
 
 static const struct segment_allocation default_salloc_ops = {
@@ -1498,25 +1494,11 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		struct f2fs_summary *sum, int type)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	struct curseg_info *curseg;
-	bool direct_io = (type == CURSEG_DIRECT_IO);
-
-	if (direct_io) {
-		if (sbi->active_logs <= 4)
-			type = CURSEG_HOT_DATA;
-		else
-			type = CURSEG_WARM_DATA;
-	}
-	curseg = CURSEG_I(sbi, type);
+	struct curseg_info *curseg = CURSEG_I(sbi, type);
 
 	mutex_lock(&curseg->curseg_mutex);
 	mutex_lock(&sit_i->sentry_lock);
 
-	/* direct_io'ed data is aligned to the segment for better performance */
-	if (direct_io && curseg->next_blkoff &&
-				!has_not_enough_free_secs(sbi, 0, 0))
-		__allocate_new_segments(sbi, type);
-
 	*new_blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
 	/*
-- 
2.8.3


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
