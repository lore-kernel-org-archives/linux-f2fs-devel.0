From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 3/3] f2fs: remove unused parameter
Date: Wed, 22 Nov 2017 18:23:40 +0800
Message-ID: <20171122102340.133491-3-shengyong1@huawei.com>
References: <20171122102340.133491-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1eHSCH-0006qe-N7
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Nov 2017 10:24:01 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eHSCG-0003H9-I9
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Nov 2017 10:24:01 +0000
In-Reply-To: <20171122102340.133491-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, chao@kernel.org
Cc: shengyong1@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Commit d260081ccf37 ("f2fs: change recovery policy of xattr node block")
removes the use of blkaddr, which is no longer used. So remove the
parameter.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/f2fs.h     | 3 +--
 fs/f2fs/node.c     | 2 +-
 fs/f2fs/recovery.c | 6 +++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a269d795ba7c..bab4c2287090 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2607,8 +2607,7 @@ void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
 void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid);
 int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink);
 void recover_inline_xattr(struct inode *inode, struct page *page);
-int recover_xattr_data(struct inode *inode, struct page *page,
-			block_t blkaddr);
+int recover_xattr_data(struct inode *inode, struct page *page);
 int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
 int restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fe1fc662af2a..ebb0d1797431 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2238,7 +2238,7 @@ void recover_inline_xattr(struct inode *inode, struct page *page)
 	f2fs_put_page(ipage, 1);
 }
 
-int recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
+int recover_xattr_data(struct inode *inode, struct page *page)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	nid_t prev_xnid = F2FS_I(inode)->i_xattr_nid;
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 92c57ace1939..7d63faf51e52 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -404,7 +404,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 }
 
 static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
-					struct page *page, block_t blkaddr)
+					struct page *page)
 {
 	struct dnode_of_data dn;
 	struct node_info ni;
@@ -415,7 +415,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	if (IS_INODE(page)) {
 		recover_inline_xattr(inode, page);
 	} else if (f2fs_has_xattr_block(ofs_of_node(page))) {
-		err = recover_xattr_data(inode, page, blkaddr);
+		err = recover_xattr_data(inode, page);
 		if (!err)
 			recovered++;
 		goto out;
@@ -568,7 +568,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 				break;
 			}
 		}
-		err = do_recover_data(sbi, entry->inode, page, blkaddr);
+		err = do_recover_data(sbi, entry->inode, page);
 		if (err) {
 			f2fs_put_page(page, 1);
 			break;
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
