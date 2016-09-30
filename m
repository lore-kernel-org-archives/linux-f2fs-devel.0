From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2 v2] f2fs: use crc and cp version to determine
 roll-forward recovery
Date: Fri, 30 Sep 2016 10:10:05 -0700
Message-ID: <20160930171005.GC46477@jaegeuk>
References: <20160920025504.72524-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160920025504.72524-1-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, we used cp_version only to detect recoverable dnodes.
In order to avoid same garbage cp_version, we needed to truncate the next
dnode during checkpoint, resulting in additional discard or data write.
If we can distinguish this by using crc in addition to cp_version, we can
remove this overhead.

There is backward compatibility concern where it changes node_footer layout.
So, this patch introduces a new checkpoint flag, CP_CRC_RECOVERY_FLAG, to
detect new layout. New layout will be activated only when this flag is set.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c    | 21 ++------------
 fs/f2fs/f2fs.h          |  1 -
 fs/f2fs/node.h          | 77 +++++++++++++++++++++++++++++++------------------
 fs/f2fs/recovery.c      | 36 ++++-------------------
 fs/f2fs/segment.c       | 22 --------------
 fs/f2fs/super.c         |  5 +++-
 include/linux/f2fs_fs.h |  1 +
 7 files changed, 63 insertions(+), 100 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index df56a43..9c6439b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -992,7 +992,6 @@ static void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
 static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned long orphan_num = sbi->im[ORPHAN_INO].ino_num;
 	nid_t last_nid = nm_i->next_scan_nid;
@@ -1001,19 +1000,10 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	__u32 crc32 = 0;
 	int i;
 	int cp_payload_blks = __cp_payload(sbi);
-	block_t discard_blk = NEXT_FREE_BLKADDR(sbi, curseg);
-	bool invalidate = false;
 	struct super_block *sb = sbi->sb;
 	struct curseg_info *seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
 	u64 kbytes_written;
 
-	/*
-	 * This avoids to conduct wrong roll-forward operations and uses
-	 * metapages, so should be called prior to sync_meta_pages below.
-	 */
-	if (!test_opt(sbi, LFS) && discard_next_dnode(sbi, discard_blk))
-		invalidate = true;
-
 	/* Flush all the NAT/SIT pages */
 	while (get_pages(sbi, F2FS_DIRTY_META)) {
 		sync_meta_pages(sbi, META, LONG_MAX);
@@ -1089,6 +1079,9 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
 		set_ckpt_flags(ckpt, CP_FSCK_FLAG);
 
+	/* set this flag to activate crc|cp_ver for recovery */
+	set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG);
+
 	/* update SIT/NAT bitmap */
 	get_sit_bitmap(sbi, __bitmap_ptr(sbi, SIT_BITMAP));
 	get_nat_bitmap(sbi, __bitmap_ptr(sbi, NAT_BITMAP));
@@ -1154,14 +1147,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	/* wait for previous submitted meta pages writeback */
 	wait_on_all_pages_writeback(sbi);
 
-	/*
-	 * invalidate meta page which is used temporarily for zeroing out
-	 * block at the end of warm node chain.
-	 */
-	if (invalidate)
-		invalidate_mapping_pages(META_MAPPING(sbi), discard_blk,
-								discard_blk);
-
 	release_ino_entry(sbi, false);
 
 	if (unlikely(f2fs_cp_error(sbi)))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b39fdcd..cda8e6f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2045,7 +2045,6 @@ void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
 void f2fs_wait_all_discard_bio(struct f2fs_sb_info *);
 void clear_prefree_segments(struct f2fs_sb_info *, struct cp_control *);
 void release_discard_addrs(struct f2fs_sb_info *);
-bool discard_next_dnode(struct f2fs_sb_info *, block_t);
 int npages_for_summary_flush(struct f2fs_sb_info *, bool);
 void allocate_new_segments(struct f2fs_sb_info *);
 int f2fs_trim_fs(struct f2fs_sb_info *, struct fstrim_range *);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index fc76845..e8ca64a 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -229,6 +229,37 @@ static inline void set_to_next_nat(struct f2fs_nm_info *nm_i, nid_t start_nid)
 	f2fs_change_bit(block_off, nm_i->nat_bitmap);
 }
 
