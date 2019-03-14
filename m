From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 1/2] f2fs: Fix use of number of devices
Date: Fri, 15 Mar 2019 01:37:06 +0900
Message-ID: <20190314163707.14364-2-damien.lemoal@wdc.com>
References: <20190314163707.14364-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=969fcb079=damien.lemoal@wdc.com>)
 id 1h4TMR-0004Y5-06
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Mar 2019 16:37:39 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h4TMP-0012Dg-4I
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Mar 2019 16:37:38 +0000
In-Reply-To: <20190314163707.14364-1-damien.lemoal@wdc.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, Masato Suzuki <masato.suzuki@wdc.com>, Matias Bjorling <matias.bjorling@wdc.com>

For a single device mount using a zoned block device, the zone
information for the device is stored in the sbi->devs single entry
array and sbi->s_ndevs is set to 1. This differs from a single device
mount using a regular block device which does not allocate sbi->devs
and sets sbi->s_ndevs to 0.

However, sbi->s_devs == 0 condition is used throughout the code to
differentiate a single device mount from a multi-device mount where
sbi->s_ndevs is always larger than 1. This results in problems with
single zoned block device volumes as these are treated as multi-device
mounts but do not have the start_blk and end_blk information set. One
of the problem observed is skipping of zone discard issuing resulting in
write commands being issued to full zones or unaligned to a zone write
pointer.

Fix this problem by simply treating the cases sbi->s_ndevs == 0 (single
regular block device mount) and sbi->s_ndevs == 1 (single zoned block
device mount) in the same manner. This is done by introducing the
helper function f2fs_is_multi_device() and using thius helper in place
of direct tests of sbi->s_ndevs value, improving code readability.

Fixes: 7bb3a371d199 ("f2fs: Fix zoned block device support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/data.c    | 17 +++++++++++------
 fs/f2fs/f2fs.h    | 13 ++++++++++++-
 fs/f2fs/file.c    |  2 +-
 fs/f2fs/gc.c      |  2 +-
 fs/f2fs/segment.c | 13 +++++++------
 5 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 568e1d09eb48..91dd8407ba86 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -220,12 +220,14 @@ struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
 	struct block_device *bdev = sbi->sb->s_bdev;
 	int i;
 
-	for (i = 0; i < sbi->s_ndevs; i++) {
-		if (FDEV(i).start_blk <= blk_addr &&
-					FDEV(i).end_blk >= blk_addr) {
-			blk_addr -= FDEV(i).start_blk;
-			bdev = FDEV(i).bdev;
-			break;
+	if (f2fs_is_multi_device(sbi)) {
+		for (i = 0; i < sbi->s_ndevs; i++) {
+			if (FDEV(i).start_blk <= blk_addr &&
+			    FDEV(i).end_blk >= blk_addr) {
+				blk_addr -= FDEV(i).start_blk;
+				bdev = FDEV(i).bdev;
+				break;
+			}
 		}
 	}
 	if (bio) {
@@ -239,6 +241,9 @@ int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	int i;
 
+	if (!f2fs_is_multi_device(sbi))
+		return 0;
+
 	for (i = 0; i < sbi->s_ndevs; i++)
 		if (FDEV(i).start_blk <= blkaddr && FDEV(i).end_blk >= blkaddr)
 			return i;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7ea5c9cede37..073f450af346 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1364,6 +1364,17 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 }
 #endif
 
+/*
+ * Test if the current moun t super block is a multi-device volume.
+ * For single device regular disks, sbi->s_ndevs is 0.
+ * For single device zoned disks, sbi->s_ndevs is 1.
+ * For multi-device mounts, sbi->s_ndevs is always 2 or more.
+ */
+static inline bool f2fs_is_multi_device(struct f2fs_sb_info *sbi)
+{
+	return sbi->s_ndevs > 1;
+}
+
 /* For write statistics. Suppose sector size is 512 bytes,
  * and the return value is in kbytes. s is of struct f2fs_sb_info.
  */
@@ -3586,7 +3597,7 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 
 	if (f2fs_post_read_required(inode))
 		return true;
-	if (sbi->s_ndevs)
+	if (f2fs_is_multi_device(sbi))
 		return true;
 	/*
 	 * for blkzoned device, fallback direct IO to buffered IO, so
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ba5954f41e14..1e3a78bf7a66 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2571,7 +2571,7 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
 							sizeof(range)))
 		return -EFAULT;
 
-	if (sbi->s_ndevs <= 1 || sbi->s_ndevs - 1 <= range.dev_num ||
+	if (!f2fs_is_multi_device(sbi) || sbi->s_ndevs - 1 <= range.dev_num ||
 			__is_large_section(sbi)) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
 			"Can't flush %u in %d for segs_per_sec %u != 1\n",
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 195cf0f9d9ef..ab764bd106de 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1346,7 +1346,7 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 	sbi->gc_pin_file_threshold = DEF_GC_FAILED_PINNED_FILES;
 
 	/* give warm/cold data area from slower device */
-	if (sbi->s_ndevs && !__is_large_section(sbi))
+	if (f2fs_is_multi_device(sbi) && !__is_large_section(sbi))
 		SIT_I(sbi)->last_victim[ALLOC_NEXT] =
 				GET_SEGNO(sbi, FDEV(0).end_blk) + 1;
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9b79056d705d..d8f531b33350 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -560,7 +560,7 @@ static int submit_flush_wait(struct f2fs_sb_info *sbi, nid_t ino)
 	int ret = 0;
 	int i;
 
-	if (!sbi->s_ndevs)
+	if (!f2fs_is_multi_device(sbi))
 		return __submit_flush_wait(sbi, sbi->sb->s_bdev);
 
 	for (i = 0; i < sbi->s_ndevs; i++) {
@@ -628,7 +628,8 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino)
 		return ret;
 	}
 
-	if (atomic_inc_return(&fcc->queued_flush) == 1 || sbi->s_ndevs > 1) {
+	if (atomic_inc_return(&fcc->queued_flush) == 1 ||
+	    f2fs_is_multi_device(sbi)) {
 		ret = submit_flush_wait(sbi, ino);
 		atomic_dec(&fcc->queued_flush);
 
@@ -734,7 +735,7 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 {
 	int ret = 0, i;
 
-	if (!sbi->s_ndevs)
+	if (!f2fs_is_multi_device(sbi))
 		return 0;
 
 	for (i = 1; i < sbi->s_ndevs; i++) {
@@ -1343,7 +1344,7 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
 
 	trace_f2fs_queue_discard(bdev, blkstart, blklen);
 
-	if (sbi->s_ndevs) {
+	if (f2fs_is_multi_device(sbi)) {
 		int devi = f2fs_target_device_index(sbi, blkstart);
 
 		blkstart -= FDEV(devi).start_blk;
@@ -1698,7 +1699,7 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 	block_t lblkstart = blkstart;
 	int devi = 0;
 
-	if (sbi->s_ndevs) {
+	if (f2fs_is_multi_device(sbi)) {
 		devi = f2fs_target_device_index(sbi, blkstart);
 		blkstart -= FDEV(devi).start_blk;
 	}
@@ -3055,7 +3056,7 @@ static void update_device_state(struct f2fs_io_info *fio)
 	struct f2fs_sb_info *sbi = fio->sbi;
 	unsigned int devidx;
 
-	if (!sbi->s_ndevs)
+	if (!f2fs_is_multi_device(sbi))
 		return;
 
 	devidx = f2fs_target_device_index(sbi, fio->new_blkaddr);
-- 
2.20.1
