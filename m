From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3 v2] f2fs: add bitmaps for empty or full
	NAT blocks
Date: Thu, 23 Feb 2017 14:58:13 -0800
Message-ID: <20170223225813.GH2026@jaegeuk.local>
References: <20170214020644.18189-1-jaegeuk@kernel.org>
	<20170214020644.18189-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ch2LB-0007dx-TS
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 22:58:25 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ch2LA-0007Cu-3q
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 22:58:25 +0000
Content-Disposition: inline
In-Reply-To: <20170214020644.18189-2-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Change log from v1:
 - modified some condition checks suggested by Chao

This patches adds bitmaps to represent empty or full NAT blocks containing
free nid entries.

If we can find valid crc|cp_ver in the last block of checkpoint pack, we'll
use these bitmaps when building free nids. In order to avoid checkpointing
burden, up-to-date bitmaps will be flushed only during umount time. So,
normally we can get this gain, but when power-cut happens, we rely on fsck.f2fs
which recovers this bitmap again.

After this patch, we build free nids from nid #0 at mount time to make more
full NAT blocks, but in runtime, we check empty NAT blocks to load free nids
without loading any NAT pages from disk.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c    |  28 +++++++-
 fs/f2fs/debug.c         |   1 +
 fs/f2fs/f2fs.h          |  31 +++++++-
 fs/f2fs/node.c          | 188 +++++++++++++++++++++++++++++++++++++++++++-----
 fs/f2fs/segment.c       |   2 +-
 include/linux/f2fs_fs.h |   1 +
 6 files changed, 231 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 042f8d9afe44..cd7132121573 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1024,6 +1024,10 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	spin_lock(&sbi->cp_lock);
 
+	if (cpc->reason == CP_UMOUNT && ckpt->cp_pack_total_block_count >
+			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks)
+		disable_nat_bits(sbi, false);
+
 	if (cpc->reason == CP_UMOUNT)
 		__set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
 	else
@@ -1136,6 +1140,28 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	start_blk = __start_cp_next_addr(sbi);
 
+	/* write nat bits */
+	if (enabled_nat_bits(sbi, cpc)) {
+		__u64 cp_ver = cur_cp_version(ckpt);
+		unsigned int i;
+		block_t blk;
+
+		cp_ver |= ((__u64)crc32 << 32);
+		*(__le64 *)nm_i->nat_bits = cpu_to_le64(cp_ver);
+
+		blk = start_blk + sbi->blocks_per_seg - nm_i->nat_bits_blocks;
+		for (i = 0; i < nm_i->nat_bits_blocks; i++)
+			update_meta_page(sbi, nm_i->nat_bits +
+					(i << F2FS_BLKSIZE_BITS), blk + i);
+
+		/* Flush all the NAT BITS pages */
+		while (get_pages(sbi, F2FS_DIRTY_META)) {
+			sync_meta_pages(sbi, META, LONG_MAX);
+			if (unlikely(f2fs_cp_error(sbi)))
+				return -EIO;
+		}
+	}
+
 	/* need to wait for end_io results */
 	wait_on_all_pages_writeback(sbi);
 	if (unlikely(f2fs_cp_error(sbi)))
@@ -1272,7 +1298,7 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	ckpt->checkpoint_ver = cpu_to_le64(++ckpt_ver);
 
 	/* write cached NAT/SIT entries to NAT/SIT area */
-	flush_nat_entries(sbi);
+	flush_nat_entries(sbi, cpc);
 	flush_sit_entries(sbi, cpc);
 
 	/* unlock all the fs_lock[] in do_checkpoint() */
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index de8da9fc5c99..015ad2b73a92 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -193,6 +193,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	/* build nm */
 	si->base_mem += sizeof(struct f2fs_nm_info);
 	si->base_mem += __bitmap_size(sbi, NAT_BITMAP);
