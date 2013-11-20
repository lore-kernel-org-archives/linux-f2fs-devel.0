From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH 2/2] f2fs: adds a tracepoint for f2fs_submit_read_bio
Date: Wed, 20 Nov 2013 16:41:17 +0800
Message-ID: <001f01cee5cc$5d297450$177c5cf0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?gb2312?B?zLfmrQ==?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds a tracepoint for f2fs_submit_read_bio.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c              |    2 ++
 include/trace/events/f2fs.h |   27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0ca93be..c9e9d79 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -407,6 +407,8 @@ void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, int rw)
 	if (!io->bio)
 		return;
 
+	trace_f2fs_submit_read_bio(sbi->sb, rw, io->bio);
+
 	mutex_lock(&io->io_mutex);
 	if (io->bio) {
 		submit_bio(rw, io->bio);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 571f39a..ac970e3 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -453,6 +453,33 @@ TRACE_EVENT_CONDITION(f2fs_readpage,
 		show_bio_type(__entry->type))
 );
 
+TRACE_EVENT(f2fs_submit_read_bio,
+
+	TP_PROTO(struct super_block *sb, int rw, struct bio *bio),
+
+	TP_ARGS(sb, rw, bio),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(int,	rw)
+		__field(sector_t,	sector)
+		__field(unsigned int,	size)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= sb->s_dev;
+		__entry->rw		= rw;
+		__entry->sector		= bio->bi_sector;
+		__entry->size		= bio->bi_size;
+	),
+
+	TP_printk("dev = (%d,%d), bio_type = %s, sector = %lld, size = %u",
+		show_dev(__entry),
+		show_bio_type(__entry->rw),
+		(unsigned long long)__entry->sector,
+		__entry->size)
+);
+
 TRACE_EVENT(f2fs_submit_read_page,
 
 	TP_PROTO(struct page *page, block_t blk_addr, int rw),
-- 
1.7.9.5


