From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: avoid unnecessary bio submit when wait
 page writeback
Date: Sat, 22 Mar 2014 14:57:23 +0800
Message-ID: <000c01cf459c$25f2af30$71d80d90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WRFtH-0003q7-Is
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 22 Mar 2014 06:58:47 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WRFtF-00050c-KY
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 22 Mar 2014 06:58:47 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N2T00D3SSPP6VB0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 22 Mar 2014 15:58:37 +0900 (KST)
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
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduce is_merged_page() to check whether current page is merged
in f2fs bio cache. When page is not in cache, we can avoid submitting bio cache,
resulting in having more chance to merge pages.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c    |    8 ++++----
 fs/f2fs/f2fs.h    |    2 +-
 fs/f2fs/segment.c |   28 +++++++++++++++++++++++++++-
 fs/f2fs/super.c   |    4 ++--
 4 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b0c923a..598bfa6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -134,7 +134,7 @@ void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 
 	io = is_read_io(rw) ? &sbi->read_io : &sbi->write_io[btype];
 
-	mutex_lock(&io->io_mutex);
+	down_write(&io->io_rwsem);
 
 	/* change META to META_FLUSH in the checkpoint procedure */
 	if (type >= META_FLUSH) {
@@ -142,7 +142,7 @@ void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 		io->fio.rw = WRITE_FLUSH_FUA | REQ_META | REQ_PRIO;
 	}
 	__submit_merged_bio(io);
-	mutex_unlock(&io->io_mutex);
+	up_write(&io->io_rwsem);
 }
 
 /*
@@ -180,7 +180,7 @@ void f2fs_submit_page_mbio(struct f2fs_sb_info *sbi, struct page *page,
 
 	verify_block_addr(sbi, blk_addr);
 
-	mutex_lock(&io->io_mutex);
+	down_write(&io->io_rwsem);
 
 	if (!is_read)
 		inc_page_count(sbi, F2FS_WRITEBACK);
@@ -204,7 +204,7 @@ alloc_new:
 
 	io->last_block_in_bio = blk_addr;
 
-	mutex_unlock(&io->io_mutex);
+	up_write(&io->io_rwsem);
 	trace_f2fs_submit_page_mbio(page, fio->rw, fio->type, blk_addr);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f83433e..1e3d869 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -394,7 +394,7 @@ struct f2fs_bio_info {
 	struct bio *bio;		/* bios to merge */
 	sector_t last_block_in_bio;	/* last block number */
 	struct f2fs_io_info fio;	/* store buffered io info. */
-	struct mutex io_mutex;		/* mutex for bio */
+	struct rw_semaphore io_rwsem;	/* blocking op for bio */
 };
 
 struct f2fs_sb_info {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e7ff23a..570ab9a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1046,12 +1046,38 @@ void rewrite_node_page(struct f2fs_sb_info *sbi,
 	mutex_unlock(&curseg->curseg_mutex);
 }
 
+static inline bool is_merged_page(struct f2fs_sb_info *sbi,
+					struct page *page, enum page_type type)
+{
+	enum page_type btype = PAGE_TYPE_OF_BIO(type);
+	struct f2fs_bio_info *io = &sbi->write_io[btype];
+	struct bio *bio = io->bio;
+	struct bio_vec *bvec;
+	int i;
+
+	down_read(&io->io_rwsem);
+	if (!bio)
+		goto out;
+
+	bio_for_each_segment_all(bvec, bio, i) {
+		if (page == bvec->bv_page) {
+			up_read(&io->io_rwsem);
+			return true;
+		}
+	}
+
+out:
+	up_read(&io->io_rwsem);
+	return false;
+}
+
 void f2fs_wait_on_page_writeback(struct page *page,
 				enum page_type type)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(page->mapping->host->i_sb);
 	if (PageWriteback(page)) {
-		f2fs_submit_merged_bio(sbi, type, WRITE);
+		if (is_merged_page(sbi, page, type))
+			f2fs_submit_merged_bio(sbi, type, WRITE);
 		wait_on_page_writeback(page);
 	}
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 89ea046..9598340 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -920,11 +920,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->por_doing = false;
 	spin_lock_init(&sbi->stat_lock);
 
-	mutex_init(&sbi->read_io.io_mutex);
+	init_rwsem(&sbi->read_io.io_rwsem);
 	sbi->read_io.sbi = sbi;
 	sbi->read_io.bio = NULL;
 	for (i = 0; i < NR_PAGE_TYPE; i++) {
-		mutex_init(&sbi->write_io[i].io_mutex);
+		init_rwsem(&sbi->write_io[i].io_rwsem);
 		sbi->write_io[i].sbi = sbi;
 		sbi->write_io[i].bio = NULL;
 	}
-- 
1.7.9.5



------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
