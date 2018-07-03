From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 2/2] fsck.f2fs: check extra_attr feature
Date: Tue, 3 Jul 2018 18:10:05 +0800
Message-ID: <20180703101005.200396-2-shengyong1@huawei.com>
References: <20180703101005.200396-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1faIGl-0006UY-6j
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Jul 2018 10:10:47 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1faIGi-00GCKs-W6
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Jul 2018 10:10:47 +0000
In-Reply-To: <20180703101005.200396-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, wen.xu@gatech.edu
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Check extra_attr feature for inode. If it is corrupted, remove the
inode.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200219
Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/fsck.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 15264b2..acbe25d 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -460,6 +460,12 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 		__check_inode_mode(nid, ftype, le32_to_cpu(node_blk->i.i_mode)))
 		return -EINVAL;
 
+	if (ntype == TYPE_INODE &&
+			((f2fs_has_extra_isize(&node_blk->i) &&
+			  !(c.feature & F2FS_FEATURE_EXTRA_ATTR)) ||
+			 get_extra_isize(node_blk) >= DEF_ADDRS_PER_INODE))
+		return -EINVAL;
+
 	/* workaround to fix later */
 	if (ftype != F2FS_FT_ORPHAN ||
 			f2fs_test_bit(nid, fsck->nat_area_bitmap) != 0) {
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
