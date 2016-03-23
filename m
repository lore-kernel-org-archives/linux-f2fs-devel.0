From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/7] fsck.f2fs: introduce -p option to check meta
Date: Wed, 23 Mar 2016 13:41:15 -0700
Message-ID: <1458765681-24123-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aipat-0008Di-5a
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 20:41:31 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aipar-0002lt-Ot
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 20:41:31 +0000
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

From: Sheng Yong <shengyong1@huawei.com>

This patch introduces a new option '-p' to do more checks on NAT/SIT areas.
'-p' has 2 levels: level 1 has the same sematics as '-a'; level 2 checks
NAT/SIT counters to see if they matches the status in SB and CP.

A new function, fsck_chk_meta, is called by '-p 1' to implement these
comparsion. If errors are detected, fix_on is set, which means fsck will
do a 'fsck -f' immediately.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fsck/fsck.h       |  7 +++++++
 fsck/main.c       | 39 +++++++++++++++++++++++++++++++++---
 fsck/mount.c      |  4 ++--
 include/f2fs_fs.h |  1 +
 5 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index c68eae7..fede8e1 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1517,6 +1517,65 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 	free(new_blk);
 }
 
+int fsck_chk_meta(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+	struct seg_entry *se;
+	unsigned int sit_valid_segs = 0, sit_node_blks = 0;
+	unsigned int i;
+
+	/* 1. check sit usage with CP: curseg is lost? */
+	for (i = 0; i < TOTAL_SEGS(sbi); i++) {
+		se = get_seg_entry(sbi, i);
+		if (se->valid_blocks != 0)
+			sit_valid_segs++;
+		else if (IS_CUR_SEGNO(sbi, i, NO_CHECK_TYPE)) {
+			/* curseg has not been written back to device */
+			MSG(1, "\tInfo: curseg %u is counted in valid segs\n", i);
+			sit_valid_segs++;
+		}
+		if (IS_NODESEG(se->type))
+			sit_node_blks += se->valid_blocks;
+	}
+	if (fsck->chk.sit_free_segs + sit_valid_segs != TOTAL_SEGS(sbi)) {
+		ASSERT_MSG("SIT usage does not match: sit_free_segs %u, "
+				"sit_valid_segs %u, total_segs %u",
+			fsck->chk.sit_free_segs, sit_valid_segs,
+			TOTAL_SEGS(sbi));
+		return -EINVAL;
+	}
+
+	/* 2. check node count */
+	if (fsck->chk.valid_nat_entry_cnt != sit_node_blks) {
+		ASSERT_MSG("node count does not match: valid_nat_entry_cnt %u,"
+			" sit_node_blks %u",
+			fsck->chk.valid_nat_entry_cnt, sit_node_blks);
+		return -EINVAL;
+	}
+
+	/* 3. check SIT with CP */
+	if (fsck->chk.sit_free_segs != le32_to_cpu(cp->free_segment_count)) {
+		ASSERT_MSG("free segs does not match: sit_free_segs %u, "
+				"free_segment_count %u",
+				fsck->chk.sit_free_segs,
+				le32_to_cpu(cp->free_segment_count));
+		return -EINVAL;
+	}
+
+	/* 4. check NAT with CP */
+	if (fsck->chk.valid_nat_entry_cnt !=
+					le32_to_cpu(cp->valid_node_count)) {
+		ASSERT_MSG("valid node does not match: valid_nat_entry_cnt %u,"
+				" valid_node_count %u",
+				fsck->chk.valid_nat_entry_cnt,
+				le32_to_cpu(cp->valid_node_count));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 void fsck_init(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 45e4366..f03efb8 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -15,6 +15,12 @@
 
 #define FSCK_UNMATCHED_EXTENT		0x00000001
 
+enum {
+	PREEN_MODE_0,
+	PREEN_MODE_1,
+	PREEN_MODE_MAX
+};
+
 /* fsck.c */
 struct orphan_info {
 	u32 nr_inodes;
@@ -119,6 +125,7 @@ extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, u32, struct child_info *,
 		int, int);
 int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
 		struct child_info *);
+int fsck_chk_meta(struct f2fs_sb_info *sbi);
 
 void print_cp_state(u32);
 extern void print_node_info(struct f2fs_node *);
diff --git a/fsck/main.c b/fsck/main.c
index 0e23c81..93008a5 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -22,7 +22,7 @@ void fsck_usage()
 	MSG(0, "  -a check/fix potential corruption, reported by f2fs\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -f check/fix entire partition\n");
-	MSG(0, "  -p preen mode [default is same as -a]\n");
+	MSG(0, "  -p preen mode [default:0 the same as -a [0|1]]\n");
 	MSG(0, "  -t show directory tree [-d -1]\n");
 	exit(1);
 }
@@ -58,16 +58,30 @@ void f2fs_parse_options(int argc, char *argv[])
 	char *prog = basename(argv[0]);
 
 	if (!strcmp("fsck.f2fs", prog)) {
-		const char *option_string = "ad:fpt";
+		const char *option_string = "ad:fp:t";
 
 		config.func = FSCK;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
 			switch (option) {
 			case 'a':
-			case 'p':
 				config.auto_fix = 1;
 				MSG(0, "Info: Fix the reported corruption.\n");
 				break;
+			case 'p':
+				/* preen mode has different levels:
+				 *  0: default level, the same as -a
+				 *  1: check meta
+				 */
+				config.preen_mode = atoi(optarg);
+				if (config.preen_mode < 0)
+					config.preen_mode = PREEN_MODE_0;
+				else if (config.preen_mode >= PREEN_MODE_MAX)
+					config.preen_mode = PREEN_MODE_MAX - 1;
+				if (config.preen_mode == PREEN_MODE_0)
+					config.auto_fix = 1;
+				MSG(0, "Info: Fix the reported corruption in "
+					"preen mode %d\n", config.preen_mode);
+				break;
 			case 'd':
 				config.dbg_lv = atoi(optarg);
 				MSG(0, "Info: Debug level = %d\n",
@@ -213,6 +227,25 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 
 	print_cp_state(flag);
 
+	if (!config.fix_on && !config.bug_on) {
+		switch (config.preen_mode) {
+		case PREEN_MODE_1:
+			if (fsck_chk_meta(sbi)) {
+				MSG(0, "[FSCK] F2FS metadata   [Fail]");
+				MSG(0, "\tError: meta does not match, "
+					"force check all\n");
+			} else {
+				MSG(0, "[FSCK] F2FS metadata   [Ok..]");
+				fsck_free(sbi);
+				return;
+			}
+
+			if (!config.ro)
+				config.fix_on = 1;
+			break;
+		}
+	}
+
 	fsck_chk_orphan_node(sbi);
 
 	/* Traverse all block recursively from root inode */
diff --git a/fsck/mount.c b/fsck/mount.c
index 153055e..af1e0c3 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1749,12 +1749,12 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 
 	print_ckpt_info(sbi);
 
-	if (config.auto_fix) {
+	if (config.auto_fix || config.preen_mode) {
 		u32 flag = get_cp(ckpt_flags);
 
 		if (flag & CP_FSCK_FLAG)
 			config.fix_on = 1;
-		else
+		else if (!config.preen_mode)
 			return 1;
 	}
 
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 0046be6..330cbe5 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -251,6 +251,7 @@ struct f2fs_configuration {
 	int fix_on;
 	int bug_on;
 	int auto_fix;
+	int preen_mode;
 	int ro;
 	__le32 feature;			/* defined features */
 
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
