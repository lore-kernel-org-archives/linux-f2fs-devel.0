From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 3/3] f2fs: improve discard handling with
 multi-device volumes
Date: Sat, 16 Mar 2019 09:13:08 +0900
Message-ID: <20190316001308.18115-4-damien.lemoal@wdc.com>
References: <20190316001308.18115-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=9710b8926=damien.lemoal@wdc.com>)
 id 1h4wxD-0003HH-Rp
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 16 Mar 2019 00:13:35 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h4wxC-00GoGN-Al
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 16 Mar 2019 00:13:35 +0000
In-Reply-To: <20190316001308.18115-1-damien.lemoal@wdc.com>
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

f2fs_hw_support_discard() only tests if the super block device supports
discard. However, for a multi-device volume, not all disks used may
support discard. Improve the check performed to test all devices of
the volume and report discard as supported if at least one device of
the volume supports discard. To implement this, introduce the helper
function f2fs_bdev_support_discard(), which returns true for zoned block
devices (where discard is processed as a zone reset) and for regular
disks supporting the discard command.

f2fs_bdev_support_discard() is also used in __queue_discard_cmd() to
handle discard command issuing for a particular device of the volume.
That is, prevent issuing a discard command for block devices that do
not support it.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/f2fs.h    | 16 +++++++++++++++-
 fs/f2fs/segment.c |  8 ++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 576e637ef568..db4564c6531d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3527,9 +3527,23 @@ static inline bool f2fs_hw_should_discard(struct f2fs_sb_info *sbi)
 	return f2fs_sb_has_blkzoned(sbi);
 }
 
+static inline bool f2fs_bdev_support_discard(struct block_device *bdev)
+{
+	return blk_queue_discard(bdev_get_queue(bdev)) ||
+	       bdev_is_zoned(bdev);
+}
+
 static inline bool f2fs_hw_support_discard(struct f2fs_sb_info *sbi)
 {
-	return blk_queue_discard(bdev_get_queue(sbi->sb->s_bdev));
+	int i;
+
+	if (!f2fs_is_multi_device(sbi))
+		return f2fs_bdev_support_discard(sbi->sb->s_bdev);
+
+	for (i = 0; i < sbi->s_ndevs; i++)
+		if (f2fs_bdev_support_discard(FDEV(i).bdev))
+			return true;
+	return false;
 }
 
 static inline bool f2fs_realtime_discard_enable(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f40148b735d7..9b320dd1c9d7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1342,6 +1342,9 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
 {
 	block_t lblkstart = blkstart;
 
+	if (!f2fs_bdev_support_discard(bdev))
+		return 0;
+
 	trace_f2fs_queue_discard(bdev, blkstart, blklen);
 
 	if (f2fs_is_multi_device(sbi)) {
@@ -1728,8 +1731,6 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 	}
 
 	/* For conventional zones, use regular discard if supported */
-	if (!blk_queue_discard(bdev_get_queue(bdev)))
-		return 0;
 	return __queue_discard_cmd(sbi, bdev, lblkstart, blklen);
 }
 #endif
@@ -1738,8 +1739,7 @@ static int __issue_discard_async(struct f2fs_sb_info *sbi,
 		struct block_device *bdev, block_t blkstart, block_t blklen)
 {
 #ifdef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_has_blkzoned(sbi) &&
-				bdev_zoned_model(bdev) != BLK_ZONED_NONE)
+	if (f2fs_sb_has_blkzoned(sbi) && bdev_is_zoned(bdev))
 		return __f2fs_issue_discard_zone(sbi, bdev, blkstart, blklen);
 #endif
 	return __queue_discard_cmd(sbi, bdev, blkstart, blklen);
-- 
2.20.1
