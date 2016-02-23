From: Junling Zheng <zhengjunling@huawei.com>
Subject: [RFC PATCH v2] mkfs.f2fs: recalculate sit_segments by
	max_sit_bitmap_size
Date: Tue, 23 Feb 2016 11:46:54 +0800
Message-ID: <1456199214-4865-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1aY477-0008A1-L7
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 03:58:17 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aY474-0008FA-Py
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 03:58:17 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org

In most cases, sit_bitmap_size is smaller than MAX_SIT_BITMAP_SIZE.

However, in some extreme scenarios, such as 16TB, sit_bitmap_size
could be larger than MAX_SIT_BITMAP_SIZE.

In this case, we should recalculate the sit_segments through
max_sit_bitmap_size to prevent sit_ver_bitmap_bytesize got from
segment_count_sit in f2fs_write_check_point_pack() being over
MAX_SIT_BITMAP_SIZE.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 mkfs/f2fs_format.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 645c2aa..3a050e0 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -191,6 +191,22 @@ static int f2fs_prepare_super_block(void)
 
 	sit_segments = SEG_ALIGN(blocks_for_sit);
 
+	/*
+	 * In most cases, sit_bitmap_size is smaller than MAX_SIT_BITMAP_SIZE.
+	 * However, in an extreme scenario(16TB), sit_bitmap_size could be larger
+	 * than MAX_SIT_BITMAP_SIZE. Thus, we should recalculate the sit_segments
+	 * to prevent sit_ver_bitmap_bytesize got from segment_count_sit in
+	 * f2fs_write_check_point_pack() being over MAX_SIT_BITMAP_SIZE.
+	 */
+	sit_bitmap_size = (sit_segments << log_blks_per_seg) / 8;
+
+	if (sit_bitmap_size > MAX_SIT_BITMAP_SIZE) {
+		max_sit_bitmap_size = MAX_SIT_BITMAP_SIZE;
+		sit_segments = max_sit_bitmap_size * 8 >> log_blks_per_seg;
+		blocks_for_sit = sit_segments << log_blks_per_seg;
+	} else
+		max_sit_bitmap_size = sit_bitmap_size;
+
 	set_sb(segment_count_sit, sit_segments * 2);
 
 	set_sb(nat_blkaddr, get_sb(sit_blkaddr) + get_sb(segment_count_sit) *
@@ -208,13 +224,6 @@ static int f2fs_prepare_super_block(void)
 	 * This number resizes NAT bitmap area in a CP page.
 	 * So the threshold is determined not to overflow one CP page
 	 */
-	sit_bitmap_size = ((get_sb(segment_count_sit) / 2) <<
-				log_blks_per_seg) / 8;
-
-	if (sit_bitmap_size > MAX_SIT_BITMAP_SIZE)
-		max_sit_bitmap_size = MAX_SIT_BITMAP_SIZE;
-	else
-		max_sit_bitmap_size = sit_bitmap_size;
 
 	/*
 	 * It should be reserved minimum 1 segment for nat.
-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
