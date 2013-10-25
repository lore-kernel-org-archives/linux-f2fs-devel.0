From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/2] f2fs: add tracepoint for vm_page_mkwrite
Date: Fri, 25 Oct 2013 14:34:59 +0900
Message-ID: <1382679299-18250-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1382679299-18250-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VZa3n-0006YE-7N
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Oct 2013 05:35:47 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VZa3l-0001pT-4I for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Oct 2013 05:35:47 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MV7002A3M79JYD0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Oct 2013 14:35:38 +0900 (KST)
In-reply-to: <1382679299-18250-1-git-send-email-jaegeuk.kim@samsung.com>
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

This patch adds a tracepoint for f2fs_vm_page_mkwrite.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/file.c              | 1 +
 include/trace/events/f2fs.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c80faa2..2d4190a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -88,6 +88,7 @@ static int f2fs_vm_page_mkwrite(struct vm_area_struct *vma,
 	set_page_dirty(page);
 	SetPageUptodate(page);
 
+	trace_f2fs_vm_page_mkwrite(page, DATA);
 mapped:
 	/* fill the page */
 	wait_on_page_writeback(page);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index ebde3af..e0dc355 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -667,6 +667,13 @@ DEFINE_EVENT(f2fs__page, f2fs_set_page_dirty,
 	TP_ARGS(page, type)
 );
 
+DEFINE_EVENT(f2fs__page, f2fs_vm_page_mkwrite,
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
