From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/2] f2fs: introduce a bio array for per-page
	write bios
Date: Tue, 19 Nov 2013 16:10:37 +0900
Message-ID: <1384845037-7872-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1384845037-7872-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VifTK-0007As-Mu
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Nov 2013 07:11:42 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VifTH-0007TX-I9 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Nov 2013 07:11:42 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWI00A2V1B674J0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Nov 2013 16:11:30 +0900 (KST)
In-reply-to: <1384845037-7872-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

The f2fs has three bio types, NODE, DATA, and META, and manages some data
structures per each bio types.

The codes are a little bit messy, thus, this patch introduces a bio array
which groups individual data structures as follows.

struct f2fs_bio_info {
	struct bio *bio;		/* bios to merge */
	sector_t last_block_in_bio;	/* last block number */
	struct mutex io_mutex;		/* mutex for bio */
};

struct f2fs_sb_info {
	...
	struct f2fs_bio_info write_io[NR_PAGE_TYPE];	/* for write bios */
	...
};

The code changes from this new data structure are trivial.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h    | 12 +++++++++---
 fs/f2fs/segment.c | 44 ++++++++++++++++++++++----------------------
 fs/f2fs/super.c   |  2 +-
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e9038bb..05f8fe1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -361,6 +361,12 @@ enum page_type {
 	META_FLUSH,
 };
 
+struct f2fs_bio_info {
+	struct bio *bio;		/* bios to merge */
+	sector_t last_block_in_bio;	/* last block number */
+	struct mutex io_mutex;		/* mutex for bio */
+};
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
@@ -374,9 +380,9 @@ struct f2fs_sb_info {
 
 	/* for segment-related operations */
 	struct f2fs_sm_info *sm_info;		/* segment manager */
-	struct bio *bio[NR_PAGE_TYPE];		/* bios to merge */
-	sector_t last_block_in_bio[NR_PAGE_TYPE];	/* last block number */
-	struct mutex write_mutex[NR_PAGE_TYPE];	/* mutex for writing IOs */
+
+	/* for bio operations */
+	struct f2fs_bio_info write_io[NR_PAGE_TYPE];	/* for write bios */
 
 	/* for checkpoint */
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 119af0b..9607cc4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -838,65 +838,65 @@ static void do_submit_bio(struct f2fs_sb_info *sbi,
 {
 	int rw = sync ? WRITE_SYNC : WRITE;
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
-	struct bio *bio = sbi->bio[btype];
+	struct f2fs_bio_info *io = &sbi->write_io[btype];
 	struct bio_private *p;
 
-	if (!bio)
+	if (!io->bio)
 		return;
 
-	sbi->bio[btype] = NULL;
-
 	if (type >= META_FLUSH)
 		rw = WRITE_FLUSH_FUA;
 	if (btype == META)
 		rw |= REQ_META;
 
-	p = bio->bi_private;
+	p = io->bio->bi_private;
 	p->sbi = sbi;
-	bio->bi_end_io = f2fs_end_io_write;
+	io->bio->bi_end_io = f2fs_end_io_write;
 
-	trace_f2fs_do_submit_bio(sbi->sb, btype, sync, bio);
+	trace_f2fs_do_submit_bio(sbi->sb, btype, sync, io->bio);
 
 	if (type == META_FLUSH) {
 		DECLARE_COMPLETION_ONSTACK(wait);
 		p->is_sync = true;
 		p->wait = &wait;
-		submit_bio(rw, bio);
+		submit_bio(rw, io->bio);
 		wait_for_completion(&wait);
 	} else {
 		p->is_sync = false;
-		submit_bio(rw, bio);
+		submit_bio(rw, io->bio);
 	}
+	io->bio = NULL;
 }
 
 void f2fs_submit_bio(struct f2fs_sb_info *sbi, enum page_type type, bool sync)
 {
-	enum page_type btype = PAGE_TYPE_OF_BIO(type);
+	struct f2fs_bio_info *io = &sbi->write_io[PAGE_TYPE_OF_BIO(type)];
 
-	if (!sbi->bio[btype])
+	if (!io->bio)
 		return;
 
-	mutex_lock(&sbi->write_mutex[btype]);
+	mutex_lock(&io->io_mutex);
 	do_submit_bio(sbi, type, sync);
-	mutex_unlock(&sbi->write_mutex[btype]);
+	mutex_unlock(&io->io_mutex);
 }
 
 static void submit_write_page(struct f2fs_sb_info *sbi, struct page *page,
 				block_t blk_addr, enum page_type type)
 {
 	struct block_device *bdev = sbi->sb->s_bdev;
+	struct f2fs_bio_info *io = &sbi->write_io[type];
 	int bio_blocks;
 
 	verify_block_addr(sbi, blk_addr);
 
-	mutex_lock(&sbi->write_mutex[type]);
+	mutex_lock(&io->io_mutex);
 
 	inc_page_count(sbi, F2FS_WRITEBACK);
 
-	if (sbi->bio[type] && sbi->last_block_in_bio[type] != blk_addr - 1)
+	if (io->bio && io->last_block_in_bio != blk_addr - 1)
 		do_submit_bio(sbi, type, false);
 alloc_new:
-	if (sbi->bio[type] == NULL) {
+	if (io->bio == NULL) {
 		struct bio_private *priv;
 retry:
 		priv = kmalloc(sizeof(struct bio_private), GFP_NOFS);
@@ -906,9 +906,9 @@ retry:
 		}
 
 		bio_blocks = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
-		sbi->bio[type] = f2fs_bio_alloc(bdev, bio_blocks);
-		sbi->bio[type]->bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
-		sbi->bio[type]->bi_private = priv;
+		io->bio = f2fs_bio_alloc(bdev, bio_blocks);
+		io->bio->bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
+		io->bio->bi_private = priv;
 		/*
 		 * The end_io will be assigned at the sumbission phase.
 		 * Until then, let bio_add_page() merge consecutive IOs as much
@@ -916,15 +916,15 @@ retry:
 		 */
 	}
 
-	if (bio_add_page(sbi->bio[type], page, PAGE_CACHE_SIZE, 0) <
+	if (bio_add_page(io->bio, page, PAGE_CACHE_SIZE, 0) <
 							PAGE_CACHE_SIZE) {
 		do_submit_bio(sbi, type, false);
 		goto alloc_new;
 	}
 
-	sbi->last_block_in_bio[type] = blk_addr;
+	io->last_block_in_bio = blk_addr;
 
-	mutex_unlock(&sbi->write_mutex[type]);
+	mutex_unlock(&io->io_mutex);
 	trace_f2fs_submit_write_page(page, blk_addr, type);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e194578..8c677e9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -879,7 +879,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	spin_lock_init(&sbi->stat_lock);
 
 	for (i = 0; i < NR_PAGE_TYPE; i++)
-		mutex_init(&sbi->write_mutex[i]);
+		mutex_init(&sbi->write_io[i].io_mutex);
 
 	init_rwsem(&sbi->cp_rwsem);
 	init_waitqueue_head(&sbi->cp_wait);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
