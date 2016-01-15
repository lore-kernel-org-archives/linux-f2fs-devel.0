From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] fsck.f2fs: return 0 for no error was reported
Date: Fri, 15 Jan 2016 10:33:41 -0800
Message-ID: <1452882821-61713-2-git-send-email-jaegeuk@kernel.org>
References: <1452882821-61713-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aK9C4-0007ZZ-1d
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jan 2016 18:33:52 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aK9C3-0004bL-BM for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jan 2016 18:33:52 +0000
In-Reply-To: <1452882821-61713-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

When skipping fsck, return 0 with message.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index d70b9ed..54dbb2d 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -330,8 +330,13 @@ fsck_again:
 	sbi = &gfsck.sbi;
 
 	ret = f2fs_do_mount(sbi);
-	if (ret != 0)
+	if (ret != 0) {
+		if (ret == 1) {
+			MSG(0, "Info: No error was reported\n");
+			ret = 0;
+		}
 		goto out_err;
+	}
 
 	switch (config.func) {
 	case FSCK:
@@ -341,7 +346,8 @@ fsck_again:
 		do_dump(sbi);
 		break;
 	case DEFRAG:
-		if (do_defrag(sbi))
+		ret = do_defrag(sbi);
+		if (ret)
 			goto out_err;
 		break;
 	}
@@ -376,5 +382,5 @@ out_err:
 		free(sbi->ckpt);
 	if (sbi->raw_super)
 		free(sbi->raw_super);
-	return -1;
+	return ret;
 }
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
