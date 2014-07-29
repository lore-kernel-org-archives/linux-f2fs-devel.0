From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: add tracepoint for f2fs_issue_flush
Date: Tue, 29 Jul 2014 07:04:52 -0700
Message-ID: <1406642692-89201-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XC81C-000393-WE
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 14:04:43 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XC81B-0003Qn-Ti for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 14:04:42 +0000
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

This patch adds a tracepoint for f2fs_issue_flush.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c           |  3 +++
 include/trace/events/f2fs.h | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e016b97..5a53a0a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -239,6 +239,9 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 	struct flush_cmd_control *fcc = SM_I(sbi)->cmd_control_info;
 	struct flush_cmd cmd;
 
+	trace_f2fs_issue_flush(sbi->sb, test_opt(sbi, NOBARRIER),
+					test_opt(sbi, FLUSH_MERGE));
+
 	if (test_opt(sbi, NOBARRIER))
 		return 0;
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index b983990..7d2e70e 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -926,6 +926,30 @@ TRACE_EVENT(f2fs_issue_discard,
 		(unsigned long long)__entry->blkstart,
 		(unsigned long long)__entry->blklen)
 );
+
+TRACE_EVENT(f2fs_issue_flush,
+
+	TP_PROTO(struct super_block *sb, bool nobarrier, bool flush_merge),
+
+	TP_ARGS(sb, nobarrier, flush_merge),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(bool, nobarrier)
+		__field(bool, flush_merge)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= sb->s_dev;
+		__entry->nobarrier = nobarrier;
+		__entry->flush_merge = flush_merge;
+	),
+
+	TP_printk("dev = (%d,%d), %s %s",
+		show_dev(__entry),
+		__entry->nobarrier ? "skip (nobarrier)" : "issue",
+		__entry->flush_merge ? " with flush_merge" : "")
+);
 #endif /* _TRACE_F2FS_H */
 
  /* This part must be outside protection */
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
