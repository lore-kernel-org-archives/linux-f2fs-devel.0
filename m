From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH RESEND] f2fs: avoid allocating failure in
	bio_alloc
Date: Fri, 13 Sep 2013 21:27:22 +0800
Message-ID: <000301ceb085$13189480$3949bd80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VKTPw-0006tX-5U
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Sep 2013 13:28:12 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VKTPu-00038D-8Y for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Sep 2013 13:28:12 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MT20078FG2MIOT0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Sep 2013 22:28:03 +0900 (KST)
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
f2fs_bio_alloc,
it can avoid allocating failure in bio_alloc caused by npages is larger than
UIO_MAXIOV.

Signed-off-by: Yu Chao <chao2.yu@samsung.com>
 ---
 fs/f2fs/segment.c |    4 +++-
 fs/f2fs/segment.h |    3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 09af9c7..bd79bbe 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -657,6 +657,7 @@ static void submit_write_page(struct f2fs_sb_info *sbi,
struct page *page,
                                block_t blk_addr, enum page_type type)
 {
        struct block_device *bdev = sbi->sb->s_bdev;
+       int bio_blocks;
 
        verify_block_addr(sbi, blk_addr);
 
@@ -676,7 +677,8 @@ retry:
                        goto retry;
                }
 
-               sbi->bio[type] = f2fs_bio_alloc(bdev, max_hw_blocks(sbi));
+               bio_blocks = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
+               sbi->bio[type] = f2fs_bio_alloc(bdev, bio_blocks);
                sbi->bio[type]->bi_sector = SECTOR_FROM_BLOCK(sbi,
blk_addr);
                sbi->bio[type]->bi_private = priv;
                /*
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index bdd10ea..6352af1 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/blkdev.h>
+#include <linux/uio.h>
 
 /* constant macro */
 #define NULL_SEGNO                     ((unsigned int)(~0))
@@ -90,6 +91,8 @@
        (blk_addr << ((sbi)->log_blocksize - F2FS_LOG_SECTOR_SIZE))
 #define SECTOR_TO_BLOCK(sbi, sectors)                                  \
        (sectors >> ((sbi)->log_blocksize - F2FS_LOG_SECTOR_SIZE))
+#define MAX_BIO_BLOCKS(max_hw_blocks)                                  \
+       (min((int)max_hw_blocks, UIO_MAXIOV))
 
 /* during checkpoint, bio_private is used to synchronize the last bio */
 struct bio_private {
---


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
