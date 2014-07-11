From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 1/2] f2fs: cleanup the needless return of
	f2fs_create_root_stats
Date: Fri, 11 Jul 2014 18:35:43 +0800
Message-ID: <1405074944-18283-1-git-send-email-guz.fnst@cn.fujitsu.com>
References: <N>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz@guz>) id 1X5Ybe-00061P-NT
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Jul 2014 11:03:10 +0000
Received: from fgwmail8.fujitsu.co.jp ([192.51.44.38])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X5Ybd-0000Fg-8c
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Jul 2014 11:03:10 +0000
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by fgwmail8.fujitsu.co.jp (Postfix) with ESMTP id 20C9015040AE
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 11 Jul 2014 19:48:51 +0900 (JST)
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [10.0.237.133])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 616F23EE1D0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 11 Jul 2014 19:48:44 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
	by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6FA52AC0AF6
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 11 Jul 2014 19:48:43 +0900 (JST)
Received: from s01.gw.fujitsu.co.jp (s01.gw.nic.fujitsu.com [133.161.11.16])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 198911DB8032
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 11 Jul 2014 19:48:43 +0900 (JST)
In-Reply-To: <N>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/debug.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index b52c12c..3f99266 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -345,21 +345,14 @@ void __init f2fs_create_root_stats(void)
 
 	f2fs_debugfs_root = debugfs_create_dir("f2fs", NULL);
 	if (!f2fs_debugfs_root)
-		goto bail;
+		return;
 
 	file = debugfs_create_file("status", S_IRUGO, f2fs_debugfs_root,
 			NULL, &stat_fops);
-	if (!file)
-		goto free_debugfs_dir;
-
-	return;
-
-free_debugfs_dir:
-	debugfs_remove(f2fs_debugfs_root);
-
-bail:
-	f2fs_debugfs_root = NULL;
-	return;
+	if (!file) {
+		debugfs_remove(f2fs_debugfs_root);
+		f2fs_debugfs_root = NULL;
+	}
 }
 
 void f2fs_destroy_root_stats(void)
-- 
1.7.7


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
