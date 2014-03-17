From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: introduce f2fs_has_xattr_block for
 better readability
Date: Mon, 17 Mar 2014 16:35:06 +0800
Message-ID: <000001cf41bb$f0754220$d15fc660$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WPT1z-0005Mw-L6
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Mar 2014 08:36:23 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WPT1s-0004AO-Np
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Mar 2014 08:36:23 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N2K00M9WNW6KG40@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Mar 2014 17:36:06 +0900 (KST)
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

This patch introduces a help function f2fs_has_xattr_block for better
readability.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h |    5 +++++
 fs/f2fs/node.c |    4 ++--
 fs/f2fs/node.h |    2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1f87a04..292cc3c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -637,6 +637,11 @@ static inline int F2FS_HAS_BLOCKS(struct inode *inode)
 		return inode->i_blocks > F2FS_DEFAULT_ALLOCATED_BLOCKS;
 }
 
+static inline bool f2fs_has_xattr_block(unsigned int ofs)
+{
+	return ofs == XATTR_NODE_OFFSET;
+}
+
 static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t count)
 {
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c618fad..3e36240 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -836,7 +836,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	SetPageUptodate(page);
 	set_page_dirty(page);
 
-	if (ofs == XATTR_NODE_OFFSET)
+	if (f2fs_has_xattr_block(ofs))
 		F2FS_I(dn->inode)->i_xattr_nid = dn->nid;
 
 	dn->node_page = page;
@@ -1533,7 +1533,7 @@ bool recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
 
 	recover_inline_xattr(inode, page);
 
-	if (ofs_of_node(page) != XATTR_NODE_OFFSET)
+	if (!f2fs_has_xattr_block(ofs_of_node(page)))
 		return false;
 
 	/* 1: invalidate the previous xattr nid */
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 4dea719..ee6d286 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -242,7 +242,7 @@ static inline bool IS_DNODE(struct page *node_page)
 {
 	unsigned int ofs = ofs_of_node(node_page);
 
-	if (ofs == XATTR_NODE_OFFSET)
+	if (f2fs_has_xattr_block(ofs))
 		return false;
 
 	if (ofs == 3 || ofs == 4 + NIDS_PER_BLOCK ||
-- 
1.7.9.5



------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
