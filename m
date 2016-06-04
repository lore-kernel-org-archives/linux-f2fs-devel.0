From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] fsck.f2fs: modify sit dump && add nat dump
Date: Sat, 4 Jun 2016 18:03:56 +0800
Message-ID: <1465034636-23557-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1b98O1-00079x-HE
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Jun 2016 10:00:57 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b98Ny-0000Ej-Hs
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Jun 2016 10:00:57 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao@huawei.com
Cc: heyunlei@huwei.com

modify sit dump && add nat dump like this:

dump_sit:

segment_type(0:HD, 1:WD, 2:CD, 3:HN, 4:WN, 5:CN)

segno:      13  vblocks:512     seg_type:2      sit_pack:2

  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff
  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff
  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff
  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff  ff

dump_nat:

nid:    3       ino:    3       offset:    0    blkaddr:   2076417      pack:2
nid: 1042       ino: 1042       offset:    0    blkaddr:   2087156      pack:2
nid:57076       ino:57076       offset:    0    blkaddr:   2071232      pack:2
nid:57118       ino:57118       offset:    0    blkaddr:   2071233      pack:2
Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/dump.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 fsck/fsck.h |   3 ++
 fsck/main.c |  27 +++++++++-----
 3 files changed, 134 insertions(+), 18 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 81a39c8..332ff7c 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -23,45 +23,151 @@ const char *seg_type_name[SEG_TYPE_MAX + 1] = {
 	"SEG_TYPE_NONE",
 };
 
