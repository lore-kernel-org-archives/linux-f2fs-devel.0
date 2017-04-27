From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: allow cpc->reason to indicate more
	than one reason
Date: Thu, 27 Apr 2017 20:40:39 +0800
Message-ID: <20170427124040.74399-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d3iko-0004PJ-9w
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Apr 2017 12:42:38 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187]
	helo=dggrg01-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d3ika-0004Bz-7L
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Apr 2017 12:42:38 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Change to use different bits of cpc->reason to indicate different status,
so cpc->reason can indicate more than one reason.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 14 +++++++-------
 fs/f2fs/f2fs.h       | 16 +++++++---------
 fs/f2fs/segment.c    |  8 ++++----
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 800be94f8cb3..27578903eeb6 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1054,17 +1054,17 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	spin_lock(&sbi->cp_lock);
 
-	if (cpc->reason == CP_UMOUNT &&
+	if ((cpc->reason & CP_UMOUNT) &&
 			le32_to_cpu(ckpt->cp_pack_total_block_count) >
 			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks)
 		disable_nat_bits(sbi, false);
 
-	if (cpc->reason == CP_UMOUNT)
+	if (cpc->reason & CP_UMOUNT)
 		__set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
 	else
 		__clear_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
 
-	if (cpc->reason == CP_FASTBOOT)
+	if (cpc->reason & CP_FASTBOOT)
 		__set_ckpt_flags(ckpt, CP_FASTBOOT_FLAG);
 	else
 		__clear_ckpt_flags(ckpt, CP_FASTBOOT_FLAG);
@@ -1272,8 +1272,8 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	mutex_lock(&sbi->cp_mutex);
 
 	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
-		(cpc->reason == CP_FASTBOOT || cpc->reason == CP_SYNC ||
-		(cpc->reason == CP_DISCARD && !sbi->discard_blks)))
+		((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYNC) ||
+		((cpc->reason & CP_DISCARD) && !sbi->discard_blks)))
 		goto out;
 	if (unlikely(f2fs_cp_error(sbi))) {
 		err = -EIO;
@@ -1295,7 +1295,7 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	f2fs_flush_merged_bios(sbi);
 
 	/* this is the case of multiple fstrims without any changes */
-	if (cpc->reason == CP_DISCARD) {
+	if (cpc->reason & CP_DISCARD) {
 		if (!exist_trim_candidates(sbi, cpc)) {
 			unblock_operations(sbi);
 			goto out;
@@ -1333,7 +1333,7 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	unblock_operations(sbi);
 	stat_inc_cp_count(sbi->stat_info);
 
-	if (cpc->reason == CP_RECOVERY)
+	if (cpc->reason & CP_RECOVERY)
 		f2fs_msg(sbi->sb, KERN_NOTICE,
 			"checkpoint: version = %llx", ckpt_ver);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bf48213642ab..453eaa943a21 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -125,13 +125,11 @@ enum {
 	SIT_BITMAP
 };
 
-enum {
-	CP_UMOUNT,
-	CP_FASTBOOT,
-	CP_SYNC,
-	CP_RECOVERY,
-	CP_DISCARD,
-};
+#define	CP_UMOUNT	0x00000001
+#define	CP_FASTBOOT	0x00000002
+#define	CP_SYNC		0x00000004
+#define	CP_RECOVERY	0x00000008
+#define	CP_DISCARD	0x00000010
 
 #define DEF_BATCHED_TRIM_SECTIONS	2048
 #define BATCHED_TRIM_SEGMENTS(sbi)	\
@@ -1264,7 +1262,7 @@ static inline bool enabled_nat_bits(struct f2fs_sb_info *sbi,
 {
 	bool set = is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
 
-	return (cpc) ? (cpc->reason == CP_UMOUNT) && set : set;
+	return (cpc) ? (cpc->reason & CP_UMOUNT) && set : set;
 }
 
 static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
@@ -1300,7 +1298,7 @@ static inline int __get_cp_reason(struct f2fs_sb_info *sbi)
 
 static inline bool __remain_node_summaries(int reason)
 {
-	return (reason == CP_UMOUNT || reason == CP_FASTBOOT);
+	return (reason & (CP_UMOUNT | CP_FASTBOOT));
 }
 
 static inline bool __exist_node_summaries(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b0babb73a076..a2cd10cdff60 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1167,7 +1167,7 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 	unsigned long *discard_map = (unsigned long *)se->discard_map;
 	unsigned long *dmap = SIT_I(sbi)->tmp_map;
 	unsigned int start = 0, end = -1;
-	bool force = (cpc->reason == CP_DISCARD);
+	bool force = (cpc->reason & CP_DISCARD);
 	struct discard_entry *de = NULL;
 	struct list_head *head = &SM_I(sbi)->dcc_info->entry_list;
 	int i;
@@ -1250,7 +1250,7 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	unsigned long *prefree_map = dirty_i->dirty_segmap[PRE];
 	unsigned int start = 0, end = -1;
 	unsigned int secno, start_segno;
-	bool force = (cpc->reason == CP_DISCARD);
+	bool force = (cpc->reason & CP_DISCARD);
 
 	mutex_lock(&dirty_i->seglist_lock);
 
@@ -2754,7 +2754,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			se = get_seg_entry(sbi, segno);
 
 			/* add discard candidates */
-			if (cpc->reason != CP_DISCARD) {
+			if (!(cpc->reason & CP_DISCARD)) {
 				cpc->trim_start = segno;
 				add_discard_addrs(sbi, cpc, false);
 			}
@@ -2790,7 +2790,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	f2fs_bug_on(sbi, !list_empty(head));
 	f2fs_bug_on(sbi, sit_i->dirty_sentries);
 out:
-	if (cpc->reason == CP_DISCARD) {
+	if (cpc->reason & CP_DISCARD) {
 		__u64 trim_start = cpc->trim_start;
 
 		for (; cpc->trim_start <= cpc->trim_end; cpc->trim_start++)
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
