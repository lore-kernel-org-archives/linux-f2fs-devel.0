From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH 3/3 V3] f2fs: introduce f2fs_cache_node_page() to
 add page into node_inode cache
Date: Mon, 09 Dec 2013 13:35:48 +0800
Message-ID: <000a01cef4a0$9f2d64a0$dd882de0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces f2fs_cache_node_page(), in this function, page which is
readed ahead will be copy to node_inode's mapping cache.
It will avoid rereading these node pages.

change log:
 o check validity of page by searching NAT suggested by Jaegeuk Kim.
 o add 'unlikely' for compiler optimization suggested by Jaegeuk Kim.

Suggested-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 099f06f..4c6da98 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1600,13 +1600,46 @@ static int ra_sum_pages(struct f2fs_sb_info *sbi, struct list_head *pages,
 	return 0;
 }
 
+/*
+ * f2fs_cache_node_page() check validaty of input page by searching NAT.
+ * Then, it will copy updated data of vaild page to node_inode cache.
+ */
+void f2fs_cache_node_page(struct f2fs_sb_info *sbi, struct page *page,
+						nid_t nid, block_t blkaddr)
+{
+	struct address_space *mapping = sbi->node_inode->i_mapping;
+	struct page *npage;
+	struct node_info ni;
+
+	get_node_info(sbi, nid, &ni);
+
+	if (ni.blk_addr != blkaddr)
+		return;
+
+	npage = grab_cache_page(mapping, nid);
+	if (unlikely(!npage))
+		return;
+
+	if (PageUptodate(npage)) {
+		f2fs_put_page(npage, 1);
+		return;
+	}
+
+	memcpy(page_address(npage), page_address(page), PAGE_CACHE_SIZE);
+
+	SetPageUptodate(npage);
+	f2fs_put_page(npage, 1);
+
+	return;
+}
+
 int restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum)
 {
 	struct f2fs_node *rn;
 	struct f2fs_summary *sum_entry;
 	struct page *page, *tmp;
-	block_t addr;
+	block_t addr, blkaddr;
 	int bio_blocks = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
 	int i, last_offset, nrpages, err = 0;
 	LIST_HEAD(page_list);
@@ -1624,6 +1657,7 @@ int restore_node_summary(struct f2fs_sb_info *sbi,
 		if (err)
 			return err;
 
+		blkaddr = addr;
 		list_for_each_entry_safe(page, tmp, &page_list, lru) {
 
 			lock_page(page);
@@ -1633,6 +1667,8 @@ int restore_node_summary(struct f2fs_sb_info *sbi,
 				sum_entry->version = 0;
 				sum_entry->ofs_in_node = 0;
 				sum_entry++;
+				f2fs_cache_node_page(sbi, page,
+					le32_to_cpu(rn->footer.nid), blkaddr);
 			} else {
 				err = -EIO;
 			}
@@ -1640,6 +1676,7 @@ int restore_node_summary(struct f2fs_sb_info *sbi,
 			list_del(&page->lru);
 			unlock_page(page);
 			__free_pages(page, 0);
+			blkaddr++;
 		}
 	}
 	return err;
-- 
1.7.9.5
