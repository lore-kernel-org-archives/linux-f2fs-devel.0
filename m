From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: trace in batches extent info update
Date: Sun, 06 Sep 2015 17:50:13 +0800
Message-ID: <009601d0e889$8f6db680$ae492380$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZYWbY-0006zO-Gl
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 06 Sep 2015 09:51:20 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZYWbW-0007fw-BF
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 06 Sep 2015 09:51:20 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NU902BAS218FFA0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sun, 06 Sep 2015 18:51:10 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Rename trace_f2fs_update_extent_tree to trace_f2fs_update_extent_tree_range,
then expand and enable it to trace in batches extent info updates.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/extent_cache.c      |  2 ++
 include/trace/events/f2fs.h | 15 ++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 00b2b3f..0227260 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -409,6 +409,8 @@ unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 	if (!et)
 		return false;
 
+	trace_f2fs_update_extent_tree_range(inode, fofs, blkaddr, len);
+
 	write_lock(&et->lock);
 
 	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT)) {
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index a019465..6aa63d9 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1132,17 +1132,19 @@ TRACE_EVENT_CONDITION(f2fs_lookup_extent_tree_end,
 		__entry->len)
 );
 
-TRACE_EVENT(f2fs_update_extent_tree,
+TRACE_EVENT(f2fs_update_extent_tree_range,
 
-	TP_PROTO(struct inode *inode, unsigned int pgofs, block_t blkaddr),
+	TP_PROTO(struct inode *inode, unsigned int pgofs, block_t blkaddr,
+						unsigned int len),
 
-	TP_ARGS(inode, pgofs, blkaddr),
+	TP_ARGS(inode, pgofs, blkaddr, len),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
 		__field(unsigned int, pgofs)
 		__field(u32, blk)
+		__field(unsigned int, len)
 	),
 
 	TP_fast_assign(
@@ -1150,12 +1152,15 @@ TRACE_EVENT(f2fs_update_extent_tree,
 		__entry->ino = inode->i_ino;
 		__entry->pgofs = pgofs;
 		__entry->blk = blkaddr;
+		__entry->len = len;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, blkaddr = %u",
+	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, "
+					"blkaddr = %u, len = %u",
 		show_dev_ino(__entry),
 		__entry->pgofs,
-		__entry->blk)
+		__entry->blk,
+		__entry->len)
 );
 
 TRACE_EVENT(f2fs_shrink_extent_tree,
-- 
2.4.2



------------------------------------------------------------------------------
