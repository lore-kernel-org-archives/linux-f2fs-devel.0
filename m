From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: add delimiter to seperate name and value in debug phrase
Date: Mon, 13 Jan 2014 10:34:18 +0900
Message-ID: <1389576858-21205-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Support for f2fs-tools/tools/f2stat to monitor
/sys/kernel/debug/f2fs/status

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/debug.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 711a0d4..6e4ac9a 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -246,13 +246,13 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "\nExtent Hit Ratio: %d / %d\n",
 			   si->hit_ext, si->total_ext);
 		seq_printf(s, "\nBalancing F2FS Async:\n");
-		seq_printf(s, "  - nodes %4d in %4d\n",
+		seq_printf(s, "  - nodes: %4d in %4d\n",
 			   si->ndirty_node, si->node_pages);
-		seq_printf(s, "  - dents %4d in dirs:%4d\n",
+		seq_printf(s, "  - dents: %4d in dirs:%4d\n",
 			   si->ndirty_dent, si->ndirty_dirs);
-		seq_printf(s, "  - meta %4d in %4d\n",
+		seq_printf(s, "  - meta: %4d in %4d\n",
 			   si->ndirty_meta, si->meta_pages);
-		seq_printf(s, "  - NATs %5d > %lu\n",
+		seq_printf(s, "  - NATs: %5d > %lu\n",
 			   si->nats, NM_WOUT_THRESHOLD);
 		seq_printf(s, "  - SITs: %5d\n  - free_nids: %5d\n",
 			   si->sits, si->fnids);
-- 
1.7.10.4

