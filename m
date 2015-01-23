From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] fsck.f2fs: fix sit types seamlessly
Date: Thu, 22 Jan 2015 16:48:50 -0800
Message-ID: <1421974132-18330-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YESQp-0006ZE-CG
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Jan 2015 00:49:03 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YESQo-0007Lg-Gc for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Jan 2015 00:49:03 +0000
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

SIT types can be wrong when active_logs are 2 or 4.
So, let's fix this implicitly.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 09bb26f..a5f9adc 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1023,6 +1023,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 {
 	unsigned int i = 0;
 	int ret = 0;
+	int force = 0;
 	u32 nr_unref_nid = 0;
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct hard_link_node *node = NULL;
@@ -1129,14 +1130,9 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		config.bug_on = 1;
 	}
 
-	printf("[FSCK] SIT types                                     ");
-	if (check_sit_types(sbi) == 0) {
-		printf(" [Ok..]\n");
-	} else {
-		printf(" [Fail]\n");
-		ret = EXIT_ERR_CODE;
-		config.bug_on = 1;
-	}
+	printf("[FSCK] fixing SIT types\n");
+	if (check_sit_types(sbi) != 0)
+		force = 1;
 
 	printf("[FSCK] other corrupted bugs                          ");
 	if (config.bug_on == 0) {
@@ -1147,7 +1143,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	}
 
 	/* fix global metadata */
-	if (config.bug_on && config.fix_on) {
+	if (force || (config.bug_on && config.fix_on)) {
 		fix_nat_entries(sbi);
 		rewrite_sit_area_bitmap(sbi);
 		fix_checkpoint(sbi);
-- 
2.1.1


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
