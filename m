From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 1/2] f2fs: remove unused input parameter
Date: Mon, 17 Jul 2017 19:16:11 +0800
Message-ID: <1500290172-24915-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1dX4D4-0004Xd-Sf
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Jul 2017 11:29:06 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dX4D3-00038I-9n
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Jul 2017 11:29:06 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch remove unused input parameter in function
new_node_page.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Yong Sheng <shengyong1@huawei.com>
---
 fs/f2fs/f2fs.h  | 3 +--
 fs/f2fs/node.c  | 7 +++----
 fs/f2fs/xattr.c | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 94a88b2..7a17b21 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2285,8 +2285,7 @@ f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info,
 int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino);
 int remove_inode_page(struct inode *inode);
 struct page *new_inode_page(struct inode *inode);
-struct page *new_node_page(struct dnode_of_data *dn,
-			unsigned int ofs, struct page *ipage);
+struct page *new_node_page(struct dnode_of_data *dn, unsigned int ofs);
 void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
 struct page *get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
 struct page *get_node_page_ra(struct page *parent, int start);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d53fe62..adc3a70 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -613,7 +613,7 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 			}
 
 			dn->nid = nids[i];
-			npage[i] = new_node_page(dn, noffset[i], NULL);
+			npage[i] = new_node_page(dn, noffset[i]);
 			if (IS_ERR(npage[i])) {
 				alloc_nid_failed(sbi, nids[i]);
 				err = PTR_ERR(npage[i]);
@@ -1022,11 +1022,10 @@ struct page *new_inode_page(struct inode *inode)
 	set_new_dnode(&dn, inode, NULL, NULL, inode->i_ino);
 
 	/* caller should f2fs_put_page(page, 1); */
-	return new_node_page(&dn, 0, NULL);
+	return new_node_page(&dn, 0);
 }
 
-struct page *new_node_page(struct dnode_of_data *dn,
-				unsigned int ofs, struct page *ipage)
+struct page *new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct node_info new_ni;
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 832c511..ef3a372 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -442,7 +442,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 	} else {
 		struct dnode_of_data dn;
 		set_new_dnode(&dn, inode, NULL, NULL, new_nid);
-		xpage = new_node_page(&dn, XATTR_NODE_OFFSET, ipage);
+		xpage = new_node_page(&dn, XATTR_NODE_OFFSET);
 		if (IS_ERR(xpage)) {
 			alloc_nid_failed(sbi, new_nid);
 			return PTR_ERR(xpage);
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
