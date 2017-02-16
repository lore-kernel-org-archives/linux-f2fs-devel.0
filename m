From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: show actual device info in tracepoints
Date: Wed, 15 Feb 2017 17:54:52 -0800
Message-ID: <20170216015452.22441-2-jaegeuk@kernel.org>
References: <20170216015452.22441-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ceBHl-0003vd-2a
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Feb 2017 01:55:05 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ceBHk-0002ZI-0P
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Feb 2017 01:55:05 +0000
In-Reply-To: <20170216015452.22441-1-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch shows actual device information in the tracepoints.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c           | 10 ++++-----
 include/trace/events/f2fs.h | 49 ++++++++++++++++++++++++---------------------
 2 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0a1c737f2d79..008f971296f8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -426,11 +426,11 @@ static int submit_flush_wait(struct f2fs_sb_info *sbi)
 	int ret = __submit_flush_wait(sbi->sb->s_bdev);
 	int i;
 
-	trace_f2fs_issue_flush(sbi->sb, test_opt(sbi, NOBARRIER),
-					test_opt(sbi, FLUSH_MERGE));
-
 	if (sbi->s_ndevs && !ret) {
 		for (i = 1; i < sbi->s_ndevs; i++) {
+			trace_f2fs_issue_flush(FDEV(i).bdev,
+					test_opt(sbi, NOBARRIER),
+					test_opt(sbi, FLUSH_MERGE));
 			ret = __submit_flush_wait(FDEV(i).bdev);
 			if (ret)
 				break;
@@ -758,7 +758,7 @@ static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
 	block_t lblkstart = blkstart;
 	int err;
 
-	trace_f2fs_issue_discard(sbi->sb, blkstart, blklen);
+	trace_f2fs_issue_discard(bdev, blkstart, blklen);
 
 	if (sbi->s_ndevs) {
 		int devi = f2fs_target_device_index(sbi, blkstart);
@@ -815,7 +815,7 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 		return __f2fs_issue_discard_async(sbi, bdev, blkstart, blklen);
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
-		trace_f2fs_issue_reset_zone(sbi->sb, blkstart);
+		trace_f2fs_issue_reset_zone(bdev, blkstart);
 		return blkdev_reset_zones(bdev, sector,
 					  nr_sects, GFP_NOFS);
 	default:
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 82236792b50c..153572e256d6 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -6,8 +6,8 @@
 
 #include <linux/tracepoint.h>
 
-#define show_dev(entry)		MAJOR(entry->dev), MINOR(entry->dev)
-#define show_dev_ino(entry)	show_dev(entry), (unsigned long)entry->ino
+#define show_dev(dev)		MAJOR(dev), MINOR(dev)
+#define show_dev_ino(entry)	show_dev(entry->dev), (unsigned long)entry->ino
 
 TRACE_DEFINE_ENUM(NODE);
 TRACE_DEFINE_ENUM(DATA);
@@ -245,7 +245,7 @@ TRACE_EVENT(f2fs_sync_fs,
 	),
 
 	TP_printk("dev = (%d,%d), superblock is %s, wait = %d",
-		show_dev(__entry),
+		show_dev(__entry->dev),
 		__entry->dirty ? "dirty" : "not dirty",
 		__entry->wait)
 );
@@ -544,7 +544,7 @@ TRACE_EVENT(f2fs_background_gc,
 	),
 
 	TP_printk("dev = (%d,%d), wait_ms = %ld, prefree = %u, free = %u",
-		show_dev(__entry),
+		show_dev(__entry->dev),
 		__entry->wait_ms,
 		__entry->prefree,
 		__entry->free)
@@ -586,7 +586,7 @@ TRACE_EVENT(f2fs_get_victim,
 
 	TP_printk("dev = (%d,%d), type = %s, policy = (%s, %s, %s), victim = %u "
 		"ofs_unit = %u, pre_victim_secno = %d, prefree = %u, free = %u",
-		show_dev(__entry),
+		show_dev(__entry->dev),
 		show_data_type(__entry->type),
 		show_gc_type(__entry->gc_type),
 		show_alloc_mode(__entry->alloc_mode),
@@ -723,7 +723,7 @@ TRACE_EVENT(f2fs_reserve_new_blocks,
 	),
 
 	TP_printk("dev = (%d,%d), nid = %u, ofs_in_node = %u, count = %llu",
-		show_dev(__entry),
+		show_dev(__entry->dev),
 		(unsigned int)__entry->nid,
 		__entry->ofs_in_node,
 		(unsigned long long)__entry->count)
@@ -793,6 +793,7 @@ DECLARE_EVENT_CLASS(f2fs__bio,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
+		__field(dev_t,	target)
 		__field(int,	op)
 		__field(int,	op_flags)
 		__field(int,	type)
@@ -802,6 +803,7 @@ DECLARE_EVENT_CLASS(f2fs__bio,
 
 	TP_fast_assign(
 		__entry->dev		= sb->s_dev;
+		__entry->target		= bio->bi_bdev->bd_dev;
 		__entry->op		= bio_op(bio);
 		__entry->op_flags	= bio->bi_opf;
 		__entry->type		= type;
@@ -809,8 +811,9 @@ DECLARE_EVENT_CLASS(f2fs__bio,
 		__entry->size		= bio->bi_iter.bi_size;
 	),
 
-	TP_printk("dev = (%d,%d), rw = %s%s, %s, sector = %lld, size = %u",
-		show_dev(__entry),
+	TP_printk("dev = (%d,%d)/(%d,%d), rw = %s%s, %s, sector = %lld, size = %u",
+		show_dev(__entry->target),
+		show_dev(__entry->dev),
 		show_bio_type(__entry->op, __entry->op_flags),
 		show_block_type(__entry->type),
 		(unsigned long long)__entry->sector,
@@ -1107,16 +1110,16 @@ TRACE_EVENT(f2fs_write_checkpoint,
 	),
 
 	TP_printk("dev = (%d,%d), checkpoint for %s, state = %s",
-		show_dev(__entry),
+		show_dev(__entry->dev),
 		show_cpreason(__entry->reason),
 		__entry->msg)
 );
 
 TRACE_EVENT(f2fs_issue_discard,
 
-	TP_PROTO(struct super_block *sb, block_t blkstart, block_t blklen),
+	TP_PROTO(struct block_device *dev, block_t blkstart, block_t blklen),
 
-	TP_ARGS(sb, blkstart, blklen),
+	TP_ARGS(dev, blkstart, blklen),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -1125,22 +1128,22 @@ TRACE_EVENT(f2fs_issue_discard,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= sb->s_dev;
+		__entry->dev	= dev->bd_dev;
 		__entry->blkstart = blkstart;
 		__entry->blklen = blklen;
 	),
 
 	TP_printk("dev = (%d,%d), blkstart = 0x%llx, blklen = 0x%llx",
-		show_dev(__entry),
+		show_dev(__entry->dev),
 		(unsigned long long)__entry->blkstart,
 		(unsigned long long)__entry->blklen)
 );
 
 TRACE_EVENT(f2fs_issue_reset_zone,
 
-	TP_PROTO(struct super_block *sb, block_t blkstart),
+	TP_PROTO(struct block_device *dev, block_t blkstart),
 
-	TP_ARGS(sb, blkstart),
+	TP_ARGS(dev, blkstart),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -1148,21 +1151,21 @@ TRACE_EVENT(f2fs_issue_reset_zone,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= sb->s_dev;
+		__entry->dev	= dev->bd_dev;
 		__entry->blkstart = blkstart;
 	),
 
 	TP_printk("dev = (%d,%d), reset zone at block = 0x%llx",
-		show_dev(__entry),
+		show_dev(__entry->dev),
 		(unsigned long long)__entry->blkstart)
 );
 
 TRACE_EVENT(f2fs_issue_flush,
 
-	TP_PROTO(struct super_block *sb, unsigned int nobarrier,
+	TP_PROTO(struct block_device *dev, unsigned int nobarrier,
 					unsigned int flush_merge),
 
-	TP_ARGS(sb, nobarrier, flush_merge),
+	TP_ARGS(dev, nobarrier, flush_merge),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -1171,13 +1174,13 @@ TRACE_EVENT(f2fs_issue_flush,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= sb->s_dev;
+		__entry->dev	= dev->bd_dev;
 		__entry->nobarrier = nobarrier;
 		__entry->flush_merge = flush_merge;
 	),
 
 	TP_printk("dev = (%d,%d), %s %s",
-		show_dev(__entry),
+		show_dev(__entry->dev),
 		__entry->nobarrier ? "skip (nobarrier)" : "issue",
 		__entry->flush_merge ? " with flush_merge" : "")
 );
@@ -1292,7 +1295,7 @@ TRACE_EVENT(f2fs_shrink_extent_tree,
 	),
 
 	TP_printk("dev = (%d,%d), shrunk: node_cnt = %u, tree_cnt = %u",
-		show_dev(__entry),
+		show_dev(__entry->dev),
 		__entry->node_cnt,
 		__entry->tree_cnt)
 );
@@ -1339,7 +1342,7 @@ DECLARE_EVENT_CLASS(f2fs_sync_dirty_inodes,
 	),
 
 	TP_printk("dev = (%d,%d), %s, dirty count = %lld",
-		show_dev(__entry),
+		show_dev(__entry->dev),
 		show_file_type(__entry->type),
 		__entry->count)
 );
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
