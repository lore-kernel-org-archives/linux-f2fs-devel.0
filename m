From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] f2fs: move flush tracepoint
Date: Fri,  3 Feb 2017 15:48:14 -0800
Message-ID: <20170203234816.12723-3-jaegeuk@kernel.org>
References: <20170203234816.12723-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cZnag-0004hu-4R
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Feb 2017 23:48:30 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cZnaf-0006NX-Gd
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Feb 2017 23:48:30 +0000
In-Reply-To: <20170203234816.12723-1-jaegeuk@kernel.org>
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

This patch moves the tracepoint location for flush command.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 984d94efe8cb..2c283a5fead0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -429,6 +429,9 @@ static int submit_flush_wait(struct f2fs_sb_info *sbi)
 	int ret = __submit_flush_wait(sbi->sb->s_bdev);
 	int i;
 
+	trace_f2fs_issue_flush(sbi->sb, test_opt(sbi, NOBARRIER),
+					test_opt(sbi, FLUSH_MERGE));
+
 	if (sbi->s_ndevs && !ret) {
 		for (i = 1; i < sbi->s_ndevs; i++) {
 			ret = __submit_flush_wait(FDEV(i).bdev);
@@ -474,9 +477,6 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 	struct flush_cmd_control *fcc = SM_I(sbi)->fcc_info;
 	struct flush_cmd cmd;
 
-	trace_f2fs_issue_flush(sbi->sb, test_opt(sbi, NOBARRIER),
-					test_opt(sbi, FLUSH_MERGE));
-
 	if (test_opt(sbi, NOBARRIER))
 		return 0;
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
