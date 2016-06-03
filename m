From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 8/8] f2fs: control not to exceed # of cached nat
	entries
Date: Thu,  2 Jun 2016 20:55:39 -0700
Message-ID: <1464926139-58252-8-git-send-email-jaegeuk@kernel.org>
References: <1464926139-58252-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b8gDF-0008Ps-5d
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jun 2016 03:55:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b8gDE-0004gR-EM
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jun 2016 03:55:57 +0000
In-Reply-To: <1464926139-58252-1-git-send-email-jaegeuk@kernel.org>
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

This is to avoid cache entry management overhead including radix tree.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c    | 4 ++++
 fs/f2fs/node.h    | 7 +++++++
 fs/f2fs/segment.c | 5 +++++
 3 files changed, 16 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 15f55ae..d7e624c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -52,6 +52,10 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 		mem_size = (nm_i->nat_cnt * sizeof(struct nat_entry)) >>
 							PAGE_SHIFT;
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
+		if (excess_cached_nats(sbi))
+			res = false;
+		if (nm_i->nat_cnt > DEF_NAT_CACHE_THRESHOLD)
+			res = false;
 	} else if (type == DIRTY_DENTS) {
 		if (sbi->sb->s_bdi->wb.dirty_exceeded)
 			return false;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 2c2a797..59e0470 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -27,6 +27,8 @@
 
 /* control dirty nats ratio threshold (default: 10% over max nid count) */
 #define DEF_DIRTY_NAT_RATIO_THRESHOLD		10
+/* control total # of nats */
+#define DEF_NAT_CACHE_THRESHOLD			50000
 
 /* vector size for gang look-up from nat cache that consists of radix tree */
 #define NATVEC_SIZE	64
@@ -126,6 +128,11 @@ static inline bool excess_dirty_nats(struct f2fs_sb_info *sbi)
 					NM_I(sbi)->dirty_nats_ratio / 100;
 }
 
+static inline bool excess_cached_nats(struct f2fs_sb_info *sbi)
+{
+	return NM_I(sbi)->nat_cnt >= DEF_NAT_CACHE_THRESHOLD;
+}
+
 enum mem_type {
 	FREE_NIDS,	/* indicates the free nid list */
 	NAT_ENTRIES,	/* indicates the cached nat entry */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 34a9159..9011bffd 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -345,6 +345,11 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 {
 	if (!need)
 		return;
+
+	/* balance_fs_bg is able to be pending */
+	if (excess_cached_nats(sbi))
+		f2fs_balance_fs_bg(sbi);
+
 	/*
 	 * We should do GC or end up with checkpoint, if there are so many dirty
 	 * dir/node pages without enough free segments.
-- 
2.6.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
