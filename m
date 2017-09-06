From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: use generic terms used for encrypted block management
Date: Tue,  5 Sep 2017 17:15:50 -0700
Message-ID: <20170906001550.53917-2-jaegeuk@kernel.org>
References: <20170906001550.53917-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170906001550.53917-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch renames functions regarding to buffer management via META_MAPPING
used for encrypted blocks especially. We can actually use them in generic way.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    |  6 +++---
 fs/f2fs/f2fs.h    |  3 +--
 fs/f2fs/file.c    |  2 +-
 fs/f2fs/gc.c      | 13 +++++++++----
 fs/f2fs/segment.c |  3 +--
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e6c683e7a10e..ee6801fdbdec 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1163,7 +1163,7 @@ static struct bio *f2fs_grab_bio(struct inode *inode, block_t blkaddr,
 			return ERR_CAST(ctx);
 
 		/* wait the page to be moved by cleaning */
-		f2fs_wait_on_encrypted_page_writeback(sbi, blkaddr);
+		f2fs_wait_on_block_writeback(sbi, blkaddr);
 	}
 
 	bio = bio_alloc(GFP_KERNEL, min_t(int, nr_pages, BIO_MAX_PAGES));
@@ -1349,7 +1349,7 @@ static int encrypt_one_page(struct f2fs_io_info *fio)
 		return 0;
 
 	/* wait for GCed encrypted page writeback */
-	f2fs_wait_on_encrypted_page_writeback(fio->sbi, fio->old_blkaddr);
+	f2fs_wait_on_block_writeback(fio->sbi, fio->old_blkaddr);
 
 retry_encrypt:
 	fio->encrypted_page = fscrypt_encrypt_page(inode, fio->page,
@@ -1975,7 +1975,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 	/* wait for GCed encrypted page writeback */
 	if (f2fs_encrypted_file(inode))
-		f2fs_wait_on_encrypted_page_writeback(sbi, blkaddr);
+		f2fs_wait_on_block_writeback(sbi, blkaddr);
 
 	if (len == PAGE_SIZE || PageUptodate(page))
 		return 0;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 417c28f01fd5..91fb749686f2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2550,8 +2550,7 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			struct f2fs_io_info *fio, bool add_list);
 void f2fs_wait_on_page_writeback(struct page *page,
 			enum page_type type, bool ordered);
-void f2fs_wait_on_encrypted_page_writeback(struct f2fs_sb_info *sbi,
-			block_t blkaddr);
+void f2fs_wait_on_block_writeback(struct f2fs_sb_info *sbi, block_t blkaddr);
 void write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
 void write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
 int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f8cedaba7ce4..224379a9848c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -107,7 +107,7 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	/* wait for GCed encrypted page writeback */
 	if (f2fs_encrypted_file(inode))
-		f2fs_wait_on_encrypted_page_writeback(sbi, dn.data_blkaddr);
+		f2fs_wait_on_block_writeback(sbi, dn.data_blkaddr);
 
 out_sem:
 	up_read(&F2FS_I(inode)->i_mmap_sem);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6a12f33d0cdd..bfe6a8ccc3a0 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -599,8 +599,12 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	return true;
 }
 
-static void move_encrypted_block(struct inode *inode, block_t bidx,
-							unsigned int segno, int off)
+/*
+ * Move data block via META_MAPPING while keeping locked data page.
+ * This can be used to move blocks, aka LBAs, directly on disk.
+ */
+static void move_data_block(struct inode *inode, block_t bidx,
+					unsigned int segno, int off)
 {
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(inode),
@@ -873,9 +877,10 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			start_bidx = start_bidx_of_node(nofs, inode)
 								+ ofs_in_node;
 			if (f2fs_encrypted_file(inode))
-				move_encrypted_block(inode, start_bidx, segno, off);
+				move_data_block(inode, start_bidx, segno, off);
 			else
-				move_data_page(inode, start_bidx, gc_type, segno, off);
+				move_data_page(inode, start_bidx, gc_type,
+								segno, off);
 
 			if (locked) {
 				up_write(&fi->dio_rwsem[WRITE]);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 265c3bc44f2d..9e708e525ba8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2528,8 +2528,7 @@ void f2fs_wait_on_page_writeback(struct page *page,
 	}
 }
 
-void f2fs_wait_on_encrypted_page_writeback(struct f2fs_sb_info *sbi,
-							block_t blkaddr)
+void f2fs_wait_on_block_writeback(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	struct page *cpage;
 
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
