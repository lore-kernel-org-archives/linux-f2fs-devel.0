From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: remove unused value
Date: Mon, 24 Nov 2014 16:43:28 -0800
Message-ID: <1416876208-32094-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xt4EE-0005ku-BL
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Nov 2014 00:43:38 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xt4ED-0004tI-9q for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Nov 2014 00:43:38 +0000
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

Remove build warning.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 95b4028..f7309d6 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -999,7 +999,6 @@ int check_curseg_offset(struct f2fs_sb_info *sbi)
 
 int check_sit_types(struct f2fs_sb_info *sbi)
 {
-	struct seg_entry *se;
 	unsigned int i;
 	int err = 0;
 
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
