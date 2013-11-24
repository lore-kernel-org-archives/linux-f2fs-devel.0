From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 2/2] f2fs: adds a tracepoint for
 f2fs_submit_read_bio
Date: Sun, 24 Nov 2013 12:51:24 +0900
Message-ID: <1385265084.26319.90.camel@kjgkr>
References: <001f01cee5cc$5d297450$177c5cf0$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VkQkF-0005TJ-IO
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 24 Nov 2013 03:52:27 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VkQkD-00084Z-7b
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 24 Nov 2013 03:52:27 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWR0066T1F5WD60@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sun, 24 Nov 2013 12:52:17 +0900 (KST)
In-reply-to: <001f01cee5cc$5d297450$177c5cf0$@samsung.com>
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

Again, this tracepoint alos can be integrated with write_bios like this.


>From e0360910b24624e40d92eb2e1949914339b83881 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao2.yu@samsung.com>
Date: Sun, 24 Nov 2013 12:36:42 +0900
Subject: [PATCH] f2fs: adds a tracepoint for f2fs_submit_read_bio

This patch adds a tracepoint for f2fs_submit_read_bio.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
[Jaegeuk Kim: integrate tracepoints of f2fs_submit_read(_write)_bio]
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c              |  2 ++
 fs/f2fs/segment.c           |  5 +++--
 include/trace/events/f2fs.h | 49
+++++++++++++++++++++++++++++----------------
 3 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cdb342e..7117220 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -421,6 +421,8 @@ void f2fs_submit_read_bio(struct f2fs_sb_info *sbi,
int rw)
 	if (!io->bio)
 		return;
 
+	trace_f2fs_submit_read_bio(sbi->sb, rw, META, io->bio);
+
 	mutex_lock(&io->io_mutex);
 	if (io->bio) {
 		submit_bio(rw, io->bio);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 264a5ff..3aad374 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -846,6 +846,9 @@ static void do_submit_bio(struct f2fs_sb_info *sbi,
 
 	if (type >= META_FLUSH)
 		rw = WRITE_FLUSH_FUA;
+
+	trace_f2fs_submit_write_bio(sbi->sb, rw, btype, io->bio);
+
 	if (btype == META)
 		rw |= REQ_META;
 
@@ -853,8 +856,6 @@ static void do_submit_bio(struct f2fs_sb_info *sbi,
 	p->sbi = sbi;
 	io->bio->bi_end_io = f2fs_end_io_write;
 
-	trace_f2fs_do_submit_bio(sbi->sb, btype, sync, io->bio);
-
 	if (type == META_FLUSH) {
 		DECLARE_COMPLETION_ONSTACK(wait);
 		p->is_sync = true;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 73cc5f0..1f59f5d 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -18,13 +18,14 @@
 
 #define show_bio_type(type)						\
 	__print_symbolic(type,						\
-		{ READ, 	"READ" },				\
-		{ READA, 	"READAHEAD" },				\
-		{ READ_SYNC, 	"READ_SYNC" },				\
-		{ WRITE, 	"WRITE" },				\
-		{ WRITE_SYNC, 	"WRITE_SYNC" },				\
-		{ WRITE_FLUSH,	"WRITE_FLUSH" },			\
-		{ WRITE_FUA, 	"WRITE_FUA" })
+		{ READ, 		"READ" },			\
+		{ READA, 		"READAHEAD" },			\
+		{ READ_SYNC, 		"READ_SYNC" },			\
+		{ WRITE, 		"WRITE" },			\
+		{ WRITE_SYNC, 		"WRITE_SYNC" },			\
+		{ WRITE_FLUSH,		"WRITE_FLUSH" },		\
+		{ WRITE_FUA, 		"WRITE_FUA" },			\
+		{ WRITE_FLUSH_FUA,	"WRITE_FLUSH_FUA" })
 
 #define show_data_type(type)						\
 	__print_symbolic(type,						\
@@ -598,36 +599,50 @@ TRACE_EVENT(f2fs_reserve_new_block,
 		__entry->ofs_in_node)
 );
 
-TRACE_EVENT(f2fs_do_submit_bio,
+DECLARE_EVENT_CLASS(f2fs__submit_bio,
 
-	TP_PROTO(struct super_block *sb, int btype, bool sync, struct bio
*bio),
+	TP_PROTO(struct super_block *sb, int rw, int type, struct bio *bio),
 
-	TP_ARGS(sb, btype, sync, bio),
+	TP_ARGS(sb, rw, type, bio),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(int,	btype)
-		__field(bool,	sync)
+		__field(int,	rw)
+		__field(int,	type)
 		__field(sector_t,	sector)
 		__field(unsigned int,	size)
 	),
 
 	TP_fast_assign(
 		__entry->dev		= sb->s_dev;
-		__entry->btype		= btype;
-		__entry->sync		= sync;
+		__entry->rw		= rw;
+		__entry->type		= type;
 		__entry->sector		= bio->bi_sector;
 		__entry->size		= bio->bi_size;
 	),
 
-	TP_printk("dev = (%d,%d), type = %s, io = %s, sector = %lld, size = %
u",
+	TP_printk("dev = (%d,%d), %s, %s, sector = %lld, size = %u",
 		show_dev(__entry),
-		show_block_type(__entry->btype),
-		__entry->sync ? "sync" : "no sync",
+		show_bio_type(__entry->rw),
+		show_block_type(__entry->type),
 		(unsigned long long)__entry->sector,
 		__entry->size)
 );
 
+DEFINE_EVENT(f2fs__submit_bio, f2fs_submit_write_bio,
+
+	TP_PROTO(struct super_block *sb, int rw, int type, struct bio *bio),
+
+	TP_ARGS(sb, rw, type, bio)
+);
+
+DEFINE_EVENT(f2fs__submit_bio, f2fs_submit_read_bio,
+
+	TP_PROTO(struct super_block *sb, int rw, int type, struct bio *bio),
+
+	TP_ARGS(sb, rw, type, bio)
+);
+
 DECLARE_EVENT_CLASS(f2fs__page,
 
 	TP_PROTO(struct page *page, int type),
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
