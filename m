From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/6] f2fs: add key functions for f2fs_io_tracer
Date: Sun, 21 Dec 2014 08:35:20 -0800
Message-ID: <1419179723-3234-3-git-send-email-jaegeuk@kernel.org>
References: <1419179723-3234-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y2jTl-00074F-O0
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Dec 2014 16:35:37 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y2jTk-0003Bo-Ly for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Dec 2014 16:35:37 +0000
In-Reply-To: <1419179723-3234-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds two key functions to trace process ids and IOs.
The basic idea is to
1. remain process ids, pids, in page->private.
2. show pids in IO traces.

So, later we can retrieve process information according to IO traces.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/trace.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/trace.h | 18 ++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
index 4e4a069..19f5216 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -15,10 +15,96 @@
 #include "f2fs.h"
 #include "trace.h"
 
+RADIX_TREE(pids, GFP_NOIO);
+struct last_io_info last_io;
+
+static inline void __print_last_io(void)
+{
+	if (!last_io.len)
+		return;
+
+	trace_printk("%3x:%3x %4x %-16s %2x %5x %12x %4x\n",
+			last_io.major, last_io.minor,
+			last_io.pid, "----------------",
+			last_io.type,
+			last_io.fio.rw, last_io.fio.blk_addr,
+			last_io.len);
+	memset(&last_io, 0, sizeof(last_io));
+}
+
+static int __file_type(struct inode *inode, pid_t pid)
+{
+	if (f2fs_is_atomic_file(inode))
+		return __ATOMIC_FILE;
+	else if (f2fs_is_volatile_file(inode))
+		return __VOLATILE_FILE;
+	else if (S_ISDIR(inode->i_mode))
+		return __DIR_FILE;
+	else if (inode->i_ino == F2FS_NODE_INO(F2FS_I_SB(inode)))
+		return __NODE_FILE;
+	else if (inode->i_ino == F2FS_META_INO(F2FS_I_SB(inode)))
+		return __META_FILE;
+	else if (pid)
+		return __NORMAL_FILE;
+	else
+		return __MISC_FILE;
+}
+
 void f2fs_trace_pid(struct page *page)
 {
+	struct inode *inode = page->mapping->host;
+	pid_t pid = task_pid_nr(current);
+	void *p;
+
+	page->private = pid;
+
+	p = radix_tree_lookup(&pids, pid);
+	if (p == current)
+		return;
+	if (p)
+		radix_tree_delete(&pids, pid);
+
+	f2fs_radix_tree_insert(&pids, pid, current);
+
+	trace_printk("%3x:%3x %4x %-16s\n",
+			MAJOR(inode->i_sb->s_dev), MINOR(inode->i_sb->s_dev),
+			pid, current->comm);
+
 }
 
 void f2fs_trace_ios(struct page *page, struct f2fs_io_info *fio, int flush)
 {
+	struct inode *inode;
+	pid_t pid;
+	int major, minor;
+
+	if (flush) {
+		__print_last_io();
+		return;
+	}
+
+	inode = page->mapping->host;
+	pid = page_private(page);
+
+	major = MAJOR(inode->i_sb->s_dev);
+	minor = MINOR(inode->i_sb->s_dev);
+
+	if (last_io.major == major && last_io.minor == minor &&
+			last_io.pid == pid &&
+			last_io.type == __file_type(inode, pid) &&
+			last_io.fio.rw == fio->rw &&
+			last_io.fio.blk_addr + last_io.len == fio->blk_addr) {
+		last_io.len++;
+		return;
+	}
+
+	__print_last_io();
+
+	last_io.major = major;
+	last_io.minor = minor;
+	last_io.pid = pid;
+	last_io.type = __file_type(inode, pid);
+	last_io.fio = *fio;
+	last_io.len = 1;
+	return;
 }
diff --git a/fs/f2fs/trace.h b/fs/f2fs/trace.h
index 08856a9..aa6663b 100644
--- a/fs/f2fs/trace.h
+++ b/fs/f2fs/trace.h
@@ -14,6 +14,24 @@
 #ifdef CONFIG_F2FS_IO_TRACE
 #include <trace/events/f2fs.h>
 
+enum file_type {
+	__NORMAL_FILE,
+	__DIR_FILE,
+	__NODE_FILE,
+	__META_FILE,
+	__ATOMIC_FILE,
+	__VOLATILE_FILE,
+	__MISC_FILE,
+};
+
+struct last_io_info {
+	int major, minor;
+	pid_t pid;
+	enum file_type type;
+	struct f2fs_io_info fio;
+	block_t len;
+};
+
 extern void f2fs_trace_pid(struct page *);
 extern void f2fs_trace_ios(struct page *, struct f2fs_io_info *, int);
 #else
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
