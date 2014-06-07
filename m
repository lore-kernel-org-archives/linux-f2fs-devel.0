From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: fix to recover data written by dio
Date: Sun,  8 Jun 2014 01:44:30 +0900
Message-ID: <1402159472-61137-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1WtJjr-0003WZ-Dl
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jun 2014 16:45:03 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WtJjq-0004Lf-Ak for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jun 2014 16:45:03 +0000
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

If data are overwritten through dio, previous f2fs doesn't remain the fsync mark
due to no additional node writes.

Note that this patch should resolve the xfstests:311.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c |  3 +++
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/node.c | 12 ++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8c250a5..39fe7d7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1041,6 +1041,9 @@ static ssize_t f2fs_direct_IO(int rw, struct kiocb *iocb,
 	if (check_direct_IO(inode, rw, iov, offset, nr_segs))
 		return 0;
 
+	/* clear fsync mark to recover these blocks */
+	fsync_mark_clear(F2FS_SB(inode->i_sb), inode->i_ino);
+
 	return blockdev_direct_IO(rw, iocb, inode, iov, offset, nr_segs,
 							get_data_block);
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9684b1f..f628c3c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1168,6 +1168,7 @@ struct node_info;
 bool available_free_memory(struct f2fs_sb_info *, int);
 int is_checkpointed_node(struct f2fs_sb_info *, nid_t);
 bool fsync_mark_done(struct f2fs_sb_info *, nid_t);
+void fsync_mark_clear(struct f2fs_sb_info *, nid_t);
 void get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
 int get_dnode_of_data(struct dnode_of_data *, pgoff_t, int);
 int truncate_inode_blocks(struct inode *, pgoff_t);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 02a59e9..a0a1f25 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -153,6 +153,18 @@ bool fsync_mark_done(struct f2fs_sb_info *sbi, nid_t nid)
 	return fsync_done;
 }
 
+void fsync_mark_clear(struct f2fs_sb_info *sbi, nid_t nid)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	struct nat_entry *e;
+
+	write_lock(&nm_i->nat_tree_lock);
+	e = __lookup_nat_cache(nm_i, nid);
+	if (e)
+		e->fsync_done = false;
+	write_unlock(&nm_i->nat_tree_lock);
+}
+
 static struct nat_entry *grab_nat_entry(struct f2fs_nm_info *nm_i, nid_t nid)
 {
 	struct nat_entry *new;
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