+static inline nid_t ino_of_node(struct page *node_page)
+{
+	struct f2fs_node *rn = F2FS_NODE(node_page);
+	return le32_to_cpu(rn->footer.ino);
+}
+
+static inline nid_t nid_of_node(struct page *node_page)
+{
+	struct f2fs_node *rn = F2FS_NODE(node_page);
+	return le32_to_cpu(rn->footer.nid);
+}
+
+static inline unsigned int ofs_of_node(struct page *node_page)
+{
+	struct f2fs_node *rn = F2FS_NODE(node_page);
+	unsigned flag = le32_to_cpu(rn->footer.flag);
+	return flag >> OFFSET_BIT_SHIFT;
+}
+
+static inline __u64 cpver_of_node(struct page *node_page)
+{
+	struct f2fs_node *rn = F2FS_NODE(node_page);
+	return le64_to_cpu(rn->footer.cp_ver);
+}
+
+static inline block_t next_blkaddr_of_node(struct page *node_page)
+{
+	struct f2fs_node *rn = F2FS_NODE(node_page);
+	return le32_to_cpu(rn->footer.next_blkaddr);
+}
+
 static inline void fill_node_footer(struct page *page, nid_t nid,
 				nid_t ino, unsigned int ofs, bool reset)
 {
@@ -259,40 +290,30 @@ static inline void fill_node_footer_blkaddr(struct page *page, block_t blkaddr)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_P_SB(page));
 	struct f2fs_node *rn = F2FS_NODE(page);
+	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
+	__u64 cp_ver = le64_to_cpu(ckpt->checkpoint_ver);
 
-	rn->footer.cp_ver = ckpt->checkpoint_ver;
+	if (is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG)) {
+		__u64 crc = le32_to_cpu(*((__le32 *)
+				((unsigned char *)ckpt + crc_offset)));
+		cp_ver |= (crc << 32);
+	}
+	rn->footer.cp_ver = cpu_to_le64(cp_ver);
 	rn->footer.next_blkaddr = cpu_to_le32(blkaddr);
 }
 
-static inline nid_t ino_of_node(struct page *node_page)
-{
-	struct f2fs_node *rn = F2FS_NODE(node_page);
-	return le32_to_cpu(rn->footer.ino);
-}
-
-static inline nid_t nid_of_node(struct page *node_page)
+static inline bool is_recoverable_dnode(struct page *page)
 {
-	struct f2fs_node *rn = F2FS_NODE(node_page);
-	return le32_to_cpu(rn->footer.nid);
-}
-
-static inline unsigned int ofs_of_node(struct page *node_page)
-{
-	struct f2fs_node *rn = F2FS_NODE(node_page);
-	unsigned flag = le32_to_cpu(rn->footer.flag);
-	return flag >> OFFSET_BIT_SHIFT;
-}
-
-static inline unsigned long long cpver_of_node(struct page *node_page)
-{
-	struct f2fs_node *rn = F2FS_NODE(node_page);
-	return le64_to_cpu(rn->footer.cp_ver);
-}
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_P_SB(page));
+	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
+	__u64 cp_ver = cur_cp_version(ckpt);
 
