From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH] f2fs: limit nr_iovecs in bio_alloc
Date: Fri, 13 Sep 2013 18:07:23 +0800
Message-ID: <000001ceb069$318a87a0$949f96e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?gb2312?B?zLfmrQ==?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch add macro MAX_BIO_BLOCKS to limit value of npages in
f2fs_bio_alloc,
it can avoid to return NULL in bio_alloc caused by npages is larger than
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
index bdd10ea..9cc95eb 100644
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
+#define MAX_BIO_BLOCK(max_hw_blocks)                                   \
+       (min((int)max_hw_blocks, UIO_MAXIOV))
 
 /* during checkpoint, bio_private is used to synchronize the last bio */
 struct bio_private {
---
