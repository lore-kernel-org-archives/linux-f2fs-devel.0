From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: make discard command directly
Date: Wed, 11 Jan 2017 16:48:48 -0800
Message-ID: <20170112004848.37202-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cRTZa-0005vS-Et
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jan 2017 00:48:58 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cRTZZ-0005EO-Fg
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jan 2017 00:48:58 +0000
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

This can reduce the backporting efforts.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0738f48293cc..ebfd5cd7619e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -673,8 +673,8 @@ static void f2fs_submit_bio_wait_endio(struct bio *bio)
 static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
 		struct block_device *bdev, block_t blkstart, block_t blklen)
 {
+	struct bio_entry *be;
 	struct bio *bio = NULL;
-	int err;
 
 	trace_f2fs_issue_discard(sbi->sb, blkstart, blklen);
 
@@ -683,20 +683,24 @@ static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
 
 		blkstart -= FDEV(devi).start_blk;
 	}
-	err = __blkdev_issue_discard(bdev,
-				SECTOR_FROM_BLOCK(blkstart),
-				SECTOR_FROM_BLOCK(blklen),
-				GFP_NOFS, 0, &bio);
-	if (!err && bio) {
-		struct bio_entry *be = __add_bio_entry(sbi, bio);
 
-		bio->bi_private = be;
-		bio->bi_end_io = f2fs_submit_bio_wait_endio;
-		bio->bi_opf |= REQ_SYNC;
-		submit_bio(bio);
-	}
+	if (!blk_queue_discard(bdev_get_queue(bdev)))
+		return 0;
 
-	return err;
+	/* we always submit 4KB-aligned discard commands. */
+	bio = f2fs_bio_alloc(0);
+	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(blkstart);
+	bio->bi_bdev = bdev;
+	bio_set_op_attrs(bio, REQ_OP_DISCARD, 0);
+	bio->bi_iter.bi_size = SECTOR_FROM_BLOCK(blklen) << 9;
+	bio->bi_end_io = f2fs_submit_bio_wait_endio;
+
+	be = __add_bio_entry(sbi, bio);
+
+	bio->bi_private = be;
+	bio->bi_opf |= REQ_SYNC;
+	submit_bio(bio);
+	return 0;
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
-- 
2.11.0


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
