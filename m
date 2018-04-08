From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] resize.f2fs: clear CP_COMPACT_SUM_FLAG when
 rebuilding checkpoint
Date: Sun, 8 Apr 2018 10:14:29 +0800
Message-ID: <20180408021429.26448-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1f4zqy-00063h-F1
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 02:14:48 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f4zqv-000PNT-Uc
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 02:14:48 +0000
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

Resize rebuilds checkpoint with 6 summary blocks, so if
CP_COMPACT_SUM_FLAG is set in the old checkpoint, clear it.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/resize.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fsck/resize.c b/fsck/resize.c
index 7643511..019da71 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -504,6 +504,8 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 
 	/* update nat_bits flag */
 	flags = update_nat_bits_flags(new_sb, cp, get_cp(ckpt_flags));
+	if (flags & CP_COMPACT_SUM_FLAG)
+		flags &= ~CP_COMPACT_SUM_FLAG;
 	set_cp(ckpt_flags, flags);
 
 	memcpy(new_cp, cp, (unsigned char *)cp->sit_nat_version_bitmap -
-- 
2.14.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
