From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v2] f2fs: alloc new nids for xattr block in
 recovery
Date: Tue, 18 Jul 2017 09:48:12 +0800
Message-ID: <1500342492-31830-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1dXHor-0006Uf-9N
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Jul 2017 02:01:01 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dXHop-0000Kn-WE
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Jul 2017 02:01:01 +0000
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
Cc: morgan.wang@huawei.com

recovery file A:			recovery file B:
	-get_dnode_of_data
		-alloc_nid
					-recover_xattr_data
						-set_node_addr(sbi, &ni, NEW_ADDR, false);
							--->bug_on for nid has been used by file A

In recovery process, new allocated node blocks may "reuse" xattr block
nids, this patch alloc new nids for xattr blocks in recovery process to
avoid this problem.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/node.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index adc3a70..5396611 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -19,6 +19,7 @@
 #include "f2fs.h"
 #include "node.h"
 #include "segment.h"
+#include "xattr.h"
 #include "trace.h"
 #include <trace/events/f2fs.h>
 
@@ -2190,7 +2191,8 @@ int recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	nid_t prev_xnid = F2FS_I(inode)->i_xattr_nid;
-	nid_t new_xnid = nid_of_node(page);
+	nid_t new_xnid;
+	struct dnode_of_data dn;
 	struct node_info ni;
 	struct page *xpage;
 
@@ -2206,22 +2208,22 @@ int recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
 
 recover_xnid:
 	/* 2: update xattr nid in inode */
-	remove_free_nid(sbi, new_xnid);
-	f2fs_i_xnid_write(inode, new_xnid);
-	if (unlikely(inc_valid_node_count(sbi, inode, false)))
-		f2fs_bug_on(sbi, 1);
+	if (!alloc_nid(sbi, &new_xnid))
+		return -ENOSPC;
+
+	set_new_dnode(&dn, inode, NULL, NULL, new_xnid);
+	xpage = new_node_page(&dn, XATTR_NODE_OFFSET);
+	if (IS_ERR(xpage)) {
+		alloc_nid_failed(sbi, new_xnid);
+		return PTR_ERR(xpage);
+	}
+
+	alloc_nid_done(sbi, new_xnid);
 	update_inode_page(inode);
 
 	/* 3: update and set xattr node page dirty */
-	xpage = grab_cache_page(NODE_MAPPING(sbi), new_xnid);
-	if (!xpage)
-		return -ENOMEM;
-
-	memcpy(F2FS_NODE(xpage), F2FS_NODE(page), PAGE_SIZE);
+	memcpy(F2FS_NODE(xpage), F2FS_NODE(page), VALID_XATTR_BLOCK_SIZE);
 
-	get_node_info(sbi, new_xnid, &ni);
-	ni.ino = inode->i_ino;
-	set_node_addr(sbi, &ni, NEW_ADDR, false);
 	set_page_dirty(xpage);
 	f2fs_put_page(xpage, 1);
 
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
