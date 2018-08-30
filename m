From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid wrong decrypted data from disk
Date: Wed, 29 Aug 2018 21:04:58 -0700
Message-ID: <20180830040458.GB97850@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180827225226.14272-1-jaegeuk@kernel.org>
 <20180830014858.GA91444@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180830014858.GA91444@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

1. Create a file in an encrypted directory
2. Do GC & drop caches
3. Read stale data before its bio for metapage was not issued yet

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
Change log from v2:
 - make it globally consistent
 - should use f2fs_post_read_required()

 fs/f2fs/data.c    | 18 ++++++++++--------
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/file.c    |  3 +--
 fs/f2fs/segment.c |  6 +++++-
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 382c1ef9a9e4..8c204f896c22 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -565,9 +565,6 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 		ctx->bio = bio;
 		ctx->enabled_steps = post_read_steps;
 		bio->bi_private = ctx;
-
-		/* wait the page to be moved by cleaning */
-		f2fs_wait_on_block_writeback(sbi, blkaddr);
 	}
 
 	return bio;
@@ -582,6 +579,9 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
+	/* wait for GCed page writeback via META_MAPPING */
+	f2fs_wait_on_block_writeback(inode, blkaddr);
+
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
 		bio_put(bio);
 		return -EFAULT;
@@ -1558,6 +1558,12 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 			}
 		}
 
+		/*
+		 * If the page is under writeback, we need to wait for
+		 * its completion to see the correct decrypted data.
+		 */
+		f2fs_wait_on_block_writeback(inode, block_nr);
+
 		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
 			goto submit_and_realloc;
 
@@ -1625,7 +1631,7 @@ static int encrypt_one_page(struct f2fs_io_info *fio)
 		return 0;
 
 	/* wait for GCed page writeback via META_MAPPING */
-	f2fs_wait_on_block_writeback(fio->sbi, fio->old_blkaddr);
+	f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
 
 retry_encrypt:
 	fio->encrypted_page = fscrypt_encrypt_page(inode, fio->page,
@@ -2382,10 +2388,6 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 	f2fs_wait_on_page_writeback(page, DATA, false);
 
-	/* wait for GCed page writeback via META_MAPPING */
-	if (f2fs_post_read_required(inode))
-		f2fs_wait_on_block_writeback(sbi, blkaddr);
-
 	if (len == PAGE_SIZE || PageUptodate(page))
 		return 0;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4e1120f20041..42950d87e91d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2942,7 +2942,7 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			struct f2fs_io_info *fio, bool add_list);
 void f2fs_wait_on_page_writeback(struct page *page,
 			enum page_type type, bool ordered);
-void f2fs_wait_on_block_writeback(struct f2fs_sb_info *sbi, block_t blkaddr);
+void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr);
 void f2fs_write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
 void f2fs_write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
 int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5474aaa274b9..98bb26be3f6f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -112,8 +112,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	f2fs_wait_on_page_writeback(page, DATA, false);
 
 	/* wait for GCed page writeback via META_MAPPING */
-	if (f2fs_post_read_required(inode))
-		f2fs_wait_on_block_writeback(sbi, dn.data_blkaddr);
+	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
 out_sem:
 	up_read(&F2FS_I(inode)->i_mmap_sem);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 29a1ee21f396..056ac120305a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3191,10 +3191,14 @@ void f2fs_wait_on_page_writeback(struct page *page,
 	}
 }
 
-void f2fs_wait_on_block_writeback(struct f2fs_sb_info *sbi, block_t blkaddr)
+void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *cpage;
 
+	if (!f2fs_post_read_required(inode))
+		return;
+
 	if (!is_valid_data_blkaddr(sbi, blkaddr))
 		return;
 
-- 
2.17.0.441.gb46fe60e1d-goog
