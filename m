From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: should check the type of end_io after
 pullback by fscrypto
Date: Fri,  6 Jul 2018 14:09:03 -0700
Message-ID: <20180706210903.77887-4-jaegeuk@kernel.org>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fbXyc-000116-FA
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 21:09:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fbXyb-00EoSW-44
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 21:09:14 +0000
In-Reply-To: <20180706210903.77887-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This fixes to get the page type after pullback by fscrypto, since the original
page is bounce page but we should need to get control page which is what we
originally submitted.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c3f9b9baf140..9a0fcec53d0e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -152,7 +152,6 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	bio_for_each_segment_all(bvec, bio, i) {
 		struct page *page = bvec->bv_page;
-		enum count_type type = WB_DATA_TYPE(page);
 
 		if (IS_DUMMY_WRITTEN_PAGE(page)) {
 			set_page_private(page, (unsigned long)NULL);
@@ -169,14 +168,14 @@ static void f2fs_write_end_io(struct bio *bio)
 
 		if (unlikely(bio->bi_status)) {
 			mapping_set_error(page->mapping, -EIO);
-			if (type == F2FS_WB_CP_DATA)
+			if (WB_DATA_TYPE(page) == F2FS_WB_CP_DATA)
 				f2fs_stop_checkpoint(sbi, true);
 		}
 
 		f2fs_bug_on(sbi, page->mapping == NODE_MAPPING(sbi) &&
 					page->index != nid_of_node(page));
 
-		dec_page_count(sbi, type);
+		dec_page_count(sbi, WB_DATA_TYPE(page));
 		clear_cold_data(page);
 		end_page_writeback(page);
 	}
-- 
2.17.0.441.gb46fe60e1d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
