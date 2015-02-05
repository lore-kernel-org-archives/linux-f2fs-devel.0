From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/3] f2fs: use extent cache for dir
Date: Thu, 05 Feb 2015 18:03:40 +0800
Message-ID: <000a01d0412b$27eee070$77cca150$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

We update extent cache for all user inode of f2fs including dir inode, so this
patch gives another chance to try to get physical address of page from extent
cache for dir inode.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 45b97a5..f84c44a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -806,6 +806,7 @@ struct page *find_data_page(struct inode *inode, pgoff_t index, bool sync)
 	struct address_space *mapping = inode->i_mapping;
 	struct dnode_of_data dn;
 	struct page *page;
+	struct extent_info ei;
 	int err;
 	struct f2fs_io_info fio = {
 		.type = DATA,
@@ -817,6 +818,11 @@ struct page *find_data_page(struct inode *inode, pgoff_t index, bool sync)
 		return page;
 	f2fs_put_page(page, 0);
 
+	if (f2fs_lookup_extent_cache(inode, index, &ei)) {
+		dn.data_blkaddr = ei.blk + index - ei.fofs;
+		goto got_it;
+	}
+
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
 	if (err)
@@ -830,6 +836,7 @@ struct page *find_data_page(struct inode *inode, pgoff_t index, bool sync)
 	if (unlikely(dn.data_blkaddr == NEW_ADDR))
 		return ERR_PTR(-EINVAL);
 
+got_it:
 	page = grab_cache_page(mapping, index);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
@@ -864,6 +871,7 @@ struct page *get_lock_data_page(struct inode *inode, pgoff_t index)
 	struct address_space *mapping = inode->i_mapping;
 	struct dnode_of_data dn;
 	struct page *page;
+	struct extent_info ei;
 	int err;
 	struct f2fs_io_info fio = {
 		.type = DATA,
@@ -874,6 +882,11 @@ repeat:
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
+	if (f2fs_lookup_extent_cache(inode, index, &ei)) {
+		dn.data_blkaddr = ei.blk + index - ei.fofs;
+		goto got_it;
+	}
+
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
 	if (err) {
@@ -887,6 +900,7 @@ repeat:
 		return ERR_PTR(-ENOENT);
 	}
 
+got_it:
 	if (PageUptodate(page))
 		return page;
 
-- 
2.2.1
