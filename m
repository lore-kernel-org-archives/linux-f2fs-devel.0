From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 04/10] f2fs: support IO alignment for DATA and
	NODE writes
Date: Fri, 30 Dec 2016 10:51:11 -0800
Message-ID: <20161230185117.3832-4-jaegeuk@kernel.org>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cN2H6-0006BB-4j
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Dec 2016 18:51:32 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cN2H4-0003su-RN
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Dec 2016 18:51:32 +0000
In-Reply-To: <20161230185117.3832-1-jaegeuk@kernel.org>
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

This patch implements IO alignment by filling dummy blocks in DATA and NODE
write bios. If we can guarantee, for example, 32KB or 64KB for such the IOs,
we can eliminate underlying dummy page problem which FTL conducts in order to
close MLC or TLC partial written pages.

Note that,
 - it requires "-o mode=lfs".
 - IO size should be power of 2, not exceed BIO_MAX_PAGES, 256.
 - read IO is still 4KB.
 - do checkpoint at fsync, if dummy NODE page was written.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c          | 55 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/f2fs/f2fs.h          |  4 +++-
 fs/f2fs/segment.c       |  9 ++++++--
 fs/f2fs/segment.h       |  3 +++
 fs/f2fs/super.c         | 13 +++++++++++-
 include/linux/f2fs_fs.h |  6 ++++++
 6 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 54da4e2f1318..f17df9f76d55 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -93,6 +93,17 @@ static void f2fs_write_end_io(struct bio *bio)
 		struct page *page = bvec->bv_page;
 		enum count_type type = WB_DATA_TYPE(page);
 
+		if (IS_DUMMY_WRITTEN_PAGE(page)) {
+			set_page_private(page, (unsigned long)NULL);
+			ClearPagePrivate(page);
+			unlock_page(page);
+			mempool_free(page, sbi->write_io_dummy);
+
+			if (unlikely(bio->bi_error))
+				f2fs_stop_checkpoint(sbi, true);
+			continue;
+		}
+
 		fscrypt_pullback_bio_page(&page, true);
 
 		if (unlikely(bio->bi_error)) {
@@ -171,10 +182,42 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 				struct bio *bio, enum page_type type)
 {
 	if (!is_read_io(bio_op(bio))) {
+		unsigned int start;
+
 		if (f2fs_sb_mounted_blkzoned(sbi->sb) &&
 			current->plug && (type == DATA || type == NODE))
 			blk_finish_plug(current->plug);
+
+		if (type != DATA && type != NODE)
+			goto submit_io;
+
+		start = bio->bi_iter.bi_size >> F2FS_BLKSIZE_BITS;
+		start %= F2FS_IO_SIZE(sbi);
+
+		if (start == 0)
+			goto submit_io;
+
+		/* fill dummy pages */
+		for (; start < F2FS_IO_SIZE(sbi); start++) {
+			struct page *page =
+				mempool_alloc(sbi->write_io_dummy,
+					GFP_NOIO | __GFP_ZERO | __GFP_NOFAIL);
+			f2fs_bug_on(sbi, !page);
+
+			SetPagePrivate(page);
+			set_page_private(page, (unsigned long)DUMMY_WRITTEN_PAGE);
+			lock_page(page);
+			if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
+				f2fs_bug_on(sbi, 1);
+		}
+		/*
+		 * In the NODE case, we lose next block address chain. So, we
+		 * need to do checkpoint in f2fs_sync_file.
+		 */
+		if (type == NODE)
+			set_sbi_flag(sbi, SBI_NEED_CP);
 	}
+submit_io:
 	trace_f2fs_submit_bio(sbi->sb, bio);
 	submit_bio(bio);
 }
@@ -316,13 +359,14 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	return 0;
 }
 
-void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
+int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = fio->sbi;
 	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
 	struct f2fs_bio_info *io;
 	bool is_read = is_read_io(fio->op);
 	struct page *bio_page;
+	int err = 0;
 
 	io = is_read ? &sbi->read_io : &sbi->write_io[btype];
 
@@ -343,6 +387,12 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
+		if ((fio->type == DATA || fio->type == NODE) &&
+				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
+			err = -EAGAIN;
+			dec_page_count(sbi, WB_DATA_TYPE(bio_page));
+			goto out_fail;
+		}
 		io->bio = __bio_alloc(sbi, fio->new_blkaddr,
 						BIO_MAX_PAGES, is_read);
 		io->fio = *fio;
@@ -356,9 +406,10 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 
 	io->last_block_in_bio = fio->new_blkaddr;
 	f2fs_trace_ios(fio, 0);
-
+out_fail:
 	up_write(&io->io_rwsem);
 	trace_f2fs_submit_page_mbio(fio->page, fio);
