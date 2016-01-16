From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: flush dirty nat entries when exceeding
	threshold
Date: Sat, 16 Jan 2016 17:36:40 +0800
Message-ID: <017d01d15041$7fad3890$7f07a9b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aKNIa-0002ca-QW
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 16 Jan 2016 09:37:32 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aKNIY-0003m8-Oe
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 16 Jan 2016 09:37:32 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O1100BCWHEAHK80@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 16 Jan 2016 18:37:22 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When testing f2fs with xfstest, generic/251 is stuck for long time,
the case uses below serials to obtain fresh released space in device,
in order to preparing for following fstrim test.

1. rm -rf /mnt/dir
2. mkdir /mnt/dir/
3. cp -axT `pwd`/ /mnt/dir/
4. goto 1

During preparing step, all nat entries will be cached in nat cache,
most of them are dirty entries with invalid blkaddr, which means
nodes related to these entries have been truncated, and they could
be reused after the dirty entries been checkpointed.

However, there was no checkpoint been triggered, so nid allocators
(e.g. mkdir, creat) will run into long journey of iterating all NAT
pages, looking for free nids in alloc_nid->build_free_nids.

Here, we give another chance to f2fs_balance_fs_bg to do checkpoint
to flush nat entries for reusing in free nid cache when dirty entry
count exceeds 10% of max count.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.h    | 8 ++++++++
 fs/f2fs/segment.c | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index d4d1f63..630c62d 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -25,6 +25,8 @@
 /* control the memory footprint threshold (10MB per 1GB ram) */
 #define DEF_RAM_THRESHOLD	10
 
+#define DEF_DIRTY_NAT_THRESHOLD		10	/* 10% over max nid */
+
 /* vector size for gang look-up from nat cache that consists of radix tree */
 #define NATVEC_SIZE	64
 #define SETVEC_SIZE	32
@@ -117,6 +119,12 @@ static inline void raw_nat_from_node_info(struct f2fs_nat_entry *raw_ne,
 	raw_ne->version = ni->version;
 }
 
+static inline bool excess_dirty_nats(struct f2fs_sb_info *sbi)
+{
+	return NM_I(sbi)->dirty_nat_cnt >=
+			NM_I(sbi)->max_nid * DEF_DIRTY_NAT_THRESHOLD / 100;
+}
+
 enum mem_type {
 	FREE_NIDS,	/* indicates the free nid list */
 	NAT_ENTRIES,	/* indicates the cached nat entry */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5904a41..68800e6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -291,8 +291,9 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 
 	/* checkpoint is the only way to shrink partial cached entries */
 	if (!available_free_memory(sbi, NAT_ENTRIES) ||
-			excess_prefree_segs(sbi) ||
 			!available_free_memory(sbi, INO_ENTRIES) ||
+			excess_prefree_segs(sbi) ||
+			excess_dirty_nats(sbi) ||
 			(is_idle(sbi) && f2fs_time_over(sbi, CP_TIME))) {
 		if (test_opt(sbi, DATA_FLUSH))
 			sync_dirty_inodes(sbi, FILE_INODE);
-- 
2.6.3



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
