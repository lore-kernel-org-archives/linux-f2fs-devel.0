From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: support revoking atomic written pages
Date: Tue, 29 Dec 2015 11:12:36 +0800
Message-ID: <00a901d141e6$e42ec950$ac8c5bf0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aDkjE-0001el-1a
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Dec 2015 03:13:40 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aDkjB-0003up-HV
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Dec 2015 03:13:40 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0300MVMNM9DQ10@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Dec 2015 12:13:29 +0900 (KST)
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

f2fs support atomic write with following semantics:
1. open db file
2. ioctl start atomic write
3. (write db file) * n
4. ioctl commit atomic write
5. close db file

With this flow we can avoid file becoming corrupted when abnormal power
cut, because we hold data of transaction in referenced pages linked in
inmem_pages list of inode, but without setting them dirty, so these data
won't be persisted unless we commit them in step 4.

But we should still hold journal db file in memory by using volatile write,
because our semantics of 'atomic write support' is not full, in step 4, we
could be fail to submit all dirty data of transaction, once partial dirty
data was committed in storage, db file should be corrupted, in this case,
we should use journal db to recover the original data in db file.

So this patch tries to improve atomic write flow, it adds a flow to support
revoking these partial submitted data of transaction when inner error
occurs. after this patch journal db file could be deprecated to reduce
memory footprint.

If revoking is failed, EAGAIN will be reported to user for sugguesting
retrying current transaction.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c              |   1 +
 fs/f2fs/f2fs.h              |   4 +-
 fs/f2fs/file.c              |   2 +-
 fs/f2fs/recovery.c          |   2 +-
 fs/f2fs/segment.c           | 116 +++++++++++++++++++++++++++++++-------------
 fs/f2fs/segment.h           |   1 +
 include/trace/events/f2fs.h |   1 +
 7 files changed, 90 insertions(+), 37 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d506a0e..7175d33 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1052,6 +1052,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 		return err;
 
 	fio->blk_addr = dn.data_blkaddr;
+	fio->old_blkaddr = dn.data_blkaddr;
 
 	/* This page is already truncated */
 	if (fio->blk_addr == NULL_ADDR) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7fbfee9..9ba6a09 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -679,6 +679,7 @@ enum page_type {
 	META_FLUSH,
 	INMEM,		/* the below types are used by tracepoints only. */
 	INMEM_DROP,
+	INMEM_REVOKE,
 	IPU,
 	OPU,
 };
@@ -688,6 +689,7 @@ struct f2fs_io_info {
 	enum page_type type;	/* contains DATA/NODE/META/META_FLUSH */
 	int rw;			/* contains R/RS/W/WS with REQ_META/REQ_PRIO */
 	block_t blk_addr;	/* block address to be written */
+	block_t old_blkaddr;	/* old block address before Cow */
 	struct page *page;	/* page to be written */
 	struct page *encrypted_page;	/* encrypted page */
 };
@@ -1804,7 +1806,7 @@ void write_node_page(unsigned int, struct f2fs_io_info *);
 void write_data_page(struct dnode_of_data *, struct f2fs_io_info *);
 void rewrite_data_page(struct f2fs_io_info *);
 void f2fs_replace_block(struct f2fs_sb_info *, struct dnode_of_data *,
-				block_t, block_t, unsigned char, bool);
+				block_t, block_t, unsigned char, bool, bool);
 void allocate_data_block(struct f2fs_sb_info *, struct page *,
 		block_t, block_t *, struct f2fs_summary *, int);
 void f2fs_wait_on_page_writeback(struct page *, enum page_type);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cfe7f13..91d5abd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -885,7 +885,7 @@ static int __exchange_data_block(struct inode *inode, pgoff_t src,
 
 		get_node_info(sbi, dn.nid, &ni);
 		f2fs_replace_block(sbi, &dn, dn.data_blkaddr, new_addr,
-				ni.version, true);
+				ni.version, true, false);
 		f2fs_put_dnode(&dn);
 	} else {
 		struct page *psrc, *pdst;
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 589b20b..581544d 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -467,7 +467,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			/* write dummy data page */
 			f2fs_replace_block(sbi, &dn, src, dest,
-							ni.version, false);
+						ni.version, false, false);
 			recovered++;
 		}
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 733f876..2145741f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -191,24 +191,48 @@ void register_inmem_page(struct inode *inode, struct page *page)
 	trace_f2fs_register_inmem_page(page, INMEM);
 }
 
