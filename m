From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/6] defrag.f2fs: introduce defragmentation tool
Date: Fri, 11 Dec 2015 16:00:14 -0800
Message-ID: <1449878414-41254-6-git-send-email-jaegeuk@kernel.org>
References: <1449878414-41254-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a7Xc9-0005gm-Ck
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 00:00:41 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a7Xc7-0007tu-7t for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 00:00:41 +0000
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

This tool tries to move the valid blocks ranging from blkaddr to blkaddr + len
to targeted blkaddr with a direction like expand or shrink.

The option includes:
 -d debug level [default:0]
 -s start block address [default: main_blkaddr]
 -l length [default:512 (2MB)]
 -t target block address [default: main_blkaddr + 2MB]
 -i set direction as shrink [default: expand]

For example,
 # defrag.f2fs -s 0x100 -l 0x10 -t 0x4000 /dev/sdb1

This will move data blocks between 0x100 and 0x110 to the right side of
0x4000 space.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 autogen.sh        |   0
 fsck/Makefile.am  |   3 +-
 fsck/defrag.c     | 101 +++++++++++++++++++
 fsck/f2fs.h       |   1 +
 fsck/fsck.h       |  10 ++
 fsck/main.c       | 135 +++++++++++++++++++++++--
 fsck/mount.c      | 290 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/f2fs_fs.h |   7 ++
 8 files changed, 538 insertions(+), 9 deletions(-)
 mode change 100644 => 100755 autogen.sh
 create mode 100644 fsck/defrag.c

diff --git a/autogen.sh b/autogen.sh
old mode 100644
new mode 100755
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 6c19e11..73df884 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -3,8 +3,9 @@
 AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
 AM_CFLAGS = -Wall
 sbin_PROGRAMS = fsck.f2fs
-fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c f2fs.h fsck.h $(top_srcdir)/include/f2fs_fs.h
+fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c defrag.c f2fs.h fsck.h $(top_srcdir)/include/f2fs_fs.h
 fsck_f2fs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
 
 install-data-hook:
 	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/dump.f2fs
