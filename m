From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 02/17] fsck.f2fs: retry to fix corrupted image
Date: Fri, 29 Aug 2014 17:28:49 -0700
Message-ID: <1409358544-54740-2-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWXq-00055T-QO
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:30 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWXp-0000Nd-NM for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:30 +0000
In-Reply-To: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds a facility to retry conducting fsck.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       |   9 +++-
 fsck/main.c       | 141 +++++++++++++++++++++++++++++++++++-------------------
 include/f2fs_fs.h |   5 ++
 3 files changed, 104 insertions(+), 51 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 303ba8d..9a4c26c 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -761,6 +761,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 					node->nid, node->links);
 			node = node->next;
 		}
+		config.bug_on = 1;
 	}
 
 	printf("[FSCK] Unreachable nat entries                       ");
@@ -769,6 +770,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf(" [Fail] [0x%x]\n", nr_unref_nid);
 		ret = EXIT_ERR_CODE;
+		config.bug_on = 1;
 	}
 
 	printf("[FSCK] SIT valid block bitmap checking                ");
@@ -777,6 +779,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf("[Fail]\n");
 		ret = EXIT_ERR_CODE;
+		config.bug_on = 1;
 	}
 
 	printf("[FSCK] Hard link checking for regular file           ");
@@ -785,6 +788,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf(" [Fail] [0x%x]\n", fsck->chk.multi_hard_link_files);
 		ret = EXIT_ERR_CODE;
+		config.bug_on = 1;
 	}
 
 	printf("[FSCK] valid_block_count matching with CP            ");
@@ -793,6 +797,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf(" [Fail] [0x%x]\n", (u32)fsck->chk.valid_blk_cnt);
 		ret = EXIT_ERR_CODE;
+		config.bug_on = 1;
 	}
 
 	printf("[FSCK] valid_node_count matcing with CP (de lookup)  ");
@@ -801,6 +806,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf(" [Fail] [0x%x]\n", fsck->chk.valid_node_cnt);
 		ret = EXIT_ERR_CODE;
+		config.bug_on = 1;
 	}
 
 	printf("[FSCK] valid_node_count matcing with CP (nat lookup) ");
@@ -809,6 +815,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf(" [Fail] [0x%x]\n", fsck->chk.valid_nat_entry_cnt);
 		ret = EXIT_ERR_CODE;
+		config.bug_on = 1;
 	}
 
 	printf("[FSCK] valid_inode_count matched with CP             ");
@@ -817,8 +824,8 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	} else {
 		printf(" [Fail] [0x%x]\n", fsck->chk.valid_inode_cnt);
 		ret = EXIT_ERR_CODE;
+		config.bug_on = 1;
 	}
-
 	return ret;
 }
 
diff --git a/fsck/main.c b/fsck/main.c
index 46f5d04..266e9b5 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -11,9 +11,7 @@
 #include "fsck.h"
 #include <libgen.h>
 
-struct f2fs_fsck gfsck = {
-	.sbi = { .fsck = &gfsck, },
-};
+struct f2fs_fsck gfsck;
 
 void fsck_usage()
 {
@@ -42,22 +40,27 @@ void f2fs_parse_options(int argc, char *argv[])
 	char *prog = basename(argv[0]);
 
 	if (!strcmp("fsck.f2fs", prog)) {
-		const char *option_string = "d:t";
+		const char *option_string = "d:tf";
 
 		config.func = FSCK;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
 			switch (option) {
-				case 'd':
-					config.dbg_lv = atoi(optarg);
-					MSG(0, "Info: Debug level = %d\n", config.dbg_lv);
-					break;
-				case 't':
-					config.dbg_lv = -1;
-					break;
-				default:
-					MSG(0, "\tError: Unknown option %c\n",option);
-					fsck_usage();
-					break;
+			case 'd':
+				config.dbg_lv = atoi(optarg);
+				MSG(0, "Info: Debug level = %d\n",
+							config.dbg_lv);
+				break;
+			case 't':
+				config.dbg_lv = -1;
+				break;
+			case 'f':
+				config.fix_on = 1;
+				MSG(0, "Info: Force to fix corruption\n");
+				break;
+			default:
+				MSG(0, "\tError: Unknown option %c\n", option);
+				fsck_usage();
+				break;
 			}
 		}
 	} else if (!strcmp("dump.f2fs", prog)) {
@@ -73,34 +76,46 @@ void f2fs_parse_options(int argc, char *argv[])
 
 		config.func = DUMP;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
+			int ret = 0;
+
 			switch (option) {
-				case 'd':
-					config.dbg_lv = atoi(optarg);
-					MSG(0, "Info: Debug level = %d\n", config.dbg_lv);
-					break;
-				case 'i':
-					if (strncmp(optarg, "0x", 2))
-						sscanf(optarg, "%d", &dump_opt.nid);
-					else
-						sscanf(optarg, "%x", &dump_opt.nid);
-					break;
-				case 's':
-					sscanf(optarg, "%d~%d", &dump_opt.start_sit, &dump_opt.end_sit);
-					break;
-				case 'a':
-					sscanf(optarg, "%d~%d", &dump_opt.start_ssa, &dump_opt.end_ssa);
-					break;
-				case 'b':
-					if (strncmp(optarg, "0x", 2))
-						sscanf(optarg, "%d", &dump_opt.blk_addr);
-					else
-						sscanf(optarg, "%x", &dump_opt.blk_addr);
-					break;
-				default:
-					MSG(0, "\tError: Unknown option %c\n", option);
-					dump_usage();
-					break;
+			case 'd':
+				config.dbg_lv = atoi(optarg);
+				MSG(0, "Info: Debug level = %d\n",
+							config.dbg_lv);
+				break;
+			case 'i':
+				if (strncmp(optarg, "0x", 2))
+					ret = sscanf(optarg, "%d",
+							&dump_opt.nid);
+				else
+					ret = sscanf(optarg, "%x",
+							&dump_opt.nid);
+				break;
+			case 's':
+				ret = sscanf(optarg, "%d~%d",
+							&dump_opt.start_sit,
+							&dump_opt.end_sit);
+				break;
+			case 'a':
+				ret = sscanf(optarg, "%d~%d",
+							&dump_opt.start_ssa,
+							&dump_opt.end_ssa);
+				break;
+			case 'b':
+				if (strncmp(optarg, "0x", 2))
+					ret = sscanf(optarg, "%d",
+							&dump_opt.blk_addr);
+				else
+					ret = sscanf(optarg, "%x",
+							&dump_opt.blk_addr);
+				break;
+			default:
+				MSG(0, "\tError: Unknown option %c\n", option);
+				dump_usage();
+				break;
 			}
+			ASSERT(ret >= 0);
 		}
 
 		config.private = &dump_opt;
