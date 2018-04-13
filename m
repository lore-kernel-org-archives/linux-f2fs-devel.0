From: Zhikang Zhang <zhangzhikang1@huawei.com>
Subject: [PATCH] f2fs: change le32 to le16 of
 f2fs_inode->i_extra_size
Date: Sat, 14 Apr 2018 01:02:34 +0800
Message-ID: <1523638954-17272-1-git-send-email-zhangzhikang1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhangzhikang1@huawei.com>) id 1f6um2-000658-3Q
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Apr 2018 09:13:38 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f6ulm-00GftO-DT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Apr 2018 09:13:38 +0000
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

In the structure of f2fs_inode, i_extra_size's type is __le16,
so we should keep type consistent when using it.

Signed-off-by: Zhikang Zhang <zhangzhikang1@huawei.com>
Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 70aba58..c6d8f65 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -117,7 +117,6 @@ static void __recover_inline_status(struct inode *inode, struct page *ipage)
 static bool f2fs_enable_inode_chksum(struct f2fs_sb_info *sbi, struct page *page)
 {
 	struct f2fs_inode *ri = &F2FS_NODE(page)->i;
-	int extra_isize = le32_to_cpu(ri->i_extra_isize);
 
 	if (!f2fs_sb_has_inode_chksum(sbi->sb))
 		return false;
@@ -125,7 +124,8 @@ static bool f2fs_enable_inode_chksum(struct f2fs_sb_info *sbi, struct page *page
 	if (!RAW_IS_INODE(F2FS_NODE(page)) || !(ri->i_inline & F2FS_EXTRA_ATTR))
 		return false;
 
-	if (!F2FS_FITS_IN_INODE(ri, extra_isize, i_inode_checksum))
+	if (!F2FS_FITS_IN_INODE(ri, le16_to_cpu(ri->i_extra_isize),
+				i_inode_checksum))
 		return false;
 
 	return true;
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
