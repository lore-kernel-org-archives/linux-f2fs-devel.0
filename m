From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: align direct_io'ed data to section
Date: Tue,  6 Jan 2015 11:20:34 -0800
Message-ID: <1420572034-53758-4-git-send-email-jaegeuk@kernel.org>
References: <1420572034-53758-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y8ZgT-0007G8-Bh
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jan 2015 19:20:53 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y8ZgS-000855-AV for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jan 2015 19:20:53 +0000
In-Reply-To: <1420572034-53758-1-git-send-email-jaegeuk@kernel.org>
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

This patch aligns the start block address of a file for direct io to the f2fs's
section size.

Some flash devices manage an over 4KB-sized page as a write unit, and if the
direct_io'ed data are written but not aligned to that unit, the performance can
be degraded due to the partial page copies.

Thus, since f2fs has a section that is well aligned to FTL units, we can align
the block address to the section size so that f2fs avoids this misalignment.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    |  7 +++++--
 fs/f2fs/f2fs.h    |  3 ++-
 fs/f2fs/segment.c | 27 +++++++++++++++++++--------
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3e0f5f3..b48b355 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -564,6 +564,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	struct f2fs_inode_info *fi = F2FS_I(dn->inode);
 	struct f2fs_summary sum;
 	struct node_info ni;
+	int seg = CURSEG_WARM_DATA;
 	pgoff_t fofs;
 
 	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
@@ -574,8 +575,10 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	get_node_info(sbi, dn->nid, &ni);
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 
-	allocate_data_block(sbi, NULL, NULL_ADDR, &dn->data_blkaddr, &sum,
-							CURSEG_WARM_DATA);
+	if (dn->ofs_in_node == 0 && dn->inode_page == dn->node_page)
+		seg = CURSEG_DIRECT_IO;
+
+	allocate_data_block(sbi, NULL, NULL_ADDR, &dn->data_blkaddr, &sum, seg);
 
 	/* direct IO doesn't use extent cache to maximize the performance */
 	__set_data_blkaddr(dn);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 37e935a..ba30218 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -406,7 +406,8 @@ enum {
 	CURSEG_HOT_NODE,	/* direct node blocks of directory files */
 	CURSEG_WARM_NODE,	/* direct node blocks of normal files */
 	CURSEG_COLD_NODE,	/* indirect node blocks */
-	NO_CHECK_TYPE
+	NO_CHECK_TYPE,
+	CURSEG_DIRECT_IO,	/* to use for the direct IO path */
 };
 
 struct flush_cmd {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8144a30..31c4e57 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1024,18 +1024,22 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 	stat_inc_seg_type(sbi, curseg);
 }
 
+static void __allocate_new_segments(struct f2fs_sb_info *sbi, int type)
+{
+	struct curseg_info *curseg = CURSEG_I(sbi, type);
+	unsigned int old_segno;
+
+	old_segno = curseg->segno;
+	SIT_I(sbi)->s_ops->allocate_segment(sbi, type, true);
+	locate_dirty_segment(sbi, old_segno);
+}
+
 void allocate_new_segments(struct f2fs_sb_info *sbi)
 {
-	struct curseg_info *curseg;
-	unsigned int old_curseg;
 	int i;
 
-	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
-		curseg = CURSEG_I(sbi, i);
-		old_curseg = curseg->segno;
-		SIT_I(sbi)->s_ops->allocate_segment(sbi, i, true);
-		locate_dirty_segment(sbi, old_curseg);
-	}
+	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++)
+		__allocate_new_segments(sbi, i);
 }
 
 static const struct segment_allocation default_salloc_ops = {
@@ -1148,11 +1152,18 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg;
+	bool direct_io = (type == CURSEG_DIRECT_IO);
+
+	type = direct_io ? CURSEG_WARM_DATA : type;
 
 	curseg = CURSEG_I(sbi, type);
 
 	mutex_lock(&curseg->curseg_mutex);
 
+	/* direct_io'ed data is aligned to the segment for better performance */
+	if (direct_io && curseg->next_blkoff)
+		__allocate_new_segments(sbi, type);
+
 	*new_blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
 	/*
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
