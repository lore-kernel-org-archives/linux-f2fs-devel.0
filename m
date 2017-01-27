From: DongOh Shin <doscode.kr@gmail.com>
Subject: [PATCH 3/5] Fix coding style warnings in f2fs.h
Date: Fri, 27 Jan 2017 10:29:38 -0800
Message-ID: <20170127182940.11389-4-doscode.kr@gmail.com>
References: <20170127182940.11389-1-doscode.kr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <doscode.kr@gmail.com>) id 1cXBI3-0003ty-Kn
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Jan 2017 18:30:27 +0000
Received: from mail-pg0-f67.google.com ([74.125.83.67])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cXBI2-000809-Qx
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Jan 2017 18:30:27 +0000
Received: by mail-pg0-f67.google.com with SMTP id 3so7826697pgj.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 27 Jan 2017 10:30:26 -0800 (PST)
In-Reply-To: <20170127182940.11389-1-doscode.kr@gmail.com>
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
Cc: doscode.kr@gmail.com, linux-f2fs-devel@lists.sourceforge.net

Nine coding style warnings below have been resolved:
"Missing a blank line after declarations"

Signed-off-by: DongOh Shin <doscode.kr@gmail.com>
---
 fs/f2fs/f2fs.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 85bd8c1..f997fb1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -212,6 +212,7 @@ struct fsync_inode_entry {
 static inline int update_nats_in_cursum(struct f2fs_journal *journal, int i)
 {
 	int before = nats_in_cursum(journal);
+
 	journal->n_nats = cpu_to_le16(before + i);
 	return before;
 }
@@ -219,6 +220,7 @@ static inline int update_nats_in_cursum(struct f2fs_journal *journal, int i)
 static inline int update_sits_in_cursum(struct f2fs_journal *journal, int i)
 {
 	int before = sits_in_cursum(journal);
+
 	journal->n_sits = cpu_to_le16(before + i);
 	return before;
 }
@@ -304,12 +306,14 @@ static inline void make_dentry_ptr(struct inode *inode,
 
 	if (type == 1) {
 		struct f2fs_dentry_block *t = (struct f2fs_dentry_block *)src;
+
 		d->max = NR_DENTRY_IN_BLOCK;
 		d->bitmap = &t->dentry_bitmap;
 		d->dentry = t->dentry;
 		d->filename = t->filename;
 	} else {
 		struct f2fs_inline_dentry *t = (struct f2fs_inline_dentry *)src;
+
 		d->max = NR_INLINE_DENTRY;
 		d->bitmap = &t->dentry_bitmap;
 		d->dentry = t->dentry;
@@ -1454,6 +1458,7 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 {
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	struct page *page = find_lock_page(mapping, index);
+
 	if (page)
 		return page;
 
@@ -1537,6 +1542,7 @@ static inline void f2fs_radix_tree_insert(struct radix_tree_root *root,
 static inline bool IS_INODE(struct page *page)
 {
 	struct f2fs_node *p = F2FS_NODE(page);
+
 	return RAW_IS_INODE(p);
 }
 
@@ -1550,6 +1556,7 @@ static inline block_t datablock_addr(struct page *node_page,
 {
 	struct f2fs_node *raw_node;
 	__le32 *addr_array;
+
 	raw_node = F2FS_NODE(node_page);
 	addr_array = blkaddr_in_node(raw_node);
 	return le32_to_cpu(addr_array[offset]);
@@ -1785,6 +1792,7 @@ static inline unsigned int addrs_per_inode(struct inode *inode)
 static inline void *inline_xattr_addr(struct page *page)
 {
 	struct f2fs_inode *ri = F2FS_INODE(page);
+
 	return (void *)&(ri->i_addr[DEF_ADDRS_PER_INODE -
 					F2FS_INLINE_XATTR_ADDRS]);
 }
@@ -1846,6 +1854,7 @@ static inline bool f2fs_is_drop_cache(struct inode *inode)
 static inline void *inline_data_addr(struct page *page)
 {
 	struct f2fs_inode *ri = F2FS_INODE(page);
+
 	return (void *)&(ri->i_addr[1]);
 }
 
-- 
1.8.3.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
