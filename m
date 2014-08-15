From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: remove rewrite_node_page
Date: Fri, 15 Aug 2014 15:03:49 -0700
Message-ID: <1408140229-54949-4-git-send-email-jaegeuk@kernel.org>
References: <1408140229-54949-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XIPaV-0003bN-UF
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Aug 2014 22:03:08 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XIPaV-0002O8-2C for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Aug 2014 22:03:07 +0000
In-Reply-To: <1408140229-54949-1-git-send-email-jaegeuk@kernel.org>
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

I think we need to let the dirty node pages remain in the page cache instead
of rewriting them in their places.
So, after done with successful recovery, write_checkpoint will flush all of them
through the normal write path.
Through this, we can avoid potential error cases in terms of block allocation.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h     |  4 ----
 fs/f2fs/node.c     |  9 ---------
 fs/f2fs/recovery.c |  2 --
 fs/f2fs/segment.c  | 49 -------------------------------------------------
 4 files changed, 64 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7f976c1..e921242 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1207,8 +1207,6 @@ int sync_node_pages(struct f2fs_sb_info *, nid_t, struct writeback_control *);
 bool alloc_nid(struct f2fs_sb_info *, nid_t *);
 void alloc_nid_done(struct f2fs_sb_info *, nid_t);
 void alloc_nid_failed(struct f2fs_sb_info *, nid_t);
-void recover_node_page(struct f2fs_sb_info *, struct page *,
-		struct f2fs_summary *, struct node_info *, block_t);
 void recover_inline_xattr(struct inode *, struct page *);
 void recover_xattr_data(struct inode *, struct page *, block_t);
 int recover_inode_page(struct f2fs_sb_info *, struct page *);
@@ -1243,8 +1241,6 @@ void write_data_page(struct page *, struct dnode_of_data *, block_t *,
 void rewrite_data_page(struct page *, block_t, struct f2fs_io_info *);
 void recover_data_page(struct f2fs_sb_info *, struct page *,
 				struct f2fs_summary *, block_t, block_t);
-void rewrite_node_page(struct f2fs_sb_info *, struct page *,
-				struct f2fs_summary *, block_t, block_t);
 void allocate_data_block(struct f2fs_sb_info *, struct page *,
 		block_t, block_t *, struct f2fs_summary *, int);
 void f2fs_wait_on_page_writeback(struct page *, enum page_type);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d2f7842..b4d9640 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1545,15 +1545,6 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 		kmem_cache_free(free_nid_slab, i);
 }
 
-void recover_node_page(struct f2fs_sb_info *sbi, struct page *page,
-		struct f2fs_summary *sum, struct node_info *ni,
-		block_t new_blkaddr)
-{
-	rewrite_node_page(sbi, page, sum, ni->blk_addr, new_blkaddr);
-	set_node_addr(sbi, ni, new_blkaddr, false);
-	clear_node_page_dirty(page);
-}
-
 void recover_inline_xattr(struct inode *inode, struct page *page)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index d36ef35..756c41c 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -371,8 +371,6 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	fill_node_footer(dn.node_page, dn.nid, ni.ino,
 					ofs_of_node(page), false);
 	set_page_dirty(dn.node_page);
-
-	recover_node_page(sbi, dn.node_page, &sum, &ni, blkaddr);
 err:
 	f2fs_put_dnode(&dn);
 	f2fs_unlock_op(sbi);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 31b630e..0aa337c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1103,55 +1103,6 @@ void recover_data_page(struct f2fs_sb_info *sbi,
 	mutex_unlock(&curseg->curseg_mutex);
 }
 
-void rewrite_node_page(struct f2fs_sb_info *sbi,
-			struct page *page, struct f2fs_summary *sum,
-			block_t old_blkaddr, block_t new_blkaddr)
-{
-	struct sit_info *sit_i = SIT_I(sbi);
-	int type = CURSEG_WARM_NODE;
-	struct curseg_info *curseg;
-	unsigned int segno, old_cursegno;
-	block_t next_blkaddr = next_blkaddr_of_node(page);
-	unsigned int next_segno = GET_SEGNO(sbi, next_blkaddr);
-	struct f2fs_io_info fio = {
-		.type = NODE,
-		.rw = WRITE_SYNC,
-	};
-
-	curseg = CURSEG_I(sbi, type);
-
-	mutex_lock(&curseg->curseg_mutex);
-	mutex_lock(&sit_i->sentry_lock);
-
-	segno = GET_SEGNO(sbi, new_blkaddr);
-	old_cursegno = curseg->segno;
-
-	/* change the current segment */
-	if (segno != curseg->segno) {
-		curseg->next_segno = segno;
-		change_curseg(sbi, type, true);
-	}
-	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
-	__add_sum_entry(sbi, type, sum);
-
-	/* change the current log to the next block addr in advance */
-	if (next_segno != segno) {
-		curseg->next_segno = next_segno;
-		change_curseg(sbi, type, true);
-	}
-	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, next_blkaddr);
-
-	/* rewrite node page */
-	set_page_writeback(page);
-	f2fs_submit_page_mbio(sbi, page, new_blkaddr, &fio);
-	f2fs_submit_merged_bio(sbi, NODE, WRITE);
-	refresh_sit_entry(sbi, old_blkaddr, new_blkaddr);
-	locate_dirty_segment(sbi, old_cursegno);
-
-	mutex_unlock(&sit_i->sentry_lock);
-	mutex_unlock(&curseg->curseg_mutex);
-}
-
 static inline bool is_merged_page(struct f2fs_sb_info *sbi,
 					struct page *page, enum page_type type)
 {
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
