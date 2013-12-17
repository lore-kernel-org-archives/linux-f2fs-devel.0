From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: introduce a new direct_IO write path
Date: Tue, 17 Dec 2013 10:49:52 +0900
Message-ID: <1387244992-7038-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VsjoT-0007YY-EX
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Dec 2013 01:51:09 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VsjoQ-0000E7-Nq
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Dec 2013 01:51:09 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MXX00BZCH4ZKLB0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Dec 2013 10:50:59 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously, f2fs doesn't support direct IOs with high performance which throws
every write requests to the buffered write path, resulting in highly performance
degradation due to memory opeations like copy_from_user.

This patch introduces a new direct IO path in which every write requests are
processed by generic blockdev_direct_IO() with enhanced get_block function.

The get_data_block() in f2fs handles:
1. if original data blocks are allocates, then give them to blockdev.
2. otherwise,
  a. preallocate requested block addresses
  b. do not use extent cache for better performance
  c. give the block addresses to blockdev

This policy induces that:
- new allocated data are sequentially written to the disk
- updated data are randomly written to the disk.
- f2fs gives consistency on its file meta, not file data.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c    | 145 +++++++++++++++++++++++++++++++++++++++---------------
 fs/f2fs/f2fs.h    |   2 +
 fs/f2fs/segment.c |  23 ++++++---
 3 files changed, 123 insertions(+), 47 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 15956fa..9bdacc6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -570,74 +570,146 @@ repeat:
 	return page;
 }
 
+static int __allocate_data_block(struct dnode_of_data *dn)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(dn->inode->i_sb);
+	struct f2fs_summary sum;
+	block_t new_blkaddr;
+	struct node_info ni;
+	int type;
+
+	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
+		return -EPERM;
+	if (unlikely(!inc_valid_block_count(sbi, dn->inode, 1)))
+		return -ENOSPC;
+
+	__set_data_blkaddr(dn, NEW_ADDR);
+	dn->data_blkaddr = NEW_ADDR;
+
+	get_node_info(sbi, dn->nid, &ni);
+	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
+
+	type = CURSEG_WARM_DATA;
+
+	allocate_data_block(sbi, NULL, NULL_ADDR, &new_blkaddr, &sum, type);
+
+	/* direct IO doesn't use extent cache to maximize the performance */
+	set_inode_flag(F2FS_I(dn->inode), FI_NO_EXTENT);
+	update_extent_cache(new_blkaddr, dn);
+	clear_inode_flag(F2FS_I(dn->inode), FI_NO_EXTENT);
+
+	dn->data_blkaddr = new_blkaddr;
+	return 0;
+}
+
 /*
  * This function should be used by the data read flow only where it
  * does not check the "create" flag that indicates block allocation.
  * The reason for this special functionality is to exploit VFS readahead
  * mechanism.
  */