+	si->base_mem += (NM_I(sbi)->nat_bits_blocks << F2FS_BLKSIZE_BITS);
 
 get_cache:
 	si->cache_mem = 0;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e26cc6909a54..d1156cdd211e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -554,6 +554,7 @@ struct f2fs_nm_info {
 	struct list_head nat_entries;	/* cached nat entry list (clean) */
 	unsigned int nat_cnt;		/* the # of cached nat entries */
 	unsigned int dirty_nat_cnt;	/* total num of nat entries in set */
+	unsigned int nat_blocks;	/* # of nat blocks */
 
 	/* free node ids management */
 	struct radix_tree_root free_nid_root;/* root of the free_nid cache */
@@ -564,6 +565,11 @@ struct f2fs_nm_info {
 
 	/* for checkpoint */
 	char *nat_bitmap;		/* NAT bitmap pointer */
+
+	unsigned int nat_bits_blocks;	/* # of nat bits blocks */
+	unsigned char *nat_bits;	/* NAT bits blocks */
+	unsigned char *full_nat_bits;	/* full NAT pages */
+	unsigned char *empty_nat_bits;	/* empty NAT pages */
 #ifdef CONFIG_F2FS_CHECK_FS
 	char *nat_bitmap_mir;		/* NAT bitmap mirror */
 #endif
@@ -1171,6 +1177,27 @@ static inline void clear_ckpt_flags(struct f2fs_sb_info *sbi, unsigned int f)
 	spin_unlock(&sbi->cp_lock);
 }
 
+static inline void disable_nat_bits(struct f2fs_sb_info *sbi, bool lock)
+{
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+
+	if (lock)
+		spin_lock(&sbi->cp_lock);
+	__clear_ckpt_flags(F2FS_CKPT(sbi), CP_NAT_BITS_FLAG);
+	kfree(NM_I(sbi)->nat_bits);
+	NM_I(sbi)->nat_bits = NULL;
+	if (lock)
+		spin_unlock(&sbi->cp_lock);
+}
+
+static inline bool enabled_nat_bits(struct f2fs_sb_info *sbi,
+					struct cp_control *cpc)
+{
+	bool set = is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
+
+	return (cpc) ? (cpc->reason == CP_UMOUNT) && set : set;
+}
+
 static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
 {
 	down_read(&sbi->cp_rwsem);
@@ -2131,7 +2158,7 @@ void move_node_page(struct page *node_page, int gc_type);
 int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic);
 int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc);
-void build_free_nids(struct f2fs_sb_info *sbi, bool sync);
+void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount);
 bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
 void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
 void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid);
@@ -2142,7 +2169,7 @@ int recover_xattr_data(struct inode *inode, struct page *page,
 int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
 int restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum);
-void flush_nat_entries(struct f2fs_sb_info *sbi);
+void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 int build_node_manager(struct f2fs_sb_info *sbi);
 void destroy_node_manager(struct f2fs_sb_info *sbi);
 int __init create_node_manager_caches(void);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8ebc4c78e6a4..43d35ec11851 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -338,6 +338,9 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 		set_nat_flag(e, IS_CHECKPOINTED, false);
 	__set_nat_cache_dirty(nm_i, e);
 
+	if (enabled_nat_bits(sbi, NULL) && new_blkaddr == NEW_ADDR)
+		clear_bit_le(NAT_BLOCK_OFFSET(ni->nid), nm_i->empty_nat_bits);
+
 	/* update fsync_mark if its inode nat entry is still alive */
 	if (ni->nid != ni->ino)
 		e = __lookup_nat_cache(nm_i, ni->ino);
@@ -1841,7 +1844,60 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 	}
 }
 
-static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync)
+static int scan_nat_bits(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	struct page *page;
+	unsigned int i = 0;
+	nid_t target = FREE_NID_PAGES * NAT_ENTRY_PER_BLOCK;
+	nid_t nid;
+
+	if (!enabled_nat_bits(sbi, NULL))
+		return -EAGAIN;
+
+	down_read(&nm_i->nat_tree_lock);
+check_empty:
+	i = find_next_bit_le(nm_i->empty_nat_bits, nm_i->nat_blocks, i);
+	if (i >= nm_i->nat_blocks) {
+		i = 0;
+		goto check_partial;
+	}
+
+	for (nid = i * NAT_ENTRY_PER_BLOCK; nid < (i + 1) * NAT_ENTRY_PER_BLOCK;
+									nid++) {
+		if (unlikely(nid >= nm_i->max_nid))
+			break;
+		add_free_nid(sbi, nid, true);
+	}
+
+	if (nm_i->nid_cnt[FREE_NID_LIST] >= target)
+		goto out;
+	i++;
+	goto check_empty;
+
+check_partial:
+	i = find_next_zero_bit_le(nm_i->full_nat_bits, nm_i->nat_blocks, i);
+	if (i >= nm_i->nat_blocks) {
+		disable_nat_bits(sbi, true);
+		up_read(&nm_i->nat_tree_lock);
+		return -EINVAL;
+	}
+
+	nid = i * NAT_ENTRY_PER_BLOCK;
+	page = get_current_nat_page(sbi, nid);
+	scan_nat_page(sbi, page, nid);
+	f2fs_put_page(page, 1);
+
+	if (nm_i->nid_cnt[FREE_NID_LIST] < target) {
+		i++;
+		goto check_partial;
+	}
+out:
+	up_read(&nm_i->nat_tree_lock);
+	return 0;
+}
+
+static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
@@ -1856,6 +1912,21 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync)
 	if (!sync && !available_free_memory(sbi, FREE_NIDS))
 		return;
 
