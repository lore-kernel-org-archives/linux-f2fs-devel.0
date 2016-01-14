From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] fsck.f2fs: swap checkpoint crc to CPU endian
Date: Thu, 14 Jan 2016 09:13:04 +0000
Message-ID: <1452762784-21836-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1aJWjR-0005ao-CP
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 Jan 2016 01:29:45 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aJWjN-0003cr-1E
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 Jan 2016 01:29:45 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/mount.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index c758774..b5fbaaa 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -390,7 +390,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 	if (crc_offset >= blk_size)
 		goto invalid_cp1;
 
-	crc = *(unsigned int *)((unsigned char *)cp + crc_offset);
+	crc = le32_to_cpu(*(__le32 *)((unsigned char *)cp + crc_offset));
 	if (f2fs_crc_valid(crc, cp, crc_offset))
 		goto invalid_cp1;
 
@@ -408,7 +408,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 	if (crc_offset >= blk_size)
 		goto invalid_cp2;
 
-	crc = *(unsigned int *)((unsigned char *)cp + crc_offset);
+	crc = le32_to_cpu(*(__le32 *)((unsigned char *)cp + crc_offset));
 	if (f2fs_crc_valid(crc, cp, crc_offset))
 		goto invalid_cp2;
 
-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