-static int get_data_block_ro(struct inode *inode, sector_t iblock,
+static int get_data_block(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	unsigned int blkbits = inode->i_sb->s_blocksize_bits;
 	unsigned maxblocks = bh_result->b_size >> blkbits;
 	struct dnode_of_data dn;
-	pgoff_t pgofs;
-	int err;
+	int mode = create ? ALLOC_NODE : LOOKUP_NODE_RA;
+	pgoff_t pgofs, end_offset;
+	bool allocate = false;
+	int err = 0, ofs = 1;
 
 	/* Get the page offset from the block offset(iblock) */
 	pgofs =	(pgoff_t)(iblock >> (PAGE_CACHE_SHIFT - blkbits));
 
-	if (check_extent_cache(inode, pgofs, bh_result)) {
-		trace_f2fs_get_data_block(inode, iblock, bh_result, 0);
-		return 0;
-	}
+	if (check_extent_cache(inode, pgofs, bh_result))
+		goto out;
+
+	if (create)
+		f2fs_lock_op(sbi);
 
 	/* When reading holes, we need its node page */
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	err = get_dnode_of_data(&dn, pgofs, LOOKUP_NODE_RA);
+	err = get_dnode_of_data(&dn, pgofs, mode);
 	if (err) {
-		trace_f2fs_get_data_block(inode, iblock, bh_result, err);
-		return (err == -ENOENT) ? 0 : err;
+		if (err == -ENOENT)
+			err = 0;
+		goto put_out;
 	}
+	if (dn.data_blkaddr == NEW_ADDR)
+		goto put_out;
 
-	/* It does not support data allocation */
-	f2fs_bug_on(create);
-
-	if (dn.data_blkaddr != NEW_ADDR && dn.data_blkaddr != NULL_ADDR) {
-		int i;
-		unsigned int end_offset;
-
+	if (dn.data_blkaddr != NULL_ADDR) {
+		map_bh(bh_result, inode->i_sb, dn.data_blkaddr);
+	} else if (create) {
+		allocate = true;
+		err = __allocate_data_block(&dn);
+		if (err)
+			goto put_out;
+		map_bh(bh_result, inode->i_sb, dn.data_blkaddr);
+	} else {
+		goto put_out;
+	}
+
+	end_offset = IS_INODE(dn.node_page) ?
+			ADDRS_PER_INODE(F2FS_I(inode)) : ADDRS_PER_BLOCK;
+	bh_result->b_size = (((size_t)1) << blkbits);
+	dn.ofs_in_node++;
+	pgofs++;
+
+get_next:
+	if (dn.ofs_in_node >= end_offset) {
+		f2fs_put_dnode(&dn);
+		set_new_dnode(&dn, inode, NULL, NULL, 0);
+		err = get_dnode_of_data(&dn, pgofs, mode);
+		if (err) {
+			if (err == -ENOENT)
+				err = 0;
+			goto put_out;
+		}
 		end_offset = IS_INODE(dn.node_page) ?
-				ADDRS_PER_INODE(F2FS_I(inode)) :
-				ADDRS_PER_BLOCK;
-
-		clear_buffer_new(bh_result);
+			ADDRS_PER_INODE(F2FS_I(inode)) : ADDRS_PER_BLOCK;
+	}
 
+	if (maxblocks > (bh_result->b_size >> blkbits)) {
+		block_t blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
+		if (blkaddr == NULL_ADDR && allocate) {
+			err = __allocate_data_block(&dn);
+			if (err)
+				goto put_out;
+			blkaddr = dn.data_blkaddr;
+		}
 		/* Give more consecutive addresses for the read ahead */
-		for (i = 0; i < end_offset - dn.ofs_in_node; i++)
-			if (((datablock_addr(dn.node_page,
-							dn.ofs_in_node + i))
-				!= (dn.data_blkaddr + i)) || maxblocks == i)
-				break;
-		map_bh(bh_result, inode->i_sb, dn.data_blkaddr);
-		bh_result->b_size = (((size_t)i) << blkbits);
+		if (blkaddr == (bh_result->b_blocknr + ofs)) {
+			ofs++;
+			dn.ofs_in_node++;
+			pgofs++;
+			bh_result->b_size += (((size_t)1) << blkbits);
+			goto get_next;
+		}
 	}
+put_out:
+	if (allocate && buffer_mapped(bh_result))
+		sync_inode_page(&dn);
 	f2fs_put_dnode(&dn);
-	trace_f2fs_get_data_block(inode, iblock, bh_result, 0);
-	return 0;
+	if (create)
+		f2fs_unlock_op(sbi);
+out:
+	trace_f2fs_get_data_block(inode, iblock, bh_result, err);
+	return err;
 }
 
 static int f2fs_read_data_page(struct file *file, struct page *page)
 {
-	return mpage_readpage(page, get_data_block_ro);
+	return mpage_readpage(page, get_data_block);
 }
 
 static int f2fs_read_data_pages(struct file *file,
 			struct address_space *mapping,
 			struct list_head *pages, unsigned nr_pages)
 {
-	return mpage_readpages(mapping, pages, nr_pages, get_data_block_ro);
+	return mpage_readpages(mapping, pages, nr_pages, get_data_block);
 }
 
 int do_write_data_page(struct page *page, struct f2fs_io_info *fio)
@@ -883,13 +955,8 @@ static ssize_t f2fs_direct_IO(int rw, struct kiocb *iocb,
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
-
-	if (rw == WRITE)
-		return 0;
-
-	/* Needs synchronization with the cleaner */
 	return blockdev_direct_IO(rw, iocb, inode, iov, offset, nr_segs,
-						  get_data_block_ro);
+							get_data_block);
 }
 
 static void f2fs_invalidate_data_page(struct page *page, unsigned int offset,
@@ -928,7 +995,7 @@ static int f2fs_set_data_page_dirty(struct page *page)
 
 static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 {
-	return generic_block_bmap(mapping, block, get_data_block_ro);
+	return generic_block_bmap(mapping, block, get_data_block);
 }
 
 const struct address_space_operations f2fs_dblock_aops = {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1b05a62..8cbc5a6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1115,6 +1115,8 @@ void recover_data_page(struct f2fs_sb_info *, struct page *,
 				struct f2fs_summary *, block_t, block_t);
 void rewrite_node_page(struct f2fs_sb_info *, struct page *,
 				struct f2fs_summary *, block_t, block_t);
+void allocate_data_block(struct f2fs_sb_info *, struct page *,
+		block_t, block_t *, struct f2fs_summary *, int);
 void f2fs_wait_on_page_writeback(struct page *, enum page_type, bool);
 void write_data_summaries(struct f2fs_sb_info *, block_t);
 void write_node_summaries(struct f2fs_sb_info *, block_t);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5b890ce..9f8bdd0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -854,16 +854,14 @@ static int __get_segment_type(struct page *page, enum page_type p_type)
 	return __get_segment_type_6(page, p_type);
 }
 
-static void do_write_page(struct f2fs_sb_info *sbi, struct page *page,
-			block_t old_blkaddr, block_t *new_blkaddr,
-			struct f2fs_summary *sum, struct f2fs_io_info *fio)
+void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
+		block_t old_blkaddr, block_t *new_blkaddr,
+		struct f2fs_summary *sum, int type)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg;
 	unsigned int old_cursegno;
-	int type;
 
-	type = __get_segment_type(page, fio->type);
 	curseg = CURSEG_I(sbi, type);
 
 	mutex_lock(&curseg->curseg_mutex);
@@ -896,13 +894,22 @@ static void do_write_page(struct f2fs_sb_info *sbi, struct page *page,
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
 	mutex_unlock(&sit_i->sentry_lock);
 
-	if (fio->type == NODE)
+	if (page && IS_NODESEG(type))
 		fill_node_footer_blkaddr(page, NEXT_FREE_BLKADDR(sbi, curseg));
 
+	mutex_unlock(&curseg->curseg_mutex);
+}
+
+static void do_write_page(struct f2fs_sb_info *sbi, struct page *page,
+			block_t old_blkaddr, block_t *new_blkaddr,
+			struct f2fs_summary *sum, struct f2fs_io_info *fio)
+{
+	int type = __get_segment_type(page, fio->type);
+
+	allocate_data_block(sbi, page, old_blkaddr, new_blkaddr, sum, type);
+
 	/* writeout dirty page into bdev */
 	f2fs_submit_page_mbio(sbi, page, *new_blkaddr, fio);
-
-	mutex_unlock(&curseg->curseg_mutex);
 }
 
 void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