+	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/defrag.f2fs
diff --git a/fsck/defrag.c b/fsck/defrag.c
new file mode 100644
index 0000000..7ca7260
--- /dev/null
+++ b/fsck/defrag.c
@@ -0,0 +1,101 @@
+/**
+ * defrag.c
+ *
+ * Copyright (c) 2015 Jaegeuk Kim <jaegeuk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "fsck.h"
+
+static int migrate_block(struct f2fs_sb_info *sbi, u64 from, u64 to)
+{
+	void *raw = calloc(BLOCK_SZ, 1);
+	struct seg_entry *se;
+	struct f2fs_summary sum;
+	u64 offset;
+	int ret, type;
+
+	ASSERT(raw != NULL);
+
+	/* read from */
+	ret = dev_read_block(raw, from);
+	ASSERT(ret >= 0);
+
+	/* write to */
+	ret = dev_write_block(raw, to);
+	ASSERT(ret >= 0);
+
+	/* update sit bitmap & valid_blocks && se->type */
+	se = get_seg_entry(sbi, GET_SEGNO(sbi, from));
+	offset = OFFSET_IN_SEG(sbi, from);
+	type = se->type;
+	se->valid_blocks--;
+	f2fs_clear_bit(offset, (char *)se->cur_valid_map);
+	se->dirty = 1;
+
+	se = get_seg_entry(sbi, GET_SEGNO(sbi, to));
+	offset = OFFSET_IN_SEG(sbi, to);
+	se->type = type;
+	se->valid_blocks++;
+	f2fs_set_bit(offset, (char *)se->cur_valid_map);
+	se->dirty = 1;
+
+	/* read/write SSA */
+	get_sum_entry(sbi, from, &sum);
+	update_sum_entry(sbi, to, &sum);
+
+	/* if data block, read node and update node block */
+	if (IS_DATASEG(type))
+		update_data_blkaddr(sbi, le32_to_cpu(sum.nid),
+				le16_to_cpu(sum.ofs_in_node), to);
+	else
+		update_nat_blkaddr(sbi, le32_to_cpu(sum.nid), to);
+
+	DBG(0, "Migrate %s block %"PRIx64" -> %"PRIx64"\n",
+					IS_DATASEG(type) ? "data" : "node",
+					from, to);
+	free(raw);
+	return 0;
+}
+
+int f2fs_defragment(struct f2fs_sb_info *sbi, u64 from, u64 len, u64 to, int left)
+{
+	struct seg_entry *se;
+	u64 idx, offset;
+
+	/* flush NAT/SIT journal entries */
+	flush_journal_entries(sbi);
+
+	for (idx = from; idx < from + len; idx++) {
+		u64 target = to;
+
+		se = get_seg_entry(sbi, GET_SEGNO(sbi, idx));
+		offset = OFFSET_IN_SEG(sbi, idx);
+
+		if (!f2fs_test_bit(offset, (const char *)se->cur_valid_map))
+			continue;
+
+		if (find_next_free_block(sbi, &target, left, se->type)) {
+			ASSERT_MSG("Not enough space to migrate blocks");
+			break;
+		}
+
+		if (migrate_block(sbi, idx, target)) {
+			ASSERT_MSG("Found inconsistency: please run FSCK");
+			return -1;
+		}
+	}
+
+	/* update curseg info; can update sit->types */
+	move_curseg_info(sbi, to);
+	write_curseg_info(sbi);
+
+	/* flush dirty sit entries */
+	flush_sit_entries(sbi);
+
+	write_checkpoint(sbi);
+
+	return 0;
+}
diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 03a0646..af5cc40 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -74,6 +74,7 @@ struct seg_entry {
 	unsigned char type;             /* segment type like CURSEG_XXX_TYPE */
 	unsigned char orig_type;        /* segment type like CURSEG_XXX_TYPE */
 	unsigned long long mtime;       /* modification time of the segment */
+	int dirty;
 };
 
 struct sec_entry {
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 4876914..1464146 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -121,6 +121,8 @@ extern struct seg_entry *get_seg_entry(struct f2fs_sb_info *, unsigned int);
 extern struct f2fs_summary_block *get_sum_block(struct f2fs_sb_info *,
 				unsigned int, int *);
 extern int get_sum_entry(struct f2fs_sb_info *, u32, struct f2fs_summary *);
+extern void update_sum_entry(struct f2fs_sb_info *, block_t,
+				struct f2fs_summary *);
 extern void get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
 extern void nullify_nat_entry(struct f2fs_sb_info *, u32);
 extern void rewrite_sit_area_bitmap(struct f2fs_sb_info *);
@@ -132,9 +134,14 @@ extern void fsck_free(struct f2fs_sb_info *);
 extern int f2fs_do_mount(struct f2fs_sb_info *);
 extern void f2fs_do_umount(struct f2fs_sb_info *);
 
+extern void flush_journal_entries(struct f2fs_sb_info *);
+extern void flush_sit_entries(struct f2fs_sb_info *);
 extern void move_curseg_info(struct f2fs_sb_info *, u64);
 extern void write_curseg_info(struct f2fs_sb_info *);
 extern int find_next_free_block(struct f2fs_sb_info *, u64 *, int, int);
+extern void write_checkpoint(struct f2fs_sb_info *);
+extern void update_data_blkaddr(struct f2fs_sb_info *, nid_t, u16, block_t);
+extern void update_nat_blkaddr(struct f2fs_sb_info *, nid_t, block_t);
 
 extern void print_raw_sb_info(struct f2fs_super_block *);
 
@@ -153,4 +160,7 @@ extern void ssa_dump(struct f2fs_sb_info *, int, int);
 extern void dump_node(struct f2fs_sb_info *, nid_t);
 extern int dump_info_from_blkaddr(struct f2fs_sb_info *, u32);
 
+/* defrag.c */
+int f2fs_defragment(struct f2fs_sb_info *, u64, u64, u64, int);
+
 #endif /* _FSCK_H_ */
diff --git a/fsck/main.c b/fsck/main.c
index 6b0d97e..d70b9ed 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -3,6 +3,8 @@
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
+ * Copyright (c) 2015 Jaegeuk Kim <jaegeuk@kernel.org>
+ *  : implement defrag.f2fs
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -38,6 +40,18 @@ void dump_usage()
 	exit(1);
 }
 
+void defrag_usage()
+{
+	MSG(0, "\nUsage: defrag.f2fs [options] device\n");
+	MSG(0, "[options]:\n");
+	MSG(0, "  -d debug level [default:0]\n");
+	MSG(0, "  -s start block address [default: main_blkaddr]\n");
+	MSG(0, "  -l length [default:512 (2MB)]\n");
+	MSG(0, "  -t target block address [default: main_blkaddr + 2MB]\n");
+	MSG(0, "  -i set direction as shrink [default: expand]\n");
+	exit(1);
+}
+
 void f2fs_parse_options(int argc, char *argv[])
 {
 	int option = 0;
@@ -128,6 +142,53 @@ void f2fs_parse_options(int argc, char *argv[])
 		}
 
 		config.private = &dump_opt;
