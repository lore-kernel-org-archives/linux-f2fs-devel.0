From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 03/10] f2fs: add submit_bio tracepoint
Date: Fri, 30 Dec 2016 10:51:10 -0800
Message-ID: <20161230185117.3832-3-jaegeuk@kernel.org>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cN2H3-00036Z-Lk
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Dec 2016 18:51:29 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cN2H2-0006e4-TN
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Dec 2016 18:51:29 +0000
In-Reply-To: <20161230185117.3832-1-jaegeuk@kernel.org>
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

This patch adds final submit_bio() tracepoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c              |  1 +
 include/trace/events/f2fs.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2c5df1dc1479..54da4e2f1318 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -175,6 +175,7 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 			current->plug && (type == DATA || type == NODE))
 			blk_finish_plug(current->plug);
 	}
+	trace_f2fs_submit_bio(sbi->sb, bio);
 	submit_bio(bio);
 }
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 4c942599581b..094d92b52450 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -55,6 +55,8 @@ TRACE_DEFINE_ENUM(CP_DISCARD);
 		{ IPU,		"IN-PLACE" },				\
 		{ OPU,		"OUT-OF-PLACE" })
 
+#define F2FS_OP	(REQ_OP_READ | REQ_OP_RAHEAD | REQ_SYNC | REQ_PREFLUSH | REQ_META |\
+			REQ_PRIO)
 #define F2FS_OP_FLAGS (REQ_RAHEAD | REQ_SYNC | REQ_PREFLUSH | REQ_META |\
 			REQ_PRIO)
 #define F2FS_BIO_FLAG_MASK(t)	(t & F2FS_OP_FLAGS)
@@ -837,6 +839,35 @@ DEFINE_EVENT_CONDITION(f2fs__submit_bio, f2fs_submit_read_bio,
 	TP_CONDITION(bio)
 );
 
+TRACE_EVENT(f2fs_submit_bio,
+
+	TP_PROTO(struct super_block *sb, struct bio *bio),
+
+	TP_ARGS(sb, bio),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(int,	op)
+		__field(int,	op_flags)
+		__field(sector_t,	sector)
+		__field(unsigned int,	size)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= sb->s_dev;
+		__entry->op		= bio->bi_opf & REQ_OP_MASK;
+		__entry->op_flags	= bio->bi_opf;
+		__entry->sector		= bio->bi_iter.bi_sector;
+		__entry->size		= bio->bi_iter.bi_size;
+	),
+
+	TP_printk("dev = (%d,%d), rw = %s%s, sector = %lld, size = %u",
+		show_dev(__entry),
+		show_bio_type(__entry->op, __entry->op_flags),
+		(unsigned long long)__entry->sector,
+		__entry->size)
+);
+
 TRACE_EVENT(f2fs_write_begin,
 
 	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len,
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
