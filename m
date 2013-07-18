From: Changman Lee <cm224.lee@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs-tools: dump inode information from blkaddr
Date: Thu, 18 Jul 2013 11:20:05 +0900
Message-ID: <1374114005-9356-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1Uzdr8-0005ga-Oj
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Jul 2013 02:22:10 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uzdr5-0002k3-31 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Jul 2013 02:22:10 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MQ4009SU177GAH0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Jul 2013 11:22:00 +0900 (KST)
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

This patch is to dump inode which blkaddr belongs in.
Usage:
  dump.f2fs /dev/sdx -b blk_addr (in 4KB)

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fsck/dump.c  |   42 ++++++++++++++++++++++++++++++++++++++++--
 fsck/fsck.c  |    4 +---
 fsck/fsck.h  |    5 +++--
 fsck/main.c  |   20 ++++++++++++++++++--
 fsck/mount.c |   10 +++++++---
 5 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 1ec794a..4c113dd 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -12,6 +12,13 @@
 
 #define BUF_SZ	80
 
+const char *seg_type_name[SEG_TYPE_MAX] = {
+	"SEG_TYPE_DATA",
+	"SEG_TYPE_CUR_DATA",
+	"SEG_TYPE_NODE",
+	"SEG_TYPE_CUR_NODE",
+};
+
 void sit_dump(struct f2fs_sb_info *sbi, int start_sit, int end_sit)
 {
 	struct seg_entry *se;
@@ -137,7 +144,38 @@ int dump_node(struct f2fs_sb_info *sbi, nid_t nid)
 	return 0;
 }
 
-void dump_cleanup(struct f2fs_sb_info *sbi)
+int dump_inode_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 {
-	f2fs_do_umount(sbi);
+	nid_t ino, nid;
+	int ret;
+	struct f2fs_summary sum_entry;
+	struct node_info ni;
+	struct f2fs_node *node_blk;
+
+	ret = get_sum_entry(sbi, blk_addr, &sum_entry);
+	nid = le32_to_cpu(sum_entry.nid);
+
+	DBG(1, "Node ID               [0x%x]\n", nid);
+	DBG(1, "Segment Type          [%s]\n", seg_type_name[ret]);
+	DBG(1, "version               [%d]\n", sum_entry.version);
+	DBG(1, "ofs_in_node           [%d]\n", sum_entry.ofs_in_node);
+	ret = get_node_info(sbi, nid, &ni);
+	ASSERT(ret >= 0);
+
+	node_blk = calloc(BLOCK_SZ, 1);
+
+read_node_blk:
+	dev_read_block(node_blk, ni.blk_addr);
+
+	ino = le32_to_cpu(node_blk->footer.ino);
+	nid = le32_to_cpu(node_blk->footer.nid);
+	if (ino == nid) {
+		print_inode_info(&node_blk->i);
+	} else {
+		ret = get_node_info(sbi, ino, &ni);
+		goto read_node_blk;
+	}
+
+	free(node_blk);
+	return ino;
 }
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 1e4afd9..907dc10 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -793,7 +793,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 void fsck_free(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
-		if (fsck->main_area_bitmap)
+	if (fsck->main_area_bitmap)
 		free(fsck->main_area_bitmap);
 
 	if (fsck->nat_area_bitmap)
@@ -801,6 +801,4 @@ void fsck_free(struct f2fs_sb_info *sbi)
 
 	if (fsck->sit_area_bitmap)
 		free(fsck->sit_area_bitmap);
-
-	f2fs_do_umount(sbi);
 }
diff --git a/fsck/fsck.h b/fsck/fsck.h
index b439222..a8f440c 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -73,9 +73,9 @@ enum seg_type {
 	SEG_TYPE_CUR_DATA,
 	SEG_TYPE_NODE,
 	SEG_TYPE_CUR_NODE,
+	SEG_TYPE_MAX,
 };
 
-
 extern int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 x_nid, u32 *blk_cnt);
 extern int fsck_chk_orphan_node(struct f2fs_sb_info *sbi);
 
@@ -134,6 +134,7 @@ extern int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi,
 		int last_blk);
 
 extern void print_node_info(struct f2fs_node *node_block);
+extern void print_inode_info(struct f2fs_inode *inode);
 extern struct seg_entry *get_seg_entry(struct f2fs_sb_info *sbi, unsigned int segno);
 extern int get_sum_block(struct f2fs_sb_info *sbi, unsigned int segno, struct f2fs_summary_block *sum_blk);
 extern int get_sum_entry(struct f2fs_sb_info *sbi, u32 blk_addr, struct f2fs_summary *sum_entry);
@@ -153,11 +154,11 @@ struct dump_option {
 	int end_sit;
 	int start_ssa;
 	int end_ssa;
+	u32 blk_addr;
 };
 
 extern void sit_dump(struct f2fs_sb_info *sbi, int start_sit, int end_sit);
 extern void ssa_dump(struct f2fs_sb_info *sbi, int start_ssa, int end_ssa);
 extern int dump_node(struct f2fs_sb_info *sbi, nid_t nid);
