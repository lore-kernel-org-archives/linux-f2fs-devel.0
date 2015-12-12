From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/6] f2fs-tools: export print_raw_sb_info
Date: Fri, 11 Dec 2015 16:00:12 -0800
Message-ID: <1449878414-41254-4-git-send-email-jaegeuk@kernel.org>
References: <1449878414-41254-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a7Xby-0001Vf-1O
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 00:00:30 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a7Xbx-0002TM-AG for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 00:00:30 +0000
In-Reply-To: <1449878414-41254-1-git-send-email-jaegeuk@kernel.org>
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

This patch exports print_raw_sb_info().

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.h  | 2 ++
 fsck/mount.c | 6 ++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsck/fsck.h b/fsck/fsck.h
index 20dfe6b..f6b8c53 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -132,6 +132,8 @@ extern void fsck_free(struct f2fs_sb_info *);
 extern int f2fs_do_mount(struct f2fs_sb_info *);
 extern void f2fs_do_umount(struct f2fs_sb_info *);
 
+extern void print_raw_sb_info(struct f2fs_super_block *);
+
 /* dump.c */
 struct dump_option {
 	nid_t nid;
diff --git a/fsck/mount.c b/fsck/mount.c
index 9431cd0..99e2439 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -99,10 +99,8 @@ void print_node_info(struct f2fs_node *node_block)
 	}
 }
 
-void print_raw_sb_info(struct f2fs_sb_info *sbi)
+void print_raw_sb_info(struct f2fs_super_block *sb)
 {
-	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
-
 	if (!config.dbg_lv)
 		return;
 
@@ -1292,7 +1290,7 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 			return -1;
 	}
 
-	print_raw_sb_info(sbi);
+	print_raw_sb_info(F2FS_RAW_SUPER(sbi));
 
 	init_sb_info(sbi);
 
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
