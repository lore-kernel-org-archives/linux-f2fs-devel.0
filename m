From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH 4/4] fsck.f2fs: check ino of an inode
Date: Sat, 30 Jan 2016 09:16:39 +0000
Message-ID: <1454145399-30713-5-git-send-email-shengyong1@huawei.com>
References: <1454145399-30713-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1aPKQM-0005LZ-Gp
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Jan 2016 01:34:02 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aPKQJ-0002OF-DW
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

If the node is an inode, its ino in the nat entry should be equal to the
ino in its node footer. Otherwise, we drop the file.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
---
 fsck/fsck.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index c018d3a..312583e 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -372,6 +372,11 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 				le32_to_cpu(node_blk->footer.ino));
 		return -EINVAL;
 	}
+	if (ntype == TYPE_INODE && ni->ino != node_blk->footer.ino) {
+		ASSERT_MSG("nid[0x%x] TYPE_INODE nat_entry->ino[0x%x] footer.ino[0x%x]",
+				nid, ni->ino, le32_to_cpu(node_blk->footer.ino));
+		return -EINVAL;
+	}
 	if (ntype != TYPE_INODE &&
 			node_blk->footer.nid == node_blk->footer.ino) {
 		ASSERT_MSG("nid[0x%x] footer.nid[0x%x] footer.ino[0x%x]",
-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
