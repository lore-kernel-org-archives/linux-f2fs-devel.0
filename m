From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/3] f2fs: reclaim prefree segments periodically
Date: Thu, 24 Oct 2013 16:57:40 +0900
Message-ID: <1382601462-7989-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VZFoL-0002h7-8Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Oct 2013 07:58:29 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VZFoJ-0006kI-7X for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Oct 2013 07:58:29 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MV500JFMY5039S0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Oct 2013 16:58:20 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously, f2fs postpones reclaiming prefree segments into free segments
as much as possible.
However, if user writes and deletes a bunch of data without any sync or fsync
calls, some flash storages can suffer from garbage collections.

So, this patch adds the reclaiming codes to f2fs_write_node_pages and background
GC thread.

If there are a lot of prefree segments, let's do checkpoint so that f2fs
submits discard commands for the prefree regions to the flash storage.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h    | 3 +++
 fs/f2fs/gc.c      | 5 +++++
 fs/f2fs/node.c    | 3 ++-
 fs/f2fs/segment.c | 1 +
 fs/f2fs/segment.h | 7 +++++++
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 590a09e..3c95d35 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -299,6 +299,9 @@ struct f2fs_sm_info {
 	unsigned int main_segments;	/* # of segments in main area */
 	unsigned int reserved_segments;	/* # of reserved segments */
 	unsigned int ovp_segments;	/* # of overprovision segments */
+
+	/* a threshold to reclaim prefree segments */
+	unsigned int rec_prefree_segments;
 };
 
 /*
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index cb286d7..783c6cc 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -82,6 +82,11 @@ static int gc_thread_func(void *data)
 		/* if return value is not zero, no victim was selected */
 		if (f2fs_gc(sbi))
 			wait_ms = gc_th->no_gc_sleep_time;
+
+		/* balancing prefree segments */
+		if (excess_prefree_segs(sbi))
+			f2fs_sync_fs(sbi->sb, true);
+
 	} while (!kthread_should_stop());
 	return 0;
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index cc119b6..89dd8a5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1206,7 +1206,8 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	long nr_to_write = wbc->nr_to_write;
 
 	/* First check balancing cached NAT entries */
-	if (try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK)) {
+	if (try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK) ||
+				excess_prefree_segs(sbi)) {
 		f2fs_sync_fs(sbi->sb, true);
 		return 0;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c9c276e..43ee91e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1645,6 +1645,7 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
 	sm_info->main_segments = le32_to_cpu(raw_super->segment_count_main);
 	sm_info->ssa_blkaddr = le32_to_cpu(raw_super->ssa_blkaddr);
+	sm_info->rec_prefree_segments = DEF_RECLAIM_PREFREE_SEGMENTS;
 
 	err = build_sit_info(sbi);
 	if (err)
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 7f94d78..abe7094 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -14,6 +14,8 @@
 #define NULL_SEGNO			((unsigned int)(~0))
 #define NULL_SECNO			((unsigned int)(~0))
 
+#define DEF_RECLAIM_PREFREE_SEGMENTS	100	/* 200MB of prefree segments */
+
 /* L: Logical segment # in volume, R: Relative segment # in main area */
 #define GET_L2R_SEGNO(free_i, segno)	(segno - free_i->start_segno)
 #define GET_R2L_SEGNO(free_i, segno)	(segno + free_i->start_segno)
@@ -472,6 +474,11 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi, int freed)
 						reserved_sections(sbi)));
 }
 
+static inline bool excess_prefree_segs(struct f2fs_sb_info *sbi)
+{
+	return (prefree_segments(sbi) > SM_I(sbi)->rec_prefree_segments);
+}
+
 static inline int utilization(struct f2fs_sb_info *sbi)
 {
 	return div_u64((u64)valid_user_blocks(sbi) * 100, sbi->user_block_count);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
