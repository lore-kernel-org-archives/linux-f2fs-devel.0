From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: readahead contiguous pages for
 restore_node_summary
Date: Fri, 22 Nov 2013 15:48:54 +0800
Message-ID: <000101cee757$6f3b4790$4db1d6b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VjlV7-0000jD-CB
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Nov 2013 07:50:05 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VjlV5-0002Tu-9Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Nov 2013 07:50:05 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MWN006OZN378BK0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Nov 2013 16:49:55 +0900 (KST)
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
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If cp has no CP_UMOUNT_FLAG, we will read all pages in whole node segment 
one by one, it makes low performance. So let's merge contiguous pages and 
readahead for better performance.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c |   89 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4ac4150..81e704a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1572,47 +1572,84 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	return 0;
 }
 
+/*
+ * ra_sum_pages() merge contiguous pages into one bio and submit.
+ * these pre-readed pages are linked in pages list.
+ */
+static int ra_sum_pages(struct f2fs_sb_info *sbi, struct list_head *pages,
+				int start, int nrpages)
+{
+	struct page *page;
+	int page_idx = start;
+
+	for (; page_idx < start + nrpages; page_idx++) {
+		/* alloc temporal page for read node summary info*/
+		page = alloc_page(GFP_NOFS | __GFP_ZERO);
+		if (!page) {
+			struct page *tmp;
+			list_for_each_entry_safe(page, tmp, pages, lru) {
+				list_del(&page->lru);
+				unlock_page(page);
+				__free_pages(page, 0);
+			}
+			return -ENOMEM;
+		}
+
+		lock_page(page);
+		page->index = page_idx;
+		list_add_tail(&page->lru, pages);
+	}
+
+	list_for_each_entry(page, pages, lru)
+		submit_read_page(sbi, page, page->index, READ_SYNC);
+
+	f2fs_submit_read_bio(sbi, READ_SYNC);
+	return 0;
+}
+
 int restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum)
 {
 	struct f2fs_node *rn;
 	struct f2fs_summary *sum_entry;
-	struct page *page;
+	struct page *page, *tmp;
 	block_t addr;
-	int i, last_offset;
-
-	/* alloc temporal page for read node */
-	page = alloc_page(GFP_NOFS | __GFP_ZERO);
-	if (!page)
-		return -ENOMEM;
-	lock_page(page);
+	int bio_blocks = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
+	int i, last_offset, nrpages, err = 0;
+	LIST_HEAD(page_list);
 
 	/* scan the node segment */
 	last_offset = sbi->blocks_per_seg;
 	addr = START_BLOCK(sbi, segno);
 	sum_entry = &sum->entries[0];
 
-	for (i = 0; i < last_offset; i++, sum_entry++) {
-		/*
-		 * In order to read next node page,
-		 * we must clear PageUptodate flag.
-		 */
-		ClearPageUptodate(page);
+	for (i = 0; i < last_offset; i += nrpages, addr += nrpages) {
 
-		if (f2fs_readpage(sbi, page, addr, READ_SYNC))
-			goto out;
+		nrpages = min(last_offset - i, bio_blocks);
+		/* read ahead node pages */
+		err = ra_sum_pages(sbi, &page_list, addr, nrpages);
+		if (err)
+			return err;
 
-		lock_page(page);
-		rn = F2FS_NODE(page);
-		sum_entry->nid = rn->footer.nid;
-		sum_entry->version = 0;
-		sum_entry->ofs_in_node = 0;
-		addr++;
+		list_for_each_entry_safe(page, tmp, &page_list, lru) {
+
+			lock_page(page);
+			if(PageUptodate(page)) {
+				rn = F2FS_NODE(page);
+				sum_entry->nid = rn->footer.nid;
+				sum_entry->version = 0;
+				sum_entry->ofs_in_node = 0;
+				sum_entry++;
+			} else {
+				err = -EIO;
+			}
+
+			list_del(&page->lru);
+			unlock_page(page);
+			__free_pages(page, 0);
+		}
 	}
-	unlock_page(page);
-out:
-	__free_pages(page, 0);
-	return 0;
+	return err;
 }
 
 static bool flush_nats_in_journal(struct f2fs_sb_info *sbi)
-- 
1.7.9.5


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
