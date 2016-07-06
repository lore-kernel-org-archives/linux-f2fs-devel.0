From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/6] f2fs: call SetPageUptodate if needed
Date: Wed,  6 Jul 2016 09:06:28 -0700
Message-ID: <20160706160632.78272-2-jaegeuk@kernel.org>
References: <20160706160632.78272-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bKpLX-0005J6-Vv
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jul 2016 16:06:43 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bKpLW-0007V8-W1
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jul 2016 16:06:43 +0000
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

SetPageUptodate() issues memory barrier, resulting in performance degrdation.
Let's avoid that.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  6 ++++--
 fs/f2fs/data.c       | 18 ++++++++++++------
 fs/f2fs/file.c       |  3 ++-
 fs/f2fs/inline.c     |  9 ++++++---
 fs/f2fs/node.c       |  9 ++++++---
 5 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2755ef7..8ea8953 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -48,7 +48,8 @@ repeat:
 		goto repeat;
 	}
 	f2fs_wait_on_page_writeback(page, META, true);
-	SetPageUptodate(page);
+	if (!PageUptodate(page))
+		SetPageUptodate(page);
 	return page;
 }
 
@@ -364,7 +365,8 @@ static int f2fs_set_meta_page_dirty(struct page *page)
 {
 	trace_f2fs_set_page_dirty(page, META);
 
-	SetPageUptodate(page);
+	if (!PageUptodate(page))
+		SetPageUptodate(page);
 	if (!PageDirty(page)) {
 		f2fs_set_page_dirty_nobuffers(page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_META);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4a2e97d..b6fd5bd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -47,7 +47,8 @@ static void f2fs_read_end_io(struct bio *bio)
 		struct page *page = bvec->bv_page;
 
 		if (!bio->bi_error) {
-			SetPageUptodate(page);
+			if (!PageUptodate(page))
+				SetPageUptodate(page);
 		} else {
 			ClearPageUptodate(page);
 			SetPageError(page);
@@ -443,7 +444,8 @@ got_it:
 	 */
 	if (dn.data_blkaddr == NEW_ADDR) {
 		zero_user_segment(page, 0, PAGE_SIZE);
-		SetPageUptodate(page);
+		if (!PageUptodate(page))
+			SetPageUptodate(page);
 		unlock_page(page);
 		return page;
 	}
@@ -554,7 +556,8 @@ struct page *get_new_data_page(struct inode *inode,
 
 	if (dn.data_blkaddr == NEW_ADDR) {
 		zero_user_segment(page, 0, PAGE_SIZE);
-		SetPageUptodate(page);
+		if (!PageUptodate(page))
+			SetPageUptodate(page);
 	} else {
 		f2fs_put_page(page, 1);
 
@@ -1065,7 +1068,8 @@ got_it:
 			}
 		} else {
 			zero_user_segment(page, 0, PAGE_SIZE);
-			SetPageUptodate(page);
+			if (!PageUptodate(page))
+				SetPageUptodate(page);
 			unlock_page(page);
 			goto next_page;
 		}
@@ -1659,7 +1663,8 @@ repeat:
 		}
 	}
 out_update:
-	SetPageUptodate(page);
+	if (!PageUptodate(page))
+		SetPageUptodate(page);
 out_clear:
 	clear_cold_data(page);
 	return 0;
@@ -1813,7 +1818,8 @@ static int f2fs_set_data_page_dirty(struct page *page)
 
 	trace_f2fs_set_page_dirty(page, DATA);
 
-	SetPageUptodate(page);
+	if (!PageUptodate(page))
+		SetPageUptodate(page);
 
 	if (f2fs_is_atomic_file(inode)) {
 		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4e220ba..952cbcf 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -83,7 +83,8 @@ static int f2fs_vm_page_mkwrite(struct vm_area_struct *vma,
 		zero_user_segment(page, offset, PAGE_SIZE);
 	}
 	set_page_dirty(page);
-	SetPageUptodate(page);
+	if (!PageUptodate(page))
+		SetPageUptodate(page);
 
 	trace_f2fs_vm_page_mkwrite(page, DATA);
 mapped:
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index e10e958..2cd0edc 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -59,7 +59,8 @@ void read_inline_data(struct page *page, struct page *ipage)
 	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
 	flush_dcache_page(page);
 	kunmap_atomic(dst_addr);
-	SetPageUptodate(page);
+	if (!PageUptodate(page))
+		SetPageUptodate(page);
 }
 
 bool truncate_inline_inode(struct page *ipage, u64 from)
@@ -97,7 +98,8 @@ int f2fs_read_inline_data(struct inode *inode, struct page *page)
 	else
 		read_inline_data(page, ipage);
 
-	SetPageUptodate(page);
+	if (!PageUptodate(page))
+		SetPageUptodate(page);
 	f2fs_put_page(ipage, 1);
 	unlock_page(page);
 	return 0;
@@ -370,7 +372,8 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 					NR_INLINE_DENTRY * F2FS_SLOT_LEN);
 
 	kunmap_atomic(dentry_blk);
-	SetPageUptodate(page);
+	if (!PageUptodate(page))
+		SetPageUptodate(page);
 	set_page_dirty(page);
 
 	/* clear inline dir and flag after data writeback */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index db73f3c..ca1bb3c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1045,7 +1045,8 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	f2fs_wait_on_page_writeback(page, NODE, true);
 	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
 	set_cold_node(dn->inode, page);
-	SetPageUptodate(page);
+	if (!PageUptodate(page))
+		SetPageUptodate(page);
 	if (set_page_dirty(page))
 		dn->node_changed = true;
 
@@ -1644,7 +1645,8 @@ static int f2fs_set_node_page_dirty(struct page *page)
 {
 	trace_f2fs_set_page_dirty(page, NODE);
 
-	SetPageUptodate(page);
+	if (!PageUptodate(page))
+		SetPageUptodate(page);
 	if (!PageDirty(page)) {
 		f2fs_set_page_dirty_nobuffers(page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
@@ -2015,7 +2017,8 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	/* Should not use this inode from free nid list */
 	remove_free_nid(NM_I(sbi), ino);
 
-	SetPageUptodate(ipage);
+	if (!PageUptodate(ipage))
+		SetPageUptodate(ipage);
 	fill_node_footer(ipage, ino, ino, 0, true);
 
 	src = F2FS_INODE(page);
-- 
2.8.3


------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
