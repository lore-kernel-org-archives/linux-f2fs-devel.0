From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 4/6] f2fs: introduce cp_lock to protect
	updating of ckpt_flags
Date: Tue, 20 Sep 2016 11:04:18 +0800
Message-ID: <20160920030418.8828-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bmBN0-000058-8a
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Sep 2016 03:05:18 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bmBMv-0008IH-HT
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Sep 2016 03:05:18 +0000
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

This patch introduces spinlock to protect updating process of ckpt_flags
field in struct f2fs_checkpoint, it avoids incorrectly updating in race
condition.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 28 ++++++++++++++++------------
 fs/f2fs/f2fs.h       | 37 +++++++++++++++++++++++++++++--------
 fs/f2fs/recovery.c   |  2 +-
 fs/f2fs/segment.c    |  4 ++--
 fs/f2fs/super.c      |  5 +++--
 5 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a366521..bc93afd 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -28,7 +28,7 @@ struct kmem_cache *inode_entry_slab;
 
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
 {
-	set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
+	set_ckpt_flags(sbi, CP_ERROR_FLAG);
 	sbi->sb->s_flags |= MS_RDONLY;
 	if (!end_io)
 		f2fs_flush_merged_bios(sbi);
@@ -574,7 +574,7 @@ int recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	block_t start_blk, orphan_blocks, i, j;
 	int err;
 
-	if (!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG))
+	if (!is_set_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG))
 		return 0;
 
 	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
@@ -598,7 +598,7 @@ int recover_orphan_inodes(struct f2fs_sb_info *sbi)
 		f2fs_put_page(page, 1);
 	}
 	/* clear Orphan Flag */
-	clear_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG);
+	clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
 	return 0;
 }
 
@@ -1056,10 +1056,12 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* 2 cp  + n data seg summary + orphan inode blocks */
 	data_sum_blocks = npages_for_summary_flush(sbi, false);
+	spin_lock(&sbi->cp_lock);
 	if (data_sum_blocks < NR_CURSEG_DATA_TYPE)
-		set_ckpt_flags(ckpt, CP_COMPACT_SUM_FLAG);
+		__set_ckpt_flags(ckpt, CP_COMPACT_SUM_FLAG);
 	else
-		clear_ckpt_flags(ckpt, CP_COMPACT_SUM_FLAG);
+		__clear_ckpt_flags(ckpt, CP_COMPACT_SUM_FLAG);
+	spin_unlock(&sbi->cp_lock);
 
 	orphan_blocks = GET_ORPHAN_BLOCKS(orphan_num);
 	ckpt->cp_pack_start_sum = cpu_to_le32(1 + cp_payload_blks +
@@ -1074,23 +1076,25 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 				cp_payload_blks + data_sum_blocks +
 				orphan_blocks);
 
+	spin_lock(&sbi->cp_lock);
 	if (cpc->reason == CP_UMOUNT)
-		set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
+		__set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
 	else
-		clear_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
+		__clear_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
 
 	if (cpc->reason == CP_FASTBOOT)
-		set_ckpt_flags(ckpt, CP_FASTBOOT_FLAG);
+		__set_ckpt_flags(ckpt, CP_FASTBOOT_FLAG);
 	else
-		clear_ckpt_flags(ckpt, CP_FASTBOOT_FLAG);
+		__clear_ckpt_flags(ckpt, CP_FASTBOOT_FLAG);
 
 	if (orphan_num)
-		set_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
+		__set_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
 	else
-		clear_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
+		__clear_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
 
 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
-		set_ckpt_flags(ckpt, CP_FSCK_FLAG);
+		__set_ckpt_flags(ckpt, CP_FSCK_FLAG);
+	spin_unlock(&sbi->cp_lock);
 
 	/* update SIT/NAT bitmap */
 	get_sit_bitmap(sbi, __bitmap_ptr(sbi, SIT_BITMAP));
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 53da455..7803808 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -817,6 +817,7 @@ struct f2fs_sb_info {
 
 	/* for checkpoint */
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
+	spinlock_t cp_lock;			/* for flag in ckpt */
 	struct inode *meta_inode;		/* cache meta blocks */
 	struct mutex cp_mutex;			/* checkpoint procedure lock */
 	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
@@ -1084,26 +1085,46 @@ static inline unsigned long long cur_cp_version(struct f2fs_checkpoint *cp)
 	return le64_to_cpu(cp->checkpoint_ver);
 }
 
-static inline bool is_set_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
+static inline bool is_set_ckpt_flags(struct f2fs_sb_info *sbi, unsigned int f)
 {
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	unsigned int ckpt_flags = le32_to_cpu(cp->ckpt_flags);
+
 	return ckpt_flags & f;
 }
 
