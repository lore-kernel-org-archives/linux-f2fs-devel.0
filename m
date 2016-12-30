From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 02/10] f2fs: fix wrong tracepoints for op and op_flags
Date: Fri, 30 Dec 2016 10:51:09 -0800
Message-ID: <20161230185117.3832-2-jaegeuk@kernel.org>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161230185117.3832-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes wrong tracepoints in terms of op and op_flags.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/trace/events/f2fs.h | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 01b3c9869a0d..4c942599581b 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -55,25 +55,34 @@ TRACE_DEFINE_ENUM(CP_DISCARD);
 		{ IPU,		"IN-PLACE" },				\
 		{ OPU,		"OUT-OF-PLACE" })
 
-#define F2FS_BIO_FLAG_MASK(t)	(t & (REQ_RAHEAD | REQ_PREFLUSH | REQ_FUA))
-#define F2FS_BIO_EXTRA_MASK(t)	(t & (REQ_META | REQ_PRIO))
-
-#define show_bio_type(op_flags)	show_bio_op_flags(op_flags), 		\
-						show_bio_extra(op_flags)
+#define F2FS_OP_FLAGS (REQ_RAHEAD | REQ_SYNC | REQ_PREFLUSH | REQ_META |\
+			REQ_PRIO)
+#define F2FS_BIO_FLAG_MASK(t)	(t & F2FS_OP_FLAGS)
+
+#define show_bio_type(op,op_flags)	show_bio_op(op),		\
+						show_bio_op_flags(op_flags)
+
+#define show_bio_op(op)							\
+	__print_symbolic(op,						\
+		{ REQ_OP_READ,			"READ" },		\
+		{ REQ_OP_WRITE,			"WRITE" },		\
+		{ REQ_OP_FLUSH,			"FLUSH" },		\
+		{ REQ_OP_DISCARD,		"DISCARD" },		\
+		{ REQ_OP_ZONE_REPORT,		"ZONE_REPORT" },	\
+		{ REQ_OP_SECURE_ERASE,		"SECURE_ERASE" },	\
+		{ REQ_OP_ZONE_RESET,		"ZONE_RESET" },		\
+		{ REQ_OP_WRITE_SAME,		"WRITE_SAME" },		\
+		{ REQ_OP_WRITE_ZEROES,		"WRITE_ZEROES" })
 
 #define show_bio_op_flags(flags)					\
 	__print_symbolic(F2FS_BIO_FLAG_MASK(flags),			\
-		{ 0,			"WRITE" },			\
-		{ REQ_RAHEAD, 		"READAHEAD" },			\
-		{ REQ_SYNC, 		"REQ_SYNC" },			\
-		{ REQ_PREFLUSH,		"REQ_PREFLUSH" },		\
-		{ REQ_FUA,		"REQ_FUA" })
-
-#define show_bio_extra(type)						\
-	__print_symbolic(F2FS_BIO_EXTRA_MASK(type),			\
+		{ REQ_RAHEAD, 		"(RA)" },			\
+		{ REQ_SYNC, 		"(S)" },			\
+		{ REQ_SYNC | REQ_PRIO,	"(SP)" },			\
 		{ REQ_META, 		"(M)" },			\
-		{ REQ_PRIO, 		"(P)" },			\
 		{ REQ_META | REQ_PRIO,	"(MP)" },			\
+		{ REQ_SYNC | REQ_META | REQ_PRIO, "(SMP)" },		\
+		{ REQ_PREFLUSH | REQ_META | REQ_PRIO, "(FMP)" },	\
 		{ 0, " \b" })
 
 #define show_data_type(type)						\
@@ -753,7 +762,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 		(unsigned long)__entry->index,
 		(unsigned long long)__entry->old_blkaddr,
 		(unsigned long long)__entry->new_blkaddr,
-		show_bio_type(__entry->op_flags),
+		show_bio_type(__entry->op, __entry->op_flags),
 		show_block_type(__entry->type))
 );
 
@@ -802,7 +811,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_bio,
 
 	TP_printk("dev = (%d,%d), rw = %s%s, %s, sector = %lld, size = %u",
 		show_dev(__entry),
-		show_bio_type(__entry->op_flags),
+		show_bio_type(__entry->op, __entry->op_flags),
 		show_block_type(__entry->type),
 		(unsigned long long)__entry->sector,
 		__entry->size)
-- 
2.11.0
