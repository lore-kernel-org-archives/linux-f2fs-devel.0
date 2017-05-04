From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 3/3] f2fs: enhance scalability of trace macro
Date: Thu, 4 May 2017 09:35:43 +0800
Message-ID: <20170504013543.83865-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d65gi-0001uU-QC
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 May 2017 01:36:12 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d65gg-00038Y-Sh
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 May 2017 01:36:12 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Use __print_flags in show_bio_op_flags and show_cpreason instead of
__print_symbolic, it enables tracer function traverses and shows all
bits in the flag.

Additionally, add missing REQ_FUA into F2FS_OP_FLAGS.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
 update patch as Jaegeuk's suggestion.
 - remove useless entry in show_bio_op_flags.
 - use "%s(%s)" format to show op & op_flags.
 include/trace/events/f2fs.h | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index c78a223a0d9c..15da88c5c3a4 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -59,8 +59,8 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
 		{ IPU,		"IN-PLACE" },				\
 		{ OPU,		"OUT-OF-PLACE" })
 
-#define F2FS_OP_FLAGS (REQ_RAHEAD | REQ_SYNC | REQ_PREFLUSH | REQ_META |\
-			REQ_PRIO)
+#define F2FS_OP_FLAGS (REQ_RAHEAD | REQ_SYNC | REQ_META | REQ_PRIO |	\
+			REQ_PREFLUSH | REQ_FUA)
 #define F2FS_BIO_FLAG_MASK(t)	(t & F2FS_OP_FLAGS)
 
 #define show_bio_type(op,op_flags)	show_bio_op(op),		\
@@ -79,16 +79,13 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
 		{ REQ_OP_WRITE_ZEROES,		"WRITE_ZEROES" })
 
 #define show_bio_op_flags(flags)					\
-	__print_symbolic(F2FS_BIO_FLAG_MASK(flags),			\
-		{ REQ_RAHEAD, 		"(RA)" },			\
-		{ REQ_SYNC, 		"(S)" },			\
-		{ REQ_SYNC | REQ_PRIO,	"(SP)" },			\
-		{ REQ_META, 		"(M)" },			\
-		{ REQ_META | REQ_PRIO,	"(MP)" },			\
-		{ REQ_SYNC | REQ_PREFLUSH , "(SF)" },			\
-		{ REQ_SYNC | REQ_META | REQ_PRIO, "(SMP)" },		\
-		{ REQ_PREFLUSH | REQ_META | REQ_PRIO, "(FMP)" },	\
-		{ 0, " \b" })
+	__print_flags(F2FS_BIO_FLAG_MASK(flags), "|",			\
+		{ REQ_RAHEAD,		"R" },				\
+		{ REQ_SYNC,		"S" },				\
+		{ REQ_META,		"M" },				\
+		{ REQ_PRIO,		"P" },				\
+		{ REQ_PREFLUSH,		"PF" },				\
+		{ REQ_FUA,		"FUA" })
 
 #define show_data_type(type)						\
 	__print_symbolic(type,						\
@@ -121,13 +118,14 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
 		{ GC_CB,	"Cost-Benefit" })
 
 #define show_cpreason(type)						\
-	__print_symbolic(type,						\
+	__print_flags(type, "|",					\
 		{ CP_UMOUNT,	"Umount" },				\
 		{ CP_FASTBOOT,	"Fastboot" },				\
 		{ CP_SYNC,	"Sync" },				\
 		{ CP_RECOVERY,	"Recovery" },				\
 		{ CP_DISCARD,	"Discard" },				\
-		{ CP_UMOUNT | CP_TRIMMED,	"Umount,Trimmed" })
+		{ CP_UMOUNT,	"Umount" },				\
+		{ CP_TRIMMED,	"Trimmed" })
 
 struct victim_sel_policy;
 struct f2fs_map_blocks;
@@ -774,7 +772,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, page_index = 0x%lx, "
-		"oldaddr = 0x%llx, newaddr = 0x%llx, rw = %s%s, type = %s",
+		"oldaddr = 0x%llx, newaddr = 0x%llx, rw = %s(%s), type = %s",
 		show_dev_ino(__entry),
 		(unsigned long)__entry->index,
 		(unsigned long long)__entry->old_blkaddr,
@@ -827,7 +825,7 @@ DECLARE_EVENT_CLASS(f2fs__bio,
 		__entry->size		= bio->bi_iter.bi_size;
 	),
 
-	TP_printk("dev = (%d,%d)/(%d,%d), rw = %s%s, %s, sector = %lld, size = %u",
+	TP_printk("dev = (%d,%d)/(%d,%d), rw = %s(%s), %s, sector = %lld, size = %u",
 		show_dev(__entry->target),
 		show_dev(__entry->dev),
 		show_bio_type(__entry->op, __entry->op_flags),
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
