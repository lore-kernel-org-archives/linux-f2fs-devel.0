From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: avoid out-of-order execution of atomic
	writes
Date: Fri,  3 Feb 2017 15:48:16 -0800
Message-ID: <20170203234816.12723-5-jaegeuk@kernel.org>
References: <20170203234816.12723-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cZnal-0004EK-6Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Feb 2017 23:48:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cZnak-0003rO-Ba
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Feb 2017 23:48:35 +0000
In-Reply-To: <20170203234816.12723-1-jaegeuk@kernel.org>
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

We need to flush data writes before flushing last node block writes by using
FUA with PREFLUSH. We don't need to guarantee precedent node writes since if
those are not written, we can't reach to the last node block when scanning
node block chain during roll-forward recovery.
Afterwards f2fs_wait_on_page_writeback guarantees all the IO submission to
disk, which builds a valid node block chain.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c              |  3 ++-
 fs/f2fs/node.c              | 10 +++++++---
 include/trace/events/f2fs.h |  1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9c0f469cde13..a3808c49e326 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -278,7 +278,8 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 flush_out:
 	remove_ino_entry(sbi, ino, UPDATE_INO);
 	clear_inode_flag(inode, FI_UPDATE_WRITE);
-	ret = f2fs_issue_flush(sbi);
+	if (!atomic)
+		ret = f2fs_issue_flush(sbi);
 	f2fs_update_time(sbi, REQ_TIME);
 out:
 	trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f30cf1dec9a8..135a0233a201 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1318,7 +1318,7 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 	return last_page;
 }
 
-static int __write_node_page(struct page *page,
+static int __write_node_page(struct page *page, bool atomic,
 				struct writeback_control *wbc)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
@@ -1362,6 +1362,9 @@ static int __write_node_page(struct page *page,
 		return 0;
 	}
 
+	if (atomic)
+		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
+
 	set_page_writeback(page);
 	fio.old_blkaddr = ni.blk_addr;
 	write_node_page(nid, &fio);
@@ -1388,7 +1391,7 @@ static int __write_node_page(struct page *page,
 static int f2fs_write_node_page(struct page *page,
 				struct writeback_control *wbc)
 {
-	return __write_node_page(page, wbc);
+	return __write_node_page(page, false, wbc);
 }
 
 int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
@@ -1470,7 +1473,8 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
-			ret = __write_node_page(page, wbc);
+			ret = __write_node_page(page, atomic &&
+						page == last_page, wbc);
 			if (ret) {
 				unlock_page(page);
 				f2fs_put_page(last_page, 0);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 04c527410ecc..82236792b50c 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -81,6 +81,7 @@ TRACE_DEFINE_ENUM(CP_DISCARD);
 		{ REQ_SYNC | REQ_PRIO,	"(SP)" },			\
 		{ REQ_META, 		"(M)" },			\
 		{ REQ_META | REQ_PRIO,	"(MP)" },			\
+		{ REQ_SYNC | REQ_PREFLUSH , "(SF)" },			\
 		{ REQ_SYNC | REQ_META | REQ_PRIO, "(SMP)" },		\
 		{ REQ_PREFLUSH | REQ_META | REQ_PRIO, "(FMP)" },	\
 		{ 0, " \b" })
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
