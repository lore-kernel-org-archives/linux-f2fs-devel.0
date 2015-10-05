From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: add a tracepoint for background gc
Date: Mon,  5 Oct 2015 15:43:59 -0700
Message-ID: <1444085040-12843-2-git-send-email-jaegeuk@kernel.org>
References: <1444085040-12843-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZjEUW-0002IS-Lh
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 22:44:20 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZjEUV-0000wr-W6 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 22:44:20 +0000
In-Reply-To: <1444085040-12843-1-git-send-email-jaegeuk@kernel.org>
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

This patch introduces a tracepoint to monitor background gc behaviors.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c                |  3 +++
 include/trace/events/f2fs.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e627c19..e7cec86 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -77,6 +77,9 @@ static int gc_thread_func(void *data)
 
 		stat_inc_bggc_count(sbi);
 
+		trace_f2fs_background_gc(sbi->sb, wait_ms,
+				prefree_segments(sbi), free_segments(sbi));
+
 		/* if return value is not zero, no victim was selected */
 		if (f2fs_gc(sbi, test_opt(sbi, FORCE_FG_GC)))
 			wait_ms = gc_th->no_gc_sleep_time;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 6aa63d9..7de751d 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -514,6 +514,34 @@ TRACE_EVENT(f2fs_map_blocks,
 		__entry->ret)
 );
 
+TRACE_EVENT(f2fs_background_gc,
+
+	TP_PROTO(struct super_block *sb, long wait_ms,
+			unsigned int prefree, unsigned int free),
+
+	TP_ARGS(sb, wait_ms, prefree, free),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(long,	wait_ms)
+		__field(unsigned int,	prefree)
+		__field(unsigned int,	free)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= sb->s_dev;
+		__entry->wait_ms	= wait_ms;
+		__entry->prefree	= prefree;
+		__entry->free		= free;
+	),
+
+	TP_printk("dev = (%d,%d), wait_ms = %ld, prefree = %u, free = %u",
+		show_dev(__entry),
+		__entry->wait_ms,
+		__entry->prefree,
+		__entry->free)
+);
+
 TRACE_EVENT(f2fs_get_victim,
 
 	TP_PROTO(struct super_block *sb, int type, int gc_type,
-- 
2.1.1


------------------------------------------------------------------------------
