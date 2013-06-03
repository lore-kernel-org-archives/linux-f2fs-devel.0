From: Huajun Li <huajun.li@intel.com>
Subject: [f2fs-dev] [RFC 5/5] f2fs: add tracepoints to debug inline data
	operations
Date: Mon,  3 Jun 2013 18:04:14 +0800
Message-ID: <1370253854-15084-6-git-send-email-huajun.li@intel.com>
References: <1370253854-15084-1-git-send-email-huajun.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huajun.li@intel.com>) id 1UjRdv-0001pN-BT
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Jun 2013 10:05:35 +0000
Received: from mga14.intel.com ([143.182.124.37])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UjRdu-0006t8-Es for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Jun 2013 10:05:35 +0000
In-Reply-To: <1370253854-15084-1-git-send-email-huajun.li@intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com, linux-fsdevel@vger.kernel.org, huajun.li.lee@gmail.com
Cc: Huajun Li <huajun.li@intel.com>, namjae.jeon@samsung.com, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-f2fs-devel@lists.sourceforge.net

From: Haicheng Li <haicheng.li@linux.intel.com>

Add tracepoints for: f2fs_read_inline_data(), f2fs_convert_inline_data(),
f2fs_write_inline_data().

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
Signed-off-by: Huajun Li <huajun.li@intel.com>
---
 fs/f2fs/inline.c            |    4 +++
 include/trace/events/f2fs.h |   69 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index a2aa056..9ec66e5 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -14,6 +14,7 @@
 #include <linux/f2fs_fs.h>
 
 #include "f2fs.h"
+#include <trace/events/f2fs.h>
 
 void f2fs_clear_inode_inline_flag(struct f2fs_inode *raw_inode)
 {
@@ -44,6 +45,7 @@ static int f2fs_read_inline_data(struct inode *inode, struct page *page)
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
+	trace_f2fs_read_inline_data(inode, page);
 	src_addr = page_address(ipage);
 	dst_addr = page_address(page);
 
@@ -107,6 +109,7 @@ int f2fs_convert_inline_data(struct page *p,
 	set_page_dirty(ipage);
 	f2fs_put_page(ipage, 1);
 
+	trace_f2fs_convert_inline_data(inode, page);
 	if (!p->index) {
 		SetPageUptodate(page);
 	} else {
@@ -138,6 +141,7 @@ int f2fs_write_inline_data(struct inode *inode,
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
+	trace_f2fs_write_inline_data(inode, page);
 	src_addr = page_address(page);
 	dst_addr = page_address(ipage);
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 52ae548..bc7a84e 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -676,6 +676,75 @@ TRACE_EVENT(f2fs_write_checkpoint,
 		__entry->msg)
 );
 
+TRACE_EVENT(f2fs_read_inline_data,
+
+	TP_PROTO(struct inode *inode, struct page *page),
+
+	TP_ARGS(inode, page),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(pgoff_t, index)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->index	= page->index;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, index = %lu",
+		show_dev_ino(__entry),
+		(unsigned long)__entry->index)
+);
+
+TRACE_EVENT(f2fs_convert_inline_data,
+
+	TP_PROTO(struct inode *inode, struct page *page),
+
+	TP_ARGS(inode, page),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(pgoff_t, index)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->index	= page->index;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, index = %lu",
+		show_dev_ino(__entry),
+		(unsigned long)__entry->index)
+);
+
+TRACE_EVENT(f2fs_write_inline_data,
+
+	TP_PROTO(struct inode *inode, struct page *page),
+
+	TP_ARGS(inode, page),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(pgoff_t, index)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->index	= page->index;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, index = %lu",
+		show_dev_ino(__entry),
+		(unsigned long)__entry->index)
+);
+
 #endif /* _TRACE_F2FS_H */
 
  /* This part must be outside protection */
-- 
1.7.9.5


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
