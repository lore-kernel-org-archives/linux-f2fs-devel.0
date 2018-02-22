From: Weichao Guo <guoweichao@huawei.com>
Subject: [PATCH] f2fs: in-memory inode checksum when checking
 consistency
Date: Fri, 23 Feb 2018 02:24:39 +0800
Message-ID: <20180222182439.185402-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <guoweichao@huawei.com>) id 1eonxE-0000wo-PQ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Feb 2018 10:18:20 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eonxE-0008rf-4i
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Feb 2018 10:18:20 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Enable in-memory inode checksum to protect metadata blocks
from in-memory scribbles only when checking consistency with
no performance requirements.

Signed-off-by: Weichao Guo <guoweichao@huawei.com>
---
 fs/f2fs/inode.c | 7 +++++++
 fs/f2fs/node.c  | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 89c838b..cb51557 100644
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
@@ -464,6 +468,9 @@ void update_inode_page(struct inode *inode)
 		return;
 	}
 	update_inode(inode, node_page);
+#ifdef CONFIG_F2FS_CHECK_FS
+	f2fs_inode_chksum_set(sbi, node_page);
+#endif
 	f2fs_put_page(node_page, 1);
 }
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 177c438..d76399d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1191,11 +1191,16 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 		goto out_err;
 	}
 
+#ifdef CONFIG_F2FS_CHECK_FS
+page_hit:
+	BUG_ON(f2fs_inode_chksum_verify(sbi, page));
+#else
 	if (!f2fs_inode_chksum_verify(sbi, page)) {
 		err = -EBADMSG;
 		goto out_err;
 	}
 page_hit:
+#endif
 	if(unlikely(nid != nid_of_node(page))) {
 		f2fs_msg(sbi->sb, KERN_WARNING, "inconsistent node block, "
 			"nid:%lu, node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