+void nat_dump(struct f2fs_sb_info *sbi, int start_nat, int end_nat)
+{
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	struct f2fs_nat_block *nat_block;
+	struct f2fs_node *node_block;
+	u32 nr_nat_blks, nid;
+	pgoff_t block_off;
+	pgoff_t block_addr;
+	char buf[BUF_SZ];
+	int seg_off;
+	int fd, ret, pack = 1;
+	unsigned int i;
+
+	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
+	node_block = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
+	ASSERT(nat_block);
+
+	nr_nat_blks = get_sb(segment_count_nat) <<
+				(sbi->log_blocks_per_seg - 1);
+
+	fd = open("dump_nat", O_CREAT|O_WRONLY|O_TRUNC, 0666);
+	ASSERT(fd >= 0);
+
+	for (block_off = 0; block_off < nr_nat_blks; block_off++) {
+
+		seg_off = block_off >> sbi->log_blocks_per_seg;
+		block_addr = (pgoff_t)(nm_i->nat_blkaddr +
+			(seg_off << sbi->log_blocks_per_seg << 1) +
+			(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
+
+		if (f2fs_test_bit(block_off, nm_i->nat_bitmap)) {
+			block_addr += sbi->blocks_per_seg;
+			pack = 2;
+		}
+
+		ret = dev_read_block(nat_block, block_addr);
+		ASSERT(ret >= 0);
+
+		nid = block_off * NAT_ENTRY_PER_BLOCK;
+		for (i = 0; i < NAT_ENTRY_PER_BLOCK; i++) {
+			struct f2fs_nat_entry raw_nat;
+			struct node_info ni;
+			ni.nid = nid + i;
+
+			if(nid + i  == 0 || nid + i  == 1 || nid + i == 2 )
+				continue;
+			if (lookup_nat_in_journal(sbi, nid + i,
+							&raw_nat) >= 0) {
+				node_info_from_raw_nat(&ni, &raw_nat);
+				ret = dev_read_block(node_block, ni.blk_addr);
+				ASSERT(ret >= 0);
+				if (ni.blk_addr != 0x0) {
+					memset(buf, 0, BUF_SZ);
+					snprintf(buf, BUF_SZ, "nid:%5u\tino:%5u\toffset:%5u"
+							"\tblkaddr:%10u\tpack:%d\n",ni.nid, ni.ino,
+							node_block->footer.flag >> OFFSET_BIT_SHIFT,
+									ni.blk_addr, pack);
+					ret = write(fd, buf, strlen(buf));
+					ASSERT(ret >= 0);
+				}
+
+			} else {
+				node_info_from_raw_nat(&ni,
+						&nat_block->entries[i]);
+				if (ni.blk_addr == 0)
+					continue;
+
+				ret = dev_read_block(node_block, ni.blk_addr);
+				ASSERT(ret >= 0);
+				memset(buf, 0, BUF_SZ);
+				snprintf(buf, BUF_SZ, "nid:%5u\tino:%5u\toffset:%5u"
+						"\tblkaddr:%10u\tpack:%d\n",ni.nid,
+						ni.ino,node_block->footer.flag >>
+						OFFSET_BIT_SHIFT,ni.blk_addr, pack);
+				ret = write(fd, buf, strlen(buf));
+				ASSERT(ret >= 0);
+			}
+		}
+	}
+
+	free(nat_block);
+	free(node_block);
+
+	close(fd);
+}
+
 void sit_dump(struct f2fs_sb_info *sbi, int start_sit, int end_sit)
 {
 	struct seg_entry *se;
-	int segno;
+	struct sit_info *sit_i = SIT_I(sbi);
+	unsigned int segno;
 	char buf[BUF_SZ];
 	u32 free_segs = 0;;
 	u64 valid_blocks = 0;
 	int ret;
-	int fd;
+	int fd, i;
+	unsigned int offset;
 
 	fd = open("dump_sit", O_CREAT|O_WRONLY|O_TRUNC, 0666);
 	ASSERT(fd >= 0);
 
+	snprintf(buf, BUF_SZ, "segment_type(0:HD, 1:WD, 2:CD, "
+						"3:HN, 4:WN, 5:CN)\n");
+	ret = write(fd, buf, strlen(buf));
+	ASSERT(ret >= 0);
+
 	for (segno = start_sit; segno < end_sit; segno++) {
 		se = get_seg_entry(sbi, segno);
-
+		offset = SIT_BLOCK_OFFSET(sit_i, segno);
+		i = f2fs_test_bit(offset, sit_i->sit_bitmap)?2:1;
 		memset(buf, 0, BUF_SZ);
-		snprintf(buf, BUF_SZ, "%5d %8d\n", segno, se->valid_blocks);
+		snprintf(buf, BUF_SZ, "\nsegno:%8u\tvblocks:%3u\tseg_type:%d\tsit_pack:%d\n\n",
+							segno, se->valid_blocks, se->type, i);
 
 		ret = write(fd, buf, strlen(buf));
 		ASSERT(ret >= 0);
 
-		DBG(4, "SIT[0x%3x] : 0x%3x : %d\n", segno, se->valid_blocks, se->type);
 		if (se->valid_blocks == 0x0) {
 			free_segs++;
 		} else {
 			ASSERT(se->valid_blocks <= 512);
 			valid_blocks += se->valid_blocks;
+
+			for (i = 0; i < 64; i++) {
+				memset(buf, 0, BUF_SZ);
+				snprintf(buf, BUF_SZ, "  %02x", *(se->cur_valid_map + i));
+				ret = write(fd, buf, strlen(buf));
+				ASSERT(ret >= 0);
+				if((i+1) % 16 == 0) {
+					snprintf(buf, BUF_SZ, "\n");
+					ret = write(fd, buf, strlen(buf));
+					ASSERT(ret >= 0);
+				}
+			}
 		}
 	}
 
 	memset(buf, 0, BUF_SZ);
-	snprintf(buf, BUF_SZ, "valid_segs:%d\t free_segs:%d\n",
-			SM_I(sbi)->main_segments - free_segs, free_segs);
+	snprintf(buf, BUF_SZ, "valid_blocks:[0x%" PRIx64 "]\tvalid_segs:%d\t free_segs:%d\n",
+			valid_blocks, SM_I(sbi)->main_segments - free_segs, free_segs);
 	ret = write(fd, buf, strlen(buf));
 	ASSERT(ret >= 0);
 
 	close(fd);
-	DBG(1, "Blocks [0x%" PRIx64 "] Free Segs [0x%x]\n", valid_blocks, free_segs);
 }
 
 void ssa_dump(struct f2fs_sb_info *sbi, int start_ssa, int end_ssa)
diff --git a/fsck/fsck.h b/fsck/fsck.h
index b0481d1..50dc440 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -167,6 +167,8 @@ extern void print_raw_sb_info(struct f2fs_super_block *);
 /* dump.c */
 struct dump_option {
 	nid_t nid;
+	int start_nat;
+	int end_nat;
 	int start_sit;
 	int end_sit;
 	int start_ssa;
@@ -174,6 +176,7 @@ struct dump_option {
 	int32_t blk_addr;
 };
 
+extern void nat_dump(struct f2fs_sb_info *, int, int);
 extern void sit_dump(struct f2fs_sb_info *, int, int);
 extern void ssa_dump(struct f2fs_sb_info *, int, int);
 extern void dump_node(struct f2fs_sb_info *, nid_t);
diff --git a/fsck/main.c b/fsck/main.c
index cf670ed..464c62b 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -38,6 +38,7 @@ void dump_usage()
 	MSG(0, "[options]:\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -i inode no (hex)\n");
+	MSG(0, "  -n [NAT dump segno from #1~#2 (decimal), for all 0~-1]\n");
 	MSG(0, "  -s [SIT dump segno from #1~#2 (decimal), for all 0~-1]\n");
 	MSG(0, "  -a [SSA dump segno from #1~#2 (decimal), for all 0~-1]\n");
 	MSG(0, "  -b blk_addr (in 4KB)\n");
@@ -125,9 +126,11 @@ void f2fs_parse_options(int argc, char *argv[])
 			}
 		}
 	} else if (!strcmp("dump.f2fs", prog)) {
-		const char *option_string = "d:i:s:a:b:";
+		const char *option_string = "d:i:n:s:a:b:";
 		static struct dump_option dump_opt = {
-			.nid = 3,	/* default root ino */
+			.nid = 0,	/* default root ino */
+			.start_nat = -1,
+			.end_nat = -1,
 			.start_sit = -1,
 			.end_sit = -1,
 			.start_ssa = -1,
@@ -153,6 +156,11 @@ void f2fs_parse_options(int argc, char *argv[])
 					ret = sscanf(optarg, "%x",
 							&dump_opt.nid);
 				break;
+			case 'n':
+				ret = sscanf(optarg, "%d~%d",
+							&dump_opt.start_nat,
+							&dump_opt.end_nat);
+				break;
 			case 's':
 				ret = sscanf(optarg, "%d~%d",
 							&dump_opt.start_sit,
@@ -353,26 +361,25 @@ static void do_dump(struct f2fs_sb_info *sbi)
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	u32 flag = le32_to_cpu(ckpt->ckpt_flags);
 
-	fsck_init(sbi);
-
+	if (opt->end_nat == -1)
+		opt->end_nat = NM_I(sbi)->max_nid;
 	if (opt->end_sit == -1)
 		opt->end_sit = SM_I(sbi)->main_segments;
 	if (opt->end_ssa == -1)
 		opt->end_ssa = SM_I(sbi)->main_segments;
+	if (opt->start_nat != -1)
+		nat_dump(sbi, opt->start_nat, opt->end_nat);
 	if (opt->start_sit != -1)
 		sit_dump(sbi, opt->start_sit, opt->end_sit);
 	if (opt->start_ssa != -1)
 		ssa_dump(sbi, opt->start_ssa, opt->end_ssa);
-	if (opt->blk_addr != -1) {
+	if (opt->blk_addr != -1)
 		dump_info_from_blkaddr(sbi, opt->blk_addr);
-		goto cleanup;
-	}
+	if (opt->nid)
+		dump_node(sbi, opt->nid);
 
 	print_cp_state(flag);
 
-	dump_node(sbi, opt->nid);
-cleanup:
-	fsck_free(sbi);
 }
 
 static int do_defrag(struct f2fs_sb_info *sbi)
-- 
1.9.1


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
