From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: introduce f2fs_submit_merged_bio_cond
Date: Sat, 16 Jan 2016 17:38:38 +0800
Message-ID: <017e01d15041$c5911110$50b33330$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aKNKT-0002kI-J1
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 16 Jan 2016 09:39:29 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aKNKR-0007vM-Km
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 16 Jan 2016 09:39:29 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O1100WB0HHKYN90@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 16 Jan 2016 18:39:20 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

f2fs use single bio buffer for each META/NODE/DATA type data for caching
writes which have continuous block address as many as possible, after
submitting blocks, sometimes, the blocks are still cached in bio buffer,
so we have to flush cached writes in bio buffer by calling
f2fs_submit_merged_bio.

Unfortunately, in the scenario of high concurrency, bio buffer will could
be flushed by someone else as below reasons:
a) there is no space in bio buffer.
b) user add a request of different type (SYNC, ASYNC).
c) user add a discontinuous block address.

For this condition, f2fs_submit_merged_bio will be devastating, because
it could break the following merging of writes in bio buffer, splitting
one big bio into two smaller one.

This patch introduces f2fs_submit_merged_bio_cond which can do a
conditional submitting with bio buffer, it will judge whether:
 - page in DATA type bio buffer is matched with specified page;
 - page in DATA type bio buffer is belong to specified inode;
 - page in NODE type bio buffer is belong to specified inode;
If there is no eligible page in bio buffer, we will skip submitting step.
So that result in gaining more chance to merge consecutive block IOs in
bio cache.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c |  7 ++++-
 fs/f2fs/data.c       | 88 ++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/f2fs/f2fs.h       |  2 ++
 fs/f2fs/node.c       | 15 +++++++--
 fs/f2fs/segment.c    | 44 ++------------------------
 5 files changed, 105 insertions(+), 51 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3842af9..c75b148 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -235,10 +235,15 @@ static int f2fs_write_meta_page(struct page *page,
 	f2fs_wait_on_page_writeback(page, META);
 	write_meta_page(sbi, page);
 	dec_page_count(sbi, F2FS_DIRTY_META);
+
+	if (wbc->for_reclaim)
+		f2fs_submit_merged_bio_cond(sbi, NULL, page, 0, META, WRITE);
+
 	unlock_page(page);
 
-	if (wbc->for_reclaim || unlikely(f2fs_cp_error(sbi)))
+	if (unlikely(f2fs_cp_error(sbi)))
 		f2fs_submit_merged_bio(sbi, META, WRITE);
+
 	return 0;
 
 redirty_out:
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ac9e7c6..db7192c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -116,8 +116,59 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	io->bio = NULL;
 }
 
-void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
-				enum page_type type, int rw)
+static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
+					struct page *page, nid_t ino)
+{
+	struct bio_vec *bvec;
+	struct page *target;
+	int i;
+
+	if (!io->bio)
+		return false;
+
+	if (!inode && !page && !ino)
+		return true;
+
+	bio_for_each_segment_all(bvec, io->bio, i) {
+
+		if (bvec->bv_page->mapping) {
+			target = bvec->bv_page;
+		} else {
+			struct f2fs_crypto_ctx *ctx;
+
+			/* encrypted page */
+			ctx = (struct f2fs_crypto_ctx *)page_private(
+								bvec->bv_page);
+			target = ctx->w.control_page;
+		}
+
+		if (inode && inode == target->mapping->host)
+			return true;
+		if (page && page == target)
+			return true;
+		if (ino && ino == ino_of_node(target))
+			return true;
+	}
+
+	return false;
+}
+
+static bool __is_merged_page(struct f2fs_sb_info *sbi,
+					struct page *page, enum page_type type)
+{
+	enum page_type btype = PAGE_TYPE_OF_BIO(type);
+	struct f2fs_bio_info *io = &sbi->write_io[btype];
+	bool ret;
+
+	down_read(&io->io_rwsem);
+	ret = __has_merged_page(io, NULL, page, 0);
+	up_read(&io->io_rwsem);
+	return ret;
+}
+
+static void __f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
+				struct inode *inode, struct page *page,
+				nid_t ino, enum page_type type, int rw)
 {
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
 	struct f2fs_bio_info *io;
@@ -126,6 +177,9 @@ void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 
 	down_write(&io->io_rwsem);
 
+	if (!__has_merged_page(io, inode, page, ino))
+		goto out;
+
 	/* change META to META_FLUSH in the checkpoint procedure */
 	if (type >= META_FLUSH) {
 		io->fio.type = META_FLUSH;
@@ -135,9 +189,25 @@ void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 			io->fio.rw = WRITE_FLUSH_FUA | REQ_META | REQ_PRIO;
 	}
 	__submit_merged_bio(io);
+out:
 	up_write(&io->io_rwsem);
 }
 
