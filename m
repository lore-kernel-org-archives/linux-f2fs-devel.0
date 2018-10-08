From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] fsck.f2fs: do not check segment type of empty
 curseg
Date: Mon, 8 Oct 2018 21:09:31 +0800
Message-ID: <20181008130931.5966-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1g9VIW-0006rZ-Fb
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Oct 2018 13:10:08 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g9VIL-003CqW-Oq
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Oct 2018 13:10:08 +0000
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

If a curseg is not used, its SIT entry may have an inconsistent type.
This will be fixed during recover.

Fixes: df8065e52928be ("fsck.f2fs: introduce fsck_chk_curseg_info")
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 85d9823..dd7f6ae 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2485,7 +2485,7 @@ int fsck_chk_curseg_info(struct f2fs_sb_info *sbi)
 		se = get_seg_entry(sbi, curseg->segno);
 		sum_blk = curseg->sum_blk;
 
-		if (se->type != i) {
+		if (se->valid_blocks && se->type != i) {
 			ASSERT_MSG("Incorrect curseg [%d]: segno [0x%x] "
 				   "type(SIT) [%d]", i, curseg->segno,
 				   se->type);
-- 
2.17.1
