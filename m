From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] fsck.f2fs: add segment type in sit_dump
Date: Thu, 16 Jul 2015 10:10:36 +0800
Message-ID: <1437012636-3300-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ZFYde-0007Bb-Lf
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Jul 2015 02:11:06 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZFYda-0000fT-T6
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Jul 2015 02:11:06 +0000
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

Add segment type information in sit_dump:

	[sit_dump:  48] SIT[0x12905] : 0x  1 : 0
	[sit_dump:  48] SIT[0x12906] : 0x  1 : 5
	[sit_dump:  48] SIT[0x12907] : 0x  7 : 4
	[sit_dump:  48] SIT[0x12908] : 0x  1 : 3

The last column output message on behalf of segment type like
CURSEG_XXX_TYPE.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 8698b28..81a39c8 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -45,7 +45,7 @@ void sit_dump(struct f2fs_sb_info *sbi, int start_sit, int end_sit)
 		ret = write(fd, buf, strlen(buf));
 		ASSERT(ret >= 0);
 
-		DBG(4, "SIT[0x%3x] : 0x%x\n", segno, se->valid_blocks);
+		DBG(4, "SIT[0x%3x] : 0x%3x : %d\n", segno, se->valid_blocks, se->type);
 		if (se->valid_blocks == 0x0) {
 			free_segs++;
 		} else {
-- 
1.9.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
