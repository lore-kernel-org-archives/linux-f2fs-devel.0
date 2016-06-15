From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] mkfs/fsck: add host-managed smr feature
Date: Wed, 15 Jun 2016 09:46:42 -0700
Message-ID: <20160615164642.GA95218@jaegeuk>
References: <20160614184547.88785-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bDDxp-000333-AE
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Jun 2016 16:46:49 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bDDxo-0004zP-8T
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Jun 2016 16:46:49 +0000
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 0433C20270
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 15 Jun 2016 16:46:42 +0000 (UTC)
Received: from localhost (107-1-141-74-ip-static.hfc.comcastbusiness.net
	[107.1.141.74])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 3DFC2201ED
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 15 Jun 2016 16:46:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160614184547.88785-1-jaegeuk@kernel.org>
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

Change log from v1:
 - Fix wrong feature set.

>From 70a8fc3df7b72730fd2d40394892688292e8f78e Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 13 Jun 2016 09:36:38 -0700
Subject: [PATCH] mkfs/fsck: add host-managed smr feature

This feature flag will be used by f2fs to detect HMSMR device.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c            | 3 +++
 include/f2fs_fs.h       | 1 +
 mkfs/f2fs_format_main.c | 3 +++
 3 files changed, 7 insertions(+)

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
index 8bd938c..3741843 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -130,6 +130,9 @@ static void f2fs_parse_options(int argc, char *argv[])
 
 	if ((optind + 1) < argc)
 		config.total_sectors = atoll(argv[optind+1]);
+
+	if (config.smr_mode)
+		config.feature |= cpu_to_le32(F2FS_FEATURE_HMSMR);
 }
 
 int main(int argc, char *argv[])
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports. http://pubads.g.doubleclick.net/gampad/clk?id=1444514421&iu=/41014381
