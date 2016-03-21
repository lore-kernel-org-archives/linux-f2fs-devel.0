From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: cover large section in sanity check of
	super
Date: Mon, 21 Mar 2016 11:56:04 -0700
Message-ID: <1458586565-8827-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ai4zw-0007Xn-Mb
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 18:56:16 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ai4zv-0004nm-KL
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 18:56:16 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, "stable 4 . 5+" <stable@vger.kernel.org>

This patch fixes the bug which does not cover a large section case when checking
the sanity of superblock.

Reported-by: Matthias Prager <linux@matthiasprager.de>
Reported-by: David Gnedt <david.gnedt@davizone.at>
Cc: stable 4.5+ <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 15bb81f..fc9147f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1000,6 +1000,7 @@ static inline bool sanity_check_area_boundary(struct super_block *sb,
 	u32 segment_count_main = le32_to_cpu(raw_super->segment_count_main);
 	u32 segment_count = le32_to_cpu(raw_super->segment_count);
 	u32 log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
+	u32 segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
 
 	if (segment0_blkaddr != cp_blkaddr) {
 		f2fs_msg(sb, KERN_INFO,
@@ -1044,12 +1045,26 @@ static inline bool sanity_check_area_boundary(struct super_block *sb,
 		return true;
 	}
 
-	if (main_blkaddr + (segment_count_main << log_blocks_per_seg) !=
+	if (segs_per_sec == 1 &&
+		main_blkaddr + (segment_count_main << log_blocks_per_seg) !=
 		segment0_blkaddr + (segment_count << log_blocks_per_seg)) {
 		f2fs_msg(sb, KERN_INFO,
 			"Wrong MAIN_AREA boundary, start(%u) end(%u) blocks(%u)",
 			main_blkaddr,
-			segment0_blkaddr + (segment_count << log_blocks_per_seg),
+			segment0_blkaddr +
+			(segment_count << log_blocks_per_seg),
+			segment_count_main << log_blocks_per_seg);
+		return true;
+	}
+
+	if (segs_per_sec > 1 &&
+		main_blkaddr + (segment_count_main << log_blocks_per_seg) >
+		segment0_blkaddr + (segment_count << log_blocks_per_seg)) {
+		f2fs_msg(sb, KERN_INFO,
+			"Wrong MAIN_AREA boundary in large section, start(%u) end(%u) blocks(%u)",
+			main_blkaddr,
+			segment0_blkaddr +
+			(segment_count << log_blocks_per_seg),
 			segment_count_main << log_blocks_per_seg);
 		return true;
 	}
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
