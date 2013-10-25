From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/2] f2fs: add tracepoint for set_page_dirty
Date: Fri, 25 Oct 2013 14:34:58 +0900
Message-ID: <1382679299-18250-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VZa3m-00068u-3f
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Oct 2013 05:35:46 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VZa3j-0008NR-Qh for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Oct 2013 05:35:46 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MV7008RNM75L5C0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Oct 2013 14:35:37 +0900 (KST)
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

This patch adds a tracepoint for set_page_dirty.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c        |  2 ++
 fs/f2fs/data.c              |  2 ++
 fs/f2fs/node.c              |  2 ++
 include/trace/events/f2fs.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5649a9d..6526f50 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -167,6 +167,8 @@ static int f2fs_set_meta_page_dirty(struct page *page)
 	struct address_space *mapping = page->mapping;
 	struct f2fs_sb_info *sbi = F2FS_SB(mapping->host->i_sb);
 
+	trace_f2fs_set_page_dirty(page, META);
+
 	SetPageUptodate(page);
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4d4718f..be47eae 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -756,6 +756,8 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
 
+	trace_f2fs_set_page_dirty(page, DATA);
+
 	SetPageUptodate(page);
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7bac481..304d5ce 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1225,6 +1225,8 @@ static int f2fs_set_node_page_dirty(struct page *page)
 	struct address_space *mapping = page->mapping;
 	struct f2fs_sb_info *sbi = F2FS_SB(mapping->host->i_sb);
 
+	trace_f2fs_set_page_dirty(page, NODE);
+
 	SetPageUptodate(page);
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 52ae548..ebde3af 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -36,6 +36,11 @@
 		{ CURSEG_COLD_NODE, 	"Cold NODE" },			\
 		{ NO_CHECK_TYPE, 	"No TYPE" })
 
+#define show_file_type(type)						\
+	__print_symbolic(type,						\
+		{ 0,		"FILE" },				\
+		{ 1,		"DIR" })
+
 #define show_gc_type(type)						\
 	__print_symbolic(type,						\
 		{ FG_GC,	"Foreground GC" },			\
@@ -623,6 +628,45 @@ TRACE_EVENT(f2fs_do_submit_bio,
 		__entry->size)
 );
 
+DECLARE_EVENT_CLASS(f2fs__page,
+
+	TP_PROTO(struct page *page, int type),
+
+	TP_ARGS(page, type),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(int, type)
+		__field(int, dir)
+		__field(pgoff_t, index)
+		__field(int, dirty)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= page->mapping->host->i_sb->s_dev;
+		__entry->ino	= page->mapping->host->i_ino;
+		__entry->type	= type;
+		__entry->dir	= S_ISDIR(page->mapping->host->i_mode);
+		__entry->index	= page->index;
+		__entry->dirty	= PageDirty(page);
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, %s, %s, index = %lu, dirty = %d",
+		show_dev_ino(__entry),
+		show_block_type(__entry->type),
+		show_file_type(__entry->dir),
+		(unsigned long)__entry->index,
+		__entry->dirty)
+);
+
+DEFINE_EVENT(f2fs__page, f2fs_set_page_dirty,
+
+	TP_PROTO(struct page *page, int type),
+
+	TP_ARGS(page, type)
+);
+
 TRACE_EVENT(f2fs_submit_write_page,
 
 	TP_PROTO(struct page *page, block_t blk_addr, int type),
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