@@ -121,13 +136,15 @@ int do_fsck(struct f2fs_sb_info *sbi)
 	u32 blk_cnt;
 	int ret;
 
+	config.bug_on = 0;
+
 	ret = fsck_init(sbi);
 	if (ret < 0)
 		return ret;
 
 	fsck_chk_orphan_node(sbi);
 
-	/* Travses all block recursively from root inode  */
+	/* Traverse all block recursively from root inode */
 	blk_cnt = 1;
 	ret = fsck_chk_node_blk(sbi,
 			NULL,
@@ -139,7 +156,6 @@ int do_fsck(struct f2fs_sb_info *sbi)
 		goto out1;
 
 	ret = fsck_verify(sbi);
-
 out1:
 	fsck_free(sbi);
 	return ret;
@@ -176,7 +192,7 @@ cleanup:
 
 int main (int argc, char **argv)
 {
-	struct f2fs_sb_info *sbi = &gfsck.sbi;
+	struct f2fs_sb_info *sbi;
 	int ret = 0;
 
 	f2fs_init_configuration(&config);
@@ -189,21 +205,46 @@ int main (int argc, char **argv)
 	/* Get device */
 	if (f2fs_get_device_info(&config) < 0)
 		return -1;
+fsck_again:
+	memset(&gfsck, 0, sizeof(gfsck));
+	gfsck.sbi.fsck = &gfsck;
+	sbi = &gfsck.sbi;
 
 	if (f2fs_do_mount(sbi) < 0)
 		return -1;
 
 	switch (config.func) {
-		case FSCK:
-			ret = do_fsck(sbi);
-			break;
-		case DUMP:
-			ret = do_dump(sbi);
-			break;
+	case FSCK:
+		ret = do_fsck(sbi);
+		break;
+	case DUMP:
+		ret = do_dump(sbi);
+		break;
 	}
 
 	f2fs_do_umount(sbi);
 
+	if (config.func == FSCK && config.bug_on) {
+		if (config.fix_on == 0) {
+			char ans[255] = {0};
+retry:
+			printf("Do you want to fix this partition? [Y/N] ");
+			ret = scanf("%s", ans);
+			ASSERT(ret >= 0);
+			if (!strcasecmp(ans, "y"))
+				config.fix_cnt++;
+			else if (!strcasecmp(ans, "n"))
+				config.fix_cnt = 0;
+			else
+				goto retry;
+		} else {
+			config.fix_cnt++;
+		}
+		/* avoid infinite trials */
+		if (config.fix_cnt > 0 && config.fix_cnt < 4)
+			goto fsck_again;
+	}
+
 	f2fs_finalize_device(&config);
 
 	printf("\nDone.\n");
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index aebb1d2..49911a0 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -60,6 +60,7 @@ typedef unsigned long	pgoff_t;
 			printf("\nAssertion failed!\n");		\
 			printf("[%s:%4d] " #exp, __func__, __LINE__);	\
 			printf("\n --> "fmt, ##__VA_ARGS__);		\
+			config.bug_on = 1;				\
 			exit(-1);					\
 		}							\
 	} while (0);
@@ -69,6 +70,7 @@ typedef unsigned long	pgoff_t;
 		if (!(exp)) {						\
 			printf("\nAssertion failed!\n");		\
 			printf("[%s:%4d] " #exp"\n", __func__, __LINE__);\
+			config.bug_on = 1;				\
 			exit(-1);					\
 		}							\
 	} while (0);
@@ -180,6 +182,9 @@ struct f2fs_configuration {
 	int trim;
 	int func;
 	void *private;
+	int fix_on;
+	int fix_cnt;
+	int bug_on;
 } __attribute__((packed));
 
 #ifdef CONFIG_64BIT
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