-static void __revoke_inmem_pages(struct inode *inode,
-							struct list_head *head)
+static int __revoke_inmem_pages(struct inode *inode,
+				struct list_head *head, bool drop, bool recover)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct inmem_pages *cur, *tmp;
+	int err = 0;
 
 	list_for_each_entry_safe(cur, tmp, head, list) {
-		trace_f2fs_commit_inmem_page(cur->page, INMEM_DROP);
+		struct page *page = cur->page;
+
+		if (drop)
+			trace_f2fs_commit_inmem_page(page, INMEM_DROP);
+
+		lock_page(page);
 
-		lock_page(cur->page);
-		ClearPageUptodate(cur->page);
-		set_page_private(cur->page, 0);
-		ClearPagePrivate(cur->page);
-		f2fs_put_page(cur->page, 1);
+		if (recover) {
+			struct dnode_of_data dn;
+			struct node_info ni;
+
+			trace_f2fs_commit_inmem_page(page, INMEM_REVOKE);
+
+			set_new_dnode(&dn, inode, NULL, NULL, 0);
+			if (get_dnode_of_data(&dn, page->index, LOOKUP_NODE)) {
+				err = -EAGAIN;
+				goto next;
+			}
+			get_node_info(sbi, dn.nid, &ni);
+			f2fs_replace_block(sbi, &dn, dn.data_blkaddr,
+					cur->old_addr, ni.version, true, true);
+			f2fs_put_dnode(&dn);
+		}
+next:
+		ClearPageUptodate(page);
+		set_page_private(page, 0);
+		ClearPageUptodate(page);
+		f2fs_put_page(page, 1);
 
 		list_del(&cur->list);
 		kmem_cache_free(inmem_entry_slab, cur);
 		dec_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
 	}
+	return err;
 }
 
 void drop_inmem_pages(struct inode *inode)
@@ -216,11 +240,12 @@ void drop_inmem_pages(struct inode *inode)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
 	mutex_lock(&fi->inmem_lock);
-	__revoke_inmem_pages(inode, &fi->inmem_pages);
+	__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
 	mutex_unlock(&fi->inmem_lock);
 }
 
-static int __commit_inmem_pages(struct inode *inode)
+static int __commit_inmem_pages(struct inode *inode,
+					struct list_head *revoke_list)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -235,34 +260,39 @@ static int __commit_inmem_pages(struct inode *inode)
 	int err = 0;
 
 	list_for_each_entry_safe(cur, tmp, &fi->inmem_pages, list) {
-		lock_page(cur->page);
-		if (cur->page->mapping == inode->i_mapping) {
-			set_page_dirty(cur->page);
-			f2fs_wait_on_page_writeback(cur->page, DATA);
-			if (clear_page_dirty_for_io(cur->page))
+		struct page *page = cur->page;
+
+		lock_page(page);
+		if (page->mapping == inode->i_mapping) {
+			trace_f2fs_commit_inmem_page(page, INMEM);
+
+			set_page_dirty(page);
+			f2fs_wait_on_page_writeback(page, DATA);
+			if (clear_page_dirty_for_io(page))
 				inode_dec_dirty_pages(inode);
-			trace_f2fs_commit_inmem_page(cur->page, INMEM);
-			fio.page = cur->page;
+
+			fio.page = page;
 			err = do_write_data_page(&fio);
 			if (err) {
-				unlock_page(cur->page);
+				unlock_page(page);
 				break;
 			}
-			clear_cold_data(cur->page);
+
+			/* record old blkaddr for revoking */
+			cur->old_addr = fio.old_blkaddr;
+
+			clear_cold_data(page);
 			submit_bio = true;
 		}
+		unlock_page(page);
+		list_move_tail(&cur->list, revoke_list);
+	}
 
-		set_page_private(cur->page, 0);
-		ClearPagePrivate(cur->page);
-		f2fs_put_page(cur->page, 1);
+	f2fs_submit_merged_bio(sbi, DATA, WRITE);
 
-		list_del(&cur->list);
-		kmem_cache_free(inmem_entry_slab, cur);
-		dec_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
-	}
+	if (!err)
+		__revoke_inmem_pages(inode, revoke_list, false, false);
 
