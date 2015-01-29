From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 4/5] f2fs: should fail mount when trying to recover data
 on read-only dev
Date: Thu, 29 Jan 2015 13:39:31 -0800
Message-ID: <20150129213931.GA17521@jaegeuk-mac02>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
 <1422401503-4769-4-git-send-email-jaegeuk@kernel.org>
 <002d01d03bbd$8b533c10$a1f9b430$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <002d01d03bbd$8b533c10$a1f9b430$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

This is another patch to fix that.

>From d241924043778d0fe01e9020d5771cc42cf246e6 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 29 Jan 2015 11:45:33 -0800
Subject: [PATCH] f2fs: split UMOUNT and FASTBOOT flags

This patch adds FASTBOOT flag into checkpoint as follows.

 - CP_UMOUNT_FLAG is set when system is umounted.
 - CP_FASTBOOT_FLAG is set when intermediate checkpoint having node summaries
   was done.

So, if you get CP_UMOUNT_FLAG from checkpoint, the system was umounted cleanly.
Instead, if there was sudden-power-off, you can get CP_FASTBOOT_FLAG or nothing.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c        | 19 +++++++++++++------
 fs/f2fs/f2fs.h              | 23 +++++++++++++++++++++++
 fs/f2fs/gc.c                |  3 +--
 fs/f2fs/segment.c           | 11 +++++------
 fs/f2fs/super.c             |  5 ++---
 include/linux/f2fs_fs.h     |  1 +
 include/trace/events/f2fs.h |  1 +
 7 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 22165fb..f7cdcad 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -956,17 +956,24 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	ckpt->cp_pack_start_sum = cpu_to_le32(1 + cp_payload_blks +
 			orphan_blocks);
 
-	if (cpc->reason == CP_UMOUNT) {
-		set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
+	if (__remain_node_summaries(cpc->reason))
 		ckpt->cp_pack_total_block_count = cpu_to_le32(F2FS_CP_PACKS+
 				cp_payload_blks + data_sum_blocks +
 				orphan_blocks + NR_CURSEG_NODE_TYPE);
-	} else {
-		clear_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
+	else
 		ckpt->cp_pack_total_block_count = cpu_to_le32(F2FS_CP_PACKS +
 				cp_payload_blks + data_sum_blocks +
 				orphan_blocks);
-	}
+
+	if (cpc->reason == CP_UMOUNT)
+		set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
+	else
+		clear_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
+
+	if (cpc->reason == CP_FASTBOOT)
+		set_ckpt_flags(ckpt, CP_FASTBOOT_FLAG);
+	else
+		clear_ckpt_flags(ckpt, CP_FASTBOOT_FLAG);
 
 	if (orphan_num)
 		set_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
@@ -1010,7 +1017,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	write_data_summaries(sbi, start_blk);
 	start_blk += data_sum_blocks;
-	if (cpc->reason == CP_UMOUNT) {
+	if (__remain_node_summaries(cpc->reason)) {
 		write_node_summaries(sbi, start_blk);
 		start_blk += NR_CURSEG_NODE_TYPE;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b629408..0a2d1ff 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -100,6 +100,7 @@ enum {
 
 enum {
 	CP_UMOUNT,
+	CP_FASTBOOT,
 	CP_SYNC,
 	CP_DISCARD,
 };
@@ -788,6 +789,28 @@ static inline void f2fs_unlock_all(struct f2fs_sb_info *sbi)
 	up_write(&sbi->cp_rwsem);
 }
 
+static inline int __get_cp_reason(struct f2fs_sb_info *sbi)
+{
+	int reason = CP_SYNC;
+
+	if (test_opt(sbi, FASTBOOT))
+		reason = CP_FASTBOOT;
+	if (is_sbi_flag_set(sbi, SBI_IS_CLOSE))
+		reason = CP_UMOUNT;
+	return reason;
+}
+
+static inline bool __remain_node_summaries(int reason)
+{
+	return (reason == CP_UMOUNT || reason == CP_FASTBOOT);
+}
+
+static inline bool __exist_node_summaries(struct f2fs_sb_info *sbi)
+{
+	return (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_UMOUNT_FLAG) ||
+			is_set_ckpt_flags(F2FS_CKPT(sbi), CP_FASTBOOT_FLAG));
+}
+
 /*
  * Check whether the given nid is within node id range.
  */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ba89e27..76adbc3 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -698,8 +698,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi)
 		.iroot = RADIX_TREE_INIT(GFP_NOFS),
 	};
 
