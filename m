From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: introduce NODE_MAPPING for code consistency
Date: Tue, 21 Jan 2014 18:54:35 +0900
Message-ID: <1390298075-21458-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1390298075-21458-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1W5Y43-0004lV-Fa
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Jan 2014 09:56:11 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1W5Y41-0000TL-7B
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Jan 2014 09:56:11 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MZQ00HGFWXB2X40@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Jan 2014 18:55:59 +0900 (KST)
In-reply-to: <1390298075-21458-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, Gu Zheng <guz.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds NODE_MAPPING which is similar as META_MAPPING introduced by
Gu Zheng.

Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/debug.c      |  4 ++--
 fs/f2fs/f2fs.h       |  5 +++++
 fs/f2fs/node.c       | 50 ++++++++++++++++++++++----------------------------
 4 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ed82de6..293d048 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -771,7 +771,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	/* wait for previous submitted node/meta pages writeback */
 	wait_on_all_pages_writeback(sbi);
 
-	filemap_fdatawait_range(sbi->node_inode->i_mapping, 0, LONG_MAX);
+	filemap_fdatawait_range(NODE_MAPPING(sbi), 0, LONG_MAX);
 	filemap_fdatawait_range(META_MAPPING(sbi), 0, LONG_MAX);
 
 	/* update user_block_counts */
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 8bdc365..3de9d20 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -52,7 +52,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->free_secs = free_sections(sbi);
 	si->prefree_count = prefree_segments(sbi);
 	si->dirty_count = dirty_segments(sbi);
-	si->node_pages = sbi->node_inode->i_mapping->nrpages;
+	si->node_pages = NODE_MAPPING(sbi)->nrpages;
 	si->meta_pages = META_MAPPING(sbi)->nrpages;
 	si->nats = NM_I(sbi)->nat_cnt;
 	si->sits = SIT_I(sbi)->dirty_sentries;
@@ -166,7 +166,7 @@ get_cache:
 	/* free nids */
 	si->cache_mem = NM_I(sbi)->fcnt;
 	si->cache_mem += NM_I(sbi)->nat_cnt;
-	npages = sbi->node_inode->i_mapping->nrpages;
+	npages = NODE_MAPPING(sbi)->nrpages;
 	si->cache_mem += npages << PAGE_CACHE_SHIFT;
 	npages = META_MAPPING(sbi)->nrpages;
 	si->cache_mem += npages << PAGE_CACHE_SHIFT;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 117e30f..af51a0b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -538,6 +538,11 @@ static inline struct address_space *META_MAPPING(struct f2fs_sb_info *sbi)
 	return sbi->meta_inode->i_mapping;
 }
 
