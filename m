From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: add missing FIX_MSG during extra_attr
 field recovery
Date: Fri, 1 Mar 2019 16:02:27 +0800
Message-ID: <20190301080227.3521-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gzd8E-0005pb-FN
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 08:02:58 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gzd8C-00G9hD-Bf
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 08:02:58 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

Add missing printed message during extra_attr field recovery.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 0c3b04bf1558..2457fb3bae49 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -732,11 +732,19 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
 			if (node_blk->i.i_extra_isize >
 				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE)) {
+				FIX_MSG("ino[0x%x] recover i_extra_isize "
+					"from %u to %lu",
+					nid,
+					le16_to_cpu(node_blk->i.i_extra_isize),
+					F2FS_TOTAL_EXTRA_ATTR_SIZE);
 				node_blk->i.i_extra_isize =
 					cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
 				need_fix = 1;
 			}
 		} else {
+			FIX_MSG("ino[0x%x] remove F2FS_EXTRA_ATTR "
+				"flag in i_inline:%u",
+				nid, node_blk->i.i_inline);
 			/* we don't support tuning F2FS_FEATURE_EXTRA_ATTR now */
 			node_blk->i.i_inline &= ~F2FS_EXTRA_ATTR;
 			need_fix = 1;
-- 
2.18.0.rc1