+	return err;
 }
 
 static void __set_data_blkaddr(struct dnode_of_data *dn)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2da8c3aa0ce5..0d7eaddef4a0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -792,6 +792,8 @@ struct f2fs_sb_info {
 	struct f2fs_bio_info read_io;			/* for read bios */
 	struct f2fs_bio_info write_io[NR_PAGE_TYPE];	/* for write bios */
 	struct mutex wio_mutex[NODE + 1];	/* bio ordering for NODE/DATA */
+	int write_io_size_bits;			/* Write IO size bits */
+	mempool_t *write_io_dummy;		/* Dummy pages */
 
 	/* for checkpoint */
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
@@ -2174,7 +2176,7 @@ void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *, struct inode *,
 				struct page *, nid_t, enum page_type, int);
 void f2fs_flush_merged_bios(struct f2fs_sb_info *);
 int f2fs_submit_page_bio(struct f2fs_io_info *);
-void f2fs_submit_page_mbio(struct f2fs_io_info *);
+int f2fs_submit_page_mbio(struct f2fs_io_info *);
 struct block_device *f2fs_target_device(struct f2fs_sb_info *,
 				block_t, struct bio *);
 int f2fs_target_device_index(struct f2fs_sb_info *, block_t);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4e5ffe1d97e4..6d197f0c8151 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1604,15 +1604,20 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 {
 	int type = __get_segment_type(fio->page, fio->type);
+	int err;
 
 	if (fio->type == NODE || fio->type == DATA)
 		mutex_lock(&fio->sbi->wio_mutex[fio->type]);
-
+reallocate:
 	allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
 					&fio->new_blkaddr, sum, type);
 
 	/* writeout dirty page into bdev */
-	f2fs_submit_page_mbio(fio);
+	err = f2fs_submit_page_mbio(fio);
+	if (err == -EAGAIN) {
+		fio->old_blkaddr = fio->new_blkaddr;
+		goto reallocate;
+	}
 
 	if (fio->type == NODE || fio->type == DATA)
 		mutex_unlock(&fio->sbi->wio_mutex[fio->type]);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 9d44ce83acb2..08f1455c812c 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -186,9 +186,12 @@ struct segment_allocation {
  * the page is atomically written, and it is in inmem_pages list.
  */
 #define ATOMIC_WRITTEN_PAGE		((unsigned long)-1)
+#define DUMMY_WRITTEN_PAGE		((unsigned long)-2)
 
 #define IS_ATOMIC_WRITTEN_PAGE(page)			\
 		(page_private(page) == (unsigned long)ATOMIC_WRITTEN_PAGE)
+#define IS_DUMMY_WRITTEN_PAGE(page)			\
+		(page_private(page) == (unsigned long)DUMMY_WRITTEN_PAGE)
 
 struct inmem_pages {
 	struct list_head list;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 702638e21c76..692ff1b5adf5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1763,6 +1763,8 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 				FDEV(i).total_segments,
 				FDEV(i).start_blk, FDEV(i).end_blk);
 	}
+	f2fs_msg(sbi->sb, KERN_INFO,
+			"IO Block Size: %8d KB", F2FS_IO_SIZE_KB(sbi));
 	return 0;
 }
 
@@ -1880,12 +1882,19 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto free_options;
 
+	if (F2FS_IO_SIZE(sbi) > 1) {
+		sbi->write_io_dummy =
+			mempool_create_page_pool(F2FS_IO_SIZE(sbi) - 1, 0);
+		if (!sbi->write_io_dummy)
+			goto free_options;
+	}
+
 	/* get an inode for meta space */
 	sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
 	if (IS_ERR(sbi->meta_inode)) {
 		f2fs_msg(sb, KERN_ERR, "Failed to read F2FS meta data inode");
 		err = PTR_ERR(sbi->meta_inode);
-		goto free_options;
+		goto free_io_dummy;
 	}
 
 	err = get_valid_checkpoint(sbi);
@@ -2103,6 +2112,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_meta_inode:
 	make_bad_inode(sbi->meta_inode);
 	iput(sbi->meta_inode);
+free_io_dummy:
+	mempool_destroy(sbi->write_io_dummy);
 free_options:
 	destroy_percpu_info(sbi);
 	kfree(options);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index cea41a124a80..f0748524ca8c 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -36,6 +36,12 @@
 #define F2FS_NODE_INO(sbi)	(sbi->node_ino_num)
 #define F2FS_META_INO(sbi)	(sbi->meta_ino_num)
 
+#define F2FS_IO_SIZE(sbi)	(1 << (sbi)->write_io_size_bits) /* Blocks */
+#define F2FS_IO_SIZE_KB(sbi)	(1 << ((sbi)->write_io_size_bits + 2)) /* KB */
+#define F2FS_IO_SIZE_BYTES(sbi)	(1 << ((sbi)->write_io_size_bits + 12)) /* B */
+#define F2FS_IO_SIZE_BITS(sbi)	((sbi)->write_io_size_bits) /* power of 2 */
+#define F2FS_IO_SIZE_MASK(sbi)	(F2FS_IO_SIZE(sbi) - 1)
+
 /* This flag is used by node and meta inodes, and by recovery */
 #define GFP_F2FS_ZERO		(GFP_NOFS | __GFP_ZERO)
 #define GFP_F2FS_HIGH_ZERO	(GFP_NOFS | __GFP_ZERO | __GFP_HIGHMEM)
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
