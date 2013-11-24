From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 1/2] f2fs: adds a tracepoint for
	submit_read_page
Date: Sun, 24 Nov 2013 12:08:54 +0900
Message-ID: <1385262534.26319.88.camel@kjgkr>
References: <001e01cee5cc$3d118310$b7348930$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VkQ56-0002s2-Ci
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 24 Nov 2013 03:09:56 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VkQ54-0002b0-GS
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 24 Nov 2013 03:09:56 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWQ00GOLZGB6H50@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sun, 24 Nov 2013 12:09:47 +0900 (KST)
In-reply-to: <001e01cee5cc$3d118310$b7348930$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi,

We need to avoid redundancy as much as possible.
So, how about this patch?

>From 7b4a4f1628a1a793942c7f675e6afecece64b659 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao2.yu@samsung.com>
Date: Wed, 20 Nov 2013 16:40:10 +0800
Subject: [PATCH] f2fs: adds a tracepoint for submit_read_page

This patch adds a tracepoint for submit_read_page.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
[Jaegeuk Kim: integrate tracepoints of f2fs_submit_read(_write)_page]
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c              |  1 +
 fs/f2fs/segment.c           |  2 +-
 include/trace/events/f2fs.h | 25 +++++++++++++++++++++----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ce3cbd9..cdb342e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -462,6 +462,7 @@ alloc_new:
 	io->last_block_in_bio = blk_addr;
 
 	mutex_unlock(&io->io_mutex);
+	trace_f2fs_submit_read_page(page, rw, META, blk_addr);
 }
 
 /*
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9607cc4..264a5ff 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -925,7 +925,7 @@ retry:
 	io->last_block_in_bio = blk_addr;
 
 	mutex_unlock(&io->io_mutex);
-	trace_f2fs_submit_write_page(page, blk_addr, type);
+	trace_f2fs_submit_write_page(page, WRITE, type, blk_addr);
 }
 
 void f2fs_wait_on_page_writeback(struct page *page,
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 47ee70d..73cc5f0 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -674,15 +674,16 @@ DEFINE_EVENT(f2fs__page, f2fs_vm_page_mkwrite,
 	TP_ARGS(page, type)
 );
 
-TRACE_EVENT(f2fs_submit_write_page,
+DECLARE_EVENT_CLASS(f2fs_io_page,
 
-	TP_PROTO(struct page *page, block_t blk_addr, int type),
+	TP_PROTO(struct page *page, int rw, int type, block_t blk_addr),
 
-	TP_ARGS(page, blk_addr, type),
+	TP_ARGS(page, rw, type, blk_addr),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
+		__field(int, rw)
 		__field(int, type)
 		__field(pgoff_t, index)
 		__field(block_t, block)
@@ -691,18 +692,34 @@ TRACE_EVENT(f2fs_submit_write_page,
 	TP_fast_assign(
 		__entry->dev	= page->mapping->host->i_sb->s_dev;
 		__entry->ino	= page->mapping->host->i_ino;
+		__entry->rw	= rw;
 		__entry->type	= type;
 		__entry->index	= page->index;
 		__entry->block	= blk_addr;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, %s, index = %lu, blkaddr = 0x%
llx",
+	TP_printk("dev = (%d,%d), ino = %lu, %s, %s, index = %lu, blkaddr = 0x
%llx",
 		show_dev_ino(__entry),
+		show_bio_type(__entry->rw),
 		show_block_type(__entry->type),
 		(unsigned long)__entry->index,
 		(unsigned long long)__entry->block)
 );
 
+DEFINE_EVENT(f2fs_io_page, f2fs_submit_write_page,
+
+	TP_PROTO(struct page *page, int rw, int type, block_t blk_addr),
+
+	TP_ARGS(page, rw, type, blk_addr)
+);
+
+DEFINE_EVENT(f2fs_io_page, f2fs_submit_read_page,
+
+	TP_PROTO(struct page *page, int rw, int type, block_t blk_addr),
+
+	TP_ARGS(page, rw, type, blk_addr)
+);
+
 TRACE_EVENT(f2fs_write_checkpoint,
 
 	TP_PROTO(struct super_block *sb, bool is_umount, char *msg),
-- 
1.8.4.474.g128a96c


-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
