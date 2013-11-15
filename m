From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 5/5] f2fs: add a tracepoint for f2fs_issue_discard
Date: Fri, 15 Nov 2013 14:20:24 +0900
Message-ID: <1384492824-32483-5-git-send-email-jaegeuk.kim@samsung.com>
References: <1384492824-32483-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VhBqZ-00077r-G7
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Nov 2013 05:21:35 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VhBqY-0005wy-Mk for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Nov 2013 05:21:35 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWA00FCWHJE4QO0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Nov 2013 14:21:14 +0900 (KST)
In-reply-to: <1384492824-32483-1-git-send-email-jaegeuk.kim@samsung.com>
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

This patch adds a tracepoint for f2fs_issue_discard.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/segment.c           |  1 +
 include/trace/events/f2fs.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d021cf3..1f83999 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -274,6 +274,7 @@ static void f2fs_issue_discard(struct f2fs_sb_info *sbi,
 
 	blkdev_issue_discard(sbi->sb->s_bdev, sector_addr, sector_len,
 							GFP_NOFS, 0);
+	trace_f2fs_issue_discard(sbi->sb, blkstart, blklen);
 }
 
 static void add_discard_addrs(struct f2fs_sb_info *sbi,
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index e0dc355..47ee70d 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -727,6 +727,29 @@ TRACE_EVENT(f2fs_write_checkpoint,
 		__entry->msg)
 );
 
+TRACE_EVENT(f2fs_issue_discard,
+
+	TP_PROTO(struct super_block *sb, block_t blkstart, block_t blklen),
+
+	TP_ARGS(sb, blkstart, blklen),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(block_t, blkstart)
+		__field(block_t, blklen)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= sb->s_dev;
+		__entry->blkstart = blkstart;
+		__entry->blklen = blklen;
+	),
+
+	TP_printk("dev = (%d,%d), blkstart = 0x%llx, blklen = 0x%llx",
+		show_dev(__entry),
+		(unsigned long long)__entry->blkstart,
+		(unsigned long long)__entry->blklen)
+);
 #endif /* _TRACE_F2FS_H */
 
  /* This part must be outside protection */
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
