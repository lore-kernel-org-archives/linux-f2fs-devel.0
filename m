From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH trivial 3/7] fsck.f2fs: correct variable type and
	name
Date: Fri, 15 Jul 2016 20:01:21 +0800
Message-ID: <1468584085-29090-3-git-send-email-shengyong1@huawei.com>
References: <1468584085-29090-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1bO1tH-0003yB-D2
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jul 2016 12:06:47 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bO1tE-00077A-Bt
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jul 2016 12:06:47 +0000
In-Reply-To: <1468584085-29090-1-git-send-email-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/fsck.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 8a6373b..f349bd8 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -736,7 +736,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 
 	/* check node blocks in inode */
 	for (idx = 0; idx < 5; idx++) {
-		block_t blkaddr = le32_to_cpu(node_blk->i.i_nid[idx]);
+		nid_t i_nid = le32_to_cpu(node_blk->i.i_nid[idx]);
 
 		if (idx == 0 || idx == 1)
 			ntype = TYPE_DIRECT_NODE;
@@ -747,11 +747,10 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		else
 			ASSERT(0);
 
-		if (blkaddr == 0x0)
+		if (i_nid == 0x0)
 			goto skip;
 
-		ret = fsck_chk_node_blk(sbi, &node_blk->i,
-				blkaddr,
+		ret = fsck_chk_node_blk(sbi, &node_blk->i, i_nid,
 				NULL, ftype, ntype, blk_cnt, &child);
 		if (!ret) {
 			*blk_cnt = *blk_cnt + 1;
-- 
2.7.1


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