+void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi, enum page_type type,
+									int rw)
+{
+	__f2fs_submit_merged_bio(sbi, NULL, NULL, 0, type, rw);
+}
+
+void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *sbi,
+				struct inode *inode, struct page *page,
+				nid_t ino, enum page_type type, int rw)
+{
+	if (page && !__is_merged_page(sbi, page, type))
+		return;
+	__f2fs_submit_merged_bio(sbi, inode, page, ino, type, rw);
+}
+
 /*
  * Fill the locked page with data located in the block address.
  * Return unlocked page.
@@ -1177,12 +1247,18 @@ out:
 	inode_dec_dirty_pages(inode);
 	if (err)
 		ClearPageUptodate(page);
+
+	if (wbc->for_reclaim) {
+		f2fs_submit_merged_bio_cond(sbi, NULL, page, 0, DATA, WRITE);
+		remove_dirty_inode(inode);
+	}
+
 	unlock_page(page);
 	f2fs_balance_fs(sbi, need_balance_fs);
-	if (wbc->for_reclaim || unlikely(f2fs_cp_error(sbi))) {
+
+	if (unlikely(f2fs_cp_error(sbi)))
 		f2fs_submit_merged_bio(sbi, DATA, WRITE);
-		remove_dirty_inode(inode);
-	}
+
 	return 0;
 
 redirty_out:
@@ -1369,7 +1445,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 		locked = true;
 	}
 	ret = f2fs_write_cache_pages(mapping, wbc, __f2fs_writepage, mapping);
-	f2fs_submit_merged_bio(sbi, DATA, WRITE);
+	f2fs_submit_merged_bio_cond(sbi, inode, NULL, 0, DATA, WRITE);
 	if (locked)
 		mutex_unlock(&sbi->writepages);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2c0e478..6c413b1e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1883,6 +1883,8 @@ void destroy_checkpoint_caches(void);
  * data.c
  */
 void f2fs_submit_merged_bio(struct f2fs_sb_info *, enum page_type, int);
+void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *, struct inode *,
+				struct page *, nid_t, enum page_type, int);
 int f2fs_submit_page_bio(struct f2fs_io_info *);
 void f2fs_submit_page_mbio(struct f2fs_io_info *);
 void set_data_blkaddr(struct dnode_of_data *);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 342597a..851a80b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1258,8 +1258,13 @@ continue_unlock:
 		goto next_step;
 	}
 
-	if (wrote)
-		f2fs_submit_merged_bio(sbi, NODE, WRITE);
+	if (wrote) {
+		if (ino)
+			f2fs_submit_merged_bio_cond(sbi, NULL, NULL,
+							ino, NODE, WRITE);
+		else
+			f2fs_submit_merged_bio(sbi, NODE, WRITE);
+	}
 	return nwritten;
 }
 
@@ -1356,9 +1361,13 @@ static int f2fs_write_node_page(struct page *page,
 	set_node_addr(sbi, &ni, fio.blk_addr, is_fsync_dnode(page));
 	dec_page_count(sbi, F2FS_DIRTY_NODES);
 	up_read(&sbi->node_write);
+
+	if (wbc->for_reclaim)
+		f2fs_submit_merged_bio_cond(sbi, NULL, page, 0, NODE, WRITE);
+
 	unlock_page(page);
 
-	if (wbc->for_reclaim || unlikely(f2fs_cp_error(sbi)))
+	if (unlikely(f2fs_cp_error(sbi)))
 		f2fs_submit_merged_bio(sbi, NODE, WRITE);
 
 	return 0;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 68800e6..070988b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -253,7 +253,8 @@ int commit_inmem_pages(struct inode *inode, bool abort)
 	if (!abort) {
 		f2fs_unlock_op(sbi);
 		if (submit_bio)
-			f2fs_submit_merged_bio(sbi, DATA, WRITE);
+			f2fs_submit_merged_bio_cond(sbi, inode, NULL, 0,
+								DATA, WRITE);
 	}
 	return err;
 }
@@ -1416,52 +1417,13 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 	f2fs_update_extent_cache(dn);
 }
 
-static inline bool is_merged_page(struct f2fs_sb_info *sbi,
-					struct page *page, enum page_type type)
-{
-	enum page_type btype = PAGE_TYPE_OF_BIO(type);
-	struct f2fs_bio_info *io = &sbi->write_io[btype];
-	struct bio_vec *bvec;
-	struct page *target;
-	int i;
-
-	down_read(&io->io_rwsem);
-	if (!io->bio) {
-		up_read(&io->io_rwsem);
-		return false;
-	}
-
-	bio_for_each_segment_all(bvec, io->bio, i) {
-
-		if (bvec->bv_page->mapping) {
-			target = bvec->bv_page;
-		} else {
-			struct f2fs_crypto_ctx *ctx;
-
-			/* encrypted page */
-			ctx = (struct f2fs_crypto_ctx *)page_private(
-								bvec->bv_page);
-			target = ctx->w.control_page;
-		}
-
-		if (page == target) {
-			up_read(&io->io_rwsem);
-			return true;
-		}
-	}
-
-	up_read(&io->io_rwsem);
-	return false;
-}
-
 void f2fs_wait_on_page_writeback(struct page *page,
 				enum page_type type)
 {
 	if (PageWriteback(page)) {
 		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 
-		if (is_merged_page(sbi, page, type))
-			f2fs_submit_merged_bio(sbi, type, WRITE);
+		f2fs_submit_merged_bio_cond(sbi, NULL, page, 0, type, WRITE);
 		wait_on_page_writeback(page);
 	}
 }
-- 
2.6.3



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