-static inline void set_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
+static inline void __set_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
 {
-	unsigned int ckpt_flags = le32_to_cpu(cp->ckpt_flags);
+	unsigned int ckpt_flags;
+
+	ckpt_flags = le32_to_cpu(cp->ckpt_flags);
 	ckpt_flags |= f;
 	cp->ckpt_flags = cpu_to_le32(ckpt_flags);
 }
 
-static inline void clear_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
+static inline void set_ckpt_flags(struct f2fs_sb_info *sbi, unsigned int f)
 {
-	unsigned int ckpt_flags = le32_to_cpu(cp->ckpt_flags);
+	spin_lock(&sbi->cp_lock);
+	__set_ckpt_flags(F2FS_CKPT(sbi), f);
+	spin_unlock(&sbi->cp_lock);
+}
+
+static inline void __clear_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
+{
+	unsigned int ckpt_flags;
+
+	ckpt_flags = le32_to_cpu(cp->ckpt_flags);
 	ckpt_flags &= (~f);
 	cp->ckpt_flags = cpu_to_le32(ckpt_flags);
 }
 
+static inline void clear_ckpt_flags(struct f2fs_sb_info *sbi, unsigned int f)
+{
+	spin_lock(&sbi->cp_lock);
+	__clear_ckpt_flags(F2FS_CKPT(sbi), f);
+	spin_unlock(&sbi->cp_lock);
+}
+
 static inline bool f2fs_discard_en(struct f2fs_sb_info *sbi)
 {
 	struct request_queue *q = bdev_get_queue(sbi->sb->s_bdev);
@@ -1149,8 +1170,8 @@ static inline bool __remain_node_summaries(int reason)
 
 static inline bool __exist_node_summaries(struct f2fs_sb_info *sbi)
 {
-	return (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_UMOUNT_FLAG) ||
-			is_set_ckpt_flags(F2FS_CKPT(sbi), CP_FASTBOOT_FLAG));
+	return (is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG) ||
+			is_set_ckpt_flags(sbi, CP_FASTBOOT_FLAG));
 }
 
 /*
@@ -1852,7 +1873,7 @@ static inline int f2fs_readonly(struct super_block *sb)
 
 static inline bool f2fs_cp_error(struct f2fs_sb_info *sbi)
 {
-	return is_set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
+	return is_set_ckpt_flags(sbi, CP_ERROR_FLAG);
 }
 
 static inline bool is_dot_dotdot(const struct qstr *str)
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index ad748e5..37d99d2 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -649,7 +649,7 @@ out:
 			invalidate_mapping_pages(META_MAPPING(sbi),
 							blkaddr, blkaddr);
 
-		set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
+		set_ckpt_flags(sbi, CP_ERROR_FLAG);
 		mutex_unlock(&sbi->cp_mutex);
 	} else if (need_writecp) {
 		struct cp_control cpc = {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 101b58f..dc68f30 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1825,7 +1825,7 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 	int type = CURSEG_HOT_DATA;
 	int err;
 
-	if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_COMPACT_SUM_FLAG)) {
+	if (is_set_ckpt_flags(sbi, CP_COMPACT_SUM_FLAG)) {
 		int npages = npages_for_summary_flush(sbi, true);
 
 		if (npages >= 2)
@@ -1922,7 +1922,7 @@ static void write_normal_summaries(struct f2fs_sb_info *sbi,
 
 void write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
 {
-	if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_COMPACT_SUM_FLAG))
+	if (is_set_ckpt_flags(sbi, CP_COMPACT_SUM_FLAG))
 		write_compacted_summaries(sbi, start_blk);
 	else
 		write_normal_summaries(sbi, start_blk, CURSEG_HOT_DATA);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 52575c2..151a0cd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -736,7 +736,7 @@ static void f2fs_put_super(struct super_block *sb)
 	 * clean checkpoint again.
 	 */
 	if (is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
-			!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_UMOUNT_FLAG)) {
+			!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT,
 		};
@@ -1478,6 +1478,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	mutex_init(&sbi->umount_mutex);
 	mutex_init(&sbi->wio_mutex[NODE]);
 	mutex_init(&sbi->wio_mutex[DATA]);
+	spin_lock_init(&sbi->cp_lock);
 
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	memcpy(sbi->key_prefix, F2FS_KEY_DESC_PREFIX,
@@ -1819,7 +1820,7 @@ try_onemore:
 		 * previous checkpoint was not done by clean system shutdown.
 		 */
 		if (bdev_read_only(sb->s_bdev) &&
-				!is_set_ckpt_flags(sbi->ckpt, CP_UMOUNT_FLAG)) {
+				!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
 			err = -EROFS;
 			goto free_kobj;
 		}
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