+	} else if (!strcmp("defrag.f2fs", prog)) {
+		const char *option_string = "d:s:l:t:i";
+
+		config.func = DEFRAG;
+		while ((option = getopt(argc, argv, option_string)) != EOF) {
+			int ret = 0;
+
+			switch (option) {
+			case 'd':
+				config.dbg_lv = atoi(optarg);
+				MSG(0, "Info: Debug level = %d\n",
+							config.dbg_lv);
+				break;
+			case 's':
+				if (strncmp(optarg, "0x", 2))
+					ret = sscanf(optarg, "%"PRIu64"",
+							&config.defrag_start);
+				else
+					ret = sscanf(optarg, "%"PRIx64"",
+							&config.defrag_start);
+				break;
+			case 'l':
+				if (strncmp(optarg, "0x", 2))
+					ret = sscanf(optarg, "%"PRIu64"",
+							&config.defrag_len);
+				else
+					ret = sscanf(optarg, "%"PRIx64"",
+							&config.defrag_len);
+				break;
+			case 't':
+				if (strncmp(optarg, "0x", 2))
+					ret = sscanf(optarg, "%"PRIu64"",
+							&config.defrag_target);
+				else
+					ret = sscanf(optarg, "%"PRIx64"",
+							&config.defrag_target);
+				break;
+			case 'i':
+				config.defrag_shrink = 1;
+				break;
+			default:
+				MSG(0, "\tError: Unknown option %c\n", option);
+				defrag_usage();
+				break;
+			}
+			ASSERT(ret >= 0);
+		}
 	}
 
 	if ((optind + 1) != argc) {
@@ -136,6 +197,8 @@ void f2fs_parse_options(int argc, char *argv[])
 			fsck_usage();
 		else if (config.func == DUMP)
 			dump_usage();
+		else if (config.func == DEFRAG)
+			defrag_usage();
 	}
 	config.device_name = argv[optind];
 }
@@ -188,6 +251,55 @@ cleanup:
 	fsck_free(sbi);
 }
 
