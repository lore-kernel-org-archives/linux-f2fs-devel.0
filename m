From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: fix to cover io->bio with io_rwsem
Date: Wed, 02 Apr 2014 12:41:49 +0900
Message-ID: <1396410109-20156-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

In the f2fs_wait_on_page_writeback, io->bio should be covered by io_rwsem.
Otherwise, the bio pointer can become a dangling pointer due to data races.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/segment.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cb49e63..f799c6a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1049,15 +1049,14 @@ static inline bool is_merged_page(struct f2fs_sb_info *sbi,
 {
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
 	struct f2fs_bio_info *io = &sbi->write_io[btype];
-	struct bio *bio = io->bio;
 	struct bio_vec *bvec;
 	int i;
 
 	down_read(&io->io_rwsem);
-	if (!bio)
+	if (!io->bio)
 		goto out;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all(bvec, io->bio, i) {
 		if (page == bvec->bv_page) {
 			up_read(&io->io_rwsem);
 			return true;
-- 
1.8.4.474.g128a96c