-	if (submit_bio)
-		f2fs_submit_merged_bio(sbi, DATA, WRITE);
 	return err;
 }
 
@@ -270,13 +300,29 @@ int commit_inmem_pages(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	int err = 0;
+	struct list_head revoke_list;
+	int err;
 
+	INIT_LIST_HEAD(&revoke_list);
 	f2fs_balance_fs(sbi);
 	f2fs_lock_op(sbi);
 
 	mutex_lock(&fi->inmem_lock);
-	err = __commit_inmem_pages(inode);
+	err = __commit_inmem_pages(inode, &revoke_list);
+	if (err) {
+		int ret;
+		/*
+		 * try to revoke all committed pages, but still we could fail
+		 * to revoke due to no memory or other reason, so if that
+		 * happened, return EAGAIN to user.
+		 */
+		ret = __revoke_inmem_pages(inode, &revoke_list, false, true);
+		if (ret)
+			err = ret;
+
+		/* drop all uncommitted pages */
+		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
+	}
 	mutex_unlock(&fi->inmem_lock);
 
 	f2fs_unlock_op(sbi);
@@ -1357,7 +1403,7 @@ void rewrite_data_page(struct f2fs_io_info *fio)
 static void __f2fs_replace_block(struct f2fs_sb_info *sbi,
 				struct f2fs_summary *sum,
 				block_t old_blkaddr, block_t new_blkaddr,
-				bool recover_curseg)
+				bool recover_curseg, bool recover_newaddr)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg;
@@ -1400,7 +1446,7 @@ static void __f2fs_replace_block(struct f2fs_sb_info *sbi,
 	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
 	__add_sum_entry(sbi, type, sum);
 
-	if (!recover_curseg)
+	if (!recover_curseg || recover_newaddr)
 		update_sit_entry(sbi, new_blkaddr, 1);
 	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
 		update_sit_entry(sbi, old_blkaddr, -1);
@@ -1424,13 +1470,15 @@ static void __f2fs_replace_block(struct f2fs_sb_info *sbi,
 
 void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 				block_t old_addr, block_t new_addr,
-				unsigned char version, bool recover_curseg)
+				unsigned char version, bool recover_curseg,
+				bool recover_newaddr)
 {
 	struct f2fs_summary sum;
 
 	set_summary(&sum, dn->nid, dn->ofs_in_node, version);
 
-	__f2fs_replace_block(sbi, &sum, old_addr, new_addr, recover_curseg);
+	__f2fs_replace_block(sbi, &sum, old_addr, new_addr,
+					recover_curseg, recover_newaddr);
 
 	dn->data_blkaddr = new_addr;
 	set_data_blkaddr(dn);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index ee44d34..5146eb7 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -191,6 +191,7 @@ struct segment_allocation {
 struct inmem_pages {
 	struct list_head list;
 	struct page *page;
+	block_t old_addr;		/* for revoking when fail to commit */
 };
 
 struct sit_info {
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index a1b4888..851f158 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -52,6 +52,7 @@ TRACE_DEFINE_ENUM(CP_DISCARD);
 		{ META_FLUSH,	"META_FLUSH" },				\
 		{ INMEM,	"INMEM" },				\
 		{ INMEM_DROP,	"INMEM_DROP" },				\
+		{ INMEM_REVOKE,	"INMEM_REVOKE" },			\
 		{ IPU,		"IN-PLACE" },				\
 		{ OPU,		"OUT-OF-PLACE" })
 
-- 
2.6.3



------------------------------------------------------------------------------
