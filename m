From: Weichao Guo <guoweichao@huawei.com>
Subject: [PATCH v5] f2fs: support in-memory inode checksum when
 checking consistency
Date: Fri, 9 Mar 2018 05:31:42 +0800
Message-ID: <20180308213142.2917-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <guoweichao@huawei.com>) id 1etvYe-0001f4-Hd
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Mar 2018 13:26:08 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1etvYZ-0049VR-FG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Mar 2018 13:26:05 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: yuchao0@huawei.com, jaegeuk@kernel.org
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Only enable in-memory inode checksum to protect metadata blocks
from in-memory scribbles when checking consistency, which has no
performance requirements.
---
 fs/f2fs/inode.c |  7 +++++++
 fs/f2fs/node.c  | 10 +++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 205add3..e405b28 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -159,8 +159,12 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
 	struct f2fs_inode *ri;
 	__u32 provided, calculated;
 
+#ifdef CONFIG_F2FS_CHECK_FS
+	if (!f2fs_enable_inode_chksum(sbi, page))
+#else
 	if (!f2fs_enable_inode_chksum(sbi, page) ||
 			PageDirty(page) || PageWriteback(page))
+#endif
 		return true;
 
 	ri = &F2FS_NODE(page)->i;
@@ -445,6 +449,9 @@ void update_inode(struct inode *inode, struct page *node_page)
 	if (inode->i_nlink == 0)
 		clear_inline_node(node_page);
 
+#ifdef CONFIG_F2FS_CHECK_FS
+	f2fs_inode_chksum_set(F2FS_I_SB(inode), node_page);
+#endif
 }
 
 void update_inode_page(struct inode *inode)
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 177c438..6107935 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1113,8 +1113,12 @@ static int read_node_page(struct page *page, int op_flags)
 		.encrypted_page = NULL,
 	};
 
-	if (PageUptodate(page))
+	if (PageUptodate(page)) {
+#ifdef CONFIG_F2FS_CHECK_FS
+		f2fs_bug_on(sbi, !f2fs_inode_chksum_verify(sbi, page));
+#endif
 		return LOCKED_PAGE;
+	}
 
 	get_node_info(sbi, page->index, &ni);
 
@@ -1731,6 +1735,10 @@ static int f2fs_set_node_page_dirty(struct page *page)
 
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
+#ifdef CONFIG_F2FS_CHECK_FS
+	if (IS_INODE(page))
+		f2fs_inode_chksum_set(F2FS_P_SB(page), page);
+#endif
 	if (!PageDirty(page)) {
 		f2fs_set_page_dirty_nobuffers(page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
