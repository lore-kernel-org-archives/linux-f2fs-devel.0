From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: add a segment and section num check in
	sanity_check_raw_super
Date: Sat, 26 Dec 2015 10:46:19 +0800
Message-ID: <1451097979-4589-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1aCeqz-0004Im-0E
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Dec 2015 02:45:09 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aCequ-0003GC-Va
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Dec 2015 02:45:08 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao2.yu@samsung.com

This patch add a mismatch check between segment and section in
sanity_check_raw_super.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/super.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c3070c1..b51a690 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1036,6 +1036,17 @@ static int sanity_check_raw_super(struct super_block *sb,
 		return 1;
 	}
 
+	/* check seg # corresponding to sec # */
+	if (le32_to_cpu(raw_super->segment_count)
+			* le32_to_cpu(raw_super->segs_per_sec)
+				!= le32_to_cpu(raw_super->section_count)) {
+		f2fs_msg(sb, KERN_INFO,
+			"Mismatch seg num (%u) and sec num (%u) \n",
+			le32_to_cpu(raw_super->segment_count),
+			le32_to_cpu(raw_super->section_count));
+		return 1;
+	}
+
 	/* Currently, support 512/1024/2048/4096 bytes sector size */
 	if (le32_to_cpu(raw_super->log_sectorsize) >
 				F2FS_MAX_LOG_SECTOR_SIZE ||
-- 
1.9.1


------------------------------------------------------------------------------
