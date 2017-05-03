From: Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs: enhance scalability of trace macro
Date: Wed,  3 May 2017 23:59:14 +0800
Message-ID: <20170503155914.6859-3-chao@kernel.org>
References: <20170503155914.6859-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1d5wim-0007hy-Jf
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 May 2017 16:01:44 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d5wii-0005Xz-J0
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 May 2017 16:01:44 +0000
In-Reply-To: <20170503155914.6859-1-chao@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Use __print_flags in show_bio_op_flags and show_cpreason instead of
__print_symbolic, it enables tracer function traverses and shows all
bits in the flag.

Additionally, add missing REQ_FUA into F2FS_OP_FLAGS.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 include/trace/events/f2fs.h | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index c78a223a0d9c..ad4cbeeeef44 100644
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
@@ -79,15 +79,13 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
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
+	__print_flags(F2FS_BIO_FLAG_MASK(flags), "|",			\
+		{ REQ_RAHEAD,		"R" },				\
+		{ REQ_SYNC,		"S" },				\
+		{ REQ_META,		"M" },				\
+		{ REQ_PRIO,		"P" },				\
+		{ REQ_PREFLUSH,		"PF" },				\
+		{ REQ_FUA,		"FUA" },			\
 		{ 0, " \b" })
 
 #define show_data_type(type)						\
@@ -121,13 +119,14 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
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
@@ -774,7 +773,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, page_index = 0x%lx, "
-		"oldaddr = 0x%llx, newaddr = 0x%llx, rw = %s%s, type = %s",
+		"oldaddr = 0x%llx, newaddr = 0x%llx, rw = %s,%s, type = %s",
 		show_dev_ino(__entry),
 		(unsigned long)__entry->index,
 		(unsigned long long)__entry->old_blkaddr,
@@ -827,7 +826,7 @@ DECLARE_EVENT_CLASS(f2fs__bio,
 		__entry->size		= bio->bi_iter.bi_size;
 	),
 
-	TP_printk("dev = (%d,%d)/(%d,%d), rw = %s%s, %s, sector = %lld, size = %u",
+	TP_printk("dev = (%d,%d)/(%d,%d), rw = %s,%s, %s, sector = %lld, size = %u",
 		show_dev(__entry->target),
 		show_dev(__entry->dev),
 		show_bio_type(__entry->op, __entry->op_flags),
-- 
2.12.2.575.gb14f27f


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
