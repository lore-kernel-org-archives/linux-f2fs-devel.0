From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH] fsck.f2fs: remove duplicated codes in
	sanity_check_raw_super
Date: Tue, 26 Apr 2016 10:23:32 +0800
Message-ID: <1461637412-30729-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1ausr6-0007Bz-JF
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 02:36:04 +0000
Received: from [119.145.14.66] (helo=szxga03-in.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ausqy-00038H-By
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 02:36:04 +0000
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

Remove duplicated codes in sanity_check_raw_super().

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/mount.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 4bde179..f866c4f 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -376,10 +376,6 @@ int sanity_check_raw_super(struct f2fs_super_block *sb, u64 offset)
 	if (get_sb(log_blocks_per_seg) != 9)
 		return -1;
 
-	if (get_sb(log_sectorsize) > F2FS_MAX_LOG_SECTOR_SIZE ||
-			get_sb(log_sectorsize) < F2FS_MIN_LOG_SECTOR_SIZE)
-		return -1;
-
 	/* Currently, support 512/1024/2048/4096 bytes sector size */
 	if (get_sb(log_sectorsize) > F2FS_MAX_LOG_SECTOR_SIZE ||
 			get_sb(log_sectorsize) < F2FS_MIN_LOG_SECTOR_SIZE)
-- 
1.9.1


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
