From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH] fsck.f2fs: fix incorrect block_addr of node/meta
Date: Thu, 3 Mar 2016 10:32:31 +0800
Message-ID: <1456972351-26548-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1abJJQ-0002Kx-6T
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Mar 2016 02:48:24 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1abJJL-0001Oo-4O
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Mar 2016 02:48:24 +0000
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

Fix incorrect block_addr of node or meta inode into 0x1 during
build_nat_area_bitmap().

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
Signed-off-by: Liu Xue <liuxueliu.liu@huawei.com>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/mount.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 4c807f9..9360656 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1664,7 +1664,14 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 
 			if ((nid + i) == F2FS_NODE_INO(sbi) ||
 					(nid + i) == F2FS_META_INO(sbi)) {
-				ASSERT(nat_block->entries[i].block_addr != 0x0);
+				/* block_addr of node/meta inode should be 0x1 */
+				if (le32_to_cpu(nat_block->entries[i].block_addr) != 0x1) {
+					FIX_MSG("ino: 0x%x node/meta inode, block_addr= 0x%x -> 0x1",
+							nid + i, le32_to_cpu(nat_block->entries[i].block_addr));
+					nat_block->entries[i].block_addr = cpu_to_le32(0x1);
+					ret = dev_write_block(nat_block, block_addr);
+					ASSERT(ret >= 0);
+				}
 				continue;
 			}
 
-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
