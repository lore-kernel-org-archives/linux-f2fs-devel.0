From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 3/5] f2fs: remove unnecessary threshold
Date: Wed, 19 Mar 2014 17:02:07 +0900
Message-ID: <1395216129-13656-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1395216129-13656-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WQBTt-0005Sy-Ag
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 08:04:09 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WQBTp-0001O6-Po
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 08:04:09 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N2O003TBBQMW560@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 17:03:58 +0900 (KST)
In-reply-to: <1395216129-13656-1-git-send-email-jaegeuk.kim@samsung.com>
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

The NM_WOUT_THRESHOLD is now obsolete since f2fs starts to control on a basis
of the memory footprint.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/debug.c | 8 ++++----
 fs/f2fs/node.c  | 5 +----
 fs/f2fs/node.h  | 3 ---
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index b7111c4..b52c12c 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -250,10 +250,10 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->ndirty_dent, si->ndirty_dirs);
 		seq_printf(s, "  - meta: %4d in %4d\n",
 			   si->ndirty_meta, si->meta_pages);
-		seq_printf(s, "  - NATs: %5d > %lu\n",
-			   si->nats, NM_WOUT_THRESHOLD);
-		seq_printf(s, "  - SITs: %5d\n  - free_nids: %5d\n",
-			   si->sits, si->fnids);
+		seq_printf(s, "  - NATs: %9d\n  - SITs: %9d\n",
+			   si->nats, si->sits);
+		seq_printf(s, "  - free_nids: %9d\n",
+			   si->fnids);
 		seq_puts(s, "\nDistribution of User Blocks:");
 		seq_puts(s, " [ valid | invalid | free ]\n");
 		seq_puts(s, "  [");
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9cf524d..4f48aa3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -224,7 +224,7 @@ int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 
-	if (available_free_memory(nm_i, NAT_ENTRIES) || nr_shrink <= 0)
+	if (available_free_memory(nm_i, NAT_ENTRIES))
 		return 0;
 
 	write_lock(&nm_i->nat_tree_lock);
@@ -1828,9 +1828,6 @@ flush_now:
 	if (!flushed)
 		mutex_unlock(&curseg->curseg_mutex);
 	f2fs_put_page(page, 1);
-
-	/* 2) shrink nat caches if necessary */
-	try_to_free_nats(sbi, nm_i->nat_cnt - NM_WOUT_THRESHOLD);
 }
 
 static int init_node_manager(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index c972154..c2015b7 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -20,9 +20,6 @@
 /* maximum readahead size for node during getting data blocks */
 #define MAX_RA_NODE		128
 
-/* maximum cached nat entries to manage memory footprint */
-#define NM_WOUT_THRESHOLD	(64 * NAT_ENTRY_PER_BLOCK)
-
 /* control the memory footprint threshold (10MB per 1GB ram) */
 #define DEF_RAM_THRESHOLD	10
 
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
