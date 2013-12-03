From: Younger Liu <younger.liucn@gmail.com>
Subject: [PATCH V2 1/2] f2fs: A minor change for avoiding any
 possible conflicts to the other fs
Date: Tue, 03 Dec 2013 21:09:29 +0800
Message-ID: <529DD809.3040500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <younger.liucn@gmail.com>) id 1VnpjR-0001EO-5l
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Dec 2013 13:09:41 +0000
Received: from mail-pb0-f49.google.com ([209.85.160.49])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VnpjP-0001Lk-De
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Dec 2013 13:09:41 +0000
Received: by mail-pb0-f49.google.com with SMTP id jt11so20943544pbb.22
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 03 Dec 2013 05:09:33 -0800 (PST)
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
Cc: fs-devel <linux-fsdevel@vger.kernel.org>, kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

From: Younger Liu <liuyiyang@hisense.com>

This minor change for the naming conventions of debugfs_root
to avoid any possible conflicts to the other filesystem.

This patch is based on the first patch:
[PATCH V2 0/2] f2fs: remove debufs dir if debugfs_create_file() failed.

Signed-off-by: Younger Liu <younger.liucn@gmail.com>
Cc: Younger Liu <younger.liucn@gmail.com>
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/debug.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index b51fb3c..61adbcb 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -24,7 +24,7 @@
 #include "gc.h"

 static LIST_HEAD(f2fs_stat_list);
-static struct dentry *debugfs_root;
+static struct dentry *f2fs_debugfs_root;
 static DEFINE_MUTEX(f2fs_stat_mutex);

 static void update_general_status(struct f2fs_sb_info *sbi)
@@ -342,11 +342,11 @@ void __init f2fs_create_root_stats(void)
 {
 	struct dentry *file;

-	debugfs_root = debugfs_create_dir("f2fs", NULL);
-	if (!debugfs_root)
+	f2fs_debugfs_root = debugfs_create_dir("f2fs", NULL);
+	if (!f2fs_debugfs_root)
 		goto bail;

-	file = debugfs_create_file("status", S_IRUGO, debugfs_root,
+	file = debugfs_create_file("status", S_IRUGO, f2fs_debugfs_root,
 			NULL, &stat_fops);
 	if (!file)
 		goto free_debugfs_dir;
@@ -354,18 +354,18 @@ void __init f2fs_create_root_stats(void)
 	return;

 free_debugfs_dir:
-	debugfs_remove(debugfs_root);
+	debugfs_remove(f2fs_debugfs_root);

 bail:
-	debugfs_root = NULL;
+	f2fs_debugfs_root = NULL;
 	return;
 }

 void f2fs_destroy_root_stats(void)
 {
-	if (!debugfs_root)
+	if (!f2fs_debugfs_root)
 		return;

-	debugfs_remove_recursive(debugfs_root);
-	debugfs_root = NULL;
+	debugfs_remove_recursive(f2fs_debugfs_root);
+	f2fs_debugfs_root = NULL;
 }
-- 
1.7.9.5


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