-extern void dump_cleanup(struct f2fs_sb_info *sbi);
 
 #endif /* _FSCK_H_ */
diff --git a/fsck/main.c b/fsck/main.c
index 3e12dd8..d72533d 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -31,6 +31,7 @@ void dump_usage()
 	MSG(0, "  -i inode no (hex)\n");
 	MSG(0, "  -s [SIT dump segno from #1~#2 (decimal), for all 0~-1]\n");
 	MSG(0, "  -a [SSA dump segno from #1~#2 (decimal), for all 0~-1]\n");
+	MSG(0, "  -b blk_addr (in 4KB)\n");
 
 	exit(1);
 }
@@ -57,13 +58,14 @@ void f2fs_parse_options(int argc, char *argv[])
 			}
 		}
 	} else if (!strcmp("dump.f2fs", prog)) {
-		const char *option_string = "d:i:s:a:";
+		const char *option_string = "d:i:s:a:b:";
 		static struct dump_option dump_opt = {
 			.nid = 3,	/* default root ino */
 			.start_sit = -1,
 			.end_sit = -1,
 			.start_ssa = -1,
 			.end_ssa = -1,
+			.blk_addr = -1,
 		};
 
 		config.func = DUMP;
@@ -82,6 +84,9 @@ void f2fs_parse_options(int argc, char *argv[])
 				case 'a':
 					sscanf(optarg, "%d~%d", &dump_opt.start_ssa, &dump_opt.end_ssa);
 					break;
+				case 'b':
+					sscanf(optarg, "%d", &dump_opt.blk_addr);
+					break;
 				default:
 					MSG(0, "\tError: Unknown option %c\n", option);
 					dump_usage();
@@ -134,6 +139,11 @@ out1:
 int do_dump(struct f2fs_sb_info *sbi)
 {
 	struct dump_option *opt = (struct dump_option *)config.private;
+	int ret;
+
+	ret = fsck_init(sbi);
+	if (ret < 0)
+		return ret;
 
 	if (opt->end_sit == -1)
 		opt->end_sit = SM_I(sbi)->main_segments;
@@ -143,10 +153,15 @@ int do_dump(struct f2fs_sb_info *sbi)
 		sit_dump(sbi, opt->start_sit, opt->end_sit);
 	if (opt->start_ssa != -1)
 		ssa_dump(sbi, opt->start_ssa, opt->end_ssa);
+	if (opt->blk_addr != -1) {
+		dump_inode_from_blkaddr(sbi, opt->blk_addr);
+		goto cleanup;
+	}
 
 	dump_node(sbi, opt->nid);
 
-	dump_cleanup(sbi);
+cleanup:
+	fsck_free(sbi);
 	return 0;
 }
 
@@ -178,6 +193,7 @@ int main (int argc, char **argv)
 			break;
 	}
 
+	f2fs_do_umount(sbi);
 	printf("\nDone.\n");
 	return ret;
 }
diff --git a/fsck/mount.c b/fsck/mount.c
index 1ed5050..13a3ef1 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -77,7 +77,11 @@ void print_node_info(struct f2fs_node *node_block)
 		DBG(0, "Node ID [0x%x:%u] is inode\n", nid, nid);
 		print_inode_info(&node_block->i);
 	} else {
+		int i;
+		u32 *dump_blk = (u32 *)node_block;
 		DBG(0, "Node ID [0x%x:%u] is direct node or indirect node.\n", nid, nid);
+		for (i = 0; i <= 10; i++)
+			MSG(0, "[%d]\t\t\t[0x%8x : %d]\n", i, dump_blk[i], dump_blk[i]);
 	}
 }
 
@@ -782,8 +786,8 @@ int get_nat_entry(struct f2fs_sb_info *sbi, nid_t nid, struct f2fs_nat_entry *ra
 	int seg_off, entry_off;
 	int ret;
 
-	if (nid / NAT_ENTRY_PER_BLOCK > (fsck->nat_area_bitmap_sz * 8)) {
-		DBG(0, "\n");
+	if ((nid / NAT_ENTRY_PER_BLOCK) > fsck->nr_nat_entries) {
+		DBG(0, "nid is over max nid\n");
 		return -EINVAL;
 	}
 
@@ -934,7 +938,7 @@ int build_sit_area_bitmap(struct f2fs_sb_info *sbi)
 	fsck->chk.sit_valid_blocks = sum_vblocks;
 	fsck->chk.sit_free_segs = free_segs;
 
-	DBG(0, "Blocks [0x%x] Free Segs [0x%x]\n", sum_vblocks, free_segs);
+	DBG(0, "Blocks [0x%x] Free Segs [0x%x]\n\n", sum_vblocks, free_segs);
 	return 0;
 }
 
-- 
1.7.10.4


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
