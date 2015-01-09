From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: fix sit types seamlessly
Date: Fri,  9 Jan 2015 03:09:06 -0800
Message-ID: <1420801746-84082-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y9XRP-00050D-7B
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Jan 2015 11:09:19 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y9XRO-0006Uv-6a for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Jan 2015 11:09:19 +0000
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
index f4e81a5..9d6fc42 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1055,6 +1055,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 {
 	unsigned int i = 0;
 	int ret = 0;
+	int force = 0;
 	u32 nr_unref_nid = 0;
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct hard_link_node *node = NULL;
@@ -1161,14 +1162,9 @@ int fsck_verify(struct f2fs_sb_info *sbi)
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
@@ -1179,7 +1175,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
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
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
