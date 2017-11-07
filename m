From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: check block reserve strictly a little bit
Date: Tue, 7 Nov 2017 17:56:50 +0800
Message-ID: <1510048610-17771-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eC0oy-0004Nb-Ct
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Nov 2017 10:09:28 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.89)
 id 1eC0ow-00038S-Dl
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Nov 2017 10:09:28 +0000
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
Cc: ning.jia@huawei.com, heyunlei@huawei.com

This patch check new block reserve strictly, in case of
garbage data of node page.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/data.c    |  9 +++++++--
 fs/f2fs/file.c    | 13 +++++--------
 fs/f2fs/segment.c |  1 +
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b0781ed..3017a87 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -558,13 +558,18 @@ int reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 
 	f2fs_wait_on_page_writeback(dn->node_page, NODE, true);
 
-	for (; count > 0; dn->ofs_in_node++) {
+	for (; count > 0; dn->ofs_in_node++, count--) {
 		block_t blkaddr = datablock_addr(dn->inode,
 					dn->node_page, dn->ofs_in_node);
 		if (blkaddr == NULL_ADDR) {
 			dn->data_blkaddr = NEW_ADDR;
 			__set_data_blkaddr(dn);
-			count--;
+		} else {
+			f2fs_msg(sbi->sb, KERN_ERR, "reserve non NULL block, "
+				"blkaddr:%u, ino:%lu, nid:%u, ofs_in_node:%u",
+				blkaddr, dn->inode->i_ino, dn->nid,
+				dn->ofs_in_node);
+			f2fs_bug_on(sbi, 1);
 		}
 	}
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cee0f36..dfc23c2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1218,19 +1218,16 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	pgoff_t index = start;
 	unsigned int ofs_in_node = dn->ofs_in_node;
-	blkcnt_t count = 0;
-	int ret;
+	int ret = 0;
 
 	for (; index < end; index++, dn->ofs_in_node++) {
 		if (datablock_addr(dn->inode, dn->node_page,
 					dn->ofs_in_node) == NULL_ADDR)
-			count++;
-	}
+			ret = reserve_new_blocks(dn, 1);
 
-	dn->ofs_in_node = ofs_in_node;
-	ret = reserve_new_blocks(dn, count);
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
+	}
 
 	dn->ofs_in_node = ofs_in_node;
 	for (index = start; index < end; index++, dn->ofs_in_node++) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 20722b2..e670967 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1815,6 +1815,7 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 	bool mir_exist;
 #endif
 
+	verify_block_addr(sbi, blkaddr);
 	segno = GET_SEGNO(sbi, blkaddr);
 
 	se = get_seg_entry(sbi, segno);
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
