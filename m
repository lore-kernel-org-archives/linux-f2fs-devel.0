From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH] fsck.f2fs: fix corrupted nat entry [0]
Date: Tue, 23 Feb 2016 19:45:32 +0800
Message-ID: <1456227932-29567-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1aYBQM-0006Up-3Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 11:46:38 +0000
Received: from [119.145.14.66] (helo=szxga03-in.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aYBQH-0007rC-Da
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 11:46:38 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao2.yu@samsung.com, linux-f2fs-devel@lists.sourceforge.net
Cc: chengyinchao@huawei.com

The first nat entry must be null. If it is corrupted, we set its bit in
nat_area_bitmap, without increasing valid_nat_entry_cnt, fsck_verify will
nullify it at last.

Reported-by: Cheng Yinchao <chengyinchao@huawei.com>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/mount.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 4c807f9..ec040c8 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1683,7 +1683,18 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 						&nat_block->entries[i]);
 				if (ni.blk_addr == 0)
 					continue;
-				ASSERT(nid + i != 0x0);
+				if (nid + i == 0) {
+					/*
+					 * nat entry [0] must be null.  If
+					 * it is corrupted, set its bit in
+					 * nat_area_bitmap, fsck_verify will
+					 * nullify it
+					 */
+					ASSERT_MSG("Invalid nat entry[0]: blk_addr[0x%x]\n",
+						ni.blk_addr);
+					config.fix_on = 1;
+					fsck->chk.valid_nat_entry_cnt--;
+				}
 
 				DBG(3, "nid[0x%8x] addr[0x%16x] ino[0x%8x]\n",
 					nid + i, ni.blk_addr, ni.ino);
-- 
2.7.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
