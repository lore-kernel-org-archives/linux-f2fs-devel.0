From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 2/6] f2fs: add a tracepoint for f2fs_write_end
Date: Tue, 06 May 2014 16:47:23 +0800
Message-ID: <004401cf6907$e584ffe0$b08effa0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds a tracepoint for f2fs_write_end to trace write op of user.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c              |    2 ++
 include/trace/events/f2fs.h |   30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cde0d69..ea58fb6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -989,6 +989,8 @@ static int f2fs_write_end(struct file *file,
 {
 	struct inode *inode = page->mapping->host;
 
+	trace_f2fs_write_end(inode, pos, len, copied);
+
 	SetPageUptodate(page);
 	set_page_dirty(page);
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 1e9375a..483804b 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -689,6 +689,36 @@ TRACE_EVENT(f2fs_write_begin,
 		__entry->flags)
 );
 
+TRACE_EVENT(f2fs_write_end,
+
+	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len,
+				unsigned int copied),
+
+	TP_ARGS(inode, pos, len, copied),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t,	pos)
+		__field(unsigned int, len)
+		__field(unsigned int, copied)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->pos	= pos;
+		__entry->len	= len;
+		__entry->copied	= copied;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, pos = %llu, len = %u, copied = %u",
+		show_dev_ino(__entry),
+		(unsigned long long)__entry->pos,
+		__entry->len,
+		__entry->copied)
+);
+
 DECLARE_EVENT_CLASS(f2fs__page,
 
 	TP_PROTO(struct page *page, int type),
-- 
1.7.9.5


