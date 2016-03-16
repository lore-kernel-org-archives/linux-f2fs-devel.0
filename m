From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH] fsck.f2fs: calculate orphan_blkaddr correctly
Date: Wed, 16 Mar 2016 18:03:05 +0800
Message-ID: <1458122585-2009-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1ag8Te-0004nV-3G
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 10:14:54 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ag8TY-0007kE-PQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 10:14:54 +0000
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

Commit 4ea4f1db ("fsck.f2fs: large volume support") added the support
for large volume over about 3TB. The "cp_payload" is added to start_blk,
but not removed from orphan_blkaddr.

Fixes: 4ea4f1db ("fsck.f2fs: large volume support")
Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 6f47c5d..624adae 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1426,7 +1426,7 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 		return;
 
 	start_blk = __start_cp_addr(sbi) + 1 + get_sb(cp_payload);
-	orphan_blkaddr = __start_sum_addr(sbi) - 1;
+	orphan_blkaddr = __start_sum_addr(sbi) - 1 - get_sb(cp_payload);
 
 	orphan_blk = calloc(BLOCK_SZ, 1);
 	ASSERT(orphan_blk);
-- 
1.9.1


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
