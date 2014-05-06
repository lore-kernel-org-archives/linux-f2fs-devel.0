From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 6/6] f2fs: add a tracepoint for f2fs_read_data_pages
Date: Tue, 06 May 2014 16:54:23 +0800
Message-ID: <004801cf6908$e2149bd0$a63dd370$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds a tracepoint for f2fs_read_data_pages to trace when pages are
readahead by VFS.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c              |    3 +++
 include/trace/events/f2fs.h |   26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8c250a5..f2d1e8a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -729,6 +729,9 @@ static int f2fs_read_data_pages(struct file *file,
 			struct list_head *pages, unsigned nr_pages)
 {
 	struct inode *inode = file->f_mapping->host;
+	struct page *page = list_entry(pages->prev, struct page, lru);
+
+	trace_f2fs_readpages(inode, page, nr_pages);
 
 	/* If the file has inline data, skip readpages */
 	if (f2fs_has_inline_data(inode))
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index b983990..7fbaaaa 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -847,6 +847,32 @@ TRACE_EVENT(f2fs_writepages,
 		__entry->for_sync)
 );
 
+TRACE_EVENT(f2fs_readpages,
+
+	TP_PROTO(struct inode *inode, struct page *page, unsigned int nrpage),
+
+	TP_ARGS(inode, page, nrpage),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(pgoff_t,	start)
+		__field(unsigned int,	nrpage)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->start	= page->index;
+		__entry->nrpage	= nrpage;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, start = %lu nrpage = %u",
+		show_dev_ino(__entry),
+		(unsigned long)__entry->start,
+		__entry->nrpage)
+);
+
 TRACE_EVENT(f2fs_submit_page_mbio,
 
 	TP_PROTO(struct page *page, int rw, int type, block_t blk_addr),
-- 
1.7.9.5


