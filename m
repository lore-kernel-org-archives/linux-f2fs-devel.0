From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: adds a tracepoint for submit_read_page
Date: Wed, 20 Nov 2013 16:40:10 +0800
Message-ID: <001e01cee5cc$3d118310$b7348930$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Vj3Lb-0006wP-LC
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 Nov 2013 08:41:19 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vj3LW-0004VY-Sg for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 Nov 2013 08:41:19 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MWK00MTO04D91N0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 Nov 2013 17:41:01 +0900 (KST)
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
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds a tracepoint for submit_read_page.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c              |    1 +
 include/trace/events/f2fs.h |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9cf3f6c..0ca93be 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -448,6 +448,7 @@ alloc_new:
 	io->last_block_in_bio = blk_addr;
 
 	mutex_unlock(&io->io_mutex);
+	trace_f2fs_submit_read_page(page, blk_addr, rw);
 }
 
 /*
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index e0dc355..571f39a 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -453,6 +453,36 @@ TRACE_EVENT_CONDITION(f2fs_readpage,
 		show_bio_type(__entry->type))
 );
 
+TRACE_EVENT(f2fs_submit_read_page,
+
+	TP_PROTO(struct page *page, block_t blk_addr, int rw),
+
+	TP_ARGS(page, blk_addr, rw),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(int, rw)
+		__field(pgoff_t, index)
+		__field(block_t, block)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= page->mapping->host->i_sb->s_dev;
+		__entry->ino	= page->mapping->host->i_ino;
+		__entry->rw	= rw;
+		__entry->index	= page->index;
+		__entry->block	= blk_addr;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, bio_type = %s, "
+		"index = %lu, blkaddr = 0x%llx",
+		show_dev_ino(__entry),
+		show_bio_type(__entry->rw),
+		(unsigned long)__entry->index,
+		(unsigned long long)__entry->block)
+);
+
 TRACE_EVENT(f2fs_get_data_block,
 	TP_PROTO(struct inode *inode, sector_t iblock,
 				struct buffer_head *bh, int ret),
-- 
1.7.9.5


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
