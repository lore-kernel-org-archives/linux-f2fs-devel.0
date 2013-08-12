From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/2] f2fs: should cover i_xattr_nid with its
 xattr node page lock
Date: Mon, 12 Aug 2013 16:58:54 +0900
Message-ID: <1376294334-11699-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1376294334-11699-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1V8n1q-0003QG-FT
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Aug 2013 07:59:02 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V8n1o-0000Ue-2w for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Aug 2013 07:59:02 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MRE0009FRHUW4G0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Aug 2013 16:58:51 +0900 (KST)
In-reply-to: <1376294334-11699-1-git-send-email-jaegeuk.kim@samsung.com>
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

Previously, f2fs_setxattr assigns i_xattr_nid in the inode page inconsistently.

The scenario is:

= Thread 1 =         = Thread 2 =     = fi->i_xattr_nid =  = on-disk nid =

f2fs_setxattr                                   0                 0
  new_node_page                                 X                 0
                   sync_inode_page              X                 X
                   checkpoint                   X                 X -.
    grab_cache_page                             X                 X  |
--> allocate a new xattr node block or -ENOSPC      <----------------'

At this moment, the checkpoint stores inconsistent data where the inode has
i_xattr_nid but actual xattr node block is not allocated yet.

So, we should assign the real i_xattr_nid only after its xattr node block is
allocated.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/node.c  |  3 +++
 fs/f2fs/xattr.c | 10 +++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 858a333..1c21344 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -851,6 +851,9 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	SetPageUptodate(page);
 	set_page_dirty(page);
 
+	if (ofs == XATTR_NODE_OFFSET)
+		F2FS_I(dn->inode)->i_xattr_nid = dn->nid;
+
 	dn->node_page = page;
 	if (ipage)
 		update_inode(dn->inode, ipage);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index fb16f71..3bc307c 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -378,23 +378,23 @@ int f2fs_setxattr(struct inode *inode, int name_index, const char *name,
 	if (!fi->i_xattr_nid) {
 		/* Allocate new attribute block */
 		struct dnode_of_data dn;
+		nid_t new_nid;
 
-		if (!alloc_nid(sbi, &fi->i_xattr_nid)) {
+		if (!alloc_nid(sbi, &new_nid)) {
 			error = -ENOSPC;
 			goto exit;
 		}
-		set_new_dnode(&dn, inode, NULL, NULL, fi->i_xattr_nid);
+		set_new_dnode(&dn, inode, NULL, NULL, new_nid);
 		mark_inode_dirty(inode);
 
 		page = new_node_page(&dn, XATTR_NODE_OFFSET, ipage);
 		if (IS_ERR(page)) {
-			alloc_nid_failed(sbi, fi->i_xattr_nid);
-			fi->i_xattr_nid = 0;
+			alloc_nid_failed(sbi, new_nid);
 			error = PTR_ERR(page);
 			goto exit;
 		}
 
-		alloc_nid_done(sbi, fi->i_xattr_nid);
+		alloc_nid_done(sbi, new_nid);
 		base_addr = page_address(page);
 		header = XATTR_HDR(base_addr);
 		header->h_magic = cpu_to_le32(F2FS_XATTR_MAGIC);
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
