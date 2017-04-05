From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: count writeback pages correctly
Date: Wed,  5 Apr 2017 11:02:00 -0700
Message-ID: <20170405180201.4021-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cvpG0-0003oT-2N
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Apr 2017 18:02:12 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cvpFy-0001j7-57
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Apr 2017 18:02:12 +0000
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

This patch fixes # of outstanding writeback pages by checking its original page.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3d74c0ffa4c7..af3e849e96d2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -94,7 +94,6 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	bio_for_each_segment_all(bvec, bio, i) {
 		struct page *page = bvec->bv_page;
-		enum count_type type = WB_DATA_TYPE(page);
 
 		if (IS_DUMMY_WRITTEN_PAGE(page)) {
 			set_page_private(page, (unsigned long)NULL);
@@ -113,7 +112,7 @@ static void f2fs_write_end_io(struct bio *bio)
 			mapping_set_error(page->mapping, -EIO);
 			f2fs_stop_checkpoint(sbi, true);
 		}
-		dec_page_count(sbi, type);
+		dec_page_count(sbi, WB_DATA_TYPE(page));
 		clear_cold_data(page);
 		end_page_writeback(page);
 	}
@@ -389,7 +388,7 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 	fio->submitted = 1;
 
 	if (!is_read)
-		inc_page_count(sbi, WB_DATA_TYPE(bio_page));
+		inc_page_count(sbi, WB_DATA_TYPE(fio->page));
 
 	down_write(&io->io_rwsem);
 
@@ -403,7 +402,7 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
 			err = -EAGAIN;
 			if (!is_read)
-				dec_page_count(sbi, WB_DATA_TYPE(bio_page));
+				dec_page_count(sbi, WB_DATA_TYPE(fio->page));
 			goto out_fail;
 		}
 		io->bio = __bio_alloc(sbi, fio->new_blkaddr,
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
