From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 5/6] f2fs: add a tracepoint for f2fs_read_data_page
Date: Tue, 06 May 2014 16:53:08 +0800
Message-ID: <004701cf6908$bdb6c380$39244a80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds a tracepoint for f2fs_read_data_page to trace when page is
readed by user.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c              |    2 ++
 include/trace/events/f2fs.h |   15 +++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 21bfafa..8c250a5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -713,6 +713,8 @@ static int f2fs_read_data_page(struct file *file, struct page *page)
 	struct inode *inode = page->mapping->host;
 	int ret;
 
+	trace_f2fs_readpage(page, DATA);
+
 	/* If the file has inline data, try to read it directlly */
 	if (f2fs_has_inline_data(inode))
 		ret = f2fs_read_inline_data(inode, page);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 91b1fcc..b983990 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -732,6 +732,7 @@ DECLARE_EVENT_CLASS(f2fs__page,
 		__field(int, dir)
 		__field(pgoff_t, index)
 		__field(int, dirty)
+		__field(int, uptodate)
 	),
 
 	TP_fast_assign(
@@ -741,14 +742,17 @@ DECLARE_EVENT_CLASS(f2fs__page,
 		__entry->dir	= S_ISDIR(page->mapping->host->i_mode);
 		__entry->index	= page->index;
 		__entry->dirty	= PageDirty(page);
+		__entry->uptodate = PageUptodate(page);
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, %s, %s, index = %lu, dirty = %d",
+	TP_printk("dev = (%d,%d), ino = %lu, %s, %s, index = %lu, "
+		"dirty = %d, uptodate = %d",
 		show_dev_ino(__entry),
 		show_block_type(__entry->type),
 		show_file_type(__entry->dir),
 		(unsigned long)__entry->index,
-		__entry->dirty)
+		__entry->dirty,
+		__entry->uptodate)
 );
 
 DEFINE_EVENT(f2fs__page, f2fs_writepage,
@@ -758,6 +762,13 @@ DEFINE_EVENT(f2fs__page, f2fs_writepage,
 	TP_ARGS(page, type)
 );
 
+DEFINE_EVENT(f2fs__page, f2fs_readpage,
+
+	TP_PROTO(struct page *page, int type),
+
+	TP_ARGS(page, type)
+);
+
 DEFINE_EVENT(f2fs__page, f2fs_set_page_dirty,
 
 	TP_PROTO(struct page *page, int type),
-- 
1.7.9.5


