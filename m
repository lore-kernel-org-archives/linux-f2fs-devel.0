From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] fsck.f2fs: check nat_entry->ino for all nodes
Date: Mon, 22 Feb 2016 17:01:15 +0000
Message-ID: <1456160475-544-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1aXmfD-00015Q-2S
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 09:20:19 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aXmf9-00067V-8s
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 09:20:19 +0000
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

Commit 843f5b9388c4652a ("fsck.f2fs: check ino of an inode") checks
nat_entry->ino for inode. However, the checking is irrelevant to node
type, and if ino of other kinds of nodes gets corrupted, fsck.f2fs
cannot detect it. This patch fixes the commit.

Fixes: 843f5b9388c4652a ("fsck.f2fs: check ino of an inode")
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
This is against dev branch.
---
 fsck/fsck.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 6451595..2d07629 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -383,8 +383,8 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 				le32_to_cpu(node_blk->footer.ino));
 		return -EINVAL;
 	}
-	if (ntype == TYPE_INODE && ni->ino != node_blk->footer.ino) {
-		ASSERT_MSG("nid[0x%x] TYPE_INODE nat_entry->ino[0x%x] footer.ino[0x%x]",
+	if (ni->ino != node_blk->footer.ino) {
+		ASSERT_MSG("nid[0x%x] nat_entry->ino[0x%x] footer.ino[0x%x]",
 				nid, ni->ino, le32_to_cpu(node_blk->footer.ino));
 		return -EINVAL;
 	}
-- 
2.7.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
