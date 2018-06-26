From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] fsck.f2fs: fix wrong err message of check quota
 node
Date: Tue, 26 Jun 2018 16:06:54 +0800
Message-ID: <1530000414-29115-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1fXjDN-0004k7-8l
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Jun 2018 08:20:41 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fXjDL-0035An-9P
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Jun 2018 08:20:41 +0000
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
Cc: zhangdianfang@huawei.com

This patch fix wrong err message of check quota node.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/fsck.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 8145199..f9ed797 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1663,7 +1663,7 @@ int fsck_chk_quota_node(struct f2fs_sb_info *sbi)
 		nid_t ino = QUOTA_INO(sb, qtype);
 		struct node_info ni;
 
-		DBG(1, "[%3d] ino [0x%x]\n", qtype, ino);
+		DBG(1, "qtype [%d] ino [0x%x]\n", qtype, ino);
 		blk_cnt = 1;
 
 		if (c.preen_mode == PREEN_MODE_1 && !c.fix_on) {
@@ -1676,7 +1676,8 @@ int fsck_chk_quota_node(struct f2fs_sb_info *sbi)
 		ret = fsck_chk_node_blk(sbi, NULL, ino,
 				F2FS_FT_REG_FILE, TYPE_INODE, &blk_cnt, NULL);
 		if (ret)
-			ASSERT_MSG("[0x%x] wrong orphan inode", ino);
+			ASSERT_MSG("wrong quota inode, qtype [%d] ino [0x%x]",
+								qtype, ino);
 	}
 	return ret;
 }
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