-static inline block_t next_blkaddr_of_node(struct page *node_page)
-{
-	struct f2fs_node *rn = F2FS_NODE(node_page);
-	return le32_to_cpu(rn->footer.next_blkaddr);
+	if (is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG)) {
+		__u64 crc = le32_to_cpu(*((__le32 *)
+				((unsigned char *)ckpt + crc_offset)));
+		cp_ver |= (crc << 32);
+	}
+	return cpu_to_le64(cp_ver) == cpver_of_node(page);
 }
 
 /*
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index ad748e5..2b8a56d 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -224,7 +224,6 @@ static bool is_same_inode(struct inode *inode, struct page *ipage)
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 {
-	unsigned long long cp_ver = cur_cp_version(F2FS_CKPT(sbi));
 	struct curseg_info *curseg;
 	struct page *page = NULL;
 	block_t blkaddr;
@@ -242,7 +241,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 
 		page = get_tmp_page(sbi, blkaddr);
 
-		if (cp_ver != cpver_of_node(page))
+		if (!is_recoverable_dnode(page))
 			break;
 
 		if (!is_fsync_dnode(page))
@@ -516,7 +515,6 @@ out:
 static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 						struct list_head *dir_list)
 {
-	unsigned long long cp_ver = cur_cp_version(F2FS_CKPT(sbi));
 	struct curseg_info *curseg;
 	struct page *page = NULL;
 	int err = 0;
@@ -536,7 +534,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 
 		page = get_tmp_page(sbi, blkaddr);
 
-		if (cp_ver != cpver_of_node(page)) {
+		if (!is_recoverable_dnode(page)) {
 			f2fs_put_page(page, 1);
 			break;
 		}
@@ -628,37 +626,15 @@ out:
 	}
 
 	clear_sbi_flag(sbi, SBI_POR_DOING);
-	if (err) {
-		bool invalidate = false;
-
-		if (test_opt(sbi, LFS)) {
-			update_meta_page(sbi, NULL, blkaddr);
-			invalidate = true;
-		} else if (discard_next_dnode(sbi, blkaddr)) {
-			invalidate = true;
-		}
-
-		f2fs_wait_all_discard_bio(sbi);
-
-		/* Flush all the NAT/SIT pages */
-		while (get_pages(sbi, F2FS_DIRTY_META))
-			sync_meta_pages(sbi, META, LONG_MAX);
-
-		/* invalidate temporary meta page */
-		if (invalidate)
-			invalidate_mapping_pages(META_MAPPING(sbi),
-							blkaddr, blkaddr);
-
+	if (err)
 		set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
-		mutex_unlock(&sbi->cp_mutex);
-	} else if (need_writecp) {
+	mutex_unlock(&sbi->cp_mutex);
+
+	if (!err && need_writecp) {
 		struct cp_control cpc = {
 			.reason = CP_RECOVERY,
 		};
-		mutex_unlock(&sbi->cp_mutex);
 		err = write_checkpoint(sbi, &cpc);
-	} else {
-		mutex_unlock(&sbi->cp_mutex);
 	}
 
 	destroy_fsync_dnodes(&dir_list);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c4d0472..2d23d7b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -669,28 +669,6 @@ static int f2fs_issue_discard(struct f2fs_sb_info *sbi,
 	return __f2fs_issue_discard_async(sbi, start, len, GFP_NOFS, 0);
 }
 
-bool discard_next_dnode(struct f2fs_sb_info *sbi, block_t blkaddr)
-{
-	int err = -EOPNOTSUPP;
-
-	if (test_opt(sbi, DISCARD)) {
-		struct seg_entry *se = get_seg_entry(sbi,
-				GET_SEGNO(sbi, blkaddr));
-		unsigned int offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
-
-		if (f2fs_test_bit(offset, se->discard_map))
-			return false;
-
-		err = f2fs_issue_discard(sbi, blkaddr, 1);
-	}
-
-	if (err) {
-		update_meta_page(sbi, NULL, blkaddr);
-		return true;
-	}
-	return false;
-}
-
 static void __add_discard_entry(struct f2fs_sb_info *sbi,
 		struct cp_control *cpc, struct seg_entry *se,
 		unsigned int start, unsigned int end)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 29e3cf4..9649b79 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1827,6 +1827,9 @@ try_onemore:
 		if (need_fsck)
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 
+		if (!retry)
+			goto skip_recovery;
+
 		err = recover_fsync_data(sbi, false);
 		if (err < 0) {
 			need_fsck = true;
@@ -1844,7 +1847,7 @@ try_onemore:
 			goto free_kobj;
 		}
 	}
-
+skip_recovery:
 	/* recover_fsync_data() cleared this already */
 	clear_sbi_flag(sbi, SBI_POR_DOING);
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 4c02c65..422630b 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -100,6 +100,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_CRC_RECOVERY_FLAG	0x00000040
 #define CP_FASTBOOT_FLAG	0x00000020
 #define CP_FSCK_FLAG		0x00000010
 #define CP_ERROR_FLAG		0x00000008
-- 
2.8.3

