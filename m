From: Younger Liu <younger.liucn@gmail.com>
Subject: [PATCH V2 0/2] f2fs: remove debufs dir if
	debugfs_create_file() failed
Date: Tue, 03 Dec 2013 20:11:46 +0800
Message-ID: <529DCA82.4090005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <younger.liucn@gmail.com>) id 1VnopY-00071h-Nh
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Dec 2013 12:11:56 +0000
Received: from mail-pb0-f45.google.com ([209.85.160.45])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VnopX-0007w2-R0
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Dec 2013 12:11:56 +0000
Received: by mail-pb0-f45.google.com with SMTP id rp16so20869084pbb.18
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 03 Dec 2013 04:11:50 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>

From: Younger Liu <liuyiyang@hisense.com>

When debugfs_create_file() failed in f2fs_create_root_stats(),
debugfs_root should be remove.

Signed-off-by: Younger Liu <liuyiyang@hisense.com>
Cc: Younger Liu <younger.liucn@gmail.com>
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Reviewed-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/debug.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index a84b0a8..b51fb3c 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -340,14 +340,32 @@ void f2fs_destroy_stats(struct f2fs_sb_info *sbi)

 void __init f2fs_create_root_stats(void)
 {
+	struct dentry *file;
+
 	debugfs_root = debugfs_create_dir("f2fs", NULL);
-	if (debugfs_root)
-		debugfs_create_file("status", S_IRUGO, debugfs_root,
-					 NULL, &stat_fops);
+	if (!debugfs_root)
+		goto bail;
+
+	file = debugfs_create_file("status", S_IRUGO, debugfs_root,
+			NULL, &stat_fops);
+	if (!file)
+		goto free_debugfs_dir;
+
+	return;
+
+free_debugfs_dir:
+	debugfs_remove(debugfs_root);
+
+bail:
+	debugfs_root = NULL;
+	return;
 }

 void f2fs_destroy_root_stats(void)
 {
+	if (!debugfs_root)
+		return;
+
 	debugfs_remove_recursive(debugfs_root);
 	debugfs_root = NULL;
 }
-- 
1.7.9.5


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
