From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs/fsck: add host-managed smr feature
Date: Tue, 14 Jun 2016 11:45:47 -0700
Message-ID: <20160614184547.88785-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bCtLY-0002Op-HJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Jun 2016 18:45:56 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bCtLX-0000Cd-OM
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Jun 2016 18:45:56 +0000
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

This feature flag will be used by f2fs to detect HMSMR device.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c            | 3 +++
 include/f2fs_fs.h       | 1 +
 mkfs/f2fs_format_main.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 9d08118..e0223e0 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -267,6 +267,9 @@ void print_sb_state(struct f2fs_super_block *sb)
 	if (f & cpu_to_le32(F2FS_FEATURE_ENCRYPT)) {
 		MSG(0, "%s", " encrypt");
 	}
+	if (f & cpu_to_le32(F2FS_FEATURE_HMSMR)) {
+		MSG(0, "%s", " host-managed SMR");
+	}
 	MSG(0, "\n");
 	MSG(0, "Info: superblock encrypt level = %d, salt = ",
 					sb->encryption_level);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 1045ede..1345e2d 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -457,6 +457,7 @@ enum {
 #define MAX_ACTIVE_DATA_LOGS	8
 
 #define F2FS_FEATURE_ENCRYPT	0x0001
+#define F2FS_FEATURE_HMSMR	0x0002
 
 #define MAX_VOLUME_NAME		512
 
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 8bd938c..f69d03f 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -64,6 +64,8 @@ static void parse_feature(char *features)
 {
 	if (!strcmp(features, "encrypt")) {
 		config.feature |= cpu_to_le32(F2FS_FEATURE_ENCRYPT);
+	} else if (config.smr_mode) {
+		config.feature |= cpu_to_le32(F2FS_FEATURE_HMSMR);
 	} else {
 		MSG(0, "Error: Wrong features\n");
 		mkfs_usage();
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports. http://pubads.g.doubleclick.net/gampad/clk?id=1444514421&iu=/41014381
