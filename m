From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH] fsck.f2fs: simplify fsck_chk_quota_node in
 PREEN_MODE_1
Date: Mon, 26 Mar 2018 20:47:37 +0800
Message-ID: <20180326124737.231210-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1f0RXj-0005UW-8N
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Mar 2018 12:48:07 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f0RXf-005BuL-At
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Mar 2018 12:48:07 +0000
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Do not do fsck_chk_node_blk to simplify fsck_chk_quota_node in
PREEN_MODE_1, as well as fsck_chk_orphan_node.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/fsck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index bc91839..91c8529 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1671,6 +1671,7 @@ int fsck_chk_quota_node(struct f2fs_sb_info *sbi)
 			if (!IS_VALID_NID(sbi, ino) ||
 					!IS_VALID_BLK_ADDR(sbi, ni.blk_addr))
 				return -EINVAL;
+			continue;
 		}
 		ret = fsck_chk_node_blk(sbi, NULL, ino,
 				F2FS_FT_REG_FILE, TYPE_INODE, &blk_cnt, NULL);
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
