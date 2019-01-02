From: sunqiuyang <sunqiuyang@huawei.com>
Subject: [PATCH 2/2] fs: support direct IO in a multi-device FS
Date: Wed, 2 Jan 2019 17:07:18 +0800
Message-ID: <20190102090718.8115-1-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: sunqiuyang@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Qiuyang Sun <sunqiuyang@huawei.com>

Don't use the bdev pointer in struct buffer_head for dio_bio_alloc(),
since it may have been changed to another device in the FS in
get_more_blocks().

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/direct-io.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 722d17c..6cd6029 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -99,6 +99,7 @@ struct dio_submit {
 	unsigned cur_page_offset;	/* Offset into it, in bytes */
 	unsigned cur_page_len;		/* Nr of bytes at cur_page_offset */
 	sector_t cur_page_block;	/* Where it starts */
+	struct block_device *cur_page_dev;
 	loff_t cur_page_fs_offset;	/* Offset in file */
 
 	struct iov_iter *iter;
@@ -729,7 +730,7 @@ static int get_more_blocks(struct dio *dio, struct dio_submit *sdio,
  * There is no bio.  Make one now.
  */
 static inline int dio_new_bio(struct dio *dio, struct dio_submit *sdio,
-		sector_t start_sector, struct buffer_head *map_bh)
+		sector_t start_sector)
 {
 	sector_t sector;
 	int ret, nr_pages;
@@ -740,7 +741,7 @@ static inline int dio_new_bio(struct dio *dio, struct dio_submit *sdio,
 	sector = start_sector << (sdio->blkbits - 9);
 	nr_pages = min(sdio->pages_in_io, BIO_MAX_PAGES);
 	BUG_ON(nr_pages <= 0);
-	dio_bio_alloc(dio, sdio, map_bh->b_bdev, sector, nr_pages);
+	dio_bio_alloc(dio, sdio, sdio->cur_page_dev, sector, nr_pages);
 	sdio->boundary = 0;
 out:
 	return ret;
@@ -785,8 +786,7 @@ static inline int dio_bio_add_page(struct dio_submit *sdio)
  * The caller of this function is responsible for removing cur_page from the
  * dio, and for dropping the refcount which came from that presence.
  */
-static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
-		struct buffer_head *map_bh)
+static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio)
 {
 	int ret = 0;
 
@@ -815,14 +815,14 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 	}
 
 	if (sdio->bio == NULL) {
-		ret = dio_new_bio(dio, sdio, sdio->cur_page_block, map_bh);
+		ret = dio_new_bio(dio, sdio, sdio->cur_page_block);
 		if (ret)
 			goto out;
 	}
 
 	if (dio_bio_add_page(sdio) != 0) {
 		dio_bio_submit(dio, sdio);
-		ret = dio_new_bio(dio, sdio, sdio->cur_page_block, map_bh);
+		ret = dio_new_bio(dio, sdio, sdio->cur_page_block);
 		if (ret == 0) {
 			ret = dio_bio_add_page(sdio);
 			BUG_ON(ret != 0);
@@ -878,7 +878,7 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 	 * If there's a deferred page already there then send it.
 	 */
 	if (sdio->cur_page) {
-		ret = dio_send_cur_page(dio, sdio, map_bh);
+		ret = dio_send_cur_page(dio, sdio);
 		put_page(sdio->cur_page);
 		sdio->cur_page = NULL;
 		if (ret)
@@ -890,6 +890,7 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 	sdio->cur_page_offset = offset;
 	sdio->cur_page_len = len;
 	sdio->cur_page_block = blocknr;
+	sdio->cur_page_dev = map_bh->b_bdev;
 	sdio->cur_page_fs_offset = sdio->block_in_file << sdio->blkbits;
 out:
 	/*
@@ -897,7 +898,7 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 	 * avoid metadata seeks.
 	 */
 	if (sdio->boundary) {
-		ret = dio_send_cur_page(dio, sdio, map_bh);
+		ret = dio_send_cur_page(dio, sdio);
 		if (sdio->bio)
 			dio_bio_submit(dio, sdio);
 		put_page(sdio->cur_page);
@@ -1348,7 +1349,7 @@ static inline int drop_refcount(struct dio *dio)
 	if (sdio.cur_page) {
 		ssize_t ret2;
 
-		ret2 = dio_send_cur_page(dio, &sdio, &map_bh);
+		ret2 = dio_send_cur_page(dio, &sdio);
 		if (retval == 0)
 			retval = ret2;
 		put_page(sdio.cur_page);
-- 
1.8.3.1
