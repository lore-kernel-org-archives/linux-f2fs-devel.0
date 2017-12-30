From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: check segment type before recover data
Date: Sat, 30 Dec 2017 15:42:48 +0800
Message-ID: <1514619768-134531-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yunlong.song@huawei.com>) id 1eVBna-0006yv-UP
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Dec 2017 07:43:18 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eVBnZ-0002Zm-1c
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Dec 2017 07:43:18 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: shengyong1@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, miaoxie@huawei.com

In some case, the node blocks has wrong blkaddr whose segment type is
NODE, e.g., recover inode has missing xattr flag and the blkaddr is in
the xattr range. Since fsck.f2fs does not check the recovery nodes, this
will cause __f2fs_replace_block change the curseg of node and do the
update_sit_entry(sbi, new_blkaddr, 1) with no next_blkoff refresh, as a
result, when recovery process write checkpoint and sync nodes, the
next_blkoff of curseg is used in the segment bit map, then it will
cause f2fs_bug_on. So let's check the segment type before recover data,
and stop recover if it is not in DATA segment.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/recovery.c | 3 ++-
 fs/f2fs/segment.h  | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 7d63faf..e8fee4a 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -478,7 +478,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		}
 
 		/* dest is valid block, try to recover from src to dest */
-		if (is_valid_blkaddr(sbi, dest, META_POR)) {
+		if (is_valid_blkaddr(sbi, dest, META_POR) &&
+			is_data_blkaddr(sbi, dest)) {
 
 			if (src == NULL_ADDR) {
 				err = reserve_new_block(&dn);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 71a2aaa..5c5a215 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -115,6 +115,9 @@
 #define SECTOR_TO_BLOCK(sectors)					\
 	((sectors) >> F2FS_LOG_SECTORS_PER_BLOCK)
 
+#define is_data_blkaddr(sbi, blkaddr)	\
+	(IS_DATASEG(get_seg_entry(sbi, GET_SEGNO(sbi, blkaddr))->type))
+
 /*
  * indicate a block allocation direction: RIGHT and LEFT.
  * RIGHT means allocating new sections towards the end of volume.
-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
