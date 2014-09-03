From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] fsck.f2fs: add auto_fix feature
Date: Tue,  2 Sep 2014 22:03:28 -0700
Message-ID: <1409720608-73045-2-git-send-email-jaegeuk@kernel.org>
References: <1409720608-73045-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XP2jK-0005TA-1j
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Sep 2014 05:03:38 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XP2jJ-0006Sr-5M for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Sep 2014 05:03:38 +0000
In-Reply-To: <1409720608-73045-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds an auto_fix feature which fixes inconsistency of f2fs images.

E.g.,

With this option, -a, fsck.f2fs tries to fix inconsistency only if its valid
checkpoint has CP_FSCK_FLAG, written by previous bug_on cases.

So, normally it does fix nothing, so that there is no performance regression.
But, if a sort of corruption was reported by the f2fs module, this tries to
fix potential corrupted partition.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c       | 26 ++++++++++++++++----------
 fsck/mount.c      | 14 +++++++++++++-
 include/f2fs_fs.h |  2 ++
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 7e3bb49..e20eac2 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -40,23 +40,27 @@ void f2fs_parse_options(int argc, char *argv[])
 	char *prog = basename(argv[0]);
 
 	if (!strcmp("fsck.f2fs", prog)) {
-		const char *option_string = "d:tf";
+		const char *option_string = "ad:ft";
 
 		config.func = FSCK;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
 			switch (option) {
+			case 'a':
+				config.auto_fix = 1;
+				MSG(0, "Info: Fix the reported corruption.\n");
+				break;
 			case 'd':
 				config.dbg_lv = atoi(optarg);
 				MSG(0, "Info: Debug level = %d\n",
 							config.dbg_lv);
 				break;
-			case 't':
-				config.dbg_lv = -1;
-				break;
 			case 'f':
 				config.fix_on = 1;
 				MSG(0, "Info: Force to fix corruption\n");
 				break;
+			case 't':
+				config.dbg_lv = -1;
+				break;
 			default:
 				MSG(0, "\tError: Unknown option %c\n", option);
 				fsck_usage();
@@ -135,8 +139,6 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 {
 	u32 blk_cnt;
 
-	config.bug_on = 0;
-
 	fsck_init(sbi);
 
 	fsck_chk_orphan_node(sbi);
@@ -192,7 +194,12 @@ fsck_again:
 	gfsck.sbi.fsck = &gfsck;
 	sbi = &gfsck.sbi;
 
-	if (f2fs_do_mount(sbi) < 0)
+	ret = f2fs_do_mount(sbi);
+	if (ret == 1) {
+		free(sbi->ckpt);
+		free(sbi->raw_super);
+		goto out;
+	} else if (ret < 0)
 		return -1;
 
 	switch (config.func) {
@@ -205,9 +212,9 @@ fsck_again:
 	}
 
 	f2fs_do_umount(sbi);
-
+out:
 	if (config.func == FSCK && config.bug_on) {
-		if (config.fix_on == 0) {
+		if (config.fix_on == 0 && !config.auto_fix) {
 			char ans[255] = {0};
 retry:
 			printf("Do you want to fix this partition? [Y/N] ");
@@ -226,7 +233,6 @@ retry:
 		if (config.fix_cnt > 0 && config.fix_cnt < 4)
 			goto fsck_again;
 	}
-
 	f2fs_finalize_device(&config);
 
 	printf("\nDone.\n");
diff --git a/fsck/mount.c b/fsck/mount.c
index 2bbd3c5..5a12bb1 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1183,6 +1183,7 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 int f2fs_do_mount(struct f2fs_sb_info *sbi)
 {
 	int ret;
+
 	sbi->active_logs = NR_CURSEG_TYPE;
 	ret = validate_super_block(sbi, 0);
 	if (ret) {
@@ -1208,6 +1209,17 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 
 	print_ckpt_info(sbi);
 
+	if (config.auto_fix) {
+		u32 flag = le32_to_cpu(sbi->ckpt->ckpt_flags);
+
+		if (flag & CP_FSCK_FLAG)
+			config.fix_cnt = 1;
+		else
+			return 1;
+	}
+
+	config.bug_on = 0;
+
 	sbi->total_valid_node_count = le32_to_cpu(sbi->ckpt->valid_node_count);
 	sbi->total_valid_inode_count =
 			le32_to_cpu(sbi->ckpt->valid_inode_count);
@@ -1227,7 +1239,7 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 		return -1;
 	}
 
-	return ret;
+	return 0;
 }
 
 void f2fs_do_umount(struct f2fs_sb_info *sbi)
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 7242690..6467791 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -185,6 +185,7 @@ struct f2fs_configuration {
 	int fix_on;
 	int fix_cnt;
 	int bug_on;
+	int auto_fix;
 } __attribute__((packed));
 
 #ifdef CONFIG_64BIT
@@ -290,6 +291,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_FSCK_FLAG		0x00000010
 #define CP_ERROR_FLAG		0x00000008
 #define CP_COMPACT_SUM_FLAG	0x00000004
 #define CP_ORPHAN_PRESENT_FLAG	0x00000002
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