+	/* try to find free nids with nat_bits */
+	if (!mount && !scan_nat_bits(sbi) && nm_i->nid_cnt[FREE_NID_LIST])
+		return;
+
+	/* find next valid candidate */
+	if (enabled_nat_bits(sbi, NULL)) {
+		int idx = find_next_zero_bit_le(nm_i->full_nat_bits,
+					nm_i->nat_blocks, 0);
+
+		if (idx >= nm_i->nat_blocks)
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+		else
+			nid = idx * NAT_ENTRY_PER_BLOCK;
+	}
+
 	/* readahead nat pages to be scanned */
 	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
 							META_NAT, true);
@@ -1898,10 +1969,10 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync)
 					nm_i->ra_nid_pages, META_NAT, false);
 }
 
-void build_free_nids(struct f2fs_sb_info *sbi, bool sync)
+void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 {
 	mutex_lock(&NM_I(sbi)->build_lock);
-	__build_free_nids(sbi, sync);
+	__build_free_nids(sbi, sync, mount);
 	mutex_unlock(&NM_I(sbi)->build_lock);
 }
 
@@ -1943,7 +2014,7 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	spin_unlock(&nm_i->nid_list_lock);
 
 	/* Let's scan nat pages and its caches to get free nids */
-	build_free_nids(sbi, true);
+	build_free_nids(sbi, true, false);
 	goto retry;
 }
 
@@ -2235,8 +2306,39 @@ static void __adjust_nat_entry_set(struct nat_entry_set *nes,
 	list_add_tail(&nes->set_list, head);
 }
 
+void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
+						struct page *page)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	unsigned int nat_index = start_nid / NAT_ENTRY_PER_BLOCK;
+	struct f2fs_nat_block *nat_blk = page_address(page);
+	int valid = 0;
+	int i;
+
+	if (!enabled_nat_bits(sbi, NULL))
+		return;
+
+	for (i = 0; i < NAT_ENTRY_PER_BLOCK; i++) {
+		if (start_nid == 0 && i == 0)
+			valid++;
+		if (nat_blk->entries[i].block_addr)
+			valid++;
+	}
+	if (valid == 0) {
+		set_bit_le(nat_index, nm_i->empty_nat_bits);
+		clear_bit_le(nat_index, nm_i->full_nat_bits);
+		return;
+	}
+
+	clear_bit_le(nat_index, nm_i->empty_nat_bits);
+	if (valid == NAT_ENTRY_PER_BLOCK)
+		set_bit_le(nat_index, nm_i->full_nat_bits);
+	else
+		clear_bit_le(nat_index, nm_i->full_nat_bits);
+}
+
 static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
-					struct nat_entry_set *set)
+		struct nat_entry_set *set, struct cp_control *cpc)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
@@ -2251,7 +2353,8 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	 * #1, flush nat entries to journal in current hot data summary block.
 	 * #2, flush nat entries to nat page.
 	 */
