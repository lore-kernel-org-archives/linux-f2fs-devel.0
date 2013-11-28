From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: f2fs: introduce f2fs_issue_discard() to clean up
Date: Thu, 28 Nov 2013 13:04:47 +0900
Message-ID: <1385611487.2417.40.camel@kjgkr>
References: <20131126145315.GA27436@elgon.mountain>
	<1385520381.2417.17.camel@kjgkr> <20131127083117.GT5443@mwanda>
	<1385543097.2417.35.camel@kjgkr> <20131127104130.GW5443@mwanda>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VlsrZ-0002gs-0a
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 04:06:01 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VlsrW-0004MK-KD
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 04:06:00 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWY00KPKGPIWO00@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 13:05:42 +0900 (KST)
In-reply-to: <20131127104130.GW5443@mwanda>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Thank you Dan.

I wrote two patches to address the warnings below.
Thanks.

>From 1745cd1e14eff75089a8d88fe07f07549e1f3946 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Thu, 28 Nov 2013 12:44:05 +0900
Subject: [PATCH 1/2] f2fs: bug fix on bit overflow from 32bits to 64bits
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
linux-f2fs-devel@lists.sourceforge.net

This patch fixes some bit overflows by the shift operations.

Dan Carpenter reported potential bugs on bit overflows as follows.

fs/f2fs/segment.c:910 submit_write_page()
	warn: should 'blk_addr << ((sbi)->log_blocksize - 9)' be a 64 bit type?
fs/f2fs/checkpoint.c:429 get_valid_checkpoint()
	warn: should '1 << ()' be a 64 bit type?
fs/f2fs/data.c:408 f2fs_readpage()
	warn: should 'blk_addr << ((sbi)->log_blocksize - 9)' be a 64 bit type?
fs/f2fs/data.c:457 submit_read_page()
	warn: should 'blk_addr << ((sbi)->log_blocksize - 9)' be a 64 bit type?
fs/f2fs/data.c:525 get_data_block_ro()
	warn: should 'i << blkbits' be a 64 bit type?

Bug-Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c | 3 ++-
 fs/f2fs/data.c       | 2 +-
 fs/f2fs/segment.c    | 4 ++--
 fs/f2fs/segment.h    | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3e62987..21e7215 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -426,7 +426,8 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	cp1 = validate_checkpoint(sbi, cp_start_blk_no, &cp1_version);
 
 	/* The second checkpoint pack should start at the next segment */
-	cp_start_blk_no += 1 << le32_to_cpu(fsb->log_blocks_per_seg);
+	cp_start_blk_no += ((unsigned long long)1) <<
+				le32_to_cpu(fsb->log_blocks_per_seg);
 	cp2 = validate_checkpoint(sbi, cp_start_blk_no, &cp2_version);
 
 	if (cp1 && cp2) {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8e2937d..899d78c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -525,7 +525,7 @@ static int get_data_block_ro(struct inode *inode,
sector_t iblock,
 				!= (dn.data_blkaddr + i)) || maxblocks == i)
 				break;
 		map_bh(bh_result, inode->i_sb, dn.data_blkaddr);
-		bh_result->b_size = (i << blkbits);
+		bh_result->b_size = (((size_t)i) << blkbits);
 	}
 	f2fs_put_dnode(&dn);
 	trace_f2fs_get_data_block(inode, iblock, bh_result, 0);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1e837139..fc0a10c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -270,8 +270,8 @@ static void locate_dirty_segment(struct f2fs_sb_info
*sbi, unsigned int segno)
 static void f2fs_issue_discard(struct f2fs_sb_info *sbi,
 				block_t blkstart, block_t blklen)
 {
-	sector_t start = ((sector_t)blkstart) << sbi->log_sectors_per_block;
-	sector_t len = ((sector_t)blklen) << sbi->log_sectors_per_block;
+	sector_t start = SECTOR_FROM_BLOCK(sbi, blkstart);
+	sector_t len = SECTOR_FROM_BLOCK(blklen);
 	blkdev_issue_discard(sbi->sb->s_bdev, start, len, GFP_NOFS, 0);
 	trace_f2fs_issue_discard(sbi->sb, blkstart, blklen);
 }
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b84dd23..07887e1 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -86,9 +86,9 @@
 #define TOTAL_SECS(sbi)	(sbi->total_sections)
 
 #define SECTOR_FROM_BLOCK(sbi, blk_addr)				\
-	(blk_addr << ((sbi)->log_blocksize - F2FS_LOG_SECTOR_SIZE))
+	(((sector_t)blk_addr) << (sbi)->log_sectors_per_block)
 #define SECTOR_TO_BLOCK(sbi, sectors)					\
-	(sectors >> ((sbi)->log_blocksize - F2FS_LOG_SECTOR_SIZE))
+	(sectors >> (sbi)->log_sectors_per_block)
 #define MAX_BIO_BLOCKS(max_hw_blocks)					\
 	(min((int)max_hw_blocks, BIO_MAX_PAGES))
 
-- 
1.8.4.474.g128a96c

>From 478cabf84b707e4bf857fc6f9d1233511faa4072 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Thu, 28 Nov 2013 12:55:13 +0900
Subject: [PATCH 2/2] f2fs: remove unnecessary condition checks
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
linux-f2fs-devel@lists.sourceforge.net

This patch removes the unnecessary condition checks on:

fs/f2fs/gc.c:667 do_garbage_collect() warn: 'sum_page' isn't an ERR_PTR
fs/f2fs/f2fs.h:795 f2fs_put_page() warn: 'page' isn't an ERR_PTR

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h | 2 +-
 fs/f2fs/gc.c   | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3134259..ea8a05c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -793,7 +793,7 @@ static inline unsigned int valid_inode_count(struct
f2fs_sb_info *sbi)
 
 static inline void f2fs_put_page(struct page *page, int unlock)
 {
-	if (!page || IS_ERR(page))
+	if (!page)
 		return;
 
 	if (unlock) {
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b7ad1ec..5fa54c1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -664,8 +664,6 @@ static void do_garbage_collect(struct f2fs_sb_info
*sbi, unsigned int segno,
 
 	/* read segment summary of victim */
 	sum_page = get_sum_page(sbi, segno);
-	if (IS_ERR(sum_page))
-		return;
 
 	blk_start_plug(&plug);
 
-- 
1.8.4.474.g128a96c




-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
