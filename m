From: Liu Xue <liuxueliu.liu@huawei.com>
Subject: [PATCH] mkfs.f2fs: fix check error when calloc
	sum_compact failure
Date: Mon, 21 Dec 2015 07:44:41 +0000
Message-ID: <1450683881-122105-1-git-send-email-liuxueliu.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuxueliu.liu@huawei.com>) id 1aAvCc-0004xu-DY
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Dec 2015 07:48:18 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aAvCV-0003Dk-TU
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Dec 2015 07:48:18 +0000
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

We should check sum_compact value when deal with sum_compact
calloc failure.

Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
---
 mkfs/f2fs_format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index b0c12f2..7caf733 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -460,7 +460,7 @@ static int f2fs_write_check_point_pack(void)
 	}
 
 	sum_compact = calloc(F2FS_BLKSIZE, 1);
-	if (sum == NULL) {
+	if (sum_compact == NULL) {
 		MSG(1, "\tError: Calloc Failed for summay buffer!!!\n");
 		goto free_sum;
 	}
-- 
1.8.3.4


------------------------------------------------------------------------------
