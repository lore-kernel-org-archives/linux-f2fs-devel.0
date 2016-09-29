From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH 3/4] fsck.f2fs: fix a typo in check_sector_size
Date: Thu, 29 Sep 2016 18:38:36 +0800
Message-ID: <1475145517-18366-3-git-send-email-zhengjunling@huawei.com>
References: <1475145517-18366-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1bpYxA-0006Zz-Vw
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 10:52:36 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bpYx8-0002lH-3Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 10:52:36 +0000
In-Reply-To: <1475145517-18366-1-git-send-email-zhengjunling@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index a247dec..5f51009 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1908,7 +1908,7 @@ static int check_sector_size(struct f2fs_super_block *sb)
 	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
 	for (index = 0; index < 2; index++) {
 		if (dev_write(zero_buff, index * F2FS_BLKSIZE, F2FS_BLKSIZE)) {
-			MSG(1, "\tError: While while writing supe_blk "
+			MSG(1, "\tError: Failed while writing supe_blk "
 				"on disk!!! index : %d\n", index);
 			free(zero_buff);
 			return -1;
-- 
2.7.4


------------------------------------------------------------------------------
