From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: clean up bio cache trace
Date: Sat,  6 Aug 2016 21:09:40 +0800
Message-ID: <1470488981-2469-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bW1OQ-00015e-I2
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Aug 2016 13:11:58 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bW1OO-00080Z-9C
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Aug 2016 13:11:58 +0000
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

Trace info related to bio cache operation is out of format, clean up it.

Before:
       <...>-28308 [002] ....  4781.052703: f2fs_submit_write_bio: dev = (251,1), WRITEWRITE_SYNC ^H, DATA, sector = 271424, size = 126976
       <...>-28308 [002] ....  4781.052820: f2fs_submit_page_mbio: dev = (251,1), ino = 103, page_index = 0x1f, oldaddr = 0xffffffff, newaddr = 0x84a7 rw = WRITEWRITE_SYNCi ^H, type = DATA
kworker/u8:2-29988 [001] ....  5549.293877: f2fs_submit_page_mbio: dev = (251,1), ino = 91, page_index = 0xd, oldaddr = 0xffffffff, newaddr = 0x782f rw = WRITE0x0i ^H type = DATA

After:
kworker/u8:2-8678  [000] ....  7945.124459: f2fs_submit_write_bio: dev = (251,1), rw = WRITE_SYNC, DATA, sector = 74080, size = 53248
kworker/u8:2-8678  [000] ....  7945.124551: f2fs_submit_page_mbio: dev = (251,1), ino = 11, page_index = 0xec, oldaddr = 0xffffffff, newaddr = 0x243a, rw = WRITE, type = DATA

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 include/trace/events/f2fs.h | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index ff95fd0..903a091 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -58,16 +58,12 @@ TRACE_DEFINE_ENUM(CP_DISCARD);
 #define F2FS_BIO_FLAG_MASK(t)	(t & (REQ_RAHEAD | WRITE_FLUSH_FUA))
 #define F2FS_BIO_EXTRA_MASK(t)	(t & (REQ_META | REQ_PRIO))
 
-#define show_bio_type(op, op_flags) show_bio_op(op),			\
-			show_bio_op_flags(op_flags), show_bio_extra(op_flags)
-
-#define show_bio_op(op)							\
-	__print_symbolic(op,						\
-		{ READ, 		"READ" },			\
-		{ WRITE,		"WRITE" })
+#define show_bio_type(op_flags)	show_bio_op_flags(op_flags), 		\
+						show_bio_extra(op_flags)
 
 #define show_bio_op_flags(flags)					\
 	__print_symbolic(F2FS_BIO_FLAG_MASK(flags),			\
+		{ 0,			"WRITE" },			\
 		{ REQ_RAHEAD, 		"READAHEAD" },			\
 		{ READ_SYNC, 		"READ_SYNC" },			\
 		{ WRITE_SYNC, 		"WRITE_SYNC" },			\
@@ -754,12 +750,12 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, page_index = 0x%lx, "
-		"oldaddr = 0x%llx, newaddr = 0x%llx rw = %s%si%s, type = %s",
+		"oldaddr = 0x%llx, newaddr = 0x%llx, rw = %s%s, type = %s",
 		show_dev_ino(__entry),
 		(unsigned long)__entry->index,
 		(unsigned long long)__entry->old_blkaddr,
 		(unsigned long long)__entry->new_blkaddr,
-		show_bio_type(__entry->op, __entry->op_flags),
+		show_bio_type(__entry->op_flags),
 		show_block_type(__entry->type))
 );
 
@@ -806,9 +802,9 @@ DECLARE_EVENT_CLASS(f2fs__submit_bio,
 		__entry->size		= bio->bi_iter.bi_size;
 	),
 
-	TP_printk("dev = (%d,%d), %s%s%s, %s, sector = %lld, size = %u",
+	TP_printk("dev = (%d,%d), rw = %s%s, %s, sector = %lld, size = %u",
 		show_dev(__entry),
-		show_bio_type(__entry->op, __entry->op_flags),
+		show_bio_type(__entry->op_flags),
 		show_block_type(__entry->type),
 		(unsigned long long)__entry->sector,
 		__entry->size)
-- 
2.7.2


------------------------------------------------------------------------------