+static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
+{
+	return sbi->node_inode->i_mapping;
+}
+
 static inline void F2FS_SET_SB_DIRT(struct f2fs_sb_info *sbi)
 {
 	sbi->s_dirty = 1;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 527bd12..bbfc655 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -681,7 +681,6 @@ fail:
 int truncate_inode_blocks(struct inode *inode, pgoff_t from)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
-	struct address_space *node_mapping = sbi->node_inode->i_mapping;
 	int err = 0, cont = 1;
 	int level, offset[4], noffset[4];
 	unsigned int nofs = 0;
@@ -756,7 +755,7 @@ skip_partial:
 		if (offset[1] == 0 &&
 				ri->i_nid[offset[0] - NODE_DIR1_BLOCK]) {
 			lock_page(page);
-			if (unlikely(page->mapping != node_mapping)) {
+			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
 				f2fs_put_page(page, 1);
 				goto restart;
 			}
@@ -842,7 +841,6 @@ struct page *new_node_page(struct dnode_of_data *dn,
 				unsigned int ofs, struct page *ipage)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dn->inode->i_sb);
-	struct address_space *mapping = sbi->node_inode->i_mapping;
 	struct node_info old_ni, new_ni;
 	struct page *page;
 	int err;
@@ -850,7 +848,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
 		return ERR_PTR(-EPERM);
 
-	page = grab_cache_page(mapping, dn->nid);
+	page = grab_cache_page(NODE_MAPPING(sbi), dn->nid);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -920,18 +918,17 @@ static int read_node_page(struct page *page, int rw)
  */
 void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 {
-	struct address_space *mapping = sbi->node_inode->i_mapping;
 	struct page *apage;
 	int err;
 
-	apage = find_get_page(mapping, nid);
+	apage = find_get_page(NODE_MAPPING(sbi), nid);
 	if (apage && PageUptodate(apage)) {
 		f2fs_put_page(apage, 0);
 		return;
 	}
 	f2fs_put_page(apage, 0);
 
-	apage = grab_cache_page(mapping, nid);
+	apage = grab_cache_page(NODE_MAPPING(sbi), nid);
 	if (!apage)
 		return;
 
@@ -944,11 +941,10 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 
 struct page *get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
 {
-	struct address_space *mapping = sbi->node_inode->i_mapping;
 	struct page *page;
 	int err;
 repeat:
-	page = grab_cache_page(mapping, nid);
+	page = grab_cache_page(NODE_MAPPING(sbi), nid);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -963,7 +959,7 @@ repeat:
 		f2fs_put_page(page, 1);
 		return ERR_PTR(-EIO);
 	}
-	if (unlikely(page->mapping != mapping)) {
+	if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
 		f2fs_put_page(page, 1);
 		goto repeat;
 	}
@@ -980,7 +976,6 @@ got_it:
 struct page *get_node_page_ra(struct page *parent, int start)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(parent->mapping->host->i_sb);
-	struct address_space *mapping = sbi->node_inode->i_mapping;
 	struct blk_plug plug;
 	struct page *page;
 	int err, i, end;
@@ -991,7 +986,7 @@ struct page *get_node_page_ra(struct page *parent, int start)
 	if (!nid)
 		return ERR_PTR(-ENOENT);
 repeat:
-	page = grab_cache_page(mapping, nid);
+	page = grab_cache_page(NODE_MAPPING(sbi), nid);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -1016,7 +1011,7 @@ repeat:
 	blk_finish_plug(&plug);
 
 	lock_page(page);
-	if (unlikely(page->mapping != mapping)) {
+	if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
 		f2fs_put_page(page, 1);
 		goto repeat;
 	}
@@ -1047,7 +1042,6 @@ void sync_inode_page(struct dnode_of_data *dn)
 int sync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
 					struct writeback_control *wbc)
 {
-	struct address_space *mapping = sbi->node_inode->i_mapping;
 	pgoff_t index, end;
 	struct pagevec pvec;
 	int step = ino ? 2 : 0;
@@ -1061,7 +1055,7 @@ next_step:
 
 	while (index <= end) {
 		int i, nr_pages;
-		nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
+		nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
 				PAGECACHE_TAG_DIRTY,
 				min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1);
 		if (nr_pages == 0)
@@ -1094,7 +1088,7 @@ next_step:
 			else if (!trylock_page(page))
 				continue;
 
-			if (unlikely(page->mapping != mapping)) {
+			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
 continue_unlock:
 				unlock_page(page);
 				continue;
@@ -1121,7 +1115,7 @@ continue_unlock:
 				set_fsync_mark(page, 0);
 				set_dentry_mark(page, 0);
 			}
-			mapping->a_ops->writepage(page, wbc);
+			NODE_MAPPING(sbi)->a_ops->writepage(page, wbc);
 			wrote++;
 
 			if (--wbc->nr_to_write == 0)
@@ -1148,18 +1142,19 @@ continue_unlock:
 
 int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
 {
-	struct address_space *mapping = sbi->node_inode->i_mapping;
 	pgoff_t index = 0, end = LONG_MAX;
 	struct pagevec pvec;
-	int nr_pages;
 	int ret2 = 0, ret = 0;
 
 	pagevec_init(&pvec, 0);
-	while ((index <= end) &&
-			(nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
-			PAGECACHE_TAG_WRITEBACK,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1)) != 0) {
-		unsigned i;
+
+	while (index <= end) {
+		int i, nr_pages;
+		nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
+				PAGECACHE_TAG_WRITEBACK,
+				min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1);
+		if (nr_pages == 0)
+			break;
 
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
@@ -1178,9 +1173,9 @@ int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
 		cond_resched();
 	}
 
-	if (unlikely(test_and_clear_bit(AS_ENOSPC, &mapping->flags)))
+	if (unlikely(test_and_clear_bit(AS_ENOSPC, &NODE_MAPPING(sbi)->flags)))
 		ret2 = -ENOSPC;
-	if (unlikely(test_and_clear_bit(AS_EIO, &mapping->flags)))
+	if (unlikely(test_and_clear_bit(AS_EIO, &NODE_MAPPING(sbi)->flags)))
 		ret2 = -EIO;
 	if (!ret)
 		ret = ret2;
@@ -1538,13 +1533,12 @@ void recover_node_page(struct f2fs_sb_info *sbi, struct page *page,
 
 int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 {
-	struct address_space *mapping = sbi->node_inode->i_mapping;
 	struct f2fs_inode *src, *dst;
 	nid_t ino = ino_of_node(page);
 	struct node_info old_ni, new_ni;
 	struct page *ipage;
 
-	ipage = grab_cache_page(mapping, ino);
+	ipage = grab_cache_page(NODE_MAPPING(sbi), ino);
 	if (!ipage)
 		return -ENOMEM;
 
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
