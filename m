From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: add detailed information of bio types in
	the tracepoints
Date: Sun, 24 Nov 2013 15:17:12 +0900
Message-ID: <1385273832-32167-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VkT1O-0005Ss-Is
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 24 Nov 2013 06:18:18 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VkT1M-0008QJ-Gb
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 24 Nov 2013 06:18:18 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWR00AD28692A80@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sun, 24 Nov 2013 15:18:09 +0900 (KST)
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

This patch inserts information of bio types in more detail.
So, we can now see REQ_META and REQ_PRIO too.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/segment.c           |  4 ++--
 include/trace/events/f2fs.h | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b86b1bd..501a5dc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -848,11 +848,11 @@ static void do_submit_bio(struct f2fs_sb_info *sbi,
 	if (type >= META_FLUSH)
 		rw = WRITE_FLUSH_FUA;
 
-	trace_f2fs_submit_write_bio(sbi->sb, rw, btype, io->bio);
-
 	if (btype == META)
 		rw |= REQ_META;
 
+	trace_f2fs_submit_write_bio(sbi->sb, rw, btype, io->bio);
+
 	p = io->bio->bi_private;
 	p->sbi = sbi;
 	io->bio->bi_end_io = f2fs_end_io_write;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 1f59f5d..204fcc3 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -16,8 +16,13 @@
 		{ META,		"META" },				\
 		{ META_FLUSH,	"META_FLUSH" })
 
-#define show_bio_type(type)						\
-	__print_symbolic(type,						\
+#define F2FS_BIO_MASK(t)	(t & (READA | WRITE_FLUSH_FUA))
+#define F2FS_BIO_EXTRA_MASK(t)	(t & (REQ_META | REQ_PRIO))
+
+#define show_bio_type(type)	show_bio_base(type), show_bio_extra(type)
+
+#define show_bio_base(type)						\
+	__print_symbolic(F2FS_BIO_MASK(type),				\
 		{ READ, 		"READ" },			\
 		{ READA, 		"READAHEAD" },			\
 		{ READ_SYNC, 		"READ_SYNC" },			\
@@ -27,6 +32,13 @@
 		{ WRITE_FUA, 		"WRITE_FUA" },			\
 		{ WRITE_FLUSH_FUA,	"WRITE_FLUSH_FUA" })
 
+#define show_bio_extra(type)						\
+	__print_symbolic(F2FS_BIO_EXTRA_MASK(type),			\
+		{ REQ_META, 		"(M)" },			\
+		{ REQ_PRIO, 		"(P)" },			\
+		{ REQ_META | REQ_PRIO,	"(MP)" },			\
+		{ 0, " \b" })
+
 #define show_data_type(type)						\
 	__print_symbolic(type,						\
 		{ CURSEG_HOT_DATA, 	"Hot DATA" },			\
@@ -447,7 +459,7 @@ TRACE_EVENT_CONDITION(f2fs_readpage,
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, page_index = 0x%lx, "
-		"blkaddr = 0x%llx, bio_type = %s",
+		"blkaddr = 0x%llx, bio_type = %s%s",
 		show_dev_ino(__entry),
 		(unsigned long)__entry->index,
 		(unsigned long long)__entry->blkaddr,
@@ -621,7 +633,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_bio,
 		__entry->size		= bio->bi_size;
 	),
 
-	TP_printk("dev = (%d,%d), %s, %s, sector = %lld, size = %u",
+	TP_printk("dev = (%d,%d), %s%s, %s, sector = %lld, size = %u",
 		show_dev(__entry),
 		show_bio_type(__entry->rw),
 		show_block_type(__entry->type),
@@ -713,7 +725,7 @@ DECLARE_EVENT_CLASS(f2fs_io_page,
 		__entry->block	= blk_addr;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, %s, %s, index = %lu, blkaddr = 0x%llx",
+	TP_printk("dev = (%d,%d), ino = %lu, %s%s, %s, index = %lu, blkaddr = 0x%llx",
 		show_dev_ino(__entry),
 		show_bio_type(__entry->rw),
 		show_block_type(__entry->type),
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
