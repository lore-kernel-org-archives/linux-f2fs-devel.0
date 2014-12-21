From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/6] f2fs: add f2fs_io_tracer support
Date: Sun, 21 Dec 2014 08:35:19 -0800
Message-ID: <1419179723-3234-2-git-send-email-jaegeuk@kernel.org>
References: <1419179723-3234-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y2jTk-0005WT-QB
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Dec 2014 16:35:36 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y2jTj-0001im-KC for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Dec 2014 16:35:36 +0000
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

This patch adds:
 o initial trace.c and trace.h with skeleton functions
 o Kconfig and Makefile to activate this feature

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/Kconfig  | 10 ++++++++++
 fs/f2fs/Makefile |  1 +
 fs/f2fs/trace.c  | 24 ++++++++++++++++++++++++
 fs/f2fs/trace.h  | 24 ++++++++++++++++++++++++
 4 files changed, 59 insertions(+)
 create mode 100644 fs/f2fs/trace.c
 create mode 100644 fs/f2fs/trace.h

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 736a348..94e2d2f 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -71,3 +71,13 @@ config F2FS_CHECK_FS
 	  Enables BUG_ONs which check the filesystem consistency in runtime.
 
 	  If you want to improve the performance, say N.
+
+config F2FS_IO_TRACE
+	bool "F2FS IO tracer"
+	depends on F2FS_FS
+	depends on FUNCTION_TRACER
+	help
+	  F2FS IO trace is based on a function trace, which gathers process
+	  information and block IO patterns in the filesystem level.
+
+	  If unsure, say N.
diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index 2e35da1..d923977 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -5,3 +5,4 @@ f2fs-y		+= checkpoint.o gc.o data.o node.o segment.o recovery.o
 f2fs-$(CONFIG_F2FS_STAT_FS) += debug.o
 f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
 f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
+f2fs-$(CONFIG_F2FS_IO_TRACE) += trace.o
diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
new file mode 100644
index 0000000..4e4a069
--- /dev/null
+++ b/fs/f2fs/trace.c
@@ -0,0 +1,24 @@
+/*
+ * f2fs IO tracer
+ *
+ * Copyright (c) 2014 Motorola Mobility
+ * Copyright (c) 2014 Jaegeuk Kim <jaegeuk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/fs.h>
+#include <linux/f2fs_fs.h>
+#include <linux/sched.h>
+
+#include "f2fs.h"
+#include "trace.h"
+
+void f2fs_trace_pid(struct page *page)
+{
+}
+
+void f2fs_trace_ios(struct page *page, struct f2fs_io_info *fio, int flush)
+{
+}
diff --git a/fs/f2fs/trace.h b/fs/f2fs/trace.h
new file mode 100644
index 0000000..08856a9
--- /dev/null
+++ b/fs/f2fs/trace.h
@@ -0,0 +1,24 @@
+/*
+ * f2fs IO tracer
+ *
+ * Copyright (c) 2014 Motorola Mobility
+ * Copyright (c) 2014 Jaegeuk Kim <jaegeuk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __F2FS_TRACE_H__
+#define __F2FS_TRACE_H__
+
+#ifdef CONFIG_F2FS_IO_TRACE
+#include <trace/events/f2fs.h>
+
+extern void f2fs_trace_pid(struct page *);
+extern void f2fs_trace_ios(struct page *, struct f2fs_io_info *, int);
+#else
+#define f2fs_trace_pid(p)
+#define f2fs_trace_ios(p, i, n)
+
+#endif
+#endif /* __F2FS_TRACE_H__ */
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