+static int do_defrag(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+
+	if (config.defrag_start > get_sb(block_count))
+		goto out_range;
+	if (config.defrag_start < SM_I(sbi)->main_blkaddr)
+		config.defrag_start = SM_I(sbi)->main_blkaddr;
+
+	if (config.defrag_len == 0)
+		config.defrag_len = sbi->blocks_per_seg;
+
+	if (config.defrag_start + config.defrag_len > get_sb(block_count))
+		config.defrag_len = get_sb(block_count) - config.defrag_start;
+
+	if (config.defrag_target == 0) {
+		config.defrag_target = config.defrag_start - 1;
+		if (!config.defrag_shrink)
+			config.defrag_target += config.defrag_len + 1;
+	}
+
+	if (config.defrag_target < SM_I(sbi)->main_blkaddr ||
+			config.defrag_target > get_sb(block_count))
+		goto out_range;
+	if (config.defrag_target >= config.defrag_start &&
+		config.defrag_target < config.defrag_start + config.defrag_len)
+		goto out_range;
+
+	if (config.defrag_start > config.defrag_target)
+		MSG(0, "Info: Move 0x%"PRIx64" <- [0x%"PRIx64"-0x%"PRIx64"]\n",
+				config.defrag_target,
+				config.defrag_start,
+				config.defrag_start + config.defrag_len - 1);
+	else
+		MSG(0, "Info: Move [0x%"PRIx64"-0x%"PRIx64"] -> 0x%"PRIx64"\n",
+				config.defrag_start,
+				config.defrag_start + config.defrag_len - 1,
+				config.defrag_target);
+
+	return f2fs_defragment(sbi, config.defrag_start, config.defrag_len,
+			config.defrag_target, config.defrag_shrink);
+out_range:
+	ASSERT_MSG("Out-of-range [0x%"PRIx64" ~ 0x%"PRIx64"] to 0x%"PRIx64"",
+				config.defrag_start,
+				config.defrag_start + config.defrag_len - 1,
+				config.defrag_target);
+	return -1;
+}
+
 int main(int argc, char **argv)
 {
 	struct f2fs_sb_info *sbi;
@@ -198,7 +310,7 @@ int main(int argc, char **argv)
 	f2fs_parse_options(argc, argv);
 
 	if (f2fs_dev_is_umounted(&config) < 0) {
-		if (!config.ro) {
+		if (!config.ro || config.func == DEFRAG) {
 			MSG(0, "\tError: Not available on mounted device!\n");
 			return -1;
 		}
@@ -218,12 +330,8 @@ fsck_again:
 	sbi = &gfsck.sbi;
 
 	ret = f2fs_do_mount(sbi);
-	if (ret == 1) {
-		free(sbi->ckpt);
-		free(sbi->raw_super);
-		goto out;
-	} else if (ret < 0)
-		return -1;
+	if (ret != 0)
+		goto out_err;
 
 	switch (config.func) {
 	case FSCK:
@@ -232,10 +340,14 @@ fsck_again:
 	case DUMP:
 		do_dump(sbi);
 		break;
+	case DEFRAG:
+		if (do_defrag(sbi))
+			goto out_err;
+		break;
 	}
 
 	f2fs_do_umount(sbi);
-out:
+
 	if (config.func == FSCK && config.bug_on) {
 		if (!config.ro && config.fix_on == 0 && config.auto_fix == 0) {
 			char ans[255] = {0};
@@ -258,4 +370,11 @@ retry:
 
 	printf("\nDone.\n");
 	return 0;
+
+out_err:
+	if (sbi->ckpt)
+		free(sbi->ckpt);
+	if (sbi->raw_super)
+		free(sbi->raw_super);
+	return -1;
 }
diff --git a/fsck/mount.c b/fsck/mount.c
index 970b159..e773471 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -718,6 +718,33 @@ static void read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	free(sum_blk);
 }
 
+void update_sum_entry(struct f2fs_sb_info *sbi, block_t blk_addr,
+					struct f2fs_summary *sum)
+{
+	struct f2fs_summary_block *sum_blk;
+	u32 segno, offset;
+	int type, ret;
+	struct seg_entry *se;
+
+	segno = GET_SEGNO(sbi, blk_addr);
+	offset = OFFSET_IN_SEG(sbi, blk_addr);
+
+	se = get_seg_entry(sbi, segno);
+
+	sum_blk = get_sum_block(sbi, segno, &type);
+	memcpy(&sum_blk->entries[offset], sum, sizeof(*sum));
+	sum_blk->footer.entry_type = IS_NODESEG(se->type) ? SUM_TYPE_NODE :
+							SUM_TYPE_DATA;
+
+	if (type == SEG_TYPE_NODE || type == SEG_TYPE_DATA ||
+					type == SEG_TYPE_MAX) {
+		u64 ssa_blk = GET_SUM_BLKADDR(sbi, segno);
+		ret = dev_write_block(sum_blk, ssa_blk);
+		ASSERT(ret >= 0);
+		free(sum_blk);
+	}
+}
+
 static void restore_curseg_summaries(struct f2fs_sb_info *sbi)
 {
 	int type = CURSEG_HOT_DATA;
@@ -965,6 +992,88 @@ static void get_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 	free(nat_block);
 }
 
+void update_data_blkaddr(struct f2fs_sb_info *sbi, nid_t nid,
+				u16 ofs_in_node, block_t newaddr)
+{
+	struct f2fs_node *node_blk = NULL;
+	struct node_info ni;
+	block_t oldaddr, startaddr, endaddr;
+	int ret;
+
+	node_blk = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
+	ASSERT(node_blk != NULL);
+
+	get_node_info(sbi, nid, &ni);
+
+	/* read node_block */
+	ret = dev_read_block(node_blk, ni.blk_addr);
+	ASSERT(ret >= 0);
+
+	/* check its block address */
+	if (node_blk->footer.nid == node_blk->footer.ino) {
+		oldaddr = le32_to_cpu(node_blk->i.i_addr[ofs_in_node]);
+		node_blk->i.i_addr[ofs_in_node] = cpu_to_le32(newaddr);
+	} else {
+		oldaddr = le32_to_cpu(node_blk->dn.addr[ofs_in_node]);
+		node_blk->dn.addr[ofs_in_node] = cpu_to_le32(newaddr);
+	}
+
+	ret = dev_write_block(node_blk, ni.blk_addr);
+	ASSERT(ret >= 0);
+
+	/* check extent cache entry */
+	if (node_blk->footer.nid != node_blk->footer.ino) {
+		get_node_info(sbi, le32_to_cpu(node_blk->footer.ino), &ni);
+
+		/* read inode block */
+		ret = dev_read_block(node_blk, ni.blk_addr);
+		ASSERT(ret >= 0);
+	}
+
+	startaddr = le32_to_cpu(node_blk->i.i_ext.blk_addr);
+	endaddr = startaddr + le32_to_cpu(node_blk->i.i_ext.len);
+	if (oldaddr >= startaddr && oldaddr < endaddr) {
+		node_blk->i.i_ext.len = 0;
+
+		/* update inode block */
+		ret = dev_write_block(node_blk, ni.blk_addr);
+		ASSERT(ret >= 0);
+	}
+	free(node_blk);
+}
+
+void update_nat_blkaddr(struct f2fs_sb_info *sbi, nid_t nid, block_t newaddr)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	struct f2fs_nat_block *nat_block;
+	pgoff_t block_off;
+	pgoff_t block_addr;
+	int seg_off, entry_off;
+	int ret;
+
+	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
+
+	block_off = nid / NAT_ENTRY_PER_BLOCK;
+	entry_off = nid % NAT_ENTRY_PER_BLOCK;
+
+	seg_off = block_off >> sbi->log_blocks_per_seg;
+	block_addr = (pgoff_t)(nm_i->nat_blkaddr +
+			(seg_off << sbi->log_blocks_per_seg << 1) +
+			(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
+
+	if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
+		block_addr += sbi->blocks_per_seg;
+
+	ret = dev_read_block(nat_block, block_addr);
+	ASSERT(ret >= 0);
+
+	nat_block->entries[entry_off].block_addr = cpu_to_le32(newaddr);
+
+	ret = dev_write_block(nat_block, block_addr);
+	ASSERT(ret >= 0);
+	free(nat_block);
+}
+
 void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 {
 	struct f2fs_nat_entry raw_nat;
@@ -1133,6 +1242,123 @@ void rewrite_sit_area_bitmap(struct f2fs_sb_info *sbi)
 	}
 }
 
+static void flush_sit_journal_entries(struct f2fs_sb_info *sbi)
+{
+	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
+	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct sit_info *sit_i = SIT_I(sbi);
+	unsigned int segno;
+	int i;
+
+	for (i = 0; i < sits_in_cursum(sum); i++) {
+		struct f2fs_sit_block *sit_blk;
+		struct f2fs_sit_entry *sit;
+		struct seg_entry *se;
+
+		segno = segno_in_journal(sum, i);
+		se = get_seg_entry(sbi, segno);
+
+		sit_blk = get_current_sit_page(sbi, segno);
+		sit = &sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, segno)];
+
+		memcpy(sit->valid_map, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
+		sit->vblocks = cpu_to_le16((se->type << SIT_VBLOCKS_SHIFT) |
+							se->valid_blocks);
+		sit->mtime = cpu_to_le64(se->mtime);
+
+		rewrite_current_sit_page(sbi, segno, sit_blk);
+		free(sit_blk);
+	}
+	sum->n_sits = 0;
+}
+
+static void flush_nat_journal_entries(struct f2fs_sb_info *sbi)
+{
+	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
+	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	struct f2fs_nat_block *nat_block;
+	pgoff_t block_off;
+	pgoff_t block_addr;
+	int seg_off, entry_off;
+	nid_t nid;
+	int ret;
+	int i = 0;
+
+next:
+	if (i >= nats_in_cursum(sum)) {
+		sum->n_nats = 0;
+		return;
+	}
+
+	nid = le32_to_cpu(nid_in_journal(sum, i));
+	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
+
+	block_off = nid / NAT_ENTRY_PER_BLOCK;
+	entry_off = nid % NAT_ENTRY_PER_BLOCK;
+
+	seg_off = block_off >> sbi->log_blocks_per_seg;
+	block_addr = (pgoff_t)(nm_i->nat_blkaddr +
+			(seg_off << sbi->log_blocks_per_seg << 1) +
+			(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
+
+	if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
+		block_addr += sbi->blocks_per_seg;
+
+	ret = dev_read_block(nat_block, block_addr);
+	ASSERT(ret >= 0);
+
+	memcpy(&nat_block->entries[entry_off], &nat_in_journal(sum, i),
+					sizeof(struct f2fs_nat_entry));
+
+	ret = dev_write_block(nat_block, block_addr);
+	ASSERT(ret >= 0);
+	free(nat_block);
+	i++;
+	goto next;
+}
+
+void flush_journal_entries(struct f2fs_sb_info *sbi)
+{
+	flush_nat_journal_entries(sbi);
+	flush_sit_journal_entries(sbi);
+	write_checkpoint(sbi);
+}
+
+void flush_sit_entries(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+	struct sit_info *sit_i = SIT_I(sbi);
+	unsigned int segno = 0;
+	u32 free_segs = 0;
+
+	/* update free segments */
+	for (segno = 0; segno < TOTAL_SEGS(sbi); segno++) {
+		struct f2fs_sit_block *sit_blk;
+		struct f2fs_sit_entry *sit;
+		struct seg_entry *se;
+
+		se = get_seg_entry(sbi, segno);
+
+		if (!se->dirty)
+			continue;
+
+		sit_blk = get_current_sit_page(sbi, segno);
+		sit = &sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, segno)];
+		memcpy(sit->valid_map, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
+		sit->vblocks = cpu_to_le16((se->type << SIT_VBLOCKS_SHIFT) |
+							se->valid_blocks);
+		rewrite_current_sit_page(sbi, segno, sit_blk);
+		free(sit_blk);
+
+		if (se->valid_blocks == 0x0 &&
+				!IS_CUR_SEGNO(sbi, segno, NO_CHECK_TYPE))
+			free_segs++;
+	}
+
+	set_cp(free_segment_count, free_segs);
+}
+
 int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
 {
 	struct seg_entry *se;
@@ -1293,6 +1519,70 @@ void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
 	free(nat_block);
 }
 
+void write_checkpoint(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+	block_t orphan_blks = 0;
+	u32 free_segs = 0;
+	unsigned long long cp_blk_no;
+	u32 flags = CP_UMOUNT_FLAG;
+	unsigned int segno;
+	int i, ret;
+	u_int32_t crc = 0;
+
+	if (is_set_ckpt_flags(cp, CP_ORPHAN_PRESENT_FLAG)) {
+		orphan_blks = __start_sum_addr(sbi) - 1;
+		flags |= CP_ORPHAN_PRESENT_FLAG;
+	}
+
+	set_cp(ckpt_flags, flags);
+
+	for (segno = 0; segno < TOTAL_SEGS(sbi); segno++) {
+		struct seg_entry *se = get_seg_entry(sbi, segno);
+
+		if (se->valid_blocks == 0x0 &&
+				!IS_CUR_SEGNO(sbi, segno, NO_CHECK_TYPE))
+			free_segs++;
+	}
+	set_cp(free_segment_count, free_segs);
+	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
+
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
+	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) = cpu_to_le32(crc);
+
+	cp_blk_no = get_sb(cp_blkaddr);
+	if (sbi->cur_cp == 2)
+		cp_blk_no += 1 << get_sb(log_blocks_per_seg);
+
+	/* write the first cp */
+	ret = dev_write_block(cp, cp_blk_no++);
+	ASSERT(ret >= 0);
+
+	/* skip payload */
+	cp_blk_no += get_sb(cp_payload);
+	/* skip orphan blocks */
+	cp_blk_no += orphan_blks;
+
+	/* update summary blocks having nullified journal entries */
+	for (i = 0; i < NO_CHECK_TYPE; i++) {
+		struct curseg_info *curseg = CURSEG_I(sbi, i);
+		u64 ssa_blk;
+
+		ret = dev_write_block(curseg->sum_blk, cp_blk_no++);
+		ASSERT(ret >= 0);
+
+		/* update original SSA too */
+		ssa_blk = GET_SUM_BLKADDR(sbi, curseg->segno);
+		ret = dev_write_block(curseg->sum_blk, ssa_blk);
+		ASSERT(ret >= 0);
+	}
+
+	/* write the last cp */
+	ret = dev_write_block(cp, cp_blk_no++);
+	ASSERT(ret >= 0);
+}
+
 void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index bbdeb51..29ff9fe 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -220,6 +220,7 @@ static inline uint64_t bswap_64(uint64_t val)
 enum f2fs_config_func {
 	FSCK,
 	DUMP,
+	DEFRAG,
 };
 
 struct f2fs_configuration {
@@ -252,6 +253,12 @@ struct f2fs_configuration {
 	int auto_fix;
 	int ro;
 	__le32 feature;			/* defined features */
+
+	/* defragmentation parameters */
+	int defrag_shrink;
+	u_int64_t defrag_start;
+	u_int64_t defrag_len;
+	u_int64_t defrag_target;
 } __attribute__((packed));
 
 #ifdef CONFIG_64BIT
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
