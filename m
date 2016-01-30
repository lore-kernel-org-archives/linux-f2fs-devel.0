From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH 3/4] fsck.f2fs: check ino of an used nat entry
Date: Sat, 30 Jan 2016 09:16:38 +0000
Message-ID: <1454145399-30713-4-git-send-email-shengyong1@huawei.com>
References: <1454145399-30713-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1aPKQM-0008P1-D3
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Jan 2016 01:34:02 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aPKQJ-0000DQ-81
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Jan 2016 01:34:02 +0000
In-Reply-To: <1454145399-30713-1-git-send-email-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao2.yu@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

If a nid is valid, the ino in its nat entry should record its parent nid.
However if the ino is zero, we should drop the node.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
---
 fsck/fsck.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 4fbb56d..c018d3a 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -342,6 +342,11 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 	}
 
 	get_node_info(sbi, nid, ni);
+	if (ni->ino == 0) {
+		ASSERT_MSG("nid[0x%x] ino is 0", nid);
+		return -EINVAL;
+	}
+
 	if (ni->blk_addr == NEW_ADDR) {
 		ASSERT_MSG("nid is NEW_ADDR. [0x%x]", nid);
 		return -EINVAL;
-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
