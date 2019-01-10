From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] loop: drop caches if offset or block_size are changed
Date: Wed,  9 Jan 2019 19:17:14 -0800
Message-ID: <20190110031714.39000-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If we don't drop caches used in old offset or block_size, we can get old data
from new offset/block_size, which gives unexpected data to user.

For example, Martijn found a loopback bug in the below scenario.
1) LOOP_SET_FD loads first two pages on loop file
2) LOOP_SET_STATUS64 changes the offset on the loop file
3) mount is failed due to the cached pages having wrong superblock

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Reported-by: Martijn Coenen <maco@google.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 drivers/block/loop.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b8a0720d3653..cf5538942834 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1190,6 +1190,12 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		goto out_unlock;
 	}
 
+	if (lo->lo_offset != info->lo_offset ||
+	    lo->lo_sizelimit != info->lo_sizelimit) {
+		sync_blockdev(lo->lo_device);
+		kill_bdev(lo->lo_device);
+	}
+
 	/* I/O need to be drained during transfer transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
@@ -1218,6 +1224,14 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
+		/* kill_bdev should have truncated all the pages */
+		if (lo->lo_device->bd_inode->i_mapping->nrpages) {
+			err = -EAGAIN;
+			pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
+				__func__, lo->lo_number, lo->lo_file_name,
+				lo->lo_device->bd_inode->i_mapping->nrpages);
+			goto out_unfreeze;
+		}
 		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
 			err = -EFBIG;
 			goto out_unfreeze;
@@ -1443,22 +1457,39 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 
 static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 {
+	int err = 0;
+
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
 
 	if (arg < 512 || arg > PAGE_SIZE || !is_power_of_2(arg))
 		return -EINVAL;
 
+	if (lo->lo_queue->limits.logical_block_size != arg) {
+		sync_blockdev(lo->lo_device);
+		kill_bdev(lo->lo_device);
+	}
+
 	blk_mq_freeze_queue(lo->lo_queue);
 
+	/* kill_bdev should have truncated all the pages */
+	if (lo->lo_queue->limits.logical_block_size != arg &&
+			lo->lo_device->bd_inode->i_mapping->nrpages) {
+		err = -EAGAIN;
+		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
+			__func__, lo->lo_number, lo->lo_file_name,
+			lo->lo_device->bd_inode->i_mapping->nrpages);
+		goto out_unfreeze;
+	}
+
 	blk_queue_logical_block_size(lo->lo_queue, arg);
 	blk_queue_physical_block_size(lo->lo_queue, arg);
 	blk_queue_io_min(lo->lo_queue, arg);
 	loop_update_dio(lo);
-
+out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	return 0;
+	return err;
 }
 
 static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
-- 
2.19.0.605.g01d371f741-goog
