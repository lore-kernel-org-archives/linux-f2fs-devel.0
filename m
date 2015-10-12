From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/5] f2fs: add a tracepoint for
	f2fs_read_data_pages
Date: Mon, 12 Oct 2015 17:02:26 +0800
Message-ID: <020f01d104cc$cf35e3f0$6da1abd0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZlZ0l-0004YK-Ps
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Oct 2015 09:03:15 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZlZ0j-0006St-3L
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Oct 2015 09:03:15 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NW300FTBNRYCF60@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Oct 2015 18:03:05 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds a tracepoint for f2fs_read_data_pages to trace when pages
are readahead by VFS.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c              |  3 +++
 include/trace/events/f2fs.h | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d4f1c74..2285376 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1032,6 +1032,9 @@ static int f2fs_read_data_pages(struct file *file,
 			struct list_head *pages, unsigned nr_pages)
 {
 	struct inode *inode = file->f_mapping->host;
+	struct page *page = list_entry(pages->prev, struct page, lru);
+
+	trace_f2fs_readpages(inode, page, nr_pages);
 
 	/* If the file has inline data, skip readpages */
 	if (f2fs_has_inline_data(inode))
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 7de751d..00b4a63 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1028,6 +1028,32 @@ TRACE_EVENT(f2fs_writepages,
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
 TRACE_EVENT(f2fs_write_checkpoint,
 
 	TP_PROTO(struct super_block *sb, int reason, char *msg),
-- 
2.5.2



------------------------------------------------------------------------------
