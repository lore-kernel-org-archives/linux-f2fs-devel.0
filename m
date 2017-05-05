From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 1/3] f2fs: do get_dnode_of_data before
	f2fs_lock_op
Date: Fri, 5 May 2017 09:12:27 +0000
Message-ID: <20170505091229.156181-2-houpengyang@huawei.com>
References: <20170505091229.156181-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1d6ZIE-0003nO-8B
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 May 2017 09:12:54 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d6ZIC-0002oC-Al
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 May 2017 09:12:54 +0000
In-Reply-To: <20170505091229.156181-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Currently, if we do get_node_of_data before f2fs_lock_op, there may be dead lock
as follows, where process A would be in infinite loop, and B will NOT be awaked.

Process A(cp):            Process B:
f2fs_lock_all(sbi)
                        get_dnode_of_data <---- lock dn.node_page
flush_nodes             f2fs_lock_op

However, in do_write_data_page path, we had better do get_node_of_data first, since
we can check IPU in prior and do IPU without f2fs_lock_op. It make senses for our 
current FSYNC IPU to avoid being blocked by cp. 

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/data.c | 38 +++++++++++++++++++++++++++-----------
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/node.c |  1 +
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1254986..075d159 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1373,20 +1373,37 @@ int do_write_data_page(struct f2fs_io_info *fio)
 		}
 	}
 
-	if (fio->need_lock)
-		f2fs_lock_op(fio->sbi);
-
 	err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
-	if (err)
-		goto out;
+	if (!err) {
+		fio->old_blkaddr  = dn.data_blkaddr;
+		/* This page is already truncated */
+		if (fio->old_blkaddr == NULL_ADDR) {
+			ClearPageUptodate(page);
+			goto out_writepage;
+		}
+		unlock_page(dn.node_page);
+		dn.node_page_locked = false;
+	} else
+		return err;
 
-	fio->old_blkaddr = dn.data_blkaddr;
+	if (fio->need_lock)
+		f2fs_lock_op(fio->sbi);
 
-	/* This page is already truncated */
-	if (fio->old_blkaddr == NULL_ADDR) {
-		ClearPageUptodate(page);
-		goto out_writepage;
+	if (!dn.node_page_locked) {
+		/*
+		 * It is safe to lock_page here, since we've hold
+		 * reference of this page, but there may be conflict
+		 * with trucate/fallocate(FL_ZERO_RANGE/PUNCH_HOLE)
+		 * so after lock_page, we check dn->old_addr if is
+		 * NULL_ADDR.
+		 */
+		lock_page(dn.node_page);
+		fio->old_blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
+		if (fio->old_blkaddr == NULL_ADDR) {
+			goto out_writepage;
+		}
 	}
+
 got_it:
 	err = encrypt_one_page(fio);
 	if (err)
@@ -1416,7 +1433,6 @@ int do_write_data_page(struct f2fs_io_info *fio)
 		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 out_writepage:
 	f2fs_put_dnode(&dn);
-out:
 	if (fio->need_lock)
 		f2fs_unlock_op(fio->sbi);
 	return err;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index baefe37..2d50d7b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -651,6 +651,7 @@ struct dnode_of_data {
 	nid_t nid;			/* node id of the direct node block */
 	unsigned int ofs_in_node;	/* data offset in the node page */
 	bool inode_page_locked;		/* inode page is locked or not */
+	bool node_page_locked;		/* dnode page is locked or not */
 	bool node_changed;		/* is node block changed */
 	char cur_level;			/* level of hole node page */
 	char max_level;			/* level of current page located */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 98351a4..7cc6114 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -650,6 +650,7 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	dn->ofs_in_node = offset[level];
 	dn->node_page = npage[level];
 	dn->data_blkaddr = datablock_addr(dn->node_page, dn->ofs_in_node);
+	dn->node_page_locked = true;
 	return 0;
 
 release_pages:
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
