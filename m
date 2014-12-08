From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/4] f2fs: readahead contiguous current summary
 blocks in checkpoint
Date: Mon, 08 Dec 2014 15:01:16 +0800
Message-ID: <001a01d012b4$dfe9d040$9fbd70c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XxsKt-0003na-7h
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Dec 2014 07:02:23 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XxsKr-0007zP-LE
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Dec 2014 07:02:23 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NG9000WW4VH4J90@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Dec 2014 16:02:05 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Let's add readahead code for reading contiguous compact/normal summary blocks
in checkpoint, then we will gain better performance in mount procedure.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/segment.c    | 21 ++++++++++++++++++---
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index e0ff75e..aa2a21c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -915,7 +915,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	ckpt->next_free_nid = cpu_to_le32(last_nid);
 
 	/* 2 cp  + n data seg summary + orphan inode blocks */
-	data_sum_blocks = npages_for_summary_flush(sbi);
+	data_sum_blocks = npages_for_summary_flush(sbi, false);
 	if (data_sum_blocks < NR_CURSEG_DATA_TYPE)
 		set_ckpt_flags(ckpt, CP_COMPACT_SUM_FLAG);
 	else
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d042813..fc88e8a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1393,7 +1393,7 @@ void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
 void clear_prefree_segments(struct f2fs_sb_info *);
 void release_discard_addrs(struct f2fs_sb_info *);
 void discard_next_dnode(struct f2fs_sb_info *, block_t);
-int npages_for_summary_flush(struct f2fs_sb_info *);
+int npages_for_summary_flush(struct f2fs_sb_info *, bool);
 void allocate_new_segments(struct f2fs_sb_info *);
 int f2fs_trim_fs(struct f2fs_sb_info *, struct fstrim_range *);
 struct page *get_sum_page(struct f2fs_sb_info *, unsigned int);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9a33e34..e3bec6e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -731,7 +731,7 @@ static void __add_sum_entry(struct f2fs_sb_info *sbi, int type,
 /*
  * Calculate the number of current summary pages for writing
  */
-int npages_for_summary_flush(struct f2fs_sb_info *sbi)
+int npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra)
 {
 	int valid_sum_count = 0;
 	int i, sum_in_page;
@@ -739,8 +739,13 @@ int npages_for_summary_flush(struct f2fs_sb_info *sbi)
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
 		if (sbi->ckpt->alloc_type[i] == SSR)
 			valid_sum_count += sbi->blocks_per_seg;
-		else
-			valid_sum_count += curseg_blkoff(sbi, i);
+		else {
+			if (unlikely(for_ra))
+				valid_sum_count += le16_to_cpu(
+					F2FS_CKPT(sbi)->cur_data_blkoff[i]);
+			else
+				valid_sum_count += curseg_blkoff(sbi, i);
+		}
 	}
 
 	sum_in_page = (PAGE_CACHE_SIZE - 2 * SUM_JOURNAL_SIZE -
@@ -1446,12 +1451,22 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 	int err;
 
 	if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_COMPACT_SUM_FLAG)) {
+		int npages = npages_for_summary_flush(sbi, true);
+
+		if (npages >= 2)
+			ra_meta_pages(sbi, start_sum_block(sbi), npages,
+								META_CP);
+
 		/* restore for compacted data summary */
 		if (read_compacted_summaries(sbi))
 			return -EINVAL;
 		type = CURSEG_HOT_NODE;
 	}
 
+	if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_UMOUNT_FLAG))
+		ra_meta_pages(sbi, sum_blk_addr(sbi, NR_CURSEG_TYPE, type),
+					NR_CURSEG_TYPE - type, META_CP);
+
 	for (; type <= CURSEG_COLD_NODE; type++) {
 		err = read_normal_summaries(sbi, type);
 		if (err)
-- 
2.1.2



------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
