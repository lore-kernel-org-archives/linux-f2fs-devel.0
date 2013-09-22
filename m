From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: avoid allocating failure in bio_alloc
Date: Sun, 22 Sep 2013 15:50:50 +0800
Message-ID: <000001ceb768$9478ce70$bd6a6b50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VNeSO-0007Yk-NP
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Sep 2013 07:51:52 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VNeSM-00025o-TG for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Sep 2013 07:51:52 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MTI00E00OI7IV30@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Sep 2013 16:51:43 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim Jaegeuk <jaegeuk.kim@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, =?gb2312?B?zLfmrQ==?= <shu.tan@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch add macro MAX_BIO_BLOCKS to limit value of npages in
f2fs_bio_alloc, it can avoid allocating failure in bio_alloc caused by
npages is larger than BIO_MAX_PAGES.

Signed-off-by: Yu Chao <chao2.yu@samsung.com>
---
 fs/f2fs/segment.c |    4 +++-
 fs/f2fs/segment.h |    2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 09af9c7..bd79bbe 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -657,6 +657,7 @@ static void submit_write_page(struct f2fs_sb_info *sbi,
struct page *page,
 				block_t blk_addr, enum page_type type)
 {
 	struct block_device *bdev = sbi->sb->s_bdev;
+	int bio_blocks;
 
 	verify_block_addr(sbi, blk_addr);
 
@@ -676,7 +677,8 @@ retry:
 			goto retry;
 		}
 
-		sbi->bio[type] = f2fs_bio_alloc(bdev, max_hw_blocks(sbi));
+		bio_blocks = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
+		sbi->bio[type] = f2fs_bio_alloc(bdev, bio_blocks);
 		sbi->bio[type]->bi_sector = SECTOR_FROM_BLOCK(sbi,
blk_addr);
 		sbi->bio[type]->bi_private = priv;
 		/*
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index bdd10ea..7f94d78 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -90,6 +90,8 @@
 	(blk_addr << ((sbi)->log_blocksize - F2FS_LOG_SECTOR_SIZE))
 #define SECTOR_TO_BLOCK(sbi, sectors)					\
 	(sectors >> ((sbi)->log_blocksize - F2FS_LOG_SECTOR_SIZE))
+#define MAX_BIO_BLOCKS(max_hw_blocks)					\
+	(min((int)max_hw_blocks, BIO_MAX_PAGES))
 
 /* during checkpoint, bio_private is used to synchronize the last bio */
 struct bio_private {
---


------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/22/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=64545871&iu=/4140/ostg.clktrk
