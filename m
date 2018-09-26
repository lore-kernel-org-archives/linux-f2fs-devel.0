From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: clear PageError on the read path
Date: Tue, 25 Sep 2018 18:46:16 -0700
Message-ID: <20180926014617.12369-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When running fault injection test, I hit somewhat wrong behavior in f2fs_gc ->
gc_data_segment():

0. fault injection generated some PageError'ed pages

1. gc_data_segment
 -> f2fs_get_read_data_page(REQ_RAHEAD)

2. move_data_page
 -> f2fs_get_lock_data_page()
  -> f2f_get_read_data_page()
   -> f2fs_submit_page_read()
    -> submit_bio(READ)
  -> return EIO due to PageError
  -> fail to move data

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 41102c227eee..cb3ebcae0398 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -77,7 +77,8 @@ static void __read_end_io(struct bio *bio)
 		/* PG_error was set if any post_read step failed */
 		if (bio->bi_status || PageError(page)) {
 			ClearPageUptodate(page);
-			SetPageError(page);
+			/* will re-read again later */
+			ClearPageError(page);
 		} else {
 			SetPageUptodate(page);
 		}
@@ -591,6 +592,7 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 		bio_put(bio);
 		return -EFAULT;
 	}
+	ClearPageError(page);
 	__submit_bio(F2FS_I_SB(inode), bio, DATA);
 	return 0;
 }
@@ -1571,6 +1573,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
 			goto submit_and_realloc;
 
+		ClearPageError(page);
 		last_block_in_bio = block_nr;
 		goto next_page;
 set_error_page:
-- 
2.17.0.441.gb46fe60e1d-goog
