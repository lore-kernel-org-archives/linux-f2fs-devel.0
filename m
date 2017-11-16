From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/4] dump.f2fs: show extra attr only when feature
 is enabled
Date: Thu, 16 Nov 2017 19:50:55 +0800
Message-ID: <20171116115058.110552-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eFIih-0006DP-OU
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 11:52:35 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eFIig-00034z-Mt
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 11:52:35 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If we don't turn on the feature, don't show related info in dumped data.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/mount.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 653dcf391da7..c094f940ee1b 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -222,10 +222,15 @@ void print_inode_info(struct f2fs_sb_info *sbi,
 			le32_to_cpu(inode->i_ext.blk_addr),
 			le32_to_cpu(inode->i_ext.len));
 
-	DISP_u16(inode, i_extra_isize);
-	DISP_u16(inode, i_inline_xattr_size);
-	DISP_u32(inode, i_projid);
-	DISP_u32(inode, i_inode_checksum);
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
+		DISP_u16(inode, i_extra_isize);
+		if (c.feature & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR))
+			DISP_u16(inode, i_inline_xattr_size);
+		if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
+			DISP_u32(inode, i_projid);
+		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
+			DISP_u32(inode, i_inode_checksum);
+	}
 
 	DISP_u32(inode, i_addr[ofs]);		/* Pointers to data blocks */
 	DISP_u32(inode, i_addr[ofs + 1]);	/* Pointers to data blocks */
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
