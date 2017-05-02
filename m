From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: show available_nids in f2fs/status
Date: Mon,  1 May 2017 18:57:44 -0700
Message-ID: <20170502015744.87736-2-jaegeuk@kernel.org>
References: <20170502015744.87736-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d5N4e-00008w-Cx
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 02 May 2017 01:57:56 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d5N4d-0000yl-Lz
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 02 May 2017 01:57:56 +0000
In-Reply-To: <20170502015744.87736-1-jaegeuk@kernel.org>
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

This patch adds an entry in f2fs/status to show # of available nids.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c | 5 +++--
 fs/f2fs/f2fs.h  | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 6102737473d4..87f449845f5f 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -97,6 +97,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->sits = MAIN_SEGS(sbi);
 	si->dirty_sits = SIT_I(sbi)->dirty_sentries;
 	si->free_nids = NM_I(sbi)->nid_cnt[FREE_NID_LIST];
+	si->avail_nids = NM_I(sbi)->available_nids;
 	si->alloc_nids = NM_I(sbi)->nid_cnt[ALLOC_NID_LIST];
 	si->bg_gc = sbi->bg_gc;
 	si->util_free = (int)(free_user_blocks(sbi) >> sbi->log_blocks_per_seg)
@@ -370,8 +371,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->ndirty_imeta);
 		seq_printf(s, "  - NATs: %9d/%9d\n  - SITs: %9d/%9d\n",
 			   si->dirty_nats, si->nats, si->dirty_sits, si->sits);
-		seq_printf(s, "  - free_nids: %9d, alloc_nids: %9d\n",
-			   si->free_nids, si->alloc_nids);
+		seq_printf(s, "  - free_nids: %9d/%9d\n  - alloc_nids: %9d\n",
+			   si->free_nids, si->avail_nids, si->alloc_nids);
 		seq_puts(s, "\nDistribution of User Blocks:");
 		seq_puts(s, " [ valid | invalid | free ]\n");
 		seq_puts(s, "  [");
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index baefe379d43a..e26999a74522 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2395,7 +2395,8 @@ struct f2fs_stat_info {
 	int ndirty_node, ndirty_dent, ndirty_meta, ndirty_data, ndirty_imeta;
 	int inmem_pages;
 	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
-	int nats, dirty_nats, sits, dirty_sits, free_nids, alloc_nids;
+	int nats, dirty_nats, sits, dirty_sits;
+	int free_nids, avail_nids, alloc_nids;
 	int total_count, utilization;
 	int bg_gc, nr_wb_cp_data, nr_wb_data;
 	int nr_flushing, nr_flushed, nr_discarding, nr_discarded;
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
