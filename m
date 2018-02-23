From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v2 4/7] fsck.f2fs: integrate
 sanity_check_inode to __check_inode_mode
Date: Fri, 23 Feb 2018 11:17:58 +0800
Message-ID: <20180223031801.231805-5-shengyong1@huawei.com>
References: <20180223031801.231805-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1ep3sh-00043C-Hd
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Feb 2018 03:18:43 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ep3sf-0000gl-8Y
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Feb 2018 03:18:43 +0000
In-Reply-To: <20180223031801.231805-1-shengyong1@huawei.com>
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
Cc: hyojun@google.com, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

In sanity_check_nid, __check_inode_mode will check i_mode value of an
inode. So integrate sanity_check_inode to __check_inode_mode to clean
up the code.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/fsck.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 0a37f7a..f6391e9 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -334,6 +334,15 @@ static int __check_inode_mode(u32 nid, enum FILE_TYPE ftype, u32 mode)
 {
 	if (ftype >= F2FS_FT_MAX)
 		return 0;
+	/* f2fs_iget will return -EIO if mode is not valid file type */
+	if (!S_ISLNK(mode) && !S_ISREG(mode) && !S_ISDIR(mode) &&
+	    !S_ISCHR(mode) && !S_ISBLK(mode) && !S_ISFIFO(mode) &&
+	    !S_ISSOCK(mode)) {
+		ASSERT_MSG("inode [0x%x] unknown file type i_mode [0x%x]",
+			   nid, mode);
+		return -1;
+	}
+
 	if (S_ISLNK(mode) && ftype != F2FS_FT_SYMLINK)
 		goto err;
 	if (S_ISREG(mode) && ftype != F2FS_FT_REG_FILE)
@@ -350,7 +359,8 @@ static int __check_inode_mode(u32 nid, enum FILE_TYPE ftype, u32 mode)
 		goto err;
 	return 0;
 err:
-	ASSERT_MSG("mismatch i_mode [0x%x] [0x%x vs. 0x%x]", nid, ftype, mode);
+	ASSERT_MSG("inode [0x%x] mismatch i_mode [0x%x vs. 0x%x]",
+		   nid, ftype, mode);
 	return -1;
 }
 
@@ -465,25 +475,6 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 	return 0;
 }
 
-static int sanity_check_inode(struct f2fs_sb_info *sbi, struct f2fs_node *node)
-{
-	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
-	struct f2fs_inode *fi = &node->i;
-
-	if (!(le16_to_cpu(fi->i_mode) & S_IFMT)) {
-		ASSERT_MSG("i_mode is not valid. [0x%x]", le16_to_cpu(fi->i_mode));
-		goto remove_node;
-	}
-
-	return 0;
-
-remove_node:
-	f2fs_set_bit(le32_to_cpu(node->footer.ino), fsck->nat_area_bitmap);
-	fsck->chk.valid_blk_cnt--;
-	fsck->chk.valid_node_cnt--;
-	return -EINVAL;
-}
-
 static int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino,
 					u32 x_nid, u32 *blk_cnt)
 {
@@ -528,8 +519,6 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 	if (ntype == TYPE_INODE) {
 		struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 
-		if (sanity_check_inode(sbi, node_blk))
-			goto err;
 		fsck_chk_inode_blk(sbi, nid, ftype, node_blk, blk_cnt, &ni, child);
 		quota_add_inode_usage(fsck->qctx, nid, &node_blk->i);
 	} else {
-- 
2.14.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
