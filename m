From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/4] f2fs: split grab_cache_page and
 wait_on_page_writeback for node pages
Date: Wed, 30 Apr 2014 11:33:40 +0900
Message-ID: <1398825223-23062-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WfKNR-0000iS-5o
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Apr 2014 02:36:05 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WfKNP-0007KD-0m
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Apr 2014 02:36:05 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N4T00JG6OJVQ980@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Apr 2014 11:35:55 +0900 (KST)
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

This patch splits grab_cache_page_write_begin into grab_cache_page and
wait_on_page_writeback for node pages.

This patch intends to enhance the latency to get node pages by alleviating
unnecessary wait_on_page_writeback.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/dir.c    | 2 ++
 fs/f2fs/inline.c | 6 ++++++
 fs/f2fs/node.c   | 8 ++++----
 fs/f2fs/node.h   | 2 +-
 fs/f2fs/xattr.c  | 3 +++
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 3581c2b..c3f1485 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -268,6 +268,8 @@ static void init_dent_inode(const struct qstr *name, struct page *ipage)
 {
 	struct f2fs_inode *ri;
 
+	f2fs_wait_on_page_writeback(ipage, NODE);
+
 	/* copy name info. to this inode page */
 	ri = F2FS_INODE(ipage);
 	ri->i_namelen = cpu_to_le32(name->len);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d215dbb..8bf34f0 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -156,6 +156,7 @@ int f2fs_write_inline_data(struct inode *inode,
 		return err;
 	ipage = dn.inode_page;
 
+	f2fs_wait_on_page_writeback(ipage, NODE);
 	zero_user_segment(ipage, INLINE_DATA_OFFSET,
 				 INLINE_DATA_OFFSET + MAX_INLINE_DATA);
 	src_addr = kmap(page);
@@ -188,6 +189,8 @@ void truncate_inline_data(struct inode *inode, u64 from)
 	if (IS_ERR(ipage))
 		return;
 
+	f2fs_wait_on_page_writeback(ipage, NODE);
+
 	zero_user_segment(ipage, INLINE_DATA_OFFSET + from,
 				INLINE_DATA_OFFSET + MAX_INLINE_DATA);
 	set_page_dirty(ipage);
@@ -218,6 +221,8 @@ process_inline:
 		ipage = get_node_page(sbi, inode->i_ino);
 		f2fs_bug_on(IS_ERR(ipage));
 
+		f2fs_wait_on_page_writeback(ipage, NODE);
+
 		src_addr = inline_data_addr(npage);
 		dst_addr = inline_data_addr(ipage);
 		memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
@@ -229,6 +234,7 @@ process_inline:
 	if (f2fs_has_inline_data(inode)) {
 		ipage = get_node_page(sbi, inode->i_ino);
 		f2fs_bug_on(IS_ERR(ipage));
+		f2fs_wait_on_page_writeback(ipage, NODE);
 		zero_user_segment(ipage, INLINE_DATA_OFFSET,
 				 INLINE_DATA_OFFSET + MAX_INLINE_DATA);
 		clear_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2803ef6..059aaf5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -853,8 +853,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
 		return ERR_PTR(-EPERM);
 
-	page = grab_cache_page_write_begin(NODE_MAPPING(sbi),
-					dn->nid, AOP_FLAG_NOFS);
+	page = grab_cache_page(NODE_MAPPING(sbi), dn->nid);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -871,6 +870,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	new_ni.ino = dn->inode->i_ino;
 	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
 
+	f2fs_wait_on_page_writeback(page, NODE);
 	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
 	set_cold_node(dn->inode, page);
 	SetPageUptodate(page);
@@ -950,8 +950,7 @@ struct page *get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
 	struct page *page;
 	int err;
 repeat:
-	page = grab_cache_page_write_begin(NODE_MAPPING(sbi),
-					nid, AOP_FLAG_NOFS);
+	page = grab_cache_page(NODE_MAPPING(sbi), nid);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -1562,6 +1561,7 @@ static void recover_inline_xattr(struct inode *inode, struct page *page)
 	src_addr = inline_xattr_addr(page);
 	inline_size = inline_xattr_size(inode);
 
+	f2fs_wait_on_page_writeback(ipage, NODE);
 	memcpy(dst_addr, src_addr, inline_size);
 
 	update_inode(inode, ipage);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index a076c88..4ee29d5 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -272,7 +272,7 @@ static inline void set_nid(struct page *p, int off, nid_t nid, bool i)
 {
 	struct f2fs_node *rn = F2FS_NODE(p);
 
-	wait_on_page_writeback(p);
+	f2fs_wait_on_page_writeback(p, NODE);
 
 	if (i)
 		rn->i.i_nid[off - NODE_DIR1_BLOCK] = cpu_to_le32(nid);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 6073f9f..1f546b4 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -349,6 +349,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 
 		if (ipage) {
 			inline_addr = inline_xattr_addr(ipage);
+			f2fs_wait_on_page_writeback(ipage, NODE);
 		} else {
 			page = get_node_page(sbi, inode->i_ino);
 			if (IS_ERR(page)) {
@@ -356,6 +357,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 				return PTR_ERR(page);
 			}
 			inline_addr = inline_xattr_addr(page);
+			f2fs_wait_on_page_writeback(page, NODE);
 		}
 		memcpy(inline_addr, txattr_addr, inline_size);
 		f2fs_put_page(page, 1);
@@ -376,6 +378,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 			return PTR_ERR(xpage);
 		}
 		f2fs_bug_on(new_nid);
+		f2fs_wait_on_page_writeback(xpage, NODE);
 	} else {
 		struct dnode_of_data dn;
 		set_new_dnode(&dn, inode, NULL, NULL, new_nid);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
