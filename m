From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: show current mount status
Date: Mon, 21 Mar 2016 11:56:05 -0700
Message-ID: <1458586565-8827-2-git-send-email-jaegeuk@kernel.org>
References: <1458586565-8827-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ai4zw-0007Xh-Fa
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 18:56:16 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ai4zv-0004sI-QP
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 18:56:16 +0000
In-Reply-To: <1458586565-8827-1-git-send-email-jaegeuk@kernel.org>
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

This patch remains the current mount status to f2fs status info.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 4fb6ef8..ff8730e 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -216,8 +216,9 @@ static int stat_show(struct seq_file *s, void *v)
 	list_for_each_entry(si, &f2fs_stat_list, stat_list) {
 		update_general_status(si->sbi);
 
-		seq_printf(s, "\n=====[ partition info(%pg). #%d ]=====\n",
-			si->sbi->sb->s_bdev, i++);
+		seq_printf(s, "\n=====[ partition info(%pg). #%d, %s]=====\n",
+			si->sbi->sb->s_bdev, i++,
+			f2fs_readonly(si->sbi->sb) ? "RO": "RW");
 		seq_printf(s, "[SB: 1] [CP: 2] [SIT: %d] [NAT: %d] ",
 			   si->sit_area_segs, si->nat_area_segs);
 		seq_printf(s, "[SSA: %d] [MAIN: %d",
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
