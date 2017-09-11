From: Daeho Jeong <daeho.jeong@samsung.com>
Subject: [PATCH] f2fs: clear radix tree dirty tag of pages whose
 dirty flag is cleared
Date: Mon, 11 Sep 2017 16:30:28 +0900
Message-ID: <1505115028-10374-1-git-send-email-daeho.jeong@samsung.com>
References: <CGME20170911072934epcas2p476a584e43b7f52cf1587e7366b52a257@epcas2p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <daeho.jeong@samsung.com>)
 id 1drJA9-0002vv-Cx
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Sep 2017 07:29:45 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1drJA6-0001vZ-PV
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Sep 2017 07:29:45 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Daeho Jeong <daeho.jeong@samsung.com>

On a senario like writing out the first dirty page of the inode
as the inline data, we only cleared dirty flags of the pages, but
didn't clear the dirty tags of those pages in the radix tree.

If we don't clear the dirty tags of the pages in the radix tree, the
inodes which contain the pages will be marked with I_DIRTY_PAGES again
and again, and writepages() for the inodes will be invoked in every
writeback period. As a result, nothing will be done in every
writepages() for the inodes and it will just consume CPU time
meaninglessly.

Signed-off-by: Daeho Jeong <daeho.jeong@samsung.com>
---
 fs/f2fs/dir.c    | 7 +++++++
 fs/f2fs/inline.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 37f9c7f..c0c933ad 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -705,6 +705,8 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	struct	f2fs_dentry_block *dentry_blk;
 	unsigned int bit_pos;
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
+	struct address_space *mapping = page_mapping(page);
+	unsigned long flags;
 	int i;
 
 	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
@@ -735,6 +737,11 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 
 	if (bit_pos == NR_DENTRY_IN_BLOCK &&
 			!truncate_hole(dir, page->index, page->index + 1)) {
+		spin_lock_irqsave(&mapping->tree_lock, flags);
+		radix_tree_tag_clear(&mapping->page_tree, page_index(page),
+				     PAGECACHE_TAG_DIRTY);
+		spin_unlock_irqrestore(&mapping->tree_lock, flags);
+
 		clear_page_dirty_for_io(page);
 		ClearPagePrivate(page);
 		ClearPageUptodate(page);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index c133a4f..8322e4e 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -202,6 +202,8 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 {
 	void *src_addr, *dst_addr;
 	struct dnode_of_data dn;
+	struct address_space *mapping = page_mapping(page);
+	unsigned long flags;
 	int err;
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
@@ -223,6 +225,11 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	kunmap_atomic(src_addr);
 	set_page_dirty(dn.inode_page);
 
+	spin_lock_irqsave(&mapping->tree_lock, flags);
+	radix_tree_tag_clear(&mapping->page_tree, page_index(page),
+			     PAGECACHE_TAG_DIRTY);
+	spin_unlock_irqrestore(&mapping->tree_lock, flags);
+
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	set_inode_flag(inode, FI_DATA_EXIST);
 
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
