From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: flush bios to handle cp_error in
	put_super
Date: Fri, 29 Jan 2016 16:52:37 -0800
Message-ID: <1454115158-81227-2-git-send-email-jaegeuk@kernel.org>
References: <1454115158-81227-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aPJmT-0007NE-Ev
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Jan 2016 00:52:49 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aPJmS-0001Ts-Ph for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Jan 2016 00:52:49 +0000
In-Reply-To: <1454115158-81227-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Sometimes, if cp_error is set, there remains under-writeback pages, resulting in
kernel hang in put_super.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9962021..aa2d3d9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -582,6 +582,13 @@ static void f2fs_put_super(struct super_block *sb)
 	f2fs_leave_shrinker(sbi);
 	mutex_unlock(&sbi->umount_mutex);
 
+	/* our cp_error case, we can wait for any writeback page */
+	if (get_pages(sbi, F2FS_WRITEBACK)) {
+		f2fs_submit_merged_bio(sbi, DATA, WRITE);
+		f2fs_submit_merged_bio(sbi, NODE, WRITE);
+		f2fs_submit_merged_bio(sbi, META, WRITE);
+	}
+
 	iput(sbi->node_inode);
 	iput(sbi->meta_inode);
 
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