-	cpc.reason = test_opt(sbi, FASTBOOT) ? CP_UMOUNT : CP_SYNC;
-
+	cpc.reason = __get_cp_reason(sbi);
 gc_more:
 	if (unlikely(!(sbi->sb->s_flags & MS_ACTIVE)))
 		goto stop;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 31c4e57..5ea57ec 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1401,7 +1401,7 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 		segno = le32_to_cpu(ckpt->cur_data_segno[type]);
 		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[type -
 							CURSEG_HOT_DATA]);
-		if (is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG))
+		if (__exist_node_summaries(sbi))
 			blk_addr = sum_blk_addr(sbi, NR_CURSEG_TYPE, type);
 		else
 			blk_addr = sum_blk_addr(sbi, NR_CURSEG_DATA_TYPE, type);
@@ -1410,7 +1410,7 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 							CURSEG_HOT_NODE]);
 		blk_off = le16_to_cpu(ckpt->cur_node_blkoff[type -
 							CURSEG_HOT_NODE]);
-		if (is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG))
+		if (__exist_node_summaries(sbi))
 			blk_addr = sum_blk_addr(sbi, NR_CURSEG_NODE_TYPE,
 							type - CURSEG_HOT_NODE);
 		else
@@ -1421,7 +1421,7 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	sum = (struct f2fs_summary_block *)page_address(new);
 
 	if (IS_NODESEG(type)) {
-		if (is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG)) {
+		if (__exist_node_summaries(sbi)) {
 			struct f2fs_summary *ns = &sum->entries[0];
 			int i;
 			for (i = 0; i < sbi->blocks_per_seg; i++, ns++) {
@@ -1470,7 +1470,7 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 		type = CURSEG_HOT_NODE;
 	}
 
-	if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_UMOUNT_FLAG))
+	if (__exist_node_summaries(sbi))
 		ra_meta_pages(sbi, sum_blk_addr(sbi, NR_CURSEG_TYPE, type),
 					NR_CURSEG_TYPE - type, META_CP);
 
@@ -1567,8 +1567,7 @@ void write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
 
 void write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
 {
-	if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_UMOUNT_FLAG))
-		write_normal_summaries(sbi, start_blk, CURSEG_HOT_NODE);
+	write_normal_summaries(sbi, start_blk, CURSEG_HOT_NODE);
 }
 
 int lookup_journal_in_cursum(struct f2fs_summary_block *sum, int type,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a60fa1a..03d1b9c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -500,9 +500,8 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 	if (sync) {
 		struct cp_control cpc;
 
-		cpc.reason = (test_opt(sbi, FASTBOOT) ||
-					is_sbi_flag_set(sbi, SBI_IS_CLOSE)) ?
-						CP_UMOUNT : CP_SYNC;
+		cpc.reason = __get_cp_reason(sbi);
+
 		mutex_lock(&sbi->gc_mutex);
 		write_checkpoint(sbi, &cpc);
 		mutex_unlock(&sbi->gc_mutex);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 295acfa..cfe771b 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -87,6 +87,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_FASTBOOT_FLAG	0x00000020
 #define CP_FSCK_FLAG		0x00000010
 #define CP_ERROR_FLAG		0x00000008
 #define CP_COMPACT_SUM_FLAG	0x00000004
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 5e1c029..6962982 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -72,6 +72,7 @@
 #define show_cpreason(type)						\
 	__print_symbolic(type,						\
 		{ CP_UMOUNT,	"Umount" },				\
+		{ CP_FASTBOOT,	"Fastboot" },				\
 		{ CP_SYNC,	"Sync" },				\
 		{ CP_DISCARD,	"Discard" })
 
-- 
2.1.1