-	if (!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
+	if (enabled_nat_bits(sbi, cpc) ||
+		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
 		to_journal = false;
 
 	if (to_journal) {
@@ -2291,10 +2394,12 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		}
 	}
 
-	if (to_journal)
+	if (to_journal) {
 		up_write(&curseg->journal_rwsem);
-	else
+	} else {
+		__update_nat_bits(sbi, start_nid, page);
 		f2fs_put_page(page, 1);
+	}
 
 	f2fs_bug_on(sbi, set->entry_cnt);
 
@@ -2305,7 +2410,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 /*
  * This function is called during the checkpointing process.
  */
-void flush_nat_entries(struct f2fs_sb_info *sbi)
+void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
@@ -2326,7 +2431,8 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
 	 * entries, remove all entries from journal and merge them
 	 * into nat entry set.
 	 */
-	if (!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
+	if (cpc->reason == CP_UMOUNT ||
+		!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
 		remove_nats_in_journal(sbi);
 
 	while ((found = __gang_lookup_nat_set(nm_i,
@@ -2340,27 +2446,72 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
 
 	/* flush dirty nats in nat entry set */
 	list_for_each_entry_safe(set, tmp, &sets, set_list)
-		__flush_nat_entry_set(sbi, set);
+		__flush_nat_entry_set(sbi, set, cpc);
 
 	up_write(&nm_i->nat_tree_lock);
 
 	f2fs_bug_on(sbi, nm_i->dirty_nat_cnt);
 }
 
+static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	unsigned int nat_bits_bytes = nm_i->nat_blocks / BITS_PER_BYTE;
+	unsigned int i;
+	__u64 cp_ver = cur_cp_version(ckpt);
+	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
+	__u64 crc = le32_to_cpu(*((__le32 *)
+				((unsigned char *)ckpt + crc_offset)));
+	block_t nat_bits_addr;
+
+	if (!enabled_nat_bits(sbi, NULL))
+		return 0;
+
+	nm_i->nat_bits_blocks = F2FS_BYTES_TO_BLK((nat_bits_bytes << 1) + 8 +
+						F2FS_BLKSIZE - 1);
+	nm_i->nat_bits = kzalloc(nm_i->nat_bits_blocks << F2FS_BLKSIZE_BITS,
+						GFP_KERNEL);
+	if (!nm_i->nat_bits)
+		return -ENOMEM;
+
+	nat_bits_addr = __start_cp_addr(sbi) + sbi->blocks_per_seg -
+						nm_i->nat_bits_blocks;
+	for (i = 0; i < nm_i->nat_bits_blocks; i++) {
+		struct page *page = get_meta_page(sbi, nat_bits_addr++);
+
+		memcpy(nm_i->nat_bits + (i << F2FS_BLKSIZE_BITS),
+					page_address(page), F2FS_BLKSIZE);
+		f2fs_put_page(page, 1);
+	}
+
+	cp_ver |= (crc << 32);
+	if (cpu_to_le64(cp_ver) != *(__le64 *)nm_i->nat_bits) {
+		disable_nat_bits(sbi, true);
+		return 0;
+	}
+
+	nm_i->full_nat_bits = nm_i->nat_bits + 8;
+	nm_i->empty_nat_bits = nm_i->full_nat_bits + nat_bits_bytes;
+
+	f2fs_msg(sbi->sb, KERN_NOTICE, "Found nat_bits in checkpoint");
+	return 0;
+}
+
 static int init_node_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *sb_raw = F2FS_RAW_SUPER(sbi);
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned char *version_bitmap;
-	unsigned int nat_segs, nat_blocks;
+	unsigned int nat_segs;
+	int err;
 
 	nm_i->nat_blkaddr = le32_to_cpu(sb_raw->nat_blkaddr);
 
 	/* segment_count_nat includes pair segment so divide to 2. */
 	nat_segs = le32_to_cpu(sb_raw->segment_count_nat) >> 1;
-	nat_blocks = nat_segs << le32_to_cpu(sb_raw->log_blocks_per_seg);
-
-	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nat_blocks;
+	nm_i->nat_blocks = nat_segs << le32_to_cpu(sb_raw->log_blocks_per_seg);
+	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nm_i->nat_blocks;
 
 	/* not used nids: 0, node, meta, (and root counted as valid node) */
 	nm_i->available_nids = nm_i->max_nid - sbi->total_valid_node_count -
@@ -2394,6 +2545,10 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	if (!nm_i->nat_bitmap)
 		return -ENOMEM;
 
+	err = __get_nat_bitmaps(sbi);
+	if (err)
+		return err;
+
 #ifdef CONFIG_F2FS_CHECK_FS
 	nm_i->nat_bitmap_mir = kmemdup(version_bitmap, nm_i->bitmap_size,
 					GFP_KERNEL);
@@ -2416,7 +2571,7 @@ int build_node_manager(struct f2fs_sb_info *sbi)
 	if (err)
 		return err;
 
-	build_free_nids(sbi, true);
+	build_free_nids(sbi, true, true);
 	return 0;
 }
 
@@ -2475,6 +2630,7 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 	up_write(&nm_i->nat_tree_lock);
 
 	kfree(nm_i->nat_bitmap);
+	kfree(nm_i->nat_bits);
 #ifdef CONFIG_F2FS_CHECK_FS
 	kfree(nm_i->nat_bitmap_mir);
 #endif
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3e95db5375ed..9eb6d89bf9e2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -386,7 +386,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	if (!available_free_memory(sbi, FREE_NIDS))
 		try_to_free_nids(sbi, MAX_FREE_NIDS);
 	else
-		build_free_nids(sbi, false);
+		build_free_nids(sbi, false, false);
 
 	if (!is_idle(sbi))
 		return;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index f0748524ca8c..1c92ace2e8f8 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -114,6 +114,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_NAT_BITS_FLAG	0x00000080
 #define CP_CRC_RECOVERY_FLAG	0x00000040
 #define CP_FASTBOOT_FLAG	0x00000020
 #define CP_FSCK_FLAG		0x00000010
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
